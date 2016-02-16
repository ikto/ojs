{**
 * templates/sectionEditor/searchUsers.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Search form for enrolled users.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people.enrollment"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<form role="form" class="form-inline" id="submit" method="post" action="{url op="enrollSearch" path=$articleId}">
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
		<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" />&nbsp;</div><input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>

	<br/>
	<p>{foreach from=$alphaList item=letter}<a href="{url op="enrollSearch" path=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="enrollSearch" path=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

	<div id="users">
		<form action="{url op="enroll" path=$articleId}" method="post">
			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
					<tr class="heading" valign="bottom">
						<td width="5%">&nbsp;</td>
						<td width="25%"><label>{translate key="user.username"}</label></td>
						<td width="27%"><label>{translate key="user.name"}</label></td>
						<td width="30%"><label>{translate key="user.email"}</label></td>
						<td width="13%"><label>{translate key="common.action"}</label></td>
					</tr>
					<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
					{iterate from=users item=user}
						{assign var="userid" value=$user->getId()}
						{assign var="stats" value=$statistics[$userid]}
						<tr valign="top">
							<td><div class="form-group"><input type="checkbox" name="users[]" value="{$user->getId()}" /></div></td>
							<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getUsername()|escape}</a></td>
							<td>{$user->getFullName(true)|escape}</td>
							<td>{$user->getEmail(true)|escape}</td>
							<td><a href="{url op="enroll" path=$articleId userId=$user->getId()}" class="action">{translate key="manager.people.enroll"}</a></td>
						</tr>
						<tr><td colspan="5" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
					{/iterate}
					{if $users->wasEmpty()}
						<tr>
							<td colspan="5" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
						</tr>
						<tr><td colspan="5" class="endseparator">&nbsp;</td></tr>
					{else}
						<tr>
							<td colspan="3" align="left">{page_info iterator=$users}</td>
							<td colspan="2" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
						</tr>
					{/if}
				</table>
			</div>
			
			<input type="submit" value="{translate key="manager.people.enrollSelected"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager" escape=false}'" />
		</form>
	</div>

	{if $backLink}
		<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
	{/if}
</div>

{include file="common/footer.tpl"}

