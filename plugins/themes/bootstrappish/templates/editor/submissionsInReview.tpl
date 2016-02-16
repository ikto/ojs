{**
 * templates/editor/submissionsInReview.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in review.
 *}

<div id="submissions" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td colspan="8" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_search key="common.id" sort="id"}</label></td>
			<td width="5%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>{sort_search key="submissions.submitted" sort="submitDate"}</label></td>
			<td width="5%"><label>{sort_search key="submissions.sec" sort="section"}</label></td>
			<td width="15%"><label>{sort_search key="article.authors" sort="authors"}</label></td>
			<td width="30%"><label>{sort_search key="article.title" sort="title"}</label></td>
			<td width="30%">
				<label>{translate key="submission.peerReview"}</label>
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.ask"}</td>
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.due"}</td>
						<td width="34%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.done"}</td>
					</tr>
				</table>
			</td>
			<td width="5%"><label>{translate key="submissions.ruling"}</label></td>
			<td width="5%"><label>{translate key="article.sectionEditor"}</label></td>
		</tr>
		<tr>
			<td colspan="8" class="headseparator">&nbsp;</td>
		</tr>
		
		{iterate from=submissions item=submission}
			{assign var="highlightClass" value=$submission->getHighlightClass()}
			{assign var="fastTracked" value=$submission->getFastTracked()}
			<tr valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
				<td>{$submission->getId()}</td>
				<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url op="submissionReview" path=$submission->getId()}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></td>
				<td>
					<table width="100%" class="table table-striped">
					{foreach from=$submission->getReviewAssignments() item=reviewAssignments}
						{foreach from=$reviewAssignments item=assignment name=assignmentList}
							{if not $assignment->getCancelled() and not $assignment->getDeclined()}
							<tr valign="top">
								<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateNotified()}{$assignment->getDateNotified()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
								<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateCompleted() || !$assignment->getDateConfirmed()}&mdash;{else}{$assignment->getWeeksDue()|default:"&mdash;"}{/if}</td>
								<td width="34%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateCompleted()}{$assignment->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
							</tr>
							{/if}
						{foreachelse}
						<tr valign="top">
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
							<td width="34%" style="padding: 0 0 0 0; font-size: 1.0em">&mdash;</td>
						</tr>
						{/foreach}
					{foreachelse}
						<tr valign="top">
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
							<td width="34%" style="padding: 0 0 0 0; font-size: 1.0em">&mdash;</td>
						</tr>
					{/foreach}
					</table>
				</td>
				<td>
					{foreach from=$submission->getDecisions() item=decisions}
						{foreach from=$decisions item=decision name=decisionList}
							{if $smarty.foreach.decisionList.last}
									{$decision.dateDecided|date_format:$dateFormatTrunc}				
							{/if}
						{foreachelse}
							&mdash;
						{/foreach}
					{foreachelse}
						&mdash;
					{/foreach}
				</td>
				<td>
					{assign var="editAssignments" value=$submission->getEditAssignments()}
					{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()|escape} {/foreach}
				</td>
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
			</tr>
		{else}
			<tr>
				<td colspan="5" align="left">{page_info iterator=$submissions}</td>
				<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>