{**
 * temlates/rtadmin/addthis.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RT Administration settings.
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.sharing"}
{include file="common/header.tpl"}
{/strip}

<form role="form" method="post" action='{url op="saveSharingSettings"}'>

	<p class="help-block">{translate key="rt.admin.sharing.description"}</p>

	<div class="separator">&nbsp;</div>

	<h3>{translate key="rt.admin.sharing.basic"}</h3>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%"></td>
				<td width="80%"><div class="form-group"><input type="checkbox" name="sharingEnabled" id="sharingEnabled" {if isset($sharingEnabled) && $sharingEnabled} checked="checked" {/if} /> <label class="control-label" for="sharingEnabled">{translate key="rt.admin.sharing.enabled"}</label></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingUserName">{translate key="rt.admin.sharing.userNameLabel"}</label></td>
				<td><div class="form-group"><input type="text" class="form-control" name="sharingUserName" id="sharingUserName" value="{$sharingUserName|escape}"/></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingButtonStyle">{translate key="rt.admin.sharing.buttonStyleLabel"}</label></td>
				<td>
					{html_options name="sharingButtonStyle" id="sharingButtonStyle" values=$sharingButtonStyleOptions|@array_values output=$sharingButtonStyleOptions|@array_values selected=$sharingButtonStyle}
				</td>
			</tr>
			<tr>
				<td></td>
				<td><div class="form-group"><input type="checkbox" name="sharingDropDownMenu" id="sharingDropDownMenu" {if isset($sharingDropDownMenu) && $sharingDropDownMenu} checked="checked" {/if} /> <label class="control-label" for="sharingDropDownMenu">{translate key="rt.admin.sharing.dropDownMenuLabel"}</label></div></td>
			</tr>
		</table>
	</div>

	<h3>{translate key="rt.admin.sharing.advanced"}</h3>
	<p class="help-block">{translate key="rt.admin.sharing.customizationLink"}</p>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr valign="top">
				<td width="20%"><label class="control-label" for="sharingBrand">{translate key="rt.admin.sharing.brandLabel"}</label></td>
				<td width="80%"><div class="form-group"><input type="text" class="form-control" name="sharingBrand" id="sharingBrand" value="{$sharingBrand|escape}"/></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingDropDown">{translate key="rt.admin.sharing.dropDownLabel"}</label></td>
				<td><div class="form-group"><textarea rows="4" cols="20" class="form-control" name="sharingDropDown" id="sharingDropDown">{$sharingDropDown|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingLanguage">{translate key="rt.admin.sharing.languageLabel"}</label></td>
				<td>
					{html_options name="sharingLanguage" id="sharingLanguage" options="$sharingLanguageOptions" selected=$sharingLanguage}
				</td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingLogo">{translate key="rt.admin.sharing.logolabel"}</label></td>
				<td><div class="form-group"><input type="text" class="form-control" name="sharingLogo" id="sharingLogo" value="{$sharingLogo}" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingLogoBackground">{translate key="rt.admin.sharing.logoBackgroundLabel"}</label></td>
				<td><div class="form-group"><input type="text" class="form-control" name="sharingLogoBackground" id="sharingLogoBackground" value="{$sharingLogoBackground|escape}"/></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="sharingLogoColor">{translate key="rt.admin.sharing.logoColorLabel"}</label></td>
				<td><div class="form-group"><input type="text" class="form-control" name="sharingLogoColor" id="sharingLogoColor" value="{$sharingLogoColor|escape}"/></div></td>
			</tr>
		</table>
	</div>

	<p>
		<input type="submit" value='{translate key="common.save"}' class="btn btn-success" /> 
		<input type="button" value='{translate key="common.cancel"}' class="btn btn-danger" onclick="document.location.href='{url page=rtadmin escape=false}'" />
	</p>
</form>

{include file="common/footer.tpl"}