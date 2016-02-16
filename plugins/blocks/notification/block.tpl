{**
 * plugins/blocks/notification/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- "Notification" block.
 *
 *}

{if $currentJournal}
	<h4 class="side">{translate key="notification.notifications"}</h4>
	<div class="edit-pics" id="notification">
		<ul class="stay">
			{if $isUserLoggedIn}
				<li><a href="{url page="notification"}">{translate key="common.view"}</a>
					{if $unreadNotifications > 0}{translate key="notification.notificationsNew" numNew=$unreadNotifications}{/if}</li>
				<li><a href="{url page="notification" op="settings"}">{translate key="common.manage"}</a></li>
			{else}
				<li><a href="{url page="notification"}">{translate key="common.view"}</a></li>
				<li><a href="{url page="notification" op="subscribeMailList"}">{translate key="notification.subscribe"}</a></li>
			{/if}
		</ul>
	</div>
{/if}