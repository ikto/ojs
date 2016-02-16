{**
 * templates/admin/languages.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit site language settings.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<form role="form" method="post" action="{url op="saveLanguageSettings"}">
	<div id="languageSettings" class="col-md-12 mag-innert-left">
		<h3>{translate key="admin.languages.languageSettings"}</h3>

		<div class="table-responsive">
			<table class="table table-striped">
				<tr valign="top">
					<td width="20%"><label>{translate key="locale.primary"}</label></td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="primaryLocale" id="primaryLocale" size="1" class="form-control">
								{foreach from=$installedLocales item=localeKey}
									<option value="{$localeKey|escape}"{if $localeKey == $primaryLocale} selected="selected"{/if}>{$localeNames.$localeKey|escape}</option>
								{/foreach}
							</select>
							<p class="help-block">{translate key="admin.languages.primaryLocaleInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td><label>{translate key="locale.supported"}</label></td>
					<td>
						<table class="table table-striped" width="100%">
							{foreach from=$installedLocales item=localeKey}
								<tr valign="top">
									<td width="5%"><div class="form-group"><input type="checkbox" name="supportedLocales[]" id="supportedLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $supportedLocales)} checked="checked"{/if} /></div></td>
									<td width="95%">
										<label for="supportedLocales-{$localeKey|escape}">{$localeNames.$localeKey|escape}</label>
										{if !$localesComplete[$localeKey]}
											*
											{assign var=incompleteLocaleFound value=1}
										{/if}
									</td>
								</tr>
							{/foreach}
						</table>
						<p class="help-block">{translate key="admin.languages.supportedLocalesInstructions"}</p>
						{if $incompleteLocaleFound}
							<br/>
							<label class="help-block">* {translate key="admin.locale.maybeIncomplete"}</label>
						{/if}{* $incompleteLocaleFound *}
					</td>
				</tr>
			</table>
		</div>
		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="admin" escape=false}'" /></p>
	</div>
</form>

<div class="separator"></div>

<form role="form" method="post" action="{url op="installLocale"}">
	<div id="installLanguages" class="col-md-12 mag-innert-left">
		<h3>{translate key="admin.languages.installLanguages"}</h3>
		<h4>{translate key="admin.languages.installedLocales"}</h4>
		
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				{foreach from=$installedLocales item=localeKey}
					<tr valign="top">
						<td width="30%">&bull;&nbsp;{$localeNames.$localeKey|escape} ({$localeKey|escape})</td>
						<td width="70%"><a href="{url op="reloadLocale" locale=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="admin.languages.confirmReload"}')" class="action">{translate key="admin.languages.reload"}</a>{if $localeKey != $primaryLocale}&nbsp;|&nbsp;<a href="{url op="uninstallLocale" locale=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="admin.languages.confirmUninstall"}')" class="action">{translate key="admin.languages.uninstall"}</a>{/if}</td>
					</tr>
				{/foreach}
			</table>
		</div>
	</div>
	
	<div id="installNewLocales" class="col-md-12 mag-innert-left">
		<h4>{translate key="admin.languages.installNewLocales"}</h4>
		<p class="help-block">{translate key="admin.languages.installNewLocalesInstructions"}</p>
		
		{assign var=incompleteLocaleFound value=0}
		
		{foreach from=$uninstalledLocales item=localeKey}
			<div class="form-group"><input type="checkbox" name="installLocale[]" id="installLocale-{$localeKey|escape}" value="{$localeKey|escape}" /> <label for="installLocale-{$localeKey|escape}">{$localeNames.$localeKey|escape} ({$localeKey|escape})</label>
				{if !$localesComplete[$localeKey]}
					*
					{assign var=incompleteLocaleFound value=1}
				{/if}
			</div>
		
			<br />
		
		{foreachelse}
			{assign var="noLocalesToInstall" value="1"}
			<p class="help-block">{translate key="admin.languages.noLocalesAvailable"}</p>
		{/foreach}
		{if $incompleteLocaleFound}
			<label class="help-block">* {translate key="admin.locale.maybeIncomplete"}</label>
		{/if}{* $incompleteLocaleFound *}

		{if not $noLocalesToInstall}
			<p><input type="submit" value="{translate key="admin.languages.installLocales"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="admin" escape=false}'" /></p>
		{/if}
	</div>
</form>

<div class="separator"></div>

<div id="downloadLocales" class="col-md-12 mag-innert-left">
	<h3>{translate key="admin.languages.downloadLocales"}</h3>

	{if $downloadAvailable}
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				{foreach from=$downloadableLocales item=downloadableLocale}
					<tr valign="top">
						<td width="30%">&bull;&nbsp;{$downloadableLocale.name|escape} ({$downloadableLocale.key})</td>
						<td width="70%">
							<a href="{url op="downloadLocale" locale=$downloadableLocale.key}" class="action">{translate key="admin.languages.download"}</a>
						</td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td colspan="4" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
					</tr>
				{/foreach}
			</table>
		</div>
	{else}{* not $downloadAvailable *}
		<p class="help-block">{translate key="admin.languages.downloadUnavailable"}</p>
	{/if}{* $downloadAvailable *}
</div>

{include file="common/footer.tpl"}