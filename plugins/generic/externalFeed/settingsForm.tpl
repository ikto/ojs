{**
 * plugins/generic/externalFeed/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * External feed plugin settings
 *
 *}
{assign var="pageTitle" value="plugins.generic.externalFeed.manager.settings"}
{include file="common/header.tpl"}

<ul class="stay">
	<li><a href="{plugin_url path="feeds"}">{translate key="plugins.generic.externalFeed.manager.feeds"}</a></li>
	<li class="current"><a href="{plugin_url path="settings"}">{translate key="plugins.generic.externalFeed.manager.settings"}</a></li>
</ul>

<br />

<div class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td class="headseparator">&nbsp;</td>
		</tr>
		<tr>
			<td><p class="help-block">{translate key="plugins.generic.externalFeed.settings.description"}</p></td>
		</tr>
		<tr>
			<td class="headseparator">&nbsp;</td>
		</tr>
	</table>
</div>

<form role="form" method="post" action="{plugin_url path="settings"}" enctype="multipart/form-data">
	
	{include file="common/formErrors.tpl"}

	<h4>{translate key="plugins.generic.externalFeed.settings.styleSheet"}</h4>
	<p class="help-block">{translate key="plugins.generic.externalFeed.settings.stylesheetDescription"}: <a href="{$defaultStyleSheetUrl}" target="_blank">{translate key="plugins.generic.externalFeed.settings.defaultStyleSheet"}</a></p>

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%"><label class="control-label" for="externalFeedStyleSheet">{translate key="plugins.generic.externalFeed.settings.useStyleSheet"}</label></td>
				<td width="80%" class="value"><div class="form-group"><input type="file" name="externalFeedStyleSheet" id="externalFeedStyleSheet" class="form-control" /></div> <input type="submit" name="uploadStyleSheet" value="{translate key="common.upload"}" class="btn btn-success" /></td>
			</tr>
		</table>
	</div>

	{if $externalFeedStyleSheet}
		<p class="help-block">{translate key="common.fileName"}:</p> <a href="{$publicFilesDir}/{$externalFeedStyleSheet.uploadName|escape:"url"}" class="file">{$externalFeedStyleSheet.name|escape}</a> {$externalFeedStyleSheet.dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteStyleSheet" value="{translate key="common.delete"}" class="btn btn-danger" />
		<br/>
	{/if}

	<br/>

	<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/><input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
</form>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}