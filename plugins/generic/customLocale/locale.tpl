{**
 * plugins/generic/customLocale/locale.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List of component locales to edit for a particular locale
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="plugins.generic.customLocale.locale" locale=$locale}
{include file="common/header.tpl"}
{/strip}

<p class="help-block">{translate key="plugins.generic.customLocale.localeDescription"}</p>

<div id="localeFiles" class="col-md-12 mag-innert-left">
	<h3>{translate key="plugins.generic.customLocale.localeFiles"}</h3>

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr><td colspan="2" class="headseparator">&nbsp;</td></tr>
			<tr class="heading" valign="bottom">
				<td width="85%"><label>{translate key="plugins.generic.customLocale.file.filename"}</label></td>
				<td width="15%"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr><td colspan="2" class="headseparator">&nbsp;</td></tr>

			{iterate from=localeFiles item=filename}
				{assign var=filenameEscaped value=$filename|escape:"url"|escape:"url"}
				{if file_exists($filename)}
					{assign var=fileExists value=1}
				{else}
					{assign var=fileExists value=0}
				{/if}
				<tr valign="top">
					<td>
						{if $fileExists}
							{$filename|escape}
						{/if}
					</td>
					<td>
						{if $fileExists}
							<a href="{plugin_url path="editLocaleFile" key=$locale file=$filenameEscaped}" class="action">{translate key="common.edit"}</a>
						{/if}
					</td>
				</tr>
				<tr>
					<td colspan="2" class="{if $localeFiles->eof()}end{/if}separator">&nbsp;</td>
				</tr>
			{/iterate}

			{if $localeFiles->wasEmpty()}
				<tr>
					<td colspan="2" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td align="left">{page_info iterator=$localeFiles}</td>
					<td align="right">{page_links anchor="localeFiles" name="localeFiles" iterator=$localeFiles}</td>
				</tr>
			{/if}
		</table>
	</div>
</div>

{include file="common/footer.tpl"}