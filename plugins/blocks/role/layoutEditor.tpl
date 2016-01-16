{**
 * plugins/blocks/role/layoutEditor.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * LayoutEditor navigation sidebar.
 *
 *}
<h4 class="side">{translate key="user.role.layoutEditor"}</h4>
<div class="edit-pics" id="sidebarLayoutEditor">
	<p class="help-block">{translate key="article.submissions"}</p>
	<ul class="stay">
		<li><a href="{url op="submissions" path="active"}">{translate key="common.queue.short.active"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="completed"}">{translate key="common.queue.short.completed"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
	</ul>
</div>
