{**
 * templates/manager/sections/sectionForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a journal section.
 *
 *}
{strip}
{assign var="pageTitle" value="section.section"}
{assign var="pageCrumbTitle" value="section.section"}
{include file="common/header.tpl"}
{/strip}

<form role="form" id="section" method="post" action="{url op="updateSection" path=$sectionId}" onsubmit="return checkEditorAssignments()">
	<input type="hidden" name="editorAction" value="" />
	<input type="hidden" name="userId" value="" />

	<script type="text/javascript">
	{literal}
	<!--

	function addSectionEditor(editorId) {
		var sectionForm = document.getElementById('section');
		sectionForm.editorAction.value = "addSectionEditor";
		sectionForm.userId.value = editorId;
		sectionForm.submit();
	}

	function removeSectionEditor(editorId) {
		var sectionForm = document.getElementById('section');
		sectionForm.editorAction.value = "removeSectionEditor";
		sectionForm.userId.value = editorId;
		sectionForm.submit();
	}

	function checkEditorAssignments() {
		var isOk = true;
		{/literal}
		{foreach from=$assignedEditors item=editorEntry}
		{assign var=editor value=$editorEntry.user}
		{literal}
			if (!document.getElementById('section').canReview{/literal}{$editor->getId()}{literal}.checked && !document.getElementById('section').canEdit{/literal}{$editor->getId()}{literal}.checked) {
				isOk = false;
			}
		{/literal}{/foreach}{literal}
		if (!isOk) {
			alert({/literal}'{translate|escape:"jsparam" key="manager.sections.form.mustAllowPermission"}'{literal});
			return false;
		}
		return true;
	}

	// -->
	{/literal}
	</script>

	{include file="common/formErrors.tpl"}
	
	<div id="sectionForm" class="table-responsive">
		<table class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{if $sectionId}{url|assign:"sectionFormUrl" op="editSection" path=$sectionId escape=false}
						{else}{url|assign:"sectionFormUrl" op="createSection" path=$sectionId escape=false}
						{/if}
						{form_language_chooser form="section" url=$sectionFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{fieldLabel name="title" required="true" key="section.title"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="abbrev" required="true" key="section.abbreviation"}</td>
				<td class="value"><div class="form-group"><input type="text" name="abbrev[{$formLocale|escape}]" id="abbrev" value="{$abbrev[$formLocale]|escape}" size="20" maxlength="20" class="form-control" /><p class="help-block">{translate key="section.abbreviation.example"}</p></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="policy" key="manager.sections.policy"}</td>
				<td class="value"><div class="form-group"><textarea name="policy[{$formLocale|escape}]" rows="4" cols="40" id="policy" class="form-control">{$policy[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="reviewFormId" key="submission.reviewForm"}</td>
				<td class="value">
					<div class="form-group">
						<select name="reviewFormId" size="1" id="reviewFormId" class="form-control">
							<option value="">{translate key="manager.reviewForms.noneChosen"}</option>
							{html_options options=$reviewFormOptions selected=$reviewFormId}
						</select>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td rowspan="4">{fieldLabel suppressId="true" key="submission.indexing"}</td>
				<td class="value">
					<label class="help-block">{translate key="manager.section.submissionsToThisSection"}:</label><br/>
					<div class="form-group">
						<input type="checkbox" name="metaReviewed" id="metaReviewed" value="1" {if $metaReviewed}checked="checked"{/if} />
						{fieldLabel name="metaReviewed" key="manager.sections.submissionReview"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="abstractsNotRequired" id="abstractsNotRequired" value="1" {if $abstractsNotRequired}checked="checked"{/if} />
						{fieldLabel name="abstractsNotRequired" key="manager.sections.abstractsNotRequired"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="metaIndexed" id="metaIndexed" value="1" {if $metaIndexed}checked="checked"{/if} />
						{fieldLabel name="metaIndexed" key="manager.sections.submissionIndexing"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td class="value">
					{fieldLabel name="identifyType" key="manager.sections.identifyType"}: <div class="form-group"><input type="text" name="identifyType[{$formLocale|escape}]" id="identifyType" value="{$identifyType[$formLocale]|escape}" size="20" maxlength="60" class="form-control" /></div>
					<p class="help-block">{translate key="manager.sections.identifyTypeExamples"}</p>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel suppressId="true" key="submission.restrictions"}</td>
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="editorRestriction" id="editorRestriction" value="1" {if $editorRestriction}checked="checked"{/if} />
						{fieldLabel name="editorRestriction" key="manager.sections.editorRestriction"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel key="manager.sections.wordCount"}</td>
				<td class="value">
					{fieldLabel name="wordCount" key="manager.sections.wordCountInstructions"}&nbsp;&nbsp;<div class="form-group"><input type="text" name="wordCount" id="abbrev" value="{$wordCount}" size="10" maxlength="20" class="form-control" /></div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="hideTitle" key="issue.toc"}</td>
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="hideTitle" id="hideTitle" value="1" {if $hideTitle}checked="checked"{/if} />
						{fieldLabel name="hideTitle" key="manager.sections.hideTocTitle"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="hideAuthor" id="hideAuthor" value="1" {if $hideAuthor}checked="checked"{/if} />
						{fieldLabel name="hideAuthor" key="manager.sections.hideTocAuthor"}
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="hideAbout" key="navigation.about"}</td>
				<td class="value">
					<div class="form-group">
						<input type="checkbox" name="hideAbout" id="hideAbout" value="1" {if $hideAbout}checked="checked"{/if} />
						{fieldLabel name="hideAbout" key="manager.sections.hideAbout"}
					</div>
				</td>
			</tr>
			{if $commentsEnabled}
				<tr valign="top">
					<td>{fieldLabel name="disableComments" key="comments.readerComments"}</td>
					<td class="value">
						<div class="form-group">
							<input type="checkbox" name="disableComments" id="disableComments" value="1" {if $disableComments}checked="checked"{/if} />
							{fieldLabel name="disableComments" key="manager.sections.disableComments"}
						</div>
					</td>
				</tr>
			{/if}
		</table>
	</div>
	
	<div class="separator"></div>
	
	<div id="sectionEditors" class="col-md-12 mag-innert-left">
		<h3>{translate key="user.role.sectionEditors"}</h3>
		{url|assign:"sectionEditorsUrl" op="people" path="sectionEditors"|to_array}
		<p class="help-block">{translate key="manager.section.sectionEditorInstructions"}</p>
		<h4>{translate key="manager.sections.unassigned"}</h4>

		<div class="table-responsive">
			<table width="100%" class="table table-striped" id="unassignedSectionEditors">
				<tr>
					<td colspan="3" class="headseparator">&nbsp;</td>
				</tr>
				<tr valign="top" class="heading">
					<td width="20%"><label>{translate key="user.username"}</label></td>
					<td width="60%"><label>{translate key="user.name"}</label></td>
					<td width="20%" align="right"><label>{translate key="common.action"}</label></td>
				</tr>
				<tr>
					<td colspan="3" class="headseparator">&nbsp;</td>
				</tr>
				{foreach from=$unassignedEditors item=editor}
					<tr valign="top">
						<td>{$editor->getUsername()|escape}</td>
						<td>{$editor->getFullName()|escape}</td>
						<td align="right">
							<a class="action" href="javascript:addSectionEditor({$editor->getId()})">{translate key="common.add"}</a>
						</td>
					</tr>
				{foreachelse}
					<tr>
						<td colspan="3" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
					</tr>
				{/foreach}
				<tr>
					<td colspan="3" class="endseparator">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div id="sectionsAssigned" class="col-md-12 mag-innert-left">
		<h4>{translate key="manager.sections.assigned"}</h4>

		<div class="table-responsive">
			<table width="100%" class="table table-striped" id="assignedSectionEditors">
				<tr>
					<td colspan="5" class="headseparator">&nbsp;</td>
				</tr>
				<tr valign="top" class="heading">
					<td width="20%"><label>{translate key="user.username"}</label></td>
					<td width="40%"><label>{translate key="user.name"}</label></td>
					<td width="10%" align="center"><label>{translate key="submission.review"}</label></td>
					<td width="10%" align="center"><label>{translate key="submission.editing"}</label></td>
					<td width="20%" align="right"><label>{translate key="common.action"}</label></td>
				</tr>
				<tr>
					<td colspan="5" class="headseparator">&nbsp;</td>
				</tr>
				{foreach from=$assignedEditors item=editorEntry}
					{assign var=editor value=$editorEntry.user}
					<input type="hidden" name="assignedEditorIds[]" value="{$editor->getId()|escape}" />
					<tr valign="top">
						<td>{$editor->getUsername()|escape}</td>
						<td>{$editor->getFullName()|escape}</td>
						<td align="center"><div class="form-group"><input type="checkbox" {if $editorEntry.canReview}checked="checked"{/if} name="canReview{$editor->getId()}" /></div></td>
						<td align="center"><div class="form-group"><input type="checkbox" {if $editorEntry.canEdit}checked="checked"{/if} name="canEdit{$editor->getId()}" /></div></td>
						<td align="right">
							<a class="action" href="javascript:removeSectionEditor({$editor->getId()})">{translate key="common.remove"}</a>
						</td>
					</tr>
					{foreachelse}
						<tr>
							<td colspan="5" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
						</tr>
					{/foreach}
					<tr>
						<td colspan="5" class="endseparator">&nbsp;</td>
					</tr>
			</table>
		</div>
	</div>
	
	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="sections" escape=false}'" /></p>
</form>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}