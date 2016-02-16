{**
 * plugins/blocks/role/reviewer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Reviewer navigation sidebar.
 *
 *}
{* Note that if the user has come in via an access key, the submission counts won't
   be available as the user isn't actually logged in. Therefore we must check to
   see if the user object actually exists before displaying submission counts. *}

{if $isUserLoggedIn}
	<h4 class="side">{translate key="user.role.reviewer"}</h4>
	<div class="edit-pics" id="sidebarReviewer">
		<p class="help-block">{translate key="article.submissions"}</p>
		<ul class="stay">
			<li><a href="{url op="index" path="active"}">{translate key="common.queue.short.active"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
			<li><a href="{url op="index" path="completed"}">{translate key="common.queue.short.completed"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
		</ul>
	</div>
{/if}