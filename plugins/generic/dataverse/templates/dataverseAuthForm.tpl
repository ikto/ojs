{**
 * plugins/generic/dataverse/templates/dataverseAuthForm.tpl
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
	<li class="current"><a href="{plugin_url path="connect"}">{translate key="plugins.generic.dataverse.settings.connect"}</a></li>
	<li><a href="{plugin_url path="select"}">{translate key="plugins.generic.dataverse.settings.selectDataverse"}</a></li>
	<li><a href="{plugin_url path="settings"}">{translate key="plugins.generic.dataverse.settings"}</a></li>
</ul>

<div style="margin: 1em 0;" class="col-md-12 mag-innert-left">

	<form role="form" method="post" action="{plugin_url path="connect"}" id="dvnForm">
		
		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td>{fieldLabel name="dvnUri" required="true" key="plugins.generic.dataverse.settings.dvnUri"}</td>
					<td class="value"><div class="form-group"><input type="text" name="dvnUri" id="dvnUri" value="{$dvnUri|escape}" size="40" maxlength="90" class="form-control"/></div></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.dvnUriDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="username" required="true" key="user.username"}</td>
					<td class="value"><div class="form-group"><input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="90" class="form-control" /></div></td>
				</tr>			 
				<tr>
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.usernameDescription"}</p></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="password" required="true" key="user.password"}</td>
					<td class="value">
						<div class="form-group"><input type="password" name="password" id="password" value="{$password|escape}" size="20" maxlength="90" class="form-control"/></div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><p class="help-block">{translate key="plugins.generic.dataverse.settings.passwordDescription"}</p></td>
				</tr>
			</table>
		</div>
		
		<input type="submit" class="btn btn-success" name="save" value="{translate key="common.saveAndContinue"}"	/> 
		<input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="document.location='{plugin_url path=""}';"/>
	</form>
</div>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}