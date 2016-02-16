{**
 * lib/pkp/templates/announcement/announcements.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements in management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.announcements"}
{assign var="pageId" value="manager.announcements"}
{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li class="current"><a href="{url op="announcements"}">{translate key="manager.announcements"}</a></li>
	<li><a href="{url op="announcementTypes"}">{translate key="manager.announcementTypes"}</a></li>
</ul>

<br />

<div id="announcementList" class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td colspan="4" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td width="15%"><label>{translate key="manager.announcements.dateExpire"}</label></td>
			<td width="15%"><label>{translate key="manager.announcements.type"}</label></td>
			<td width="55%"><label>{translate key="manager.announcements.title"}</label></td>
			<td width="15%"><label>{translate key="common.action"}</label></td>
		</tr>
		<tr>
			<td colspan="4" class="headseparator">&nbsp;</td>
		</tr>
		{iterate from=announcements item=announcement}
			<tr valign="top">
				<td>{$announcement->getDateExpire()|date_format:$dateFormatShort}</td>
				<td>{$announcement->getAnnouncementTypeName()}</td>
				<td>{$announcement->getLocalizedTitle()|escape}</td>
				<td><a href="{url op="editAnnouncement" path=$announcement->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteAnnouncement" path=$announcement->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.announcements.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
			</tr>
			<tr>
				<td colspan="4" class="{if $announcements->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $announcements->wasEmpty()}
			<tr>
				<td colspan="4" class="nodata"><p class="help-block">{translate key="manager.announcements.noneCreated"}</p></td>
			</tr>
			<tr>
				<td colspan="4" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="2" align="left">{page_info iterator=$announcements}</td>
				<td colspan="2" align="right">{page_links anchor="announcements" name="announcements" iterator=$announcements}</td>
			</tr>
		{/if}
	</table>

	<a href="{url op="createAnnouncement"}" class="action">{translate key="manager.announcements.create"}</a>
</div>

{include file="common/footer.tpl"}