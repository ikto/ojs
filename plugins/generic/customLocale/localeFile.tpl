{**
 * plugins/generic/customLocale/localeFile.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Customize a specific locale file.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="plugins.generic.customLocale.locale" locale=$locale}
{include file="common/header.tpl"}
{/strip}

{assign var=filenameEscaped value=$filename|escape:"url"|escape:"url"}

<form role="form" id="reference">
	{foreach from=referenceLocaleContents key=key item=value}<input type="hidden" name="{$key|escape}" value="{$key|escape}"/>{/foreach}
</form>

<form role="form" id="localeSearch" action="{plugin_url path="editLocaleFile" key=$locale file=$filenameEscaped  anchor="localeContents"}" method="post">
	<p class="help-block">{translate key="plugins.generic.customLocale.localeKey"}&nbsp;&nbsp;</p>
	<div class="form-group"><input type="text" name="searchKey" class="form-control" />&nbsp;&nbsp;</p>
	<input type="submit" class="btn btn-info" onclick="document.getElementById('locale').redirectUrl.value=document.localeSearch.action);document.getElementById('locale').submit();return false;" value="{translate key="common.search"}" /> <p class="help-block">{translate key="plugins.generic.customLocale.localeKey.description"}</p>
</form>

<br />
<p class="help-block">{translate key="plugins.generic.customLocale.fileDescription"}</p>

<form role="form" id="locale" action="{plugin_url path="saveLocaleFile" key=$locale file=$filenameEscaped }" method="post">

	<input type="hidden" name="redirectUrl" value="" />

	<div id="localeContents" class="col-md-12 mag-innert-left">
		<h3>{translate key="plugins.generic.customLocale.file.edit" filename=$filename}</h3>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr><td colspan="3" class="headseparator">&nbsp;</td></tr>
				<tr class="heading" valign="bottom">
					<td width="35%"><label>{translate key="plugins.generic.customLocale.localeKey"}</label></td>
					<td width="60%"><label>{translate key="plugins.generic.customLocale.localeKeyValue"}</label></td>
				</tr>
				<tr><td colspan="2" class="headseparator">&nbsp;</td></tr>

				{iterate from=referenceLocaleContents key=key item=referenceValue}
					{assign var=filenameEscaped value=$filename|escape:"url"|escape:"url"}
					<tr valign="top"{if $key == $searchKey} class="highlight"{/if}>
						<td>{$key|escape}</td>
						<td>
							<input type="hidden" name="changes[]" value="{$key|escape}" />
							{if $localeContents != null}{assign var=value value=$localeContents.$key}{else}{assign var=value value=''}{/if}
							{if ($value|explode:"\n"|@count > 1) || (strlen($value) > 80) || ($referenceValue|explode:"\n"|@count > 1) || (strlen($referenceValue) > 80)}
								<div class="form-group">
									<p class="help-block">{translate key="plugins.generic.customLocale.file.reference"}</p><br/>
									<textarea name="junk[]" class="form-control" rows="5" cols="50" onkeypress="return (event.keyCode >= 37 && event.keyCode <= 40);">{$referenceValue|escape}</textarea>
								</div>
								<div class="form-group">
									<p class="help-block">{translate key="plugins.generic.customLocale.file.custom"}</p><br/>
									<textarea name="changes[]" class="form-control" rows="5" cols="50">{$value|escape}</textarea>
								</div>
							{else}
								<div class="form-group">
									<p class="help-block">{translate key="plugins.generic.customLocale.file.reference"}</p><br/>
									<input name="junk[]" class="form-control" class="textField" type="text" size="50" onkeypress="return (event.keyCode >= 37 && event.keyCode <= 40);" value="{$referenceValue|escape}" /><br/>
								</div>
								<div class="form-group">
									<p class="help-block">{translate key="plugins.generic.customLocale.file.custom"}</p><br/>
									<input name="changes[]" class="form-control" class="textField" type="text" size="50" value="{$value|escape}" />
								</div>
							{/if}
						</td>
					</tr>
					<tr>
						<td colspan="2" class="{if $referenceLocaleContents->eof()}end{/if}separator">&nbsp;</td>
					</tr>
				{/iterate}

				{if $referenceLocaleContents->wasEmpty()}
					<tr>
						<td colspan="2" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
					</tr>
					<tr>
						<td colspan="2" class="endseparator">&nbsp;</td>
					</tr>
				{else}
					<tr>
						<td align="left">{page_info iterator=$referenceLocaleContents}</td>
						<td align="right">{page_links all_extra="onclick=\"document.getElementById('locale').redirectUrl.value=this.href;this.href='javascript:document.getElementById(\'locale\').submit()';return true;\"" anchor="localeContents" name="referenceLocaleContents" iterator=$referenceLocaleContents}</td>
					</tr>
				{/if}
			</table>
		</div>

		{if $referenceLocaleContents->getPage() < $referenceLocaleContents->getPageCount()}
			<input type="submit" onclick="document.getElementById('locale').redirectUrl.value='{plugin_url path="editLocaleFile" key=$locale file=$filenameEscaped referenceLocaleContentsPage=$referenceLocaleContents->getPage()+1 escape="false"}';return true;" class="btn btn-success" value="{translate key="common.saveAndContinue"}" />
		{else}
			<input type="submit" onclick="document.getElementById('locale').redirectUrl.value='{plugin_url path="editLocaleFile" key=$locale file=$filenameEscaped referenceLocaleContentsPage=$referenceLocaleContents->getPage() escape="false"}';return true;" class="btn btn-success" value="{translate key="common.save"}" />
		{/if}

		<input type="submit" onclick="document.getElementById('locale').redirectUrl.value='{plugin_url path="edit" key=$locale escape="false"}';return true;" class="btn btn-success" value="{translate key="common.done"}" />

		<input type="button" onclick="document.location.href='{plugin_url path="edit" key=$locale escape="false"}';" class="btn btn-danger" value="{translate key="common.cancel"}" />
	</div>
</form>

{include file="common/footer.tpl"}