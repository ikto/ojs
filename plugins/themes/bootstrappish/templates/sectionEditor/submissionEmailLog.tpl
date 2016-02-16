{**
 * templates/sectionEditor/submissionEmailLog.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show submission email log page.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="submission.emailLog"}
{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	{if $canReview}<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>{/if}
	{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
	<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
</ul>

<ul class="stay">
	<li><a href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.history.submissionEventLog"}</a></li>
	<li class="current"><a href="{url op="submissionEmailLog" path=$submission->getId()}">{translate key="submission.history.submissionEmailLog"}</a></li>
	<li><a href="{url op="submissionNotes" path=$submission->getId()}">{translate key="submission.history.submissionNotes"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}

<div class="separator"></div>

<div id="emailLogEntries" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.history.submissionEmailLog"}</h3>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr><td class="headseparator" colspan="5">&nbsp;</td></tr>
			<tr valign="top" class="heading">
				<td width="7%"><label>{translate key="common.date"}</label></td>
				<td width="25%"><label>{translate key="email.sender"}</label></td>
				<td width="20%"><label>{translate key="email.recipients"}</label></td>
				<td><label>{translate key="common.subject"}</label></td>
				<td width="60" align="right"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr><td class="headseparator" colspan="5">&nbsp;</td></tr>
			{iterate from=emailLogEntries item=logEntry}
				<tr valign="top">
					<td>{$logEntry->getDateSent()|date_format:$dateFormatShort}</td>
					<td>{$logEntry->getFrom()|truncate:40:"..."|escape}</td>
					<td>{$logEntry->getRecipients()|truncate:40:"..."|escape}</td>
					<td>{$logEntry->getSubject()|truncate:60:"..."|escape}</td>
					<td align="right"><a href="{url op="submissionEmailLog" path=$submission->getId()|to_array:$logEntry->getId()}" class="action">{translate key="common.view"}</a>{if $isEditor}&nbsp;|&nbsp;<a href="{url op="clearSubmissionEmailLog" path=$submission->getId()|to_array:$logEntry->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.email.confirmDeleteLogEntry"}')" class="action">{translate key="common.delete"}</a>{/if}</td>
				</tr>
				<tr valign="top">
					<td colspan="5" class="{if $emailLogEntries->eof()}end{/if}separator">&nbsp;</td>
				</tr>
			{/iterate}
			{if $emailLogEntries->wasEmpty()}
				<tr valign="top">
					<td colspan="5" class="nodata"><p class="help-block">{translate key="submission.history.noLogEntries"}</p></td>
				</tr>
				<tr valign="top">
					<td colspan="5" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td colspan="3" align="left">{page_info iterator=$emailLogEntries}</td>
					<td colspan="2" align="right">{page_links anchor="emailLogEntries" name="emailLogEntries" iterator=$emailLogEntries}</td>
				</tr>
			{/if}
		</table>
	</div>

	{if $isEditor}
		<a class="action" href="{url op="clearSubmissionEmailLog" path=$submission->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.email.confirmClearLog"}')">{translate key="submission.history.clearLog"}</a>
	{/if}
</div>

{include file="common/footer.tpl"}