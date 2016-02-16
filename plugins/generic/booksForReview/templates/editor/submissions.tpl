{**
 * @file plugins/generic/booksForReview/templates/editor/submissions.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Selection form for book for review submissions.
 *
 *}
{assign var="pageTitle" value="plugins.generic.booksForReview.editor.selectSubmission"}
{include file="common/header.tpl"}

<form role='form" class="form-inline" method="post" id="submit" action="{url op="selectBookForReviewSubmission" path=$bookId returnPage=$returnPage}">
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

<br />

<a name="submissions"></a>

<div class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td colspan="5" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{translate key="common.id"}</label></td>
			<td width="5%"><label>{translate key="submissions.sec"}</label></td>
			<td width="30%"><label>{translate key="article.authors"}</label></td>
			<td width="50%"><label>{translate key="article.title"}</label></td>
			<td width="10%" align="right"></td>
		</tr>
		<tr>
			<td colspan="5" class="headseparator">&nbsp;</td>
		</tr>

		{iterate from=submissions item=submission}
			<tr valign="top">
				<td>{$submission->getId()}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
				<td><a href="{url page="editor" op="submission" path=$submission->getId()}" class="action">{$submission->getArticleTitle()|strip_tags|truncate:60:"..."}</a></td>
				<td align="right" class="nowrap">
					<a href="{url op="assignBookForReviewSubmission" path=$bookId returnPage=$returnPage articleId=$submission->getId()}" class="action">{translate key="plugins.generic.booksForReview.editor.select"}</a>
			</td>
			</tr>
			<tr>
				<td colspan="5" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $submissions->wasEmpty()}
			<tr>
				<td colspan="5" class="nodata"><p class="help-block">{translate key="editor.submissions.noSubmissions"}</p></td>
			</tr>
			<tr>
				<td colspan="5" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="4" align="left">{page_info iterator=$submissions}</td>
				<td align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search}</td>
			</tr>
		{/if}
	</table>
</div>

{include file="common/footer.tpl"}