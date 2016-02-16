{**
 * templates/submission/layout/galleyForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to add/edit a galley.
 *}
{strip}
{assign var="pageTitle" value="submission.galley"}
{include file="common/header.tpl"}
{/strip}

<div id="galleyForm" class="col-md-12 mag-innert-left">
	<h3>{if $galleyId}{translate key="submission.layout.editGalley"}{else}{translate key="submission.layout.addGalley"}{/if}</h3>

	<br />

	<form role="form" method="post" action="{url op="saveGalley" path=$articleId|to_array:$galleyId}" enctype="multipart/form-data">
		
		{include file="common/formErrors.tpl"}

		<div id="galleyFileData" class="col-md-12 mag-innert-left">
			<p class="help-block">{translate key="submission.layout.galleyFileData"}</p>

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td width="20%">{fieldLabel name="label" required="true" key="submission.layout.galleyLabel"}</td>
						<td width="80%" class="value"><div class="form-group"><input type="text" id="label" name="label" value="{$label|escape}" size="40" maxlength="32" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="instruct"><p class="help-block">{translate key="submission.layout.galleyLabelInstructions"}</p></td>
					</tr>

					{if $enablePublicGalleyId}
						<tr valign="top">
							<td>{fieldLabel name="publicGalleyId" key="submission.layout.publicGalleyId"}</td>
							<td class="value"><div class="form-group"><input type="text" name="publicGalleyId" id="publicGalleyId" value="{$publicGalleyId|escape}" size="20" maxlength="255" class="form-control" /></div></td>
						</tr>
					{/if}{* $enablePublicGalleyId *}

					<tr valign="top">
						<td>{fieldLabel name="galleyLocale" required="true" key="common.language"}</td>
						<td class="value">
							<div class="form-group">
								<select name="galleyLocale" id="galleyLocale" class="form-control">
								{html_options options=$supportedSubmissionLocales selected=$galleyLocale|default:$formLocale}
								</select>
							</div>
						</td>
					</tr>

					{if $galley->getRemoteURL()}
						<tr valign="top">
							<td>{fieldLabel name="remoteURL" required="true" key="submission.layout.galleyRemoteURL"}</td>
							<td class="value"><div class="form-group"><input type="text" name="remoteURL" id="remoteURL" value="{$galley->getRemoteURL()|escape}" size="40" maxlength="255" class="form-control" /></div></td>
						</tr>
					{else}
						<tr valign="top">
							<td>{translate key="common.fileName"}</td>
							<td class="value"><a class="action" href="{url op="downloadFile" path=$articleId|to_array:$galley->getFileId()}">{$galley->getFileName()|escape}</a></td>
						</tr>
						<tr valign="top">
							<td>{translate key="common.originalFileName"}</td>
							<td class="value">{$galley->getOriginalFileName()|escape}</td>
						</tr>
						<tr valign="top">
							<td>{translate key="common.fileType"}</td>
							<td class="value">{$galley->getFileType()|escape}</td>
						</tr>
						<tr valign="top">
							<td>{translate key="common.fileSize"}</td>
							<td class="value">{$galley->getNiceFileSize()}</td>
						</tr>
						<tr valign="top">
							<td>{translate key="common.dateUploaded"}</td>
							<td class="value">{$galley->getDateUploaded()|date_format:$dateFormatShort}</td>
						</tr>

						<tr valign="top">
							<td>{if $galleyId}{fieldLabel name="galleyFile" key="layoutEditor.galley.replaceGalley"}{else}{fieldLabel name="galleyFile" key="common.upload"}{/if}</td>
							<td class="value">
								<div class="form-group"><input type="file" name="galleyFile" id="galleyFile" class="form-control" />&nbsp;&nbsp;{translate key="form.saveToUpload"}</div>
							</td>
						</tr>
					{/if}
				</table>
			</div>
		</div>
		
		<br/>

		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{assign var=pubIdMetadataFile value=$pubIdPlugin->getPubIdMetadataFile()}
			{include file="$pubIdMetadataFile" pubObject=$galley}
		{/foreach}

		{call_hook name="Templates::Submission::Layout::GalleyForm::AdditionalMetadata"}

		{if $galley->isHTMLGalley()}
			<div id="htmlGalley" class="col-md-12 mag-innert-left">
				<h3>{translate key="submission.layout.galleyHTMLData"}</h3>

				<h4>{translate key="submission.layout.galleyStylesheet"}</h4>

				{assign var=styleFile value=$galley->getStyleFile()}

				<div class="table-responsive">
					<table class="table table-striped" width="100%">
						{if $styleFile}
							<tr valign="top">
								<td width="20%">{translate key="common.fileName"}</td>
								<td width="80%" class="value"><a class="action" href="{url op="downloadFile" path=$articleId|to_array:$styleFile->getFileId()}">{$styleFile->getFileName()|escape}</a></td>
							</tr>
							<tr valign="top">
								<td>{translate key="common.fileSize"}</td>
								<td class="value">{$styleFile->getNiceFileSize()}</td>
							</tr>
							<tr valign="top">
								<td>{translate key="common.dateUploaded"}</td>
								<td class="value">{$styleFile->getDateUploaded()|date_format:$dateFormatShort}</td>
							</tr>
							<tr valign="top">
								<td>&nbsp;</td>
								<td class="value">
									<div class="form-group">
										<input type="checkbox" name="deleteStyleFile" value="1"{if $deleteStyleFile} checked="checked"{/if} />&nbsp;
										{translate key="submission.layout.deleteGalleyStylesheet"}
									</div>
								</td>
							</tr>
						{else}
							<tr valign="top">
								<td class="nodata"><p class="help-block">{translate key="submission.layout.noStyleFile"}</p></td>
							</tr>
						{/if}
					</table>
				</div>

				<div class="table-responsive">
					<table class="table table-striped" width="100%">
						<tr valign="top">
							<td width="20%">{fieldLabel name="styleFile" key="common.upload"}</td>
							<td class="value">
								<div class="form-group"><input type="file" name="styleFile" id="styleFile" class="form-control" />&nbsp;&nbsp;{translate key="form.saveToUpload"}</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<br />
			
			<div id="galleyImages" class="col-md-12 mag-innert-left">
				<h4>{translate key="submission.layout.galleyImages"}</h4>

				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
						<tr class="heading" valign="bottom">
							<td width="25%"><label>{translate key="common.fileName"}</label></td>
							<td width="25%"><label>{translate key="common.originalFileName"}</label></td>
							<td width="20%"><label>{translate key="common.fileSize"}</label></td>
							<td width="20%"><label>{translate key="common.dateUploaded"}</label></td>
							<td width="10%" align="right"><label>{translate key="common.action"}</label></td>
						</tr>
						<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
						{foreach name=images from=$galley->getImageFiles() item=imageFile}
							<tr valign="top">
								<td><a class="action" href="{url op="downloadFile" path=$articleId|to_array:$imageFile->getFileId()}">{$imageFile->getFileName()|escape}</a></td>
								<td>{$imageFile->getOriginalFileName()|escape}</td>
								<td>{$imageFile->getNiceFileSize()}</td>
								<td>{$imageFile->getDateUploaded()|date_format:$dateFormatShort}</td>
								<td align="right"><input type="button" name="deleteImage[{$imageFile->getFileId()}]" value="{translate key="common.delete"}" class="btn btn-danger" onclick="return confirmAction('{url escape="false" op="deleteArticleImage" path=$galley->getArticleId()|to_array:$galley->getId():$imageFile->getFileId():$imageFile->getRevision()}', '{translate|escape:"jsparam" key="submission.layout.confirmDeleteGalleyImage"}')" /></td>
							</tr>
							<tr>
								<td colspan="6" class="{if $smarty.foreach.images.last}end{/if}separator">&nbsp;</td>
							</tr>
						{foreachelse}
							<tr>
								<td colspan="6" class="nodata"><p class="help-block">{translate key="submission.layout.galleyNoImages"}</p></td>
							</tr>
							<tr>
								<td colspan="6" class="endseparator">&nbsp;</td>
							</tr>
						{/foreach}
					</table>
				</div>

				<div class="form-group"><input type="file" name="imageFile" id="imageFile" class="form-control" />&nbsp;</div>
				<input type="submit" name="uploadImage" class="btn btn-success" value="{translate key="common.upload"}" />
			</div>
		{/if}
		
		<br />

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="submissionEditing" path=$articleId escape=false}'" /></p>

		<p class="help-block">{translate key="common.requiredField"}</p>
	</form>
</div>

{include file="common/footer.tpl"}