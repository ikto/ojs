{**
 * plugins/blocks/role/sectionEditor.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Section Editor navigation sidebar.
 *
 *}
<h4 class="side">{translate key="user.role.sectionEditor"}</h4>
<div class="edit-pics" id="sidebarSectionEditor">
	<p class="help-block">{translate key="article.submissions"}</p>
	<ul class="stay">
		<li><a href="{url op="index" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
		<li><a href="{url op="index" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
		<li><a href="{url op="index" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
	</ul>
</div>
