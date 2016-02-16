{**
 * templates/sectionEditor/submission/layout.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the layout editing table.
 *
 *}
{assign var=layoutSignoff value=$submission->getSignoff('SIGNOFF_LAYOUT')}
{assign var=layoutFile value=$submission->getFileBySignoffType('SIGNOFF_LAYOUT')}
{assign var=layoutEditor value=$submission->getUserBySignoffType('SIGNOFF_LAYOUT')}

<div id="layout" class="col-md-12 mag-innert-left">
	<h3>{translate key="submission.layout"}</h3>

	{if $useLayoutEditors}
		<div id="layoutEditors" class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr>
					<td width="20%">{translate key="user.role.layoutEditor"}</td>
					{if $layoutSignoff->getUserId()}<td width="20%" class="value">{$layoutEditor->getFullName()|escape}</td>{/if}
					<td class="value"><a href="{url op="assignLayoutEditor" path=$submission->getId()}" class="action">{translate key="submission.layout.assignLayoutEditor"}</a></td>
				</tr>
			</table>
		</div>
	{/if}

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td width="28%" colspan="2">&nbsp;</td>
				<td width="18%" class="heading"><label>{translate key="submission.request"}</label></td>
				<td width="16%" class="heading"><label>{translate key="submission.underway"}</label></td>
				<td width="16%" class="heading"><label>{translate key="submission.complete"}</label></td>
				<td width="22%" colspan="2" class="heading"><label>{translate key="submission.acknowledge"}</label></td>
			</tr>
			<tr>
				<td colspan="2">
					{translate key="submission.layout.layoutVersion"}
				</td>
				<td>
					{if $useLayoutEditors}
						{if $layoutSignoff->getUserId() && $layoutFile}
							{url|assign:"url" op="notifyLayoutEditor" articleId=$submission->getId()}
							{if $layoutSignoff->getDateUnderway()}
								{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.layout.confirmRenotify"}
								{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
							{else}
								{icon name="mail" url=$url}
							{/if}
						{else}
							{icon name="mail" disabled="disable"}
						{/if}
						{$layoutSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
					{else}
						{translate key="common.notApplicableShort"}
					{/if}
				</td>
				<td>
					{if $useLayoutEditors}
						{$layoutSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
					{else}
						{translate key="common.notApplicableShort"}
					{/if}
				</td>
				<td>
					{if $useLayoutEditors}
						{$layoutSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
					{else}
						{translate key="common.notApplicableShort"}
					{/if}
				</td>
				<td colspan="2">
					{if $useLayoutEditors}
						{if $layoutSignoff->getUserId() &&  $layoutSignoff->getDateCompleted() && !$layoutSignoff->getDateAcknowledged()}
							{url|assign:"url" op="thankLayoutEditor" articleId=$submission->getId()}
							{icon name="mail" url=$url}
						{else}
							{icon name="mail" disabled="disable"}
						{/if}
						{$layoutSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
					{else}
						{translate key="common.notApplicableShort"}
					{/if}
				</td>
			</tr>
			<tr valign="top">
				<td colspan="6">
					{translate key="common.file"}:&nbsp;&nbsp;&nbsp;&nbsp;
					{if $layoutFile}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$layoutFile->getFileId()}" class="file">{$layoutFile->getFileName()|escape}</a>&nbsp;&nbsp;{$layoutFile->getDateModified()|date_format:$dateFormatShort}
					{else}
						{translate key="submission.layout.noLayoutFile"}
					{/if}
				</td>
			</tr>
			<tr>
				<td colspan="7" class="separator">&nbsp;</td>
			</tr>

			<tr>
				<td colspan="2">{translate key="submission.layout.galleyFormat"}</td>
				<td colspan="2" class="heading"><label>{translate key="common.file"}</label></td>
				<td class="heading"><label>{translate key="common.order"}</label></td>
				<td class="heading"><label>{translate key="common.action"}</label></td>
				<td class="heading"><label>{translate key="submission.views"}</label></td>
			</tr>
			{foreach name=galleys from=$submission->getGalleys() item=galley}
				<tr>
					<td width="2%">{$smarty.foreach.galleys.iteration}.</td>
					<td width="26%">{$galley->getGalleyLabel()|escape}{if !$galley->getRemoteURL()} &nbsp; <a href="{url op="proofGalley" path=$submission->getId()|to_array:$galley->getId()}" class="action">{translate key="submission.layout.viewProof"}</a>{/if}</td>
					<td colspan="2">{if $galley->getFileId() > 0}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$galley->getFileId()}" class="file">{$galley->getFileName()|escape}</a>&nbsp;&nbsp;{$galley->getDateModified()|date_format:$dateFormatShort}{elseif $galley->getRemoteURL() != ''}<a href="{$galley->getRemoteURL()|escape}" target="_blank">{$galley->getRemoteURL()|truncate:20:"..."|escape}</a>{/if}</td>
					<td><a href="{url op="orderGalley" d=u articleId=$submission->getId() galleyId=$galley->getId()}" class="plain">&uarr;</a> <a href="{url op="orderGalley" d=d articleId=$submission->getId() galleyId=$galley->getId()}" class="plain">&darr;</a></td>
					<td>
						<a href="{url op="editGalley" path=$submission->getId()|to_array:$galley->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteGalley" path=$submission->getId()|to_array:$galley->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.layout.confirmDeleteGalley"}')" class="action">{translate key="common.delete"}</a>
					</td>
					<td>{$galley->getViews()|escape}</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="7" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
			{/foreach}
			<tr>
				<td colspan="7" class="separator">&nbsp;</td>
			</tr>
			<tr>
				<td width="28%" colspan="2">{translate key="submission.supplementaryFiles"}</td>
				<td width="34%" colspan="2" class="heading"><label>{translate key="common.file"}</label></td>
				<td width="16%" class="heading"><label>{translate key="common.order"}</label></td>
				<td width="16%" colspan="2" class="heading"><label>{translate key="common.action"}</label></td>
			</tr>
			{foreach name=suppFiles from=$submission->getSuppFiles() item=suppFile}
				<tr>
					<td width="2%">{$smarty.foreach.suppFiles.iteration}.</td>
					<td width="26%">{$suppFile->getSuppFileTitle()|escape}</td>
					<td colspan="2">{if $suppFile->getFileId() > 0}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}{elseif $suppFile->getRemoteURL() != ''}<a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>{/if}</td>
					<td><a href="{url op="orderSuppFile" d=u articleId=$submission->getId() suppFileId=$suppFile->getId()}" class="plain">&uarr;</a> <a href="{url op="orderSuppFile" d=d articleId=$submission->getId() suppFileId=$suppFile->getId()}" class="plain">&darr;</a></td>
					<td colspan="2">
						<a href="{url op="editSuppFile" from="submissionEditing" path=$submission->getId()|to_array:$suppFile->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSuppFile" from="submissionEditing" path=$submission->getId()|to_array:$suppFile->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.layout.confirmDeleteSupplementaryFile"}')" class="action">{translate key="common.delete"}</a>
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="7" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
			{/foreach}
			<tr>
				<td colspan="7" class="separator">&nbsp;</td>
			</tr>
		</table>
	</div>

	<form role="form" method="post" action="{url op="uploadLayoutFile"}"  enctype="multipart/form-data">
		<input type="hidden" name="from" value="submissionEditing" />
		<input type="hidden" name="articleId" value="{$submission->getId()}" />
		{translate key="submission.uploadFileTo"} <div class="form-group"><input type="radio" name="layoutFileType" id="layoutFileTypeSubmission" value="submission" checked="checked" /><label class="control-label" for="layoutFileTypeSubmission">{translate key="submission.layout.layoutVersion"}</label>, <input type="radio" name="layoutFileType" id="layoutFileTypeGalley" value="galley" /><label class="control-label" for="layoutFileTypeGalley">{translate key="submission.galley"}</label>, <input type="radio" name="layoutFileType" id="layoutFileTypeSupp" value="supp" /><label class="control-label" for="layoutFileTypeSupp">{translate key="article.suppFilesAbbrev"}</label></div>
		<div class="form-group"><input type="file" name="layoutFile" size="10" class="form-control" /></div>
		<input type="submit" value="{translate key="common.upload"}" class="btn btn-success" />
		<br />
		{translate key="submission.createRemote"} <div class="form-group"><input type="radio" name="layoutFileType" id="layoutFileTypeGalley" value="galley" /><label class="control-label" for="layoutFileTypeGalley">{translate key="submission.galley"}</label></div>, <div class="form-group"><input type="radio" name="layoutFileType" id="layoutFileTypeSupp" value="supp" /><label class="control-label" for="layoutFileTypeSupp">{translate key="article.suppFilesAbbrev"}</label></div>
		<input type="submit" name="createRemote" value="{translate key="common.create"}" class="btn btn-success" />
	</form>

	<div id="layoutComments" class="col-md-12 mag-innert-left">
		{translate key="submission.layout.layoutComments"}
		{if $submission->getMostRecentLayoutComment()}
			{assign var="comment" value=$submission->getMostRecentLayoutComment()}
			<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a> {$comment->getDatePosted()|date_format:$dateFormatShort}
		{else}
			<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a> {translate key="common.noComments"}
		{/if}

		{if $currentJournal->getLocalizedSetting('layoutInstructions')}
			&nbsp;&nbsp;
			<a href="javascript:openHelp('{url op="instructions" path="layout"}')" class="action">{translate key="submission.layout.instructions"}</a>
		{/if}
		{if $currentJournal->getSetting('provideRefLinkInstructions')}
			&nbsp;&nbsp;
			<a href="javascript:openHelp('{url op="instructions" path="referenceLinking"}')" class="action">{translate key="submission.layout.referenceLinking"}</a>
		{/if}
	</div>
</div>