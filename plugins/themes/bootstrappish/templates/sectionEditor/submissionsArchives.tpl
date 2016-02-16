{**
 * templates/sectionEditor/submissionsArchives.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show section editor's submission archive.
 *
 *}
 
<div id="submissions" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_search key="common.id" sort="id"}</label></td>
			<td width="15%"><label><span class="help-block"></span>{sort_search key="submissions.submitted" sort="submitDate"}</label></td>
			<td width="5%"><label>{sort_search key="submissions.sec" sort="section"}</label></td>
			<td width="25%"><label>{sort_search key="article.authors" sort="authors"}</label></td>
			<td width="30%"><label>{sort_search key="article.title" sort="title"}</label></td>
			<td width="20%" align="right"><label>{sort_search key="common.status" sort="status"}</label></td>
		</tr>
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>

		{iterate from=submissions item=submission}
			{assign var="articleId" value=$submission->getId()}
			<tr valign="top">
				<td>{$submission->getId()}</td>
				<td>{$submission->getDateSubmitted()|date_format:$dateFormatShort}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url op="submissionEditing" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td align="right">
					{assign var="status" value=$submission->getStatus()}
					{if $status == STATUS_ARCHIVED}
						{translate key="submissions.archived"}
					{elseif $status == STATUS_PUBLISHED}
						{print_issue_id articleId="$articleId"}
					{elseif $status == STATUS_DECLINED}
						{translate key="submissions.declined"}
					{/if}
				</td>
			</tr>
			<tr>
				<td colspan="6" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $submissions->wasEmpty()}
			<tr>
				<td colspan="6" class="nodata"><p class="help-block">{translate key="submissions.noSubmissions"}</p></td>
			</tr>
			<tr>
				<td colspan="6" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="3" align="left">{page_info iterator=$submissions}</td>
				<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>