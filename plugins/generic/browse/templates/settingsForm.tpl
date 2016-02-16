{**
 * plugins/generic/browse/templates/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Browse plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.browse.manager.settings.browseSettings"}
{include file="common/header.tpl"}
{/strip}

<div id="browseSettings" class="col-md-12 mag-innert-left">
	<div id="description"><p class="help-block">{translate key="plugins.generic.browse.manager.settings.description"}</p></div>

	<div class="separator"></div>

	<br />

	<form role="form" method="post" action="{plugin_url path="settings"}">
	
		{include file="common/formErrors.tpl"}
	
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="journalContent" key="plugins.generic.browse.manager.settings.browse"}</td>
					<td width="80%" class="value">
						<p class="help-block">{translate key="plugins.generic.browse.manager.settings.browseByObjects"}</p><br />
						<div class="form-group">
							<input type="checkbox" name="enableBrowseBySections" id="enableBrowseBySections" value="1"{if $enableBrowseBySections} checked="checked"{/if}/>
							<label class="control-label"for="enableBrowseBySections">{translate key="plugins.generic.browse.manager.settings.enableBrowseBySections"}</label><br />
						</div>
						<div class="form-group">
							<input type="checkbox" name="enableBrowseByIdentifyTypes" id="enableBrowseByIdentifyTypes" value="1"{if $enableBrowseByIdentifyTypes} checked="checked"{/if}/>
							<label class="control-label" for="enableBrowseByIdentifyTypes">{translate key="plugins.generic.browse.manager.settings.enableBrowseByIdentifyTypes"}</label><br />
						</div>
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="urnPrefix" key="plugins.generic.browse.manager.settings.excludedSections"}</td>
					<td width="80%" class="value">
						<p class="help-block">{translate key="plugins.generic.browse.manager.settings.excludedSections.description"}</p><br />
						<div class="form-group">
							<select name="excludedSections[]" id="excludedSections" class="form-control" multiple="multiple" size="5">
									<option {if in_array('', $excludedSections)}selected="selected" {/if}value=''>{translate key="common.none"}</option>
								{foreach from=$sections key=id item=title}
									<option {if in_array($id, $excludedSections)}selected="selected" {/if}value="{$id|escape}">{$title|escape}</option>
								{/foreach}
							</select>
						</div>
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="urnPrefix" key="plugins.generic.browse.manager.settings.excludedIdentifyTypes"}</td>
					<td width="80%" class="value">
						<p class="help-block">{translate key="plugins.generic.browse.manager.settings.excludedIdentifyTypes.description"}</p><br />
						<div class="form-group">
							<select name="excludedIdentifyTypes[]" id="excludedIdentifyTypes" class="form-control" multiple="multiple" size="5">
									<option {if in_array('', $excludedIdentifyTypes)}selected="selected" {/if}value=''>{translate key="common.none"}</option>
								{foreach from=$identifyTypes key=id item=identifyType}
									<option {if in_array($id, $excludedIdentifyTypes)}selected="selected" {/if}value="{$identifyType|escape}">{$identifyType|escape}</option>
								{/foreach}
							</select>
						</div>
					</td>
				</tr>
			</table>
		</div>
	
		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/><input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
	</form>
</div>
	<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}