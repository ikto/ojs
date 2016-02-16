{**
 * templates/manager/groups/groups.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of groups in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.groups"}
{assign var="pageId" value="manager.groups"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveGroup"); });
{/literal}
</script>

<br/>

<div class="col-md-12 mag-innert-left">
	<form role="form" action="{url op="setBoardEnabled"}" method="post">
		{url|assign:"aboutEditorialTeamUrl" page="about" op="editorialTeam"}
		{url|assign:"peopleManagementUrl" page="manager" op="people" path="all"}
		<p class="help-block">{translate key="manager.groups.enableBoard.description" aboutEditorialTeamUrl=$aboutEditorialTeamUrl}</p><br/>
		<div class="form-group"><input type="radio" id="boardEnabledOff" {if !$boardEnabled}checked="checked" {/if}name="boardEnabled" value="0"/>&nbsp;<label class="control-label" for="boardEnabledOff">{translate key="manager.groups.disableBoard"}</label></div><br/>
		<div class="form-group"><input type="radio" id="boardEnabledOn" {if $boardEnabled}checked="checked" {/if}name="boardEnabled" value="1"/>&nbsp;<label class="control-label" for="boardEnabledOn">{translate key="manager.groups.enableBoard"}</label></div><br/>
		<input type="submit" value="{translate key="common.record"}" class="btn btn-success"/>
	</form>
</div>

<br />

<div id="groups" class="table-responsive">
	<table width="100%" class="table table-striped" id="dragTable">
		<tr>
			<td colspan="3" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td colspan="2" width="75%"><label>{translate key="manager.groups.title"}</label></td>
			<td width="25%"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr>
			<td colspan="3" class="headseparator">&nbsp;</td>
		</tr>
		{assign var="isFirstEditorialTeamEntry" value=1}
		{iterate from=groups item=group}
			{if $group->getContext() == GROUP_CONTEXT_EDITORIAL_TEAM}
				{if $isFirstEditorialTeamEntry}
					{assign var="isFirstEditorialTeamEntry" value=0}
					<tr valign="top">
						<td colspan="3">{translate key="manager.groups.context.editorialTeam.short"}</td>
					</tr>
					<tr>
						<td colspan="3" class="separator">&nbsp;</td>
					</tr>
				{/if}
				<tr valign="top" id=editorialteam-{$group->getId()} class="data">
					<td class="drag" width="5%">&nbsp;</td>
					<td class="drag">
						{url|assign:"url" page="manager" op="email" toGroup=$group->getId()}
						{$group->getLocalizedTitle()|escape}&nbsp;{icon name="mail" url=$url}
					</td>
			{else}
				<tr valign="top" id="other-{$group->getId()}" class="data">
					<td class="drag" colspan="2">
						{url|assign:"url" page="manager" op="email" toGroup=$group->getId()}
						{$group->getLocalizedTitle()|escape}&nbsp;{icon name="mail" url=$url}
					</td>
			{/if}
				<td>
					<a href="{url op="editGroup" path=$group->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="groupMembership" path=$group->getId()}" class="action">{translate key="manager.groups.membership"}</a>&nbsp;|&nbsp;<a href="{url op="deleteGroup" path=$group->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.groups.confirmDelete"}')" class="action">{translate key="common.delete"}</a>&nbsp;|&nbsp;<a href="{url op="moveGroup" d=u id=$group->getId()}">&uarr;</a>&nbsp;<a href="{url op="moveGroup" d=d id=$group->getId()}">&darr;</a>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="{if $groups->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $groups->wasEmpty()}
			<tr>
				<td colspan="3" class="nodata"><p class="help-block">{translate key="manager.groups.noneCreated"}</p></td>
			</tr>
			<tr>
				<td colspan="3" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="2" align="left">{page_info iterator=$groups}</td>
				<td colspan="1" align="right">{page_links anchor="groups" name="groups" iterator=$groups}</td>
			</tr>
		{/if}
	</table>

	<a href="{url op="createGroup"}" class="action">{translate key="manager.groups.create"}</a>
</div>

{include file="common/footer.tpl"}