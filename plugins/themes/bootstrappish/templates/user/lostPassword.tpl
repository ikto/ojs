{**
 * templates/user/lostPassword.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login.resetPassword"}
{include file="common/header.tpl"}
{/strip}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

<form role="form" id="reset" action="{url page="login" op="requestResetPassword"}" method="post">
	<p class="help-block">{translate key="user.login.resetPasswordInstructions"}</p>

	{if $error}
		<p class="help-block">{translate key="$error"}</p>
	{/if}

	<div class="table-responsive">
		<table id="lostPasswordTable" class="table table-striped" width="100%">
			<tr valign="top">
				<td width="25%"><label for="registeredEmail">{translate key="user.login.registeredEmail"}</label></td>
				<td class="value" width="75%"><div class="form-group"><input type="text" name="email" value="{$username|escape}" size="30" maxlength="90" class="form-control" id="registeredEmail" /></div></td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="user.login.resetPassword"}" class="btn btn-warning" /></p>

	{if !$hideRegisterLink}
		<br/>
		<ul class="list-unstyled"><li><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></li></ul>
	{/if}

	<script type="text/javascript">
	{literal}
	<!--
		document.getElementById('reset').email.focus();
	// -->
	{/literal}
	</script>
</form>

{include file="common/footer.tpl"}