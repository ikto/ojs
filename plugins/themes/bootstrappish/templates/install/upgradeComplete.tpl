{**
 * templates/install/upgradeComplete.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display confirmation of successful upgrade.
 * If necessary, will also display new config file contents if config file could not be written.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

{translate key="installer.upgradeComplete" version=$newVersion->getVersionString()}

{if !empty($notes)}
	<div id="releaseNotes" class="col-md-12 mag-innert-left">
		<h4>{translate key="installer.releaseNotes"}</h4>
		{foreach from=$notes item=note}
			<p class="text"><pre style="font-size: 125%">{$note|escape}</pre></p>
		{/foreach}
	</div>
{/if}

{if $writeConfigFailed}
	<div id="writeConfigFailed" class="col-md-12 mag-innert-left">
		{translate key="installer.overwriteConfigFileInstructions"}

		<form role="form" action="#">
			<p>
				{translate key="installer.contentsOfConfigFile"}:<br />
				<div class="form-group">
					<textarea name="config" cols="80" rows="20" class="form-control" style="font-family: Courier,'Courier New',fixed-width">{$configFileContents|escape}</textarea>
				</div>
			</p>
		</form>
	</div>{* writeConfigFailed *}
{/if}

{include file="common/footer.tpl"}