{**
 * plugins/gateways/metsGateway/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * METS gateway plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.gateways.metsGateway.displayName"}
{include file="common/header.tpl"}
{/strip}

{url|assign:"directoryUrl" page="gateway" op="plugin" path="METSGatewayPlugin"}
<div id="metsGatewaySettings" class="col-md-12 mag-innert-left">
	<h3>{translate key="plugins.gateways.metsGateway.settings"}</h3>

	<form role="form" method="post" action="{plugin_url path="settings"}">
		
		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="30%" align="right">{fieldLabel name="FLocat" key="plugins.gateways.metsGateway.settings.FLocat"}</td>
					<td width="70%" class="value"><div class="form-group"><input type="radio" name="contentWrapper" id="FLocat" value="FLocat" {if $contentWrapper eq "FLocat"}checked="checked" {/if}/></div></td>
				</tr>
				<tr valign="top">
					<td width="30%" align="right">{fieldLabel name="FContent" key="plugins.gateways.metsGateway.settings.FContent"}</td>
					<td width="70%" class="value"><div class="form-group"><input type="radio" name="contentWrapper" id="FContent" value="FContent" {if $contentWrapper eq "FContent"}checked="checked" {/if}/></div></td>
				</tr>
				<tr>
					<td colspan="2"><div class="separator">&nbsp;</div></td>
				</tr>
				<tr valign="top">
					<td width="30%" align="right">{fieldLabel name="organization" key="plugins.gateways.metsGateway.settings.organization"}</td>
					<td width="70%" class="value">
					<div class="form-group"><input type="text" name="organization" id="organization" value="{$organization|escape}" size="50" maxlength="50" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="30%" align="right">{fieldLabel name="preservationLevel"  key="plugins.gateways.metsGateway.settings.preservationLevel"}</td>
					<td width="70%" class="value">
					<div class="form-group"><input type="text" name="preservationLevel" id="preservationLevel" value="{$preservationLevel}" size="2" maxlength="1" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="30%" align="right">{fieldLabel name="exportSuppFiles"  key="plugins.gateways.metsGateway.settings.exportSuppFiles"}</td>
					<td width="70%" class="value"><div class="form-group"><input type="checkbox" name="exportSuppFiles" id="exportSuppFiles" value="on" {if $exportSuppFiles eq "on"}checked="checked" {/if}/></div></td>
				</tr>
			</table>
		</div>

	<br/>

	<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/>
	<input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="document.location.href='{url|escape:"quotes" page="manager" op="plugins" escape="false"}'"/>
	</form>
</div>

{include file="common/footer.tpl"}