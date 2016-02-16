{**
 * plugins/generic/customBlockManager/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for Custom Block Plugin settings.
 *
 *}
{assign var="pageTitle" value="plugins.generic.customBlockManager.displayName"}
{include file="common/header.tpl"}

{url|assign:"sysPluginsUrl" page="manager" op="plugins"}
{url|assign:"setup56" page="manager" op="setup" path="5"}
{translate key="plugin.generic.customBlockManager.introduction" systemPluginsUrl=$sysPluginsUrl setupStep56=$setup56}

<br />
<br />

<form role="form" method="post" action="{plugin_url path="settings"}">

	{include file="common/formErrors.tpl"}
	
	<br />

	<input type="hidden" name="deletedBlocks" value="{$deletedBlocks|escape}" />

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td colspan="4" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="20%" align="left"><label>{translate key="plugins.generic.customBlockManager.blockName"}</label></td>
				<td width="80%" align="left"><label>{translate key="plugins.generic.customBlockManager.action"}</label></td>
			</tr>
			<tr>
				<td colspan="4" class="headseparator">&nbsp;</td>
			</tr>
			
			{foreach name=blocks from=$blocks key=blockIndex item=block}
				<tr valign="top">
					<td width="20%" class="value" align="left"><div class="form-group"><input type="text" class="form-control" name="blocks[{$blockIndex|escape}]" id="blocks-{$blockIndex|escape}" value="{$block|escape}" size="20" maxlength="40" /></div></td>
					<td  align="left"><input type="submit" name="delBlock[{$blockIndex|escape}]" value="{translate key="plugins.generic.customBlockManager.delete"}" class="btn btn-danger" /></td>
				</tr>
				<tr>
					<td colspan="4" class="separator">&nbsp;</td>
				</tr>
			{foreachelse}
				<tr valign="top">
					<td width="20%" class="value" align="right"><div class="form-group"><input type="text" class="form-control" name="blocks[0]" id="blocks-0" size="20" maxlength="40" /></div></td>
				</tr>
			{/foreach}
		</table>
	</div>

	<p><input type="submit" class="btn btn-success" name="addBlock" value="{translate key="plugins.generic.customBlockManager.addBlock"}" />
	<input type="submit" class="btn btn-success" name="save" value="{translate key="common.save"}" />
	<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager" op="plugins" escape=false}'" /></p>
</form>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}