{**
 * templates/sectionEditor/createReviewerForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for editors to create reviewers.
 *
 *}
{strip}
{assign var="pageTitle" value="sectionEditor.review.createReviewer"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<form role="form" method="post" id="reviewerForm" action="{url op="createReviewer" path=$articleId|to_array:"create"}">

		{include file="common/formErrors.tpl"}

		<script type="text/javascript">
		{literal}
		<!--

			function generateUsername() {
				var req = makeAsyncRequest();

				if (document.getElementById('reviewerForm').lastName.value == "") {
					alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
					return;
				}

				req.onreadystatechange = function() {
					if (req.readyState == 4) {
						document.getElementById('reviewerForm').username.value = req.responseText;
					}
				}
				sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(document.getElementById('reviewerForm').firstName.value)).replace('REPLACE2', escape(document.getElementById('reviewerForm').lastName.value)), null, 'get');
			}


		// -->
		{/literal}
		</script>
		
		<div id="createReviewerForm" class="col-md-12 mag-innert-left">
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					{if count($formLocales) > 1}
						<tr valign="top">
							<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
							<td width="80%" class="value">
								{url|assign:"createReviewerUrl" op="createReviewer" path=$articleId escape=false}
								{form_language_chooser form="reviewerForm" url=$createReviewerUrl}
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
						<td>{fieldLabel name="initials" key="user.initials"}</td>
						<td class="value"><div class="form-group"><input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="form-control" />&nbsp;&nbsp;{translate key="user.initialsExample"}</div></td>
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
						<td>{fieldLabel name="username" required="true" key="user.username"}</td>
						<td class="value">
						<div class="form-group">
							<input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="form-control" />&nbsp;&nbsp;</div><input type="button" class="btn btn-success" value="{translate key="common.suggest"}" onclick="generateUsername()" />
							<br />
							<p class="help-block">{translate key="user.register.usernameRestriction"}</p>
						</td>
					</tr>
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value"><div class="form-group"><input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} /> <label class="control-label" for="sendNotify">{translate key="manager.people.createUserSendNotify"}</label></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="affiliation" key="user.affiliation"}</td>
						<td class="value">
							<div class="form-group">
								<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="form-control">{$affiliation[$formLocale]|escape}</textarea><br/>
								<p class="help-block">{translate key="user.affiliation.description"}</p>
							</div>
						</td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="email" required="true" key="user.email"}</td>
						<td class="value"><div class="form-group"><input type="text" name="email" id="email" value="{$email|escape}" size="30" maxlength="90" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="userUrl" key="user.url"}</td>
						<td class="value"><div class="form-group"><input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="form-control" /></div></td>
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
						<td>{fieldLabel name="biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
						<td class="value"><div class="form-group"><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="form-control">{$biography[$formLocale]|escape}</textarea></div></td>
					</tr>
					{if count($availableLocales) > 1}
						<tr valign="top">
							<td>{translate key="user.workingLanguages"}</td>
							<td>
								{foreach from=$availableLocales key=localeKey item=localeName}
									<div class="form-group"><input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} /> <label class="control-label" for="userLocales-{$localeKey|escape}">{$localeName|escape}</label></div><br />
								{/foreach}
							</td>
						</tr>
					{/if}
				</table>
			</div>

			<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="selectReviewer" path=$articleId escape=false}'" /></p>

			<p class="help-block">{translate key="common.requiredField"}</p>
		</div>
	</form>
</div>

{include file="common/footer.tpl"}