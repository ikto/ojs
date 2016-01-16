{**
 * templates/manager/languageSettings.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit journal language settings.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<p><p class="help-block">{translate key="manager.languages.languageInstructions"}</p></p>

{include file="common/formErrors.tpl"}

{if count($availableLocales) > 1}
<form method="post" action="{url op="saveLanguageSettings"}">

<div class="table-responsive">
<table class="table table-striped" width="100%">
<tr valign="top">
	<td width="20%" rowspan="2">{fieldLabel name="primaryLocale" required="true" key="locale.primary"}</td>
	<td width="80%" colspan="3" class="value">
		<select id="primaryLocale" name="primaryLocale" size="1" class="selectMenu">
			{html_options options=$availableLocales selected=$primaryLocale}
		</select>
	</td>
</tr>
<tr valign="top">
	<td colspan="3" class="value"><p class="help-block">{translate key="manager.languages.primaryLocaleInstructions"}</p></td>
</tr>
<tr valign="top">
	<td rowspan="2">{fieldLabel suppressId="true" name="supportedLocales" key="locale.supported"}</td>
	<td colspan="3" class="value">
		<div class="table-responsive">
		<table class="table table-striped" width="100%">
		<tr valign="top">
			<td width="20%">&nbsp;</td>
			<td align="center" width="10%">{translate key="manager.language.ui"}</td>
			<td align="center" width="20%">{translate key="manager.language.submissions"}</td>
			<td align="center" width="10%">{translate key="manager.language.forms"}</td>
			<td>&nbsp;</td>
		</tr>
		{foreach from=$availableLocales key=localeKey item=localeName}
			<tr>
				<td>{$localeName|escape}</td>
				<td align="center"><input type="checkbox" name="supportedLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedLocales)} checked="checked"{/if}/></td>
				<td align="center"><input type="checkbox" name="supportedSubmissionLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedSubmissionLocales)} checked="checked"{/if}/></td>
				<td align="center"><input type="checkbox" name="supportedFormLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedFormLocales)} checked="checked"{/if}/></td>
				<td><a href="{url op="reloadLocalizedDefaultSettings" localeToLoad=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="manager.language.confirmDefaultSettingsOverwrite"}')" class="action">{translate key="manager.language.reloadLocalizedDefaultSettings"}</a></td>
			</tr>
		{/foreach}
		</table>
		</div>
	</td>
</tr>
<tr valign="top">
	<td colspan="3" class="value"><p class="help-block">{translate key="manager.languages.supportedLocalesInstructions"}</p></td>
</tr>
</table>
</div>

<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager"}'" /></p>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>

</form>

{else}
<div class="separator"></div>
<p><p class="help-block">{translate key="manager.languages.noneAvailable"}</p></p>
{/if}

{include file="common/footer.tpl"}

