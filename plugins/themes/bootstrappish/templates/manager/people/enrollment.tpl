{**
 * templates/manager/people/enrollment.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List enrolled users.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people.enrollment"}
{include file="common/header.tpl"}
{/strip}

<form role="form" id="disableUser" method="post" action="{url op="disableUser"}">
	<input type="hidden" name="reason" value=""/>
	<input type="hidden" name="userId" value=""/>
</form>

<script type="text/javascript">
{literal}
<!--
function toggleChecked() {
	var elements = document.getElementById('people').elements;
	for (var i=0; i < elements.length; i++) {
		if (elements[i].name == 'bcc[]') {
			elements[i].checked = !elements[i].checked;
		}
	}
}

function confirmAndPrompt(userId) {
	var reason = prompt('{/literal}{translate|escape:"javascript" key="manager.people.confirmDisable"}{literal}');
	if (reason == null) return;

	document.getElementById('disableUser').reason.value = reason;
	document.getElementById('disableUser').userId.value = userId;

	document.getElementById('disableUser').submit();
}
// -->
{/literal}
</script>

<h3>{translate key=$roleName}</h3>
<form role="form" class="form-inline" method="post" action="{url path=$roleSymbolic}">
	<div class="form-group">
		<select name="roleSymbolic" class="form-control">
			<option {if $roleSymbolic=='all'}selected="selected" {/if}value="all">{translate key="manager.people.allUsers"}</option>
			<option {if $roleSymbolic=='managers'}selected="selected" {/if}value="managers">{translate key="user.role.managers"}</option>
			<option {if $roleSymbolic=='editors'}selected="selected" {/if}value="editors">{translate key="user.role.editors"}</option>
			<option {if $roleSymbolic=='sectionEditors'}selected="selected" {/if}value="sectionEditors">{translate key="user.role.sectionEditors"}</option>
			{if $roleSettings.useLayoutEditors}
				<option {if $roleSymbolic=='layoutEditors'}selected="selected" {/if}value="layoutEditors">{translate key="user.role.layoutEditors"}</option>
			{/if}
			{if $roleSettings.useCopyeditors}
				<option {if $roleSymbolic=='copyeditors'}selected="selected" {/if}value="copyeditors">{translate key="user.role.copyeditors"}</option>
			{/if}
			{if $roleSettings.useProofreaders}
				<option {if $roleSymbolic=='proofreaders'}selected="selected" {/if}value="proofreaders">{translate key="user.role.proofreaders"}</option>
			{/if}
			<option {if $roleSymbolic=='reviewers'}selected="selected" {/if}value="reviewers">{translate key="user.role.reviewers"}</option>
			<option {if $roleSymbolic=='authors'}selected="selected" {/if}value="authors">{translate key="user.role.authors"}</option>
			<option {if $roleSymbolic=='readers'}selected="selected" {/if}value="readers">{translate key="user.role.readers"}</option>
			<option {if $roleSymbolic=='subscriptionManagers'}selected="selected" {/if}value="subscriptionManagers">{translate key="user.role.subscriptionManagers"}</option>
		</select>
	</div>
	<div class="form-group">
		<select name="searchField" size="1" class="form-control">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
	</div>
	<div class="form-group">
		<select name="searchMatch" size="1" class="form-control">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
		</select>
	</div>
	<div class="form-group"><input type="text" size="10" name="search" class="form-control" value="{$search|escape}" /></div>&nbsp;<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
</form>

<br/>
<p>{foreach from=$alphaList item=letter}<a href="{url path=$roleSymbolic searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url path=$roleSymbolic}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

{if not $roleId}
	<ul class="stay">
		<li><a href="{url path="managers"}">{translate key="user.role.managers"}</a></li>
		<li><a href="{url path="editors"}">{translate key="user.role.editors"}</a></li>
		<li><a href="{url path="sectionEditors"}">{translate key="user.role.sectionEditors"}</a></li>
		{if $roleSettings.useLayoutEditors}
			<li><a href="{url path="layoutEditors"}">{translate key="user.role.layoutEditors"}</a></li>
		{/if}
		{if $roleSettings.useCopyeditors}
			<li><a href="{url path="copyeditors"}">{translate key="user.role.copyeditors"}</a></li>
		{/if}
		{if $roleSettings.useProofreaders}
			<li><a href="{url path="proofreaders"}">{translate key="user.role.proofreaders"}</a></li>
		{/if}
		<li><a href="{url path="reviewers"}">{translate key="user.role.reviewers"}</a></li>
		<li><a href="{url path="authors"}">{translate key="user.role.authors"}</a></li>
		<li><a href="{url path="readers"}">{translate key="user.role.readers"}</a></li>
		<li><a href="{url path="subscriptionManagers"}">{translate key="user.role.subscriptionManagers"}</a></li>
	</ul>

	<br />
{else}
	<p><a href="{url path="all"}" class="action">{translate key="manager.people.allUsers"}</a></p>
{/if}

<form role="form" id="people" action="{url page="user" op="email"}" method="post">
	<input type="hidden" name="redirectUrl" value="{url path=$roleSymbolic}"/>

	<div id="users" class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td colspan="5" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="5%">&nbsp;</td>
				<td width="12%"><label>{sort_heading key="user.username" sort="username"}</label></td>
				<td width="20%"><label>{sort_heading key="user.name" sort="name"}</label></td>
				<td width="23%"><label>{sort_heading key="user.email" sort="email"}</label></td>
				<td width="40%" align="right"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr>
				<td colspan="5" class="headseparator">&nbsp;</td>
			</tr>
			{iterate from=users item=user}
				{assign var=userExists value=1}
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="bcc[]" value="{$user->getEmail()|escape}"/></div></td>
					<td><a class="action" href="{url op="userProfile" path=$user->getId()}">{$user->getUsername()|escape|wordwrap:15:" ":true}</a></td>
					<td>{$user->getFullName()|escape}</td>
					<td class="nowrap">
						{assign var=emailString value=$user->getFullName()|concat:" <":$user->getEmail():">"}
						{url|assign:"redirectUrl" path=$roleSymbolic escape=false}
						{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$redirectUrl}
						{$user->getEmail()|truncate:15:"..."|escape}&nbsp;{icon name="mail" url=$url}
					</td>
					<td align="right">
						{if $roleId}
						<a href="{url op="unEnroll" path=$roleId userId=$user->getId() journalId=$currentJournal->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.people.confirmUnenroll"}')" class="action">{translate key="manager.people.unenroll"}</a>&nbsp;|
						{/if}
						<a href="{url op="editUser" path=$user->getId()}" class="action">{translate key="common.edit"}</a>
						{if $thisUser->getId() != $user->getId()}
							|&nbsp;<a href="{url page="login" op="signInAsUser" path=$user->getId()}" class="action">{translate key="manager.people.signInAs"}</a>
							{if !$roleId}|&nbsp;<a href="{url op="removeUser" path=$user->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.people.confirmRemove"}')" class="action">{translate key="manager.people.remove"}</a>{/if}
							{if $user->getDisabled()}
								|&nbsp;<a href="{url op="enableUser" path=$user->getId()}" class="action">{translate key="manager.people.enable"}</a>
							{else}
								|&nbsp;<a href="javascript:confirmAndPrompt({$user->getId()})" class="action">{translate key="manager.people.disable"}</a>
							{/if}
						{/if}
					</td>
				</tr>
				<tr>
					<td colspan="5" class="{if $users->eof()}end{/if}separator">&nbsp;</td>
				</tr>
			{/iterate}
			{if $users->wasEmpty()}
				<tr>
					<td colspan="5" class="nodata"><p class="help-block">{translate key="manager.people.noneEnrolled"}</p></td>
				</tr>
				<tr>
					<td colspan="5" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td colspan="4" align="left">{page_info iterator=$users}</td>
					<td align="right">{page_links anchor="users" name="users" iterator=$users searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth roleSymbolic=$roleSymbolic searchInitial=$searchInitial sort=$sort sortDirection=$sortDirection}</td>
				</tr>
			{/if}
		</table>

		{if $userExists}
			<p><input type="submit" value="{translate key="email.compose"}" class="btn btn-success"/>&nbsp;<input type="button" value="{translate key="common.selectAll"}" class="btn btn-success" onclick="toggleChecked()" />  <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager" escape=false}'" /></p>
		{/if}
	</div>
</form>

<br/>
<a href="{url op="enrollSearch" path=$roleId}" class="action">{translate key="manager.people.enrollExistingUser"}</a> |
{url|assign:"enrollmentUrl" path=$roleSymbolic searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth searchInitial=$searchInitial}
<a href="{if $roleId}{url op="createUser" roleId=$roleId source=$enrollmentUrl}{else}{url op="createUser" source=$enrollmentUrl}{/if}" class="action">{translate key="manager.people.createUser"}</a> | <a href="{url op="enrollSyncSelect" path=$rolePath}" class="action">{translate key="manager.people.enrollSync"}</a>

{include file="common/footer.tpl"}