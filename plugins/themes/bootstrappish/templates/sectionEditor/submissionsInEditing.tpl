{**
 * templates/sectionEditor/submissionsInEditing.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show section editor's submissions in editing.
 *
 *}
 
<div id="submissions" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="8" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_search key="common.id" sort="id"}</label></td>
			<td width="5%"><label>{sort_search key="submissions.submit" sort="submitDate"}</label></td>
			<td width="5%"><label>{sort_search key="submissions.sec" sort="section"}</label></td>
			<td width="20%"><label>{sort_search key="article.authors" sort="authors"}</label></td>
			<td width="25%"><label>{sort_search key="article.title" sort="title"}</label></td>
			<td width="10%"><label>{sort_search key="submission.copyedit" sort="subCopyedit"}</label></td>
			<td width="10%"><label>{sort_search key="submission.layout" sort="subLayout"}</label></td>
			<td width="10%"><label>{sort_search key="submissions.proof" sort="subProof"}</label></td>
		</tr>
		<tr><td colspan="8" class="headseparator">&nbsp;</td></tr>

		{iterate from=submissions item=submission}
			{assign var="layoutEditorProofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
			{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
			{assign var="copyeditorFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
			{assign var="articleId" value=$submission->getId()}
			{assign var="highlightClass" value=$submission->getHighlightClass()}
			<tr valign="top"{if $highlightClass} class="{$highlightClass|escape}"{/if}>
				<td>{$submission->getId()}</td>
				<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url op="submissionEditing" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td>{$copyeditorFinalSignoff->getDateCompleted()|date_format:$dateFormatTrunc|default:"&mdash;"}</td>
				<td>{$layoutSignoff->getDateCompleted()|date_format:$dateFormatTrunc|default:"&mdash;"}</td>
				<td>{$layoutEditorProofSignoff->getDateCompleted()|date_format:$dateFormatTrunc|default:"&mdash;"}</td>
			</tr>
			<tr>
				<td colspan="8" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $submissions->wasEmpty()}
			<tr>
				<td colspan="8" class="nodata"><p class="help-block">{translate key="submissions.noSubmissions"}</p></td>
			</tr>
			<tr>
				<td colspan="8" class="endseparator">&nbsp;</td>
			<tr>
		{else}
			<tr>
				<td colspan="4" align="left">{page_info iterator=$submissions}</td>
				<td colspan="4" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>