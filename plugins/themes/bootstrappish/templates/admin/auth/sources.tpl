{**
 * templates/admin/auth/sources.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of authentication sources in site administration.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.authSources"}
{include file="common/header.tpl"}
{/strip}

<br />

<form method="post" action="{url op="updateAuthSources"}">
	<div id="sources" class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>{translate key="common.default"}</th>
					<th>{translate key="common.title"}</th>
					<th>{translate key="common.plugin"}</th>
					<th>{translate key="common.action"}</th>
				<tr>
			</thead>
			<tbody>
				{iterate from=sources item=auth}
					<tr>
						<td><div class="form-group"><input type="radio" id="defaultAuthId_{$auth->getAuthId()}" name="defaultAuthId" value="{$auth->getAuthId()}"{if $auth->getDefault()} checked="checked"{assign var="defaultAuthId" value=$auth->getAuthId()}{/if} /></div></td>
						<td><label class="control-label" for="defaultAuthId_{$auth->getAuthId()}">{$auth->getTitle()|escape}</label></td>
						<td>{$auth->getPlugin()}</td>
						<td align="left"><a href="{url op="editAuthSource" path=$auth->getAuthId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a class="action" href="{url op="deleteAuthSource" path=$auth->getAuthId()}" onclick="return confirm('{translate|escape:"jsparam" key="admin.auth.confirmDelete"}')">{translate key="common.delete"}</a></td>
					</tr>
				{/iterate}
				{if $sources->wasEmpty()}
					<tr>
						<td colspan="4" class="nodata"><p class="help-block">{translate key="admin.auth.noneCreated"}</p></td>
					</tr>
				{else}
					<tr>
						<td colspan="2">{page_info iterator=$sources}</td>
						<td colspan="2">{page_links anchor="sources" name="sources" iterator=$sources}</td>
					</tr>
				{/if}
				<tr>
					<td><div class="form-group"><input type="radio" id="defaultAuthId_0" name="defaultAuthId" value="0"{if !$defaultAuthId} checked="checked"{/if} /></div></td>
					<td colspan="1"><label class="control-label" for="defaultAuthId_0">{translate key="admin.auth.ojs"}</label></td>
					<td colspan="2" align="right">
						<input type="submit" value="{translate key="common.save"}" class="btn btn-success" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="col-md-12 mag-innert-left">
	<p class="help-block">{translate key="admin.auth.defaultSourceDescription"}</p>
</div>

<div class="col-md-12 mag-innert-left">
	<h4>{translate key="admin.auth.create"}</h4>

	<form method="post" action="{url op="createAuthSource"}">
		<label>{translate key="common.plugin"}:</label> <div class="form-group"><select name="plugin" size="1" class="form-control"><option value=""></option>{html_options options=$pluginOptions}</select></div> <input type="submit" value="{translate key="common.create"}" class="btn btn-success" />
	</form>
</div>

{include file="common/footer.tpl"}