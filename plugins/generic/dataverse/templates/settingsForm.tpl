{**
 * plugins/generic/dataverse/templates/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Dataverse plugin settings
 *
 *}
{strip}
	{assign var="pageTitle" value="plugins.generic.dataverse.displayName"}
	{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li><a href="{plugin_url path="connect"}">{translate key="plugins.generic.dataverse.settings.connect"}</a></li>
	<li><a href="{plugin_url path="select"}">{translate key="plugins.generic.dataverse.settings.selectDataverse"}</a></li>	
	<li class="current"><a href="{plugin_url path="settings"}">{translate key="plugins.generic.dataverse.settings"}</a></li>
</ul>

<div id="dataverseSettings" class="col-md-12 mag-innert-left">

	<form role="form" method="post" action="{plugin_url path="settings"}" enctype="multipart/form-data">
		
		{include file="common/formErrors.tpl"}

		{** Configure data policies *}
		<h3>{translate key="plugins.generic.dataverse.settings.dataPolicies"}</h3>
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.dataPoliciesDescription"}</p>

		<h4>{translate key="plugins.generic.dataverse.settings.dataAvailabilityPolicy"}</h4>
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.dataAvailabilityPolicyDescription"}</p>
		<div class="form-group"><textarea name="dataAvailability" id="dataAvailability" rows="12" cols="80" class="form-control richContent">{$dataAvailability|escape}</textarea></div>
		
		<h4>{translate key="about.sectionPolicies"}</h4>
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.sectionPoliciesDescription"}</p>
		<ul class="stay">
			{foreach from=$sections item=section}
				<li><a href="{url op='editSection' path=$section->getId()}" target="_blank">{$section->getLocalizedTitle()}</a></li>
			{/foreach}
		</ul>
		
		<h4>{translate key="about.authorGuidelines"}</h4>
		{url|assign:"authorGuidelinesUrl" page="manager" op="setup" path="3" anchor='authorGuidelinesInfo'}
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.authorGuidelinesDescription" authorGuidelinesUrl="$authorGuidelinesUrl"}</p>
		<div id="authorGuidelinesWrapper" class="col-md-12 mag-innert-left">
			{include file="controllers/extrasOnDemand.tpl"
				id="authorGuidelinesExtras"
				widgetWrapper="#authorGuidelinesWrapper"
				moreDetailsText="plugins.generic.dataverse.settings.default.authorGuidelines.extras"
				moreDetailsLabel="plugins.generic.dataverse.settings.default.authorGuidelines.extras.label"
				extraContent=$authorGuidelinesContent}			
		</div>
		
		<h4>{translate key="about.submissionPreparationChecklist"}</h4>
		{url|assign:"checklistUrl" page="manager" op='setup' path='3' anchor='submissionPreparationChecklist'}
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.checklistDescription" checklistUrl="$checklistUrl"}</p>
		<div id="checklistWrapper" class="col-md-12 mag-innert-left">
			{include file="controllers/extrasOnDemand.tpl"
				id="checklistExtras"
				widgetWrapper="#checklistWrapper"
				moreDetailsText="plugins.generic.dataverse.settings.default.checklist.extras"
				moreDetailsLabel="plugins.generic.dataverse.settings.default.checklist.extras.label"
				extraContent=$checklistContent}
		</div>
		
		<h4>{translate key="manager.setup.reviewPolicy"}</h4>
		{url|assign:"reviewPolicyUrl" page="manager" op='setup' path='2' anchor='peerReviewDescription'}
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.reviewPolicyDescription" reviewPolicyUrl="$reviewPolicyUrl"}</p>
		<div id="reviewPolicyWrapper" class="col-md-12 mag-innert-left">
			{include file="controllers/extrasOnDemand.tpl" 
							 id="reviewPolicyExtras" 
							 widgetWrapper="#reviewPolicyWrapper" 
							 moreDetailsText="plugins.generic.dataverse.settings.default.reviewPolicy.extras" 
							 moreDetailsLabel="plugins.generic.dataverse.settings.default.reviewPolicy.extras.label" 
							 extraContent=$reviewPolicyContent}
		</div>
		
		<h4>{translate key="manager.setup.reviewGuidelines"}</h4>
		{url|assign:"reviewGuidelinesUrl" page="manager" op='setup' path='2' anchor='reviewGuidelinesInfo'} 
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.reviewGuidelinesUrl" reviewGuidelinesUrl="$reviewGuidelinesUrl"}</p>
		<div id="reviewGuidelinesWrapper" class="col-md-12 mag-innert-left">
			{include file="controllers/extrasOnDemand.tpl" 
							 id="reviewGuidelinesExras" 
							 widgetWrapper="#reviewGuidelinesWrapper" 
							 moreDetailsText="plugins.generic.dataverse.settings.default.reviewGuidelines.extras" 
							 moreDetailsLabel="plugins.generic.dataverse.settings.default.reviewGuidelines.extras.label" 
							 extraContent=$reviewGuidelinesContent}
		</div>
		
		<h4>{translate key="manager.setup.copyeditInstructions"}</h4>
		{url|assign:"copyeditInstructionsUrl" page="manager" op='setup' path='4' anchor='copyeditInstructionsSection'}
		<p class="help-block">{translate key="plugins.generic.dataverse.settings.copyeditInstructionsUrl" copyeditInstructionsUrl="$copyeditInstructionsUrl"}</p>
		<div id="copyeditWrapper" class="col-md-12 mag-innert-left">
			{include file="controllers/extrasOnDemand.tpl" 
							 id="copyeditInstructionsExtras" 
							 widgetWrapper="#copyeditInstructionsWrapper" 
							 moreDetailsText="plugins.generic.dataverse.settings.default.copyeditInstructions.extras" 
							 moreDetailsLabel="plugins.generic.dataverse.settings.default.copyeditInstructions.extras.label" 
							 extraContent=$copyeditInstructionsContent}
		</div>
		
		<div class="separator"></div>
		
		{** Configure terms of use *}		 

		<h3>{translate key="plugins.generic.dataverse.settings.termsOfUse"}</h3>
		<div>
			<p class="help-block">{translate key="plugins.generic.dataverse.settings.termsOfUseDescription"}</p>
			<div class="form-group"><input type="radio" name="fetchTermsOfUse" id="fetchTermsOfUse-true"	value="1" {if $fetchTermsOfUse}checked="checked" {/if} /> {translate key="plugins.generic.dataverse.settings.fetchTermsOfUse"}</div><br/>
			<div class="form-group"><input type="radio" name="fetchTermsOfUse" id="fetchTermsOfUse-false" value="0" {if not $fetchTermsOfUse}checked="checked" {/if}/> {translate key="plugins.generic.dataverse.settings.defineTermsOfUse"}</div>
		</div>
		<div style="margin: 1em 0">
			<div class="form-group"><textarea name="termsOfUse" id="termsOfUse" rows="5" cols="40" class="form-control richContent">{$termsOfUse|escape}</textarea></div>				 
		</div>
		
		<div class="separator"></div>		 
		
		{** Metadata settings *}
		<h3>{translate key="plugins.generic.dataverse.settings.metadata"}</h3>
		
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="citationFormat" required="true" key="plugins.generic.dataverse.settings.citationFormat"}</td>
					<td class="value">
						{html_options name="citationFormat" id="citationFormat" options=$citationFormats selected=$citationFormat}
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.citationFormatDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="pubIdPlugin" key="plugins.generic.dataverse.settings.pubIdType"}</td>
					<td class="value">
						{html_options name="pubIdPlugin" id="pubIdPlugin" options=$pubIdTypes selected=$pubIdPlugin}
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					{url|assign:"pubIdsUrl" page="manager" op="plugins" path="pubIds"} 
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.pubIdTypeDescription" pubIdsUrl="$pubIdsUrl"}</p></td>
				</tr>
			</table>
		</div>
			
		<div class="separator"></div>
		
		{** Workflow settings *}
		<h3>{translate key="plugins.generic.dataverse.settings.workflow"}</h3>
		
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{translate key="plugins.generic.dataverse.settings.requireData"}</td>
					<td class="value">
						<div class="form-group">
							<input type="checkbox" name="requireData" id="requireData" value="1" {if $requireData} checked="checked"{/if}/>&nbsp;
							<label class="control-label" for="requireData">{translate key="plugins.generic.dataverse.settings.requireDataDescription"}</label>					
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td><label class="control-label" for="studyRelease">{translate key="plugins.generic.dataverse.settings.studyRelease"}</label></td>
					<td class="value">
						{html_options name="studyRelease" id="studyRelease" options=$studyReleaseOptions selected=$studyRelease}
					</td>
				</tr>		
			</table>
		</div>
			
		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/>
		<input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="document.location='{plugin_url path=""}';"/>		
	</form>
</div>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}