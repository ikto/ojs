{**
 * templates/manager/announcement/announcementTypeForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement type form under management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$announcementTypeTitle"}
{if $typeId}
	{assign var="pageTitle" value="manager.announcementTypes.edit"}
{else}
	{assign var="pageTitle" value="manager.announcementTypes.create"}
{/if}
{assign var="pageId" value="manager.announcementTypes.announcementTypeForm"}
{include file="common/header.tpl"}
{/strip}

<br/>

<div id="announcementType" class="col-md-12 mag-innert-left">
	<form role="form" id="announcementTypeForm" method="post" action="{url op="updateAnnouncementType"}">
		
		{if $typeId}
			<input type="hidden" name="typeId" value="{$typeId|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				{if count($formLocales) > 1}
					<tr valign="top">
						<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{if $typeId}{url|assign:"announcementTypeUrl" op="editAnnouncementType" path=$typeId escape=false}
							{else}{url|assign:"announcementTypeUrl" op="createAnnouncementType" escape=false}
							{/if}
							{form_language_chooser form="announcementTypeForm" url=$announcementTypeUrl}
							<p class="help-block">{translate key="form.formLanguage.description"}</p>
						</td>
					</tr>
				{/if}
				<tr valign="top">
					<td width="20%">{fieldLabel name="name" required="true" key="manager.announcementTypes.form.typeName"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="name[{$formLocale|escape}]" value="{$name[$formLocale]|escape}" size="40" id="name" maxlength="80" class="form-control" /></div></td>
				</tr>
			</table>
		</div>

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $typeId}<input type="submit" name="createAnother" value="{translate key="manager.announcementTypes.form.saveAndCreateAnother"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="announcementTypes" escape=false}'" /></p>
	</form>
</div>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}