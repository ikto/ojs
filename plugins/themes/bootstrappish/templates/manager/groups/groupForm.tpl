{**
 * templates/manager/groups/groupForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Group form under journal management.
 *
 *}
{strip}
{assign var="pageId" value="manager.groups.groupForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}
<div id="groupFormDiv">
{if $group}
	<ul class="stay">
		<li class="current"><a href="{url op="editGroup" path=$group->getId()}">{translate key="manager.groups.editTitle"}</a></li>
		<li><a href="{url op="groupMembership" path=$group->getId()}">{translate key="manager.groups.membership}</a></li>
	</ul>
{/if}

<br/>

<form id="groupForm" method="post" action="{url op="updateGroup"}">
{if $group}
	<input type="hidden" name="groupId" value="{$group->getId()}"/>
{/if}

{include file="common/formErrors.tpl"}
<div class="table-responsive">
<table class="table table-striped" width="100%">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{if $group}{url|assign:"groupFormUrl" op="editGroup" path=$group->getId() escape=false}
			{else}{url|assign:"groupFormUrl" op="createGroup" escape=false}
			{/if}
			{form_language_chooser form="groupForm" url=$groupFormUrl}
			<p class="help-block">{translate key="form.formLanguage.description"}</p>
		</td>
	</tr>
{/if}
<tr valign="top">
	<td width="20%">{fieldLabel name="title" required="true" key="manager.groups.title"}</td>
	<td width="80%" class="value"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="35" maxlength="80" id="title" class="textField" /></td>
</tr>

<tr valign="top">
	<td width="20%">&nbsp;</td>
	<td width="80%" class="value">
		<input type="checkbox" name="publishEmail" value="1" {if $publishEmail}checked="checked" {/if} id="publishEmail" />&nbsp;
		{fieldLabel name="publishEmail" key="manager.groups.publishEmails"}
	</td>
</tr>
<tr valign="top">
	<td width="20%">{translate key="common.type"}</td>
	<td width="80%" class="value">
		{foreach from=$groupContextOptions item=groupContextOptionKey key=groupContextOptionValue}
			<input type="radio" name="context" value="{$groupContextOptionValue|escape}" {if $context == $groupContextOptionValue}checked="checked" {/if} id="context-{$groupContextOptionValue|escape}" />&nbsp;
			{fieldLabel name="context-"|concat:$groupContextOptionValue key=$groupContextOptionKey}<br />
		{/foreach}
	</td>
</tr>
</table>
</div>

<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="groups" escape=false}'" /></p>
</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>
</div>
{include file="common/footer.tpl"}

