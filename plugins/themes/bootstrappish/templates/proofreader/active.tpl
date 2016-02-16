{**
 * templates/proofreader/active.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show proofreader's active submissions.
 *
 *}

<div id="submissions" class="table-responsive">
	<table class="table table-striped" width="100%">
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_heading key="common.id" sort="id"}</label></td>
			<td width="5%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>{sort_heading key="common.assign" sort="assignDate"}</label></td>
			<td width="5%"><label>{sort_heading key="submissions.sec" sort="section"}</label></td>
			<td width="30%"><label>{sort_heading key="article.authors" sort="authors"}</label></td>
			<td width="40%"><label>{sort_heading key="article.title" sort="title"}</label></td>
			<td width="15%" align="right"><label>{sort_heading key="common.status" sort="status"}</label></td>
		</tr>
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>

		{iterate from=submissions item=submission}
			{assign var="articleId" value=$submission->getId()}
			{assign var="proofreaderSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_PROOFREADER')}
			{assign var="authorSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}

			<tr valign="top">
				<td>{$articleId|escape}</td>
				<td>{$proofreaderSignoff->getDateNotified()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url op="submission" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td align="right">
					{if not $authorSignoff->getDateCompleted()}
						{translate key="submissions.initialProof"}
					{else}
						{translate key="submissions.postAuthor"}
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
				<td colspan="4" align="left">{page_info iterator=$submissions}</td>
				<td colspan="2" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>