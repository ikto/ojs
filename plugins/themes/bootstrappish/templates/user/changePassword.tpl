{**
 * templates/user/changePassword.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to change a user's password.
 *
 *}
{strip}
{assign var="pageTitle" value="user.changePassword"}
{url|assign:"currentUrl" page="user" op="changePassword"}
{include file="common/header.tpl"}
{/strip}

<div id="changePassword">
	<form role="form" method="post" action="{url op="savePassword"}">

		{include file="common/formErrors.tpl"}

		<p class="help-block">{translate key="user.profile.changePasswordInstructions"}</p>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%">{fieldLabel name="oldPassword" key="user.profile.oldPassword"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="password" name="oldPassword" id="oldPassword" value="{$oldPassword|escape}" size="20" maxlength="32" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="password" key="user.profile.newPassword"}</td>
					<td class="value"><div class="form-group"><input type="password" name="password" value="{$password|escape}" id="password" size="20" maxlength="32" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td></td>
					<td><p class="help-block">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</p></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="password2" key="user.profile.repeatNewPassword"}</td>
					<td class="value"><div class="form-group"><input type="password" name="password2" id="password2" value="{$password2|escape}" size="20" maxlength="32" class="form-control" /></div></td>
				</tr>
			</table>
		</div>

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="user" escape=false}'" /></p>
	</form>
</div>

{include file="common/footer.tpl"}