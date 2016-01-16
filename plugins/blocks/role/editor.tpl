{**
 * plugins/blocks/role/editor.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor navigation sidebar.
 * Lists active assignments and editor functions.
 *
 *}
<h4 class="side">{translate key="user.role.editor"}</h4>
<div class="edit-pics" id="sidebarEditor">

	<p class="help-block">{translate key="article.submissions"}</p>
	<ul class="stay">
		<li><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a>&nbsp;({if $submissionsCount[2]}{$submissionsCount[2]}{else}0{/if})</li>
		<li><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
	</ul>

	<p class="help-block">{translate key="editor.navigation.issues"}</p>
	<ul class="stay">
		<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li><a href="{url op="notifyUsers"}">{translate key="editor.notifyUsers"}</a></li>
		<li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
</div>
