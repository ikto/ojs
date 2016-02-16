{**
 * plugins/generic/externalFeed/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * External feed plugin navigation sidebar.
 *
 *}

<div class="edit-pics" id="sidebarExternalFeed">
	{foreach from=$externalFeeds item=externalFeed}
		<span class="help-block">{$externalFeed.title|truncate:20:"..."}</span>
		<ul class="stay">
			{foreach from=$externalFeed.items item=feedItem}
				<li>
					<a href="{$feedItem->get_permalink()}" target="_blank">{$feedItem->get_title()|truncate:40:"..."}</a>
				</li>
			{/foreach}
		</ul>
	{/foreach}
</div>