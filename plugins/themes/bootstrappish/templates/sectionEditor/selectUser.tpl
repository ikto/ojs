{**
 * templates/sectionEditor/selectUser.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List a set of users and allow one to be selected.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<h3>{translate key=$pageSubTitle}</h3>
	
	<form role="form" class="form-inline" id="submit" method="post" action="{url op=$actionHandler path=$articleId}">
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
	<p>{foreach from=$alphaList item=letter}<a href="{url op=$actionHandler path=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op=$actionHandler path=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

	<div id="users" class="col-md-12 mag-innert-left">
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
				<tr class="heading" valign="bottom">
					<td width="30%"><label>{translate key="user.name"}</label></td>
					<td width="20%"><label>{translate key="submissions.completed}</label></td>
					<td width="20%"><label>{translate key="submissions.active"}</label></td>
					<td width="20%"><label>{translate key="editor.submissions.lastAssigned"}</label></td>
					<td width="10%"><label>{translate key="common.action"}</label></td>
				</tr>
				<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
				{iterate from=users item=user}
					{assign var="userid" value=$user->getId()}
					{assign var="stats" value=$statistics[$userid]}
					<tr valign="top">
						<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getFullName(true)|escape}</a></td>
						<td>{if $stats.complete}{$stats.complete}{else}0{/if}</td>
						<td>{if $stats.incomplete}{$stats.incomplete}{else}0{/if}</td>
						<td>{if $stats.last_assigned}{$stats.last_assigned|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
						<td>
							{if $currentUser != $userid}
								<a href="{url op=$actionHandler path=$articleId|to_array:$userid}" class="action">{translate key="common.assign"}</a>
							{else}
								{translate key="common.alreadyAssigned"}</a>
							{/if}
						</td>
					</tr>
					<tr><td colspan="5" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
				{/iterate}
				{if $users->wasEmpty()}
					<tr>
						<td colspan="5" class="nodata"><p class="help-block">{translate key="manager.people.noneEnrolled"}</p></td>
					</tr>
					<tr><td colspan="5" class="endseparator">&nbsp;</td></tr>
				{else}
					<tr>
						<td colspan="2" align="left">{page_info iterator=$users}</td>
						<td colspan="3" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
					</tr>
				{/if}
			</table>
		</div>
		
		{if $backLink}
			<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
		{/if}
	</div>
</div>

{include file="common/footer.tpl"}