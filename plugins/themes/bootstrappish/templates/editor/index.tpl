{**
 * templates/editor/index.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor index.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.home"}
{assign var="pageCrumbTitle" value="user.role.editor"}
{include file="common/header.tpl"}
{/strip}

<div id="articleSubmissions" class="col-md-12 mag-innert-left">
	<h3>{translate key="article.submissions"}</h3>
	<ul class="stay">
		<li><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a>&nbsp;({if $submissionsCount[2]}{$submissionsCount[2]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
		{call_hook name="Templates::Editor::Index::Submissions"}
	</ul>
</div>

<div class="separator">&nbsp;</div>

&nbsp;<br />

{if !$dateFrom}
	{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
	{assign var="dateTo" value="--"}
{/if}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<div class="col-md-12 mag-innert-left">
	<form role="form" class="form-inline" method="post" id="submit" action="{url path="search"}">
		{if $section}<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>{/if}
		<input type="hidden" name="sort" value="id"/>
		<input type="hidden" name="sortDirection" value="ASC"/>
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
		<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>
		<br/>
		<div class="form-group">
			<select name="dateSearchField" size="1" class="form-control">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		{translate key="common.between"}
		{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		{translate key="common.and"}
		{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
		<br/>
		<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>
	&nbsp;
	<br/>
</div>

{if $displayResults}
	<div id="submissions" class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td colspan="6" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="5%"><label>{sort_search key="common.id" sort="id"}</label></td>
				<td width="5%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>>{sort_search key="submissions.submit" sort="submitDate"}</label></td>
				<td width="5%"><label>{sort_search key="submissions.sec" sort="section"}</label></td>
				<td width="30%"><label>{sort_search key="article.authors" sort="authors"}</label></td>
				<td width="40%"><label>{sort_search key="article.title" sort="title"}</label></td>
				<td width="15%" align="right"><label>{sort_search key="common.status" sort="status"}</label></td>
			</tr>
			<tr>
				<td colspan="6" class="headseparator">&nbsp;</td>
			</tr>

			{iterate from=submissions item=submission}
				{assign var="highlightClass" value=$submission->getHighlightClass()}
				{assign var="fastTracked" value=$submission->getFastTracked()}
				<tr valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
					<td>{$submission->getId()}</td>
					<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
					<td>{$submission->getSectionAbbrev()|escape}</td>
					<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
					<td><a href="{url op="submission" path=$submission->getId()}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
					<td align="right">
						{assign var="status" value=$submission->getSubmissionStatus()}
						{if $status == STATUS_ARCHIVED}
							{translate key="submissions.archived"}
						{elseif $status == STATUS_PUBLISHED}
							{print_issue_id articleId=$submission->getId()}
						{elseif $status == STATUS_DECLINED}
							{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
						{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
						{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
						{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
						{else}{* SUBMISSION_QUEUED -- between cracks? *}
							{translate key="submissions.queued"}
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
					<td align="right" colspan="2">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
				</tr>
			{/if}
		</table>
	</div>
{else}

	<div class="separator">&nbsp;</div>

{/if}{* displayResults *}

<div id="issues" class="col-md-12 mag-innert-left">
	<h3>{translate key="editor.navigation.issues"}</h3>
	<ul class="stay">
		<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li><a href="{url op="notifyUsers"}">{translate key="editor.notifyUsers"}</a></li>
		<li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
		{call_hook name="Templates::Editor::Index::Issues"}
	</ul>
</div>

{call_hook name="Templates::Editor::Index::AdditionalItems"}

{include file="common/footer.tpl"}