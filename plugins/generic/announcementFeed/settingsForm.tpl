{**
 * plugins/generic/announcementFeed/settingsForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement Feed plugin settings
 *
 *}
{strip}
{assign var="pageTitle" value="plugins.generic.announcementfeed.displayName"}
{include file="common/header.tpl"}
{/strip}

<div id="announcementFeedSettings" class="col-md-12 mag-innert-left">
	<div id="description"><p class="help-block">{translate key="plugins.generic.announcementfeed.description"}</p></div>

	<div class="separator">&nbsp;</div>

	<h3>{translate key="plugins.generic.announcementfeed.settings"}</h3>

	<form role="form" method="post" action="{plugin_url path="settings"}">
		
		{include file="common/formErrors.tpl"}

		<script type="text/javascript">
			{literal}
			<!--
				function toggleLimitRecentItems(form) {
					form.recentItems.disabled = !form.recentItems.disabled;
				}
			// -->
			{/literal}
		</script>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="10%" align="right"><div class="form-group"><input type="radio" name="displayPage" id="displayPage-all" value="all" {if $displayPage eq "all"}checked="checked" {/if}/></div></td>
					<td width="90%" class="value">{translate key="plugins.generic.announcementfeed.settings.all"}</td>
				</tr>
				<tr valign="top">
					<td width="10%" align="right"><div class="form-group"><input type="radio" name="displayPage" id="displayPage-homepage" value="homepage" {if $displayPage eq "homepage"}checked="checked" {/if}/></div></td>
					<td width="90%" class="value">{translate key="plugins.generic.announcementfeed.settings.homepage"}</td>
				</tr>
				<tr valign="top">
					<td width="10%" align="right"><div class="form-group"><input type="radio" name="displayPage" id="displayPage-announcement" value="announcement" {if $displayPage eq "announcement"}checked="checked" {/if}/></div></td>
					<td width="90%" class="value">{translate key="plugins.generic.announcementfeed.settings.announcement"}</td>
				</tr>
				<tr>
					<td colspan="2"><div class="separator">&nbsp;</div></td>
				</tr>
				<tr valign="top">
					<td width="10%" align="right"><div class="form-group"><input type="checkbox" name="limitRecentItems" id="limitRecentItems" value="1" onclick="toggleLimitRecentItems(this.form)"{if $limitRecentItems} checked="checked"{/if}/></div></td>
					<td width="90%" class="value">
					{translate key="plugins.generic.announcementfeed.settings.recentAnnouncements1"} <div class="form-group"><input type="text" name="recentItems" id="recentItems" value="{$recentItems|escape}" {if not $limitRecentItems}disabled="disabled"{/if} size="2" maxlength="90" class="form-control" /></div>
					{translate key="plugins.generic.announcementfeed.settings.recentAnnouncements2"}</td>
				</tr>
			</table>
		</div>

		<br/>

		<input type="submit" name="save" class="btn btn-success" value="{translate key="common.save"}"/> <input type="button" class="btn btn-danger" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
	</form>

	<p><span class="help-block">{translate key="common.requiredField"}</span></p>
</div>

{include file="common/footer.tpl"}