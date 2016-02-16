{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login"}
{include file="common/header.tpl"}
{/strip}

{if !$registerOp}
	{assign var="registerOp" value="register"}
{/if}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

{if $loginMessage}
	<p class="help-block">{translate key="$loginMessage"}</p>
	<br />
{/if}

{if $implicitAuth}
	<a id="implicitAuthLogin" href="{url page="login" op="implicitAuthLogin"}">Login</a>
{else}
	<form role="form" id="signinForm" method="post" action="{$loginUrl}">
{/if}

{if $error}
	<p class="help-block">{translate key="$error" reason=$reason}</p>
	<br />
{/if}

<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

{if ! $implicitAuth}
	<div class="table-responsive">
		<table id="signinTable" class="table table-striped">
			<tr>
				<td><label for="loginUsername">{translate key="user.username"}</label></td>
				<td class="value"><div class="form-group"><input type="text" id="loginUsername" name="username" value="{$username|escape}" size="20" maxlength="32" class="form-control" /></div></td>
			</tr>
			<tr>
				<td><label for="loginPassword">{translate key="user.password"}</label></td>
				<td class="value"><div class="form-group"><input type="password" id="loginPassword" name="password" value="{$password|escape}" size="20" class="form-control" /></div></td>
			</tr>
			{if $showRemember}
				<tr valign="middle">
					<td></td>
					<td class="value"><div class="form-group"><input type="checkbox" id="loginRemember" name="remember" value="1"{if $remember} checked="checked"{/if} /> <label for="loginRemember">{translate key="user.login.rememberUsernameAndPassword"}</label></div></td>
				</tr>
			{/if}{* $showRemember *}

			<tr>
				<td></td>
				<td><input type="submit" value="{translate key="user.login"}" class="btn btn-success" /></td>
			</tr>
		</table>
	</div>

	<div class="col-md-12 mag-innert-left">
		<ul class="list-unstyled">
			{if !$hideRegisterLink}<li><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></li>{/if}
			<li><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></li>
		</ul>
	</div>

	<script type="text/javascript">
	{literal}
	<!--
		document.getElementById('{if $username}loginPassword{else}loginUsername{/if}').focus();
	// -->
	{/literal}
	</script>
{/if}{* !$implicitAuth *}
</form>

{include file="common/footer.tpl"}