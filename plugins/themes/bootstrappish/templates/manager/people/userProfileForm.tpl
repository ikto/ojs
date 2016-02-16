{**
 * templates/manager/people/userProfileForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User profile form under journal management.
 *
 *}
{strip}
{url|assign:"currentUrl" op="people" path="all"}
{assign var="pageTitle" value="manager.people"}
{include file="common/header.tpl"}
{/strip}

{if not $userId}
	{assign var="passwordRequired" value="true"}

	<script type="text/javascript">
	{literal}
	<!--
		function setGenerateRandom(value) {
			var userForm = document.getElementById('userForm');
			if (value) {
				userForm.password.value='********';
				userForm.password2.value='********';
				userForm.password.disabled=1;
				userForm.password2.disabled=1;
				userForm.sendNotify.checked=1;
				userForm.sendNotify.disabled=1;
			} else {
				userForm.password.disabled=0;
				userForm.password2.disabled=0;
				userForm.sendNotify.disabled=0;
				userForm.password.value='';
				userForm.password2.value='';
				userForm.password.focus();
			}
		}

		function enablePasswordFields() {
			var userForm = document.getElementById('userForm');
			userForm.password.disabled=0;
			userForm.password2.disabled=0;
		}

		function generateUsername() {
			var userForm = document.getElementById('userForm');
			var req = makeAsyncRequest();

			if (userForm.lastName.value == "") {
				alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
				return;
			}

			req.onreadystatechange = function() {
				if (req.readyState == 4) {
					userForm.username.value = req.responseText;
				}
			}
			sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(userForm.firstName.value)).replace('REPLACE2', escape(userForm.lastName.value)), null, 'get');
		}

	// -->
	{/literal}
	</script>
{/if}

{if $userCreated}
	<p class="help-block">{translate key="manager.people.userCreatedSuccessfully"}</p>
{/if}

<h3>{if $userId}{translate key="manager.people.editProfile"}{else}{translate key="manager.people.createUser"}{/if}</h3>

<form role="form" id="userForm" method="post" action="{url op="updateUser"}" onsubmit="enablePasswordFields()">
	<input type="hidden" name="source" value="{$source|escape}" />
	
	{if $userId}
		<input type="hidden" name="userId" value="{$userId|escape}" />
	{/if}

	{include file="common/formErrors.tpl"}

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"userFormUrl" page="manager" op="editUser" path=$userId escape=false}
						{form_language_chooser form="userForm" url=$userFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
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
				<td>{fieldLabel suppressId="true" name="gender" key="user.gender"}</td>
				<td class="value">
					<div class="form-group">
						<select name="gender" id="gender" size="1" class="form-control">
							{html_options_translate options=$genderOptions selected=$gender}
						</select>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="initials" key="user.initials"}</td>
				<td class="value"><div class="form-group"><input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="form-control" /><p class="help-block">{translate key="user.initialsExample"}</p></div></td>
			</tr>
			{if not $userId}
				<tr valign="top">
					<td>{fieldLabel name="enrollAs" key="manager.people.enrollUserAs"}</td>
					<td class="value">
						<div class="form-group">
							<select name="enrollAs[]" id="enrollAs" multiple="multiple" size="11" class="form-control">
								{html_options_translate options=$roleOptions selected=$enrollAs}
							</select>
						</div>
						<p class="help-block">{translate key="manager.people.enrollUserAsDescription"}</p>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="username" required="true" key="user.username"}</td>
					<td class="value">
						<div class="form-group"><input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="form-control" /></div>&nbsp;&nbsp;<input type="button" class="btn btn-success" value="{translate key="common.suggest"}" onclick="generateUsername()" />
						<p class="help-block">{translate key="user.register.usernameRestriction"}</p>
					</td>
				</tr>
			{else}
				<tr valign="top">
					<td>{fieldLabel suppressId="true" name="username" key="user.username"}</td>
					<td class="value"><strong>{$username|escape}</strong></td>
				</tr>
			{/if}
			{if $authSourceOptions}
				<tr valign="top">
					<td>{fieldLabel name="authId" key="manager.people.authSource"}</td>
					<td class="value">
						<div class="form-group">
							<select name="authId" id="authId" size="1" class="form-control">
								<option value=""></option>
								{html_options options=$authSourceOptions selected=$authId}
							</select>
						</div>
					</td>
				</tr>
			{/if}

			{if !$implicitAuth}
				<tr valign="top">
					<td>{fieldLabel name="password" required=$passwordRequired key="user.password"}</td>
					<td class="value">
						<div class="form-group"><input type="password" name="password" id="password" value="{$password|escape}" size="20" maxlength="32" class="form-control" /></div>
						<p class="help-block">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</p>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="password2" required=$passwordRequired key="user.repeatPassword"}</td>
					<td class="value"><div class="form-group"><input type="password" name="password2"  id="password2" value="{$password2|escape}" size="20" maxlength="32" class="form-control" /></div></td>
				</tr>
				{if $userId}
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value"><p class="help-block">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}<br />{translate key="user.profile.leavePasswordBlank"}</p></td>
					</tr>
				{else}
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value"><div class="form-group"><input type="checkbox" onclick="setGenerateRandom(this.checked)" name="generatePassword" id="generatePassword" value="1"{if $generatePassword} checked="checked"{/if} /> <label class="control-label" for="generatePassword">{translate key="manager.people.createUserGeneratePassword"}</label></div></td>
					</tr>
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value"><div class="form-group"><input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} /> <label class="control-label" for="sendNotify">{translate key="manager.people.createUserSendNotify"}</label></div></td>
					</tr>
				{/if}
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value"><div class="form-group"><input type="checkbox" name="mustChangePassword" id="mustChangePassword" value="1"{if $mustChangePassword} checked="checked"{/if} /> <label class="control-label" for="mustChangePassword">{translate key="manager.people.userMustChangePassword"}</label></div></td>
				</tr>
			{/if}{* !$implicitAuth *}

			<tr valign="top">
				<td>{fieldLabel name="affiliation" key="user.affiliation"}</td>
				<td class="value">
					<div class="form-group"><textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="form-control">{$affiliation[$formLocale]|escape}</textarea></div>
					<p class="help-block">{translate key="user.affiliation.description"}</p>
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
				<td>{fieldLabel for="interests" key="user.interests"}</td>
				<td class="value">
					{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="gossip" key="user.gossip"}</td>
				<td class="value"><div class="form-group"><textarea name="gossip[{$formLocale|escape}]" id="gossip" rows="3" cols="40" class="form-control">{$gossip[$formLocale]|escape}</textarea></div></td>
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
			<tr valign="top">
				<td>{fieldLabel name="biography" key="user.biography"}<label class="help-block">{translate key="user.biography.description"}</label></td>
				<td class="value"><div class="form-group"><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="form-control">{$biography[$formLocale]|escape}</textarea></div></td>
			</tr>
			{if count($availableLocales) > 1}
				<tr valign="top">
					<td><label>{translate key="user.workingLanguages"}</label></td>
					<td>
						{foreach from=$availableLocales key=localeKey item=localeName}
							<div class="form-group"><input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} /> <label class="control-label" for="userLocales-{$localeKey|escape}">{$localeName|escape}</label></div>
						{/foreach}
					</td>
				</tr>
			{/if}
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $userId}<input type="submit" name="createAnother" value="{translate key="manager.people.saveAndCreateAnotherUser"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="{if $source == ''}history.go(-1);{else}document.location='{$source|escape:"jsparam"}';{/if}" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{if $generatePassword}
	<script type="text/javascript">
	{literal}
		<!--
		setGenerateRandom(1);
		// -->
	{/literal}
	</script>
{/if}

{include file="common/footer.tpl"}