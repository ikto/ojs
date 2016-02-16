{**
 * plugins/blocks/information/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- information links.
 *
 *}

{if !empty($forReaders) || !empty($forAuthors) || !empty($forLibrarians)}
	<h4 class="side">{translate key="plugins.block.information.link"}</h4>
	<div class="edit-pics" id="sidebarInformation">
		<ul class="stay">
			{if !empty($forReaders)}<li><a href="{url page="information" op="readers"}">{translate key="navigation.infoForReaders"}</a></li>{/if}
			{if !empty($forAuthors)}<li><a href="{url page="information" op="authors"}">{translate key="navigation.infoForAuthors"}</a></li>{/if}
			{if !empty($forLibrarians)}<li><a href="{url page="information" op="librarians"}">{translate key="navigation.infoForLibrarians"}</a></li>{/if}
		</ul>
	</div>
{/if}