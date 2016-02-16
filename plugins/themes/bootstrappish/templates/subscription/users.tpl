{**
 * templates/subscription/users.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Search form for users
 *
 *
 *}
{strip}
{assign var="pageTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}

{if $subscriptionCreated}
	<br/>{translate key="manager.subscriptions.subscriptionCreatedSuccessfully"}<br/>
{/if}

<p class="help-block">{translate key="manager.subscriptions.selectSubscriber.desc"}</p>
<form role="form" class="form-inline" method="post" id="submit" action="{if $subscriptionId}{url op="selectSubscriber" path=$redirect subscriptionId=$subscriptionId}{else}{url op="selectSubscriber" path=$redirect}{/if}">
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
	<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" />&nbsp;<input type="submit" value="{translate key="common.search"}" class="btn btn-info" /></div>
</form>

<br/>
<p>{foreach from=$alphaList item=letter}<a href="{if $subscriptionId}{url op="selectSubscriber" path=$redirect searchInitial=$letter subscriptionId=$subscriptionId}{else}{url op="selectSubscriber" path=$redirect searchInitial=$letter}{/if}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{if $subscriptionId}{url op="selectSubscriber" path=$redirect subscriptionId=$subscriptionId}{else}{url op="selectSubscriber" path=$redirect}{/if}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<div id="users" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="25%"><label>{translate key="user.username"}</label></td>
			<td width="35%"><label>{translate key="user.name"}</label></td>
			<td width="30%"><label>{translate key="user.email"}</label></td>
			<td width="10%" align="right"></td>
		</tr>
		<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
		{iterate from=users item=user}
			{assign var="userid" value=$user->getId()}
			<tr valign="top">
				<td>{if $isJournalManager}<a class="action" href="{url page="manager" op="userProfile" path=$userid}">{/if}{$user->getUsername()|escape}{if $isJournalManager}</a>{/if}</td>
				<td>{$user->getFullName(true)|escape}</td>
				<td class="nowrap">
					{assign var=emailString value=$user->getFullName()|concat:" <":$user->getEmail():">"}
					{url|assign:"url" page="user" op="email" to=$emailString|to_array}
					{$user->getEmail()|truncate:20:"..."|escape}&nbsp;{icon name="mail" url=$url}
				</td>
				<td align="right" class="nowrap">
					<a href="{if $subscriptionId}{url op="editSubscription" path=$redirect|to_array:$subscriptionId userId=$user->getId()}{else}{url op="createSubscription" path=$redirect userId=$user->getId()}{/if}" class="action">{translate key="manager.subscriptions.select"}</a>
				</td>
			</tr>
			<tr><td colspan="4" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
		{/iterate}
		{if $users->wasEmpty()}
			<tr>
				<td colspan="4" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
			</tr>
			<tr><td colspan="4" class="endseparator">&nbsp;</td></tr>
		{else}
			<tr>
				<td colspan="3" align="left">{page_info iterator=$users}</td>
				<td colspan="2" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
			</tr>
		{/if}
	</table>

	{url|assign:"selectSubscriberUrl" op="selectSubscriber" path=$redirect}
	<a href="{url op="createUser" source=$selectSubscriberUrl}" class="action">{translate key="manager.people.createUser"}</a>
</div>

{include file="common/footer.tpl"}