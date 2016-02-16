{**
 * templates/notification/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of notifications.
 *
 *}
{strip}
{assign var="pageTitle" value="notification.notifications"}
{include file="common/header.tpl"}
{/strip}

<div class="table-responsive">
	<table class="table table-striped" width="100%">
		<tr>
			<td>{if $isUserLoggedIn}
					<p class="help-block">{translate key="notification.notificationsDescription" unreadCount=$unread readCount=$read settingsUrl=$url}</p>
				{else}
					<p class="help-block">{translate key="notification.notificationsPublicDescription" emailUrl=$emailUrl}</p>
				{/if}
			</td>
			<td>
				<ul class="stay">
					<li><a href="{url op="getNotificationFeedUrl" path="rss"}" class="icon"><img src="{$baseUrl|escape}/lib/pkp/templates/images/rss10_logo.gif" alt="RSS 1.0"/></a></li>
					<li><a href="{url op="getNotificationFeedUrl" path="rss2"}" class="icon"><img src="{$baseUrl}/lib/pkp/templates/images/rss20_logo.gif" alt="RSS 2.0"/></a></li>
					<li><a href="{url op="getNotificationFeedUrl" path="atom"}" class="icon"><img src="{$baseUrl}/lib/pkp/templates/images/atom10_logo.gif" alt="Atom 1.0"/></a></li>
				</ul>
			</td>
		</tr>
	</table>
</div>

<br/>

<div id="notifications" class="col-md-12 mag-innert-left">

	{$formattedNotifications}

	{if $notifications->wasEmpty()}
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td colspan="2" class="nodata"><h5>{translate key="notification.noneExist"}</h5></td>
				</tr>
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
			</table>
		</div>
	{else}
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td align="left">{page_info iterator=$notifications}</td>
					<td align="right">{page_links anchor="notifications" name="notifications" iterator=$notifications}</td>
				</tr>
			</table>
		</div>
	{/if}
</div>

{include file="common/footer.tpl"}