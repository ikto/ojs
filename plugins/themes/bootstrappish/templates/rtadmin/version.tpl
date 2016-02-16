{**
 * templates/rtadmin/version.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin version editing
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.versions.edit.editVersion"}
{include file="common/header.tpl"}
{/strip}

{if $versionId}
	<ul class="stay">
		<li class="current"><a href="{url op="editVersion" path=$versionId}" class="action">{translate key="rt.admin.versions.metadata"}</a></li>
		<li><a href="{url op="contexts" path=$versionId}" class="action">{translate key="rt.contexts"}</a></li>
	</ul>
{/if}

<br />

<form role="form" action="{if $versionId}{url op="saveVersion" path=$versionId}{else}{url op="createVersion" path="save"}{/if}" method="post">
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="20%"><label class="control-label" for="title">{translate key="rt.version.title"}</label></td>
				<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="title" id="title" value="{$title|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="key">{translate key="rt.version.key"}</label></td>
				<td class="value"><div class="form-group"><input type="text" class="form-control" name="key" id="key" value="{$key|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="locale">{translate key="rt.version.locale"}</label></td>
				<td class="value"><div class="form-group"><input type="text" class="form-control" name="locale" id="locale" maxlength="5" size="5" value="{$locale|escape}" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="description">{translate key="rt.version.description"}</label></td>
				<td class="value">
					<div class="form-group"><textarea class="form-control" name="description" id="description" rows="5" cols="60">{$description|escape}</textarea></div>
				</td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="versions" escape=false}'" /></p>
</form>

{include file="common/footer.tpl"}