{**
 * templates/manager/plugins/plugins.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List available import/export plugins.
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

{if $mainPage}
	<p class="help-block">{translate key="manager.plugins.description"}</p>

	<div class="col-md-12 mag-innert-left">
		<ul id="plugins" class="list-group">
			{foreach from=$plugins item=plugin}
				{if $plugin->getCategory() != $category}
					{assign var=category value=$plugin->getCategory()}
					<li class="list-group-item"><a href="{url path=$category|escape}">{translate key="plugins.categories.$category"}</a></li>
				{/if}
			{/foreach}
			<li>&nbsp;</li>
			<li class="list-group-item"><b><a href="{url op="managePlugins" path=install}">{translate key="manager.plugins.install"}</a></b></li>
		</ul>
	</div>
{else}
	{foreach from=$plugins item=plugin}
		{if $plugin->getCategory() != $category}
			{assign var=category value=$plugin->getCategory()}
			<div id="{$category|escape}" class="col-md-12 mag-innert-left">
				<p class="help-block">{translate key="plugins.categories.$category.description"}</p>
			</div>
		{/if}
	{/foreach}
	
	<ul id="plugins" class="list-group">
		{foreach from=$plugins item=plugin}
			{if !$plugin->getHideManagement()}
			{if $plugin->getCategory() != $category}
				{assign var=category value=$plugin->getCategory()}
				<div id="{$category|escape}" class="col-md-12 mag-innert-left">
					<h3>{translate key="plugins.categories.$category"}</h3>
					<p class="help-block">{translate key="plugins.categories.$category.description"}</p>
				</div>
			{/if}
			<li class="list-group-item"><h4>{$plugin->getDisplayName()|escape}</h4>
				<p>
					{$plugin->getDescription()}<br/>
					{assign var=managementVerbs value=$plugin->getManagementVerbs()}
					{if $managementVerbs && $plugin->isSitePlugin() && !$isSiteAdmin}
						<em>{translate key="manager.plugins.sitePlugin"}</em>
					{elseif $managementVerbs}
						{foreach from=$managementVerbs item=verb}
							<a class="action" href="{url op="plugin" path=$category|to_array:$plugin->getName():$verb[0]}">{$verb[1]|escape}</a>&nbsp;
						{/foreach}
					{/if}
					{assign var=pluginInstallName value=$plugin->getPluginPath()|basename}
					{if $plugin->getCurrentVersion()}
						<a class="action" href="{url op="managePlugins" path="upgrade"|to_array:$category:$pluginInstallName}">{translate key="manager.plugins.upgrade"}</a>&nbsp;
						<a class="action" href="{url op="managePlugins" path="delete"|to_array:$category:$pluginInstallName}">{translate key="manager.plugins.delete"}</a>&nbsp;
					{/if}
				</p>
			</li>
			{/if}
		{/foreach}
	</ul>
{/if}

{include file="common/footer.tpl"}