{**
 * plugins/generic/dataverse/templates/suppFileAdditionalMetadata.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Dataverse plugin: data publication options
 *
 *}
 
{url|assign:"dataverseTermsOfUseUrl" page="dataverse" op="termsOfUse"}

<div id="dataverse" class="col-md-12 mag-innert-left">
	<h3>{translate key="plugins.generic.dataverse.suppFile.title"}</h3>
	<p class="help-block">{translate key="plugins.generic.dataverse.suppFile.description"}</p>

	<div class="form-group">
		<input type="radio" name="publishData" id="publishData-none" value="none" {if $publishData eq "none"}checked="checked" {/if}/>
		<label class="control-label" for="publishData-none">{translate key="plugins.generic.dataverse.suppFile.publishDataNone"}</label>
	</div>
	<br/>
	<div class="form-group">
		<input type="radio" name="publishData" id="publishData-dataverse" value="dataverse" {if $publishData eq "dataverse"}checked="checked" {/if}/>
		<label class="control-label" for="publishData-dataverse">{translate key="plugins.generic.dataverse.suppFile.publishDataDataverse" dataverseTermsOfUseUrl=$dataverseTermsOfUseUrl}</label>
	</div>
	<br/>
	{if $dataCitation}
		<p style="margin-left: 25px;" class="help-block">{translate key="plugins.generic.dataverse.suppFile.dataCitationDescription"}</p>
		<p style="margin-left: 25px;">{$dataCitation|strip_unsafe_html}</p>
		{if $studyLocked}
			<p style="margin-left: 25px;" class="error">{translate key="plugins.generic.dataverse.suppFile.studyLocked"}</p>
		{/if}
	{/if}
	<h4>{translate key="plugins.generic.dataverse.suppFile.studyDescription"}</h4>
	<p class="help-block">{translate key="plugins.generic.dataverse.suppFile.studyDescription.description"}</p>
	<div class="form-group"><textarea cols="60" rows="5" class="form-control" id="studyDescription" name="studyDescription">{$studyDescription|escape}</textarea></div>
	<h4>{translate key="plugins.generic.dataverse.suppFile.externalDataCitation"}</h4>
	<p class="help-block">{translate key="plugins.generic.dataverse.suppFile.externalDataCitation.description"}</p>	
	<div class="form-group"><textarea cols="60" rows="5" class="textArea" id="externalDataCitation" name="externalDataCitation">{$externalDataCitation|escape}</textarea></div>		 
</div>

<div class="separator"></div>