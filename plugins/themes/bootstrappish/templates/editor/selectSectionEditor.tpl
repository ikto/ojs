{**
 * templates/editor/selectSectionEditor.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List editors or section editors and give the ability to select one.
 *
 *}
{strip}
{assign var="pageTitle" value=$roleName|concat:"s"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="editor.article.selectEditor" roleName=$roleName|translate}</h3>

<form role="form" id="submit" method="post" action="{url op="assignEditor" path=$rolePath articleId=$articleId}">
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
	<div class="form-group"><input type="text" name="search" class="form-control" value="{$search|escape}" />&nbsp;</div><input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
</form>

<p class="text">{foreach from=$alphaList item=letter}<a href="{url op="assignEditor" path=$rolePath articleId=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="assignEditor" articleId=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<div id="editors" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
		<tr valign="bottom">
			<td class="heading" width="30%"><label>{translate key="user.name"}</label></td>
			<td class="heading" width="20%"><label>{translate key="section.sections"}</label></td>
			<td class="heading" width="20%"><label>{translate key="submissions.completed"}</label></td>
			<td class="heading" width="20%"><label>{translate key="submissions.active"}</label></td>
			<td class="heading" width="10%"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
		{iterate from=editors item=editor}
			{assign var=editorId value=$editor->getId()}
			<tr valign="top">
				<td><a class="action" href="{url op="userProfile" path=$editorId}">{$editor->getFullName()|escape}</a></td>
				<td>
					{assign var=thisEditorSections value=$editorSections[$editorId]}
					{foreach from=$thisEditorSections item=section}
						{$section->getLocalizedAbbrev()|escape}&nbsp;
					{foreachelse}
						&mdash;
					{/foreach}
				</td>
				<td>
					{if $editorStatistics[$editorId] && $editorStatistics[$editorId].complete}
						{$editorStatistics[$editorId].complete}
					{else}
						0
					{/if}
				</td>
				<td>
					{if $editorStatistics[$editorId] && $editorStatistics[$editorId].incomplete}
						{$editorStatistics[$editorId].incomplete}
					{else}
						0
					{/if}
				</td>
				<td><a class="action" href="{url op="assignEditor" articleId=$articleId editorId=$editorId}">{translate key="common.assign"}</a></td>
			</tr>
			<tr><td colspan="5" class="{if $editors->eof()}end{/if}separator">&nbsp;</td></tr>
		{/iterate}
		{if $editors->wasEmpty()}
			<tr>
			<td colspan="5" class="nodata"><p class="help-block">{translate key="manager.people.noneEnrolled"}</p></td>
			</tr>
			<tr><td colspan="5" class="{if $editors->eof()}end{/if}separator">&nbsp;</td></tr>
		{else}
			<tr>
				<td colspan="2" align="left">{page_info iterator=$editors}</td>
				<td colspan="3" align="right">{page_links anchor="editors" name="editors" iterator=$editors searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth articleId=$articleId}</td>
			</tr>
		{/if}
	</table>
</div>

{include file="common/footer.tpl"}