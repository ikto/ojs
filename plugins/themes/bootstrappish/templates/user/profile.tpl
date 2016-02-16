{**
 * templates/user/profile.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User profile form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.profile.editProfile"}
{url|assign:"url" op="profile"}
{include file="common/header.tpl"}
{/strip}

<form role="form" id="profile" method="post" action="{url op="saveProfile"}" enctype="multipart/form-data">

	{include file="common/formErrors.tpl"}

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" required="true" key="common.language"}</td>
					<td width="80%" class="value">
						{url|assign:"userProfileUrl" page="user" op="profile" escape=false}
						{form_language_chooser form="profile" url=$userProfileUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{fieldLabel suppressId="true" name="username" key="user.username"}</td>
				<td width="80%" class="value"><label class="help-block">{$username|escape}</label></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="salutation" key="user.salutation"}</td>
				<td class="value"><div class="form-group"><input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="firstName" required="true" key="user.firstName"}</td>
				<td class="value"><div class="form-group"><input type="text" name="firstName" id="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="middleName" key="user.middleName"}</td>
				<td class="value"><div class="form-group"><input type="text" name="middleName" id="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="lastName" required="true" key="user.lastName"}</td>
				<td class="value"><div class="form-group"><input type="text" name="lastName" id="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="initials" key="user.initials"}</td>
				<td class="value"><div class="form-group"><input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="form-control" /><label class="help-block">{translate key="user.initialsExample"}</div></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="gender" key="user.gender"}</td>
				<td class="value">
					<div class="form-group">
						<select name="gender" id="gender" size="1" class="form-control">
							{html_options_translate options=$genderOptions selected=$gender}
						</select>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="affiliation" key="user.affiliation"}</td>
				<td class="value">
					<div class="form-group">
						<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="form-control">{$affiliation[$formLocale]|escape}</textarea>
						<p class="help-block">{translate key="user.affiliation.description"}</p>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="signature" key="user.signature"}</td>
				<td class="value"><div class="form-group"><textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="form-control">{$signature[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="email" required="true" key="user.email"}</td>
				<td class="value"><div class="form-group"><input type="text" name="email" id="email" value="{$email|escape}" size="30" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="userUrl" key="user.url"}</td>
				<td class="value"><div class="form-group"><input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="90" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="phone" key="user.phone"}</td>
				<td class="value"><div class="form-group"><input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="fax" key="user.fax"}</td>
				<td class="value"><div class="form-group"><input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="mailingAddress" key="common.mailingAddress"}</td>
				<td class="value"><div class="form-group"><textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="form-control">{$mailingAddress|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="country" key="common.country"}</td>
				<td class="value">
					<div class="form-group">
						<select name="country" id="country" class="form-control">
							<option value=""></option>
							{html_options options=$countries selected=$country}
						</select>
					</div>
				</td>
			</tr>

			{if $currentJournal}
				<tr valign="top">
					<td>{translate key="user.roles"}</td>
					<td class="value">
						{if $allowRegReader}
							<div class="form-group">
								<input type="checkbox" id="readerRole" name="readerRole" {if $isReader || $readerRole}checked="checked" {/if}/>&nbsp;{fieldLabel name="readerRole" key="user.role.reader"}<br/>
							</div>
						{/if}
						{if $allowRegAuthor}
							<div class="form-group">
								<input type="checkbox" id="authorRole" name="authorRole" {if $isAuthor || $authorRole}checked="checked" {/if}/>&nbsp;{fieldLabel name="authorRole" key="user.role.author"}<br/>
							</div>
						{/if}
						{if $allowRegReviewer}
							<div class="form-group">
								<input type="checkbox" id="reviewerRole" name="reviewerRole" {if $isReviewer || $reviewerRole}checked="checked" {/if}/>&nbsp;{fieldLabel name="reviewerRole" key="user.role.reviewer"}<br/>
							</div>
						{/if}
					</td>
				</tr>
			{/if}
			{if $allowRegReviewer || $isReviewer}
				<tr valign="top">
					<td>{fieldLabel name="interests" key="user.interests"}</td>
					<td class="value">
						{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td>{fieldLabel name="biography" key="user.biography"}<label class="help-block">{translate key="user.biography.description"}</label></td>
				<td class="value"><div class="form-group"><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="form-control">{$biography[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>
					{fieldLabel name="profileImage" key="user.profile.form.profileImage"}
				</td>
				<td class="value">
					<div class="form-group"><input type="file" id="profileImage" name="profileImage" class="form-control" /> </div><input type="submit" name="uploadProfileImage" value="{translate key="common.upload"}" class="btn btn-success" />
					{if $profileImage}
						{translate key="common.fileName"}: {$profileImage.name|escape} {$profileImage.dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteProfileImage" value="{translate key="common.delete"}" class="btn btn-danger" />
						<br />
						<img class="img-responsive" src="{$sitePublicFilesDir}/{$profileImage.uploadName|escape:"url"}" width="{$profileImage.width|escape}" height="{$profileImage.height|escape}" style="border: 0;" alt="{translate key="user.profile.form.profileImage"}" />
					{/if}
				</td>
			</tr>
			{if count($availableLocales) > 1}
				<tr valign="top">
					<td><label>{translate key="user.workingLanguages"}</label></td>
					<td>
						{foreach from=$availableLocales key=localeKey item=localeName}
							<div class="form-group"><input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $userLocales)} checked="checked"{/if} /> <label class="control-label" for="userLocales-{$localeKey|escape}">{$localeName|escape}</label></div>
						{/foreach}
					</td>
				</tr>
			{/if}

			{if $displayOpenAccessNotification}
				{assign var=notFirstJournal value=0}
				{foreach from=$journals name=journalOpenAccessNotifications key=thisJournalId item=thisJournal}
					{assign var=thisJournalId value=$thisJournal->getJournalId()}
					{assign var=publishingMode value=$thisJournal->getSetting('publishingMode')}
					{assign var=enableOpenAccessNotification value=$thisJournal->getSetting('enableOpenAccessNotification')}
					{assign var=notificationEnabled value=$user->getSetting('openAccessNotification', $thisJournalId)}
					{if !$notFirstJournal}
						{assign var=notFirstJournal value=1}
						<tr valign="top">
							<td>{translate key="user.profile.form.openAccessNotifications"}</td>
							<td class="value">
					{/if}

					{if $publishingMode == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification}
						<div class="form-group"><input type="checkbox" name="openAccessNotify[]" {if $notificationEnabled}checked="checked" {/if}id="openAccessNotify-{$thisJournalId|escape}" value="{$thisJournalId|escape}" /> <label class="control-label" for="openAccessNotify-{$thisJournalId|escape}">{$thisJournal->getLocalizedTitle()|escape}</label></div>
					{/if}

					{if $smarty.foreach.journalOpenAccessNotifications.last}
							</td>
						</tr>
					{/if}
				{/foreach}
			{/if}
		</table>
	</div>
	
	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="user"}'" /></p>
</form>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}

