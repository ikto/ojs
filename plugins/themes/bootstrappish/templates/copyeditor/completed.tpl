{**
 * templates/copyeditor/completed.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show copyeditor's submission archive.
 *
 *}
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

<div id="search" class="col-md-12 mag-innert-left">
	<form role="form" class="form-inline" method="post" id="submit" action="{url op="index" path=$pageToDisplay}">
		<div class="form-group">
			<select name="searchField" size="1" class="form-control">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<input type="hidden" name="sort" value="id"/>
		<input type="hidden" name="sortDirection" value="ASC"/>
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

<div id="submissions" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="8" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_search key="common.id" sort="id"}</label></td>
			<td width="5%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>{sort_search key="common.assign" sort="assignDate"}</label></td>
			<td width="5%"><label>{sort_search key="submissions.sec" sort="section"}</label></td>
			<td width="25%"><label>{sort_search key="article.authors" sort="authors"}</label></td>
			<td width="30%"><label>{sort_search key="article.title" sort="title"}</label></td>
			<td width="5%"><label>{sort_search key="submission.complete" sort="dateCompleted"}</label></td>
			<td width="25%" align="right"><label>{sort_search key="common.status" sort="status"}</label></td>
		</tr>
		<tr><td colspan="8" class="headseparator">&nbsp;</td></tr>
		{iterate from=submissions item=submission}
			{assign var="articleId" value=$submission->getId()}
			{assign var="initialCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
			{assign var="finalCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
			<tr valign="top">
				<td>{$articleId|escape}</td>
				<td>{$initialCopyeditSignoff->getDateNotified()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url op="submission" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td>{$finalCopyeditSignoff->getDateCompleted()|date_format:$dateFormatTrunc}</td>
				<td align="right">
					{assign var="status" value=$submission->getStatus()}
					{if $status == STATUS_ARCHIVED}
						{translate key="submissions.archived"}
					{elseif $status == STATUS_QUEUED}
						{translate key="submissions.queued"}
					{elseif $status == STATUS_PUBLISHED}
						{print_issue_id articleId="$articleId"}
					{elseif $status == STATUS_DECLINED}
						{translate key="submissions.declined"}
					{/if}
				</td>
			</tr>

			<tr>
				<td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $submissions->wasEmpty()}
			<tr>
				<td colspan="7" class="nodata"><p class="help-block">{translate key="submissions.noSubmissions"}</p></td>
			</tr>
			<tr>
				<td colspan="7" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="5" align="left">{page_info iterator=$submissions}</td>
				<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>