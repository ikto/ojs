{**
 * settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Contributed by Lepidus Tecnologia
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * ABNT Citation plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.citationFormats.abnt.manager.AbntCitationSettings"}
{include file="common/header.tpl"}
{/strip}

<div id="abntCitationSettings" class="col-md-12 mag-innert-left">
	<div id="description"><p class="help-block">{translate key="plugins.citationFormats.abnt.manager.settings.description"}</p></div>
 
	<div class="separator"></div>

	<br />

	<form role="form" name="setupForm" method="post" action="{plugin_url path="settings"}">
	
		{include file="common/formErrors.tpl"}

		{if count($formLocales) > 1}
			<div id="locales" class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{plugin_url|assign:"setupFormUrl" path="settings"}
							{form_language_chooser form="setupForm" url=$setupFormUrl}
							<span class="help-block">{translate key="form.formLanguage.description"}</span>
						</td>
					</tr>
				</table>
			</div>
		{/if}
		
		<br/>

		<table width="100%" class="data">
			<tr valign="top">
				<td width="20%" class="label">{fieldLabel name="location" key="plugins.citationFormats.abnt.manager.settings.location"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="location[{$formLocale|escape}]" id="location" value="{$location[$formLocale]|escape}" size="40" maxlength="120" class="form-control" /></div></td>
			</tr>
		</table>

		<br/>

		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/><input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
	</form>

	<p><span class="help-block">{translate key="common.requiredField"}</span></p>
</div>

{include file="common/footer.tpl"}