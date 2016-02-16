{**
 * templates/manager/groups/selectUser.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List a set of users and allow one to be selected.
 *
 *}
{strip}
{assign var=pageTitle value="manager.groups.membership.addMember"}
{include file="common/header.tpl"}
{/strip}

<form role="form" class="form-inline" name="submit" method="post" action="{url op="addMembership" path=$group->getId()}">
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
	<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>&nbsp;<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
</form>

<br/>
<p>{foreach from=$alphaList item=letter}<a href="{url path=$group->getId() searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url path=$group->getId()}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<div id="users" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="2" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="80%"><label>{translate key="user.name"}</label></td>
			<td width="20%"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr><td colspan="2" class="headseparator">&nbsp;</td></tr>
		{iterate from=users item=user}
			{assign var="userid" value=$user->getId()}
			<tr valign="top">
				<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getFullName(true)|escape}</a></td>
				<td>
					<a href="{url op="addMembership" path=$group->getId()|to_array:$user->getId()}" class="action">{translate key="manager.groups.membership.addMember"}</a>
				</td>
			</tr>
			<tr><td colspan="2" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
		{/iterate}
		{if $users->wasEmpty()}
			<tr>
				<td colspan="2" class="nodata"><p class="help-block">{translate key="manager.groups.membership.noUsers"}</p></td>
			</tr>
			<tr><td colspan="2" class="endseparator">&nbsp;</td></tr>
		{else}
			<tr>
				<td align="left">{page_info iterator=$users}</td>
				<td align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
			</tr>
		{/if}
	</table>
	{if $backLink}
		<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
	{/if}
</div>

{include file="common/footer.tpl"}