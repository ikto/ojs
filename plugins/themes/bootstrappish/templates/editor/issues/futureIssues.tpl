{**
 * templates/editor/issues/futureIssues.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of future (unpublished) issues.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.futureIssues"}
{url|assign:"currentUrl" page="editor" op="futureIssues"}
{include file="common/header.tpl"}
{/strip}

<ul class="stay">
    <li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
    <li class="current"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
    <li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>

<br/>

<div id="issues" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td colspan="3" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td width="80%"><label>{translate key="issue.issue"}</label></td>
			<td width="15%"><label>{translate key="editor.issues.numArticles"}</label></td>
			<td width="5%" align="right"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr>
			<td colspan="3" class="headseparator">&nbsp;</td>
		</tr>
		{iterate from=issues item=issue}
			<tr valign="top">
				<td><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>
				<td>{$issue->getNumArticles()|escape}</td>
				<td align="right"><a href="{url op="removeIssue" path=$issue->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
			</tr>
			<tr>
				<td colspan="3" class="{if $issues->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $issues->wasEmpty()}
			<tr>
				<td colspan="3" class="nodata"><p class="help-block">{translate key="issue.noIssues"}</p></td>
			</tr>
			<tr>
				<td colspan="3" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td align="left">{page_info iterator=$issues}</td>
				<td colspan="2" align="right">{page_links anchor="issues" name="issues" iterator=$issues}</td>
			</tr>
		{/if}
	</table>
</div>

{include file="common/footer.tpl"}