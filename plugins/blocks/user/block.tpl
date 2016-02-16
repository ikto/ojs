{**
 * plugins/blocks/user/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- user tools.
 *
 *}

{if !$implicitAuth}
	<h4 class="side">{translate key="navigation.user"}</h4>
{/if}

<div class="edit-pics" id="sidebarUser">
	{if $isUserLoggedIn}
		<p class="help-block">{translate key="plugins.block.user.loggedInAs"}</p>
		<strong>{$loggedInUsername|escape}</strong>
		<ul class="stay">
			{if $hasOtherJournals}
				<li><a href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a></li>
			{/if}
			<li><a href="{url page="user" op="profile"}">{translate key="plugins.block.user.myProfile"}</a></li>
			<li><a href="{url page="login" op="signOut"}">{translate key="plugins.block.user.logout"}</a></li>
			{if $userSession->getSessionVar('signedInAs')}
				<li><a href="{url page="login" op="signOutAsUser"}">{translate key="plugins.block.user.signOutAsUser"}</a></li>
			{/if}
		</ul>
	{else}
		{if $implicitAuth}
			<a href="{url page="login" op="implicitAuthLogin"}">{translate key="plugins.block.user.implicitAuthLogin"}</a>
		{elseif $userBlockLoginSSL}
			<a href="{$userBlockLoginUrl}">{translate key="user.login"}</a>
		{else}
			<form method="post" action="{$userBlockLoginUrl}">
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<td><label class="control-label" for="sidebar-username">{translate key="user.username"}</label></td>
							<td><div class="form-group"><input type="text" id="sidebar-username" name="username" value="" size="12" maxlength="32" class="form-control" /></div></td>
						</tr>
						<tr>
							<td><label class="control-label" for="sidebar-password">{translate key="user.password"}</label></td>
							<td><div class="form-group"><input type="password" id="sidebar-password" name="password" value="{$password|escape}" size="12" class="form-control" /></div></td>
						</tr>
						<tr>
							<td colspan="2"><div class="form-group"><input type="checkbox" id="remember" name="remember" value="1" /> <label for="remember">{translate key="plugins.block.user.rememberMe"}</label></div></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="{translate key="user.login"}" class="btn btn-success" /></td>
						</tr>
					</table>
				</div>
			</form>
		{/if}
	{/if}
</div>