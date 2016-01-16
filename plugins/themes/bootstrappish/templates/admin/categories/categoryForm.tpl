{**
 * templates/admin/categories/categoryForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Category form under site administration.
 *
 *}
{strip}
{assign var="pageId" value="admin.categories.categoryForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}
<div id="categoryFormDiv">

<form role="form" id="categoryForm" method="post" action="{url op="updateCategory"}">
<div class="form-group">
{if $category}
	<input type="hidden" name="categoryId" value="{$category->getId()}"/>
{/if}

{include file="common/formErrors.tpl"}
<div class="table-responsive">
<table class="table table-striped" width="100%">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{if $category}{url|assign:"categoryFormUrl" op="editCategory" path=$category->getId() escape=false}
			{else}{url|assign:"categoryFormUrl" op="createCategory" escape=false}
			{/if}
			{form_language_chooser form="categoryForm" url=$categoryFormUrl}
			<p class="help-block">{translate key="form.formLanguage.description"}</p>
		</td>
	</tr>
{/if}
<tr valign="top">
	<td width="20%">{fieldLabel name="name" required="true" key="admin.categories.name"}</td>
	<td width="80%" class="value"><input type="text" name="name[{$formLocale|escape}]" value="{$name[$formLocale]|escape}" size="35" maxlength="80" id="name" class="form-control" /></td>
</tr>
</table>
</div>
<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="categories" escape=false}'" /></p>
</div>
</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>
</div>
{include file="common/footer.tpl"}

