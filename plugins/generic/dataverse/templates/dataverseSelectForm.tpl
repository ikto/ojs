{**
 * plugins/generic/dataverse/templates/dataverseSelectForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Connect to Dataverse Network
 *
 *}
{strip}
	{assign var="pageTitle" value="plugins.generic.dataverse.displayName"}
	{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li><a href="{plugin_url path="connect"}">{translate key="plugins.generic.dataverse.settings.connect"}</a></li>
	<li class="current"><a href="{plugin_url path="select"}">{translate key="plugins.generic.dataverse.settings.selectDataverse"}</a></li>
	<li><a href="{plugin_url path="settings"}">{translate key="plugins.generic.dataverse.settings"}</a></li>
</ul>

<div style="margin: 1em 0;" class="col-md-12 mag-innert-left">
	
	<form role="form" method="post" action="{plugin_url path="select"}" id="dvSelectForm">
		
		{include file="common/formErrors.tpl"}
		
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td>{fieldLabel name="dataverse" required="true" key="plugins.generic.dataverse.settings.dataverse"}</td>
					<td class="value">{html_options name="dataverse" id="dataverse" options=$dataverses selected=$dataverseUri}</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.dataverseDescription"}</p></td>
				</tr>
			</table>
		</div>
		
		<div style="margin: 1em 0">
			<input type="submit" class="btn btn-success" name="save" value="{translate key="common.saveAndContinue"}"	/> 
			<input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="document.location='{plugin_url path=""}';"/>
		</div>
	</form>
</div>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}