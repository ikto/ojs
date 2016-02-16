{**
 * templates/submission/layout/galleyView.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Read-only view of galley information.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.galley"}
{include file="common/header.tpl"}
{/strip}

<div id="galleyFileData" class="col-md-12 mag-innert-left">
	<p class="help-block">{translate key="submission.layout.galleyFileData"}</p>

	<div class="table-responsive">
		<table class="table table-striped">
			<tr valign="top">
				<td width="20%">{translate key="submission.layout.galleyLabel"}</td>
				<td width="80%" class="value">{$galley->getGalleyLabel()|escape}</td>
			</tr>

			{if $galley->getPubId('publisher-id')}
				<tr valign="top">
					<td>{translate key="submission.layout.publicGalleyId"}</td>
					<td class="value">{$galley->getPubId('publisher-id')|escape}</td>
				</tr>
			{/if}

			<tr valign="top">
				<td>{translate key="common.fileName"}</td>
				<td class="value"><a class="action" href="{url op="downloadFile" path=$articleId|to_array:$galley->getFileId()}">{$galley->getFileName()|escape}</a></td>
			</tr>
			<tr valign="top">
				<td>{translate key="common.fileType"}</td>
				<td class="value">{$galley->getFileType()|escape}</td>
			</tr>
			<tr valign="top">
				<td>{translate key="common.fileSize"}</td>
				<td class="value">{$galley->getNiceFileSize()}</td>
			</tr>
		</table>
	</div>
</div>

{if $galley->isHTMLGalley()}
	<div id="htmlGalley" class="col-md-12 mag-innert-left">
		<h3>{translate key="submission.layout.galleyHTMLData"}</h3>
		{assign var=styleFile value=$galley->getStyleFile()}

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td colspan="2"><strong>{translate key="submission.layout.galleyStylesheet"}</strong></td>
				</tr>
				{if $styleFile}
					<tr valign="top>
						<td>{translate key="common.fileName"}</td>
						<td class="value"><a href="{url op="downloadFile" path=$articleId|to_array:$styleFile->getFileId()}" class="action">{$styleFile->getFileName()|escape}</a></td>
					</tr>
					<tr valign="top">
						<td>{translate key="common.fileSize"}</td>
						<td class="value">{$styleFile->getNiceFileSize()}</td>
					</tr>
					<tr>
						<td>{translate key="common.dateUploaded"}</td>
						<td class="value">{$styleFile->getDateUploaded()|date_format:$datetimeFormatShort}</td>
					</tr>
				{else}
					<tr valign="top">
						<td colspan="2" class="nodata"><p class="help-block">{translate key="submission.layout.noStyleFile"}</p></td>
					</tr>
				{/if}
			</table>
		</div>
	</div>
	<div id="galleyImages" class="col-md-12 mag-innert-left">
		<strong>{translate key="submission.layout.galleyImages"}</strong>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
				<tr class="heading" valign="bottom">
					<td width="40%"><label>{translate key="common.fileName"}</label></td>
					<td width="20%"><label>{translate key="common.originalFileName"}</label></td>
					<td width="20%"><label>{translate key="common.fileSize"}</label></td>
					<td width="20%"><label>{translate key="common.dateUploaded"}</label></td>
				</tr>
				<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
				{foreach name="images" from=$galley->getImageFiles() item=imageFile}
					<tr valign="top">
						<td><a class="action" href="{url op="downloadFile" path=$articleId|to_array:$imageFile->getFileId()}">{$imageFile->getFileName()|escape}</a></td>
						<td>{$imageFile->getOriginalFileName()|escape}</td>
						<td>{$imageFile->getNiceFileSize()}</td>
						<td>{$imageFile->getDateUploaded()|date_format:$dateFormatShort}</td>
					</tr>
					<tr valign="top">
						<td colspan="4" class="{if $smarty.foreach.submissions.last}end{/if}separator">&nbsp;</td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td colspan="4" class="nodata"><p class="help-block">{translate key="submission.layout.galleyNoImages"}</p></td>
					</tr>
					<tr valign="top">
						<td colspan="4" class="endseparator">&nbsp;</td>
					</tr>
				{/foreach}
			</table>
		</div>
	</div>
{/if}
</form>

{include file="common/footer.tpl"}