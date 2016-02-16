{**
 * templates/reviewer/active.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's active submissions.
 *
 *}
 
<div id="submissions" class="table-responsive">
	<table class="table table-striped" width="100%">
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_heading key="common.id" sort='id'}</label></td>
			<td width="5%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>{sort_heading key="common.assigned" sort='assignDate'}</label></td>
			<td width="5%"><label>{sort_heading key="submissions.sec" sort='section'}</label></td>
			<td width="70%"><label>{sort_heading key="article.title" sort='title'}</label></td>
			<td width="5%"><label>{sort_heading key="submission.due" sort='dueDate'}</label></td>
			<td width="10%"><label>{sort_heading key="submissions.reviewRound" sort='round'}</label></td>
		</tr>
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>

		{iterate from=submissions item=submission}
			{assign var="articleId" value=$submission->getId()}
			{assign var="reviewId" value=$submission->getReviewId()}

			<tr valign="top">
				<td>{$articleId|escape}</td>
				<td>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td><a href="{url op="submission" path=$reviewId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td class="nowrap">{$submission->getDateDue()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getRound()}</td>
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
				<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>