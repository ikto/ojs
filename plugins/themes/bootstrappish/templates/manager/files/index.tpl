{**
 * templates/manager/files/index.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Files browser.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.filesBrowser"}
{include file="common/header.tpl"}
{/strip}

{assign var=displayDir value="/$currentDir"}
<h3>{translate key="manager.files.indexOfDir" dir=$displayDir|escape}</h3>

{if $currentDir}
	<p><a href="{url op="files" path=$parentDir|explode:"/"}" class="action">&lt; {translate key="manager.files.parentDir"}</a></p>
{/if}

<div class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td class="headseparator" colspan="6">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td></td>
			<td width="25%"><label>{translate key="common.fileName"}</label></td>
			<td width="25%"><label>{translate key="common.type"}</label></td>
			<td width="25%"><label>{translate key="common.dateModified"}</label></td>
			<td width="5%"><label>{translate key="common.size"}</label></td>
			<td width="20%" align="right"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr>
			<td class="headseparator" colspan="6">&nbsp;</td>
		</tr>
		{foreach from=$files item=file name=files}
			{if $currentDir}
				{assign var=filePath value=$currentDir|concat:"/":$file.name}
			{else}
				{assign var=filePath value=$file.name}
			{/if}
			{assign var=filePath value=$filePath|escape}
			<tr valign="top">
				<td>{if $file.isDir}{icon name="folder"}{else}{icon name="letter"}{/if}</td>
				<td><a href="{url op="files" path=$filePath|explode:"/"}">{$file.name}</a></td>
				<td>{$file.mimetype|escape|default:"&mdash;"}</td>
				<td>{$file.mtime|escape|date_format:$datetimeFormatShort}</td>
				<td>{$file.size|escape|default:"&mdash;"}</td>
				<td align="right" class="nowrap">
					{if !$file.isDir}
						<a href="{url op="files" path=$filePath|explode:"/" download=1}" class="action">{translate key="common.download"}</a>&nbsp;|
					{/if}
					<a href="{url op="fileDelete" path=$filePath|explode:"/"}" onclick="return confirm('{translate|escape:"jsparam" key="manager.files.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
				</td>
			</tr>
			<tr>
				<td colspan="6" class="{if $smarty.foreach.files.last}end{/if}separator">&nbsp;</td>
			</tr>
		{foreachelse}
			<tr>
				<td colspan="6" class="nodata"><p class="help-block">{translate key="manager.files.emptyDir"}</p></td>
			</tr>
			<tr>
				<td colspan="6" class="endseparator">&nbsp;</td>
			</tr>
		{/foreach}
	</table>
</div>

<div class="col-md-12 mag-innert-left">
	<form role="form" method="post" action="{url op="fileUpload" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
		<div class="form-group"><input type="file" size="20" name="file" class="form-control" /></div>
		<input type="submit" value="{translate key="manager.files.uploadFile"}" class="btn btn-success" />
	</form>
</div>

<div class="col-md-12 mag-innert-left">
	<form role="form" method="post" action="{url op="fileMakeDir" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
		<div class="form-group"><input type="text" size="20" maxlength="255" name="dirName" class="form-control" /></div>
		<input type="submit" value="{translate key="manager.files.createDir"}" class="btn btn-success" />
	</form>
</div>

<p class="help-block">{translate key="manager.files.note"}</p>

{include file="common/footer.tpl"}