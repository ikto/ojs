{**
 * @file plugins/generic/booksForReview/templates/editor/authors.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Selection form for book for review authors.
 *
 *}
{assign var="pageTitle" value="plugins.generic.booksForReview.editor.assignAuthor"}
{include file="common/header.tpl"}

<form role="form" class="form-inline" method="post" id="submit" action="{url op="selectBookForReviewAuthor" path=$bookId returnPage=$returnPage}">
	<div class="form-group">
		<select name="searchField" size="1" class="form-control">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
	</div>
	<div class="form-group">
		<select name="searchMatch" size="1" class="form-control">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
		</select>
	</div>
	<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>&nbsp;<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
</form>

<br/>
<p>{foreach from=$alphaList item=letter}<a href="{url op="selectBookForReviewAuthor" path=$bookId returnPage=$returnPage searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="selectBookForReviewAuthor" path=$bookId returnPage=$returnPage}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<a name="users"></a>

<div class="table-responsive">
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
					<a href="{url op="assignBookForReviewAuthor" path=$bookId returnPage=$returnPage userId=$user->getId()}" class="action">{translate key="plugins.generic.booksForReview.editor.assign"}</a>
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
				<td colspan="2" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search}</td>
			</tr>
		{/if}
	</table>
</div>
	
{if $isJournalManager}
	{url|assign:"selectBookForReviewAuthorUrl" op="selectBookForReviewAuthor"}
	<a href="{url page="manager" op="createUser" source=$selectBookForReviewAuthorUrl}" class="action">{translate key="plugins.generic.booksForReview.editor.createNewUser"}</a>
{/if}

{include file="common/footer.tpl"}