{**
 * plugins/generic/externalFeed/externalFeedForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * External feed form under plugin management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$feedTitle"}
{if $feedId}
	{assign var="pageTitle" value="plugins.generic.externalFeed.manager.edit"}
{else}
	{assign var="pageTitle" value="plugins.generic.externalFeed.manager.create"}
{/if}
{include file="common/header.tpl"}
{/strip}

<br/>

<form role="form" id="externalFeed" method="post" action="{plugin_url path="update"}">
	
	{if $feedId}
		<input type="hidden" name="feedId" value="{$feedId|escape}" />
	{/if}

	{include file="common/formErrors.tpl"}

	<div id="externalFeedForm" class="table-responsive">
		<table id="general" class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%" colspan="2">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{if $feedId}{plugin_url|assign:"externalFeedFormUrl" path="edit" id=$feedId escape=false}
						{else}{plugin_url|assign:"externalFeedFormUrl" path="create" id=$feedId escape=false}
						{/if}
						{form_language_chooser form="externalFeed" url=$externalFeedFormUrl}
						<span class="help-block">{translate key="form.formLanguage.description"}</span>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%" colspan="2">{fieldLabel name="title" required="true" key="plugins.generic.externalFeed.form.title"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="form-control" /></div>
					<br />
					<span class="help-block">{translate key="plugins.generic.externalFeed.form.titleDescription"}</span>
				</td>
			</tr>
			<tr valign="top">
				<td width="20%" colspan="2">{fieldLabel name="feedUrl" required="true" key="plugins.generic.externalFeed.form.feedUrl"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="feedUrl" id="feedUrl" value="{$feedUrl|escape}" size="30" maxlength="255" class="form-control" /></div>
					<br />
					<span class="help-block">{translate key="plugins.generic.externalFeed.form.feedUrlDescription"}</span>
				</td>
			</tr>
			<tr>
				<td colspan="3"><div class="separator">&nbsp;</div></td>
			</tr>
			<tr valign="top">
				<td width="10%"><label>{translate key="plugins.generic.externalFeed.form.display"}</label></td>
				<td width="10%" align="right"><div class="form-group"><input type="checkbox" name="displayHomepage" id="displayHomepage" value="1" {if $displayHomepage}checked="checked" {/if}/></div></td>
				<td width="80%" class="value">{translate key="plugins.generic.externalFeed.form.displayHomepage"}</td>
			</tr>
			<tr valign="top">
				<td width="20%" align="right" colspan="2"><div class="form-group"><input type="radio" name="displayBlock" id="displayBlock-none" value="{$smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_NONE}" {if $displayBlock == $smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_NONE}checked="checked" {/if}/></div></td>
				<td width="80%" class="value">{translate key="plugins.generic.externalFeed.form.displayBlockNone"}</td>
			</tr>
			<tr valign="top">
				<td width="20%" align="right" colspan="2"><div class="form-group"><input type="radio" name="displayBlock" id="displayBlock-homepage" value="{$smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_HOMEPAGE}" {if $displayBlock == $smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_HOMEPAGE}checked="checked" {/if}/></div></td>
				<td width="80%" class="value">{translate key="plugins.generic.externalFeed.form.displayBlockHomepage"}</td>
			</tr>
			<tr valign="top">
				<td width="20%" align="right" colspan="2"><div class="form-group"><input type="radio" name="displayBlock" id="displayBlock-all" value="{$smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_ALL}" {if $displayBlock == $smarty.const.EXTERNAL_FEED_DISPLAY_BLOCK_ALL}checked="checked" {/if}/></div></td>
				<td width="80%" class="value">{translate key="plugins.generic.externalFeed.form.displayBlockAll"}</td>
			</tr>
			<tr valign="top">
				<td width="20%" align="right" colspan="2"><div class="form-group"><input type="checkbox" name="limitItems" id="limitItems" value="1" {if $limitItems}checked="checked" {/if}/></div></td>
				<td width="80%" class="value"><div class="form-group">{translate key="plugins.generic.externalFeed.form.recentItems1"}
				<input type="text" name="recentItems" id="recentItems" value="{$recentItems|escape}" size="2" maxlength="90" class="form-control" />
				{translate key="plugins.generic.externalFeed.form.recentItems2"}</div></td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $feedId}<input type="submit" name="createAnother" value="{translate key="plugins.generic.externalFeed.form.saveAndCreateAnother"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="history.go(-1);" /></p>
</form>

<p><span class="help-block">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}