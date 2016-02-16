{**
 * templates/rtadmin/settings.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RT Administration settings.
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.settings"}
{include file="common/header.tpl"}
{/strip}

<form role="form" method="post" action="{url op="saveSettings"}">
	<p class="help-block">{translate key="rt.admin.settings.description"}</p>

	<div id="enableRT" class="col-md-12 mag-innert-left">
		<div class="form-group">
			<input type="checkbox" {if $enabled}checked="checked" {/if}name="enabled" value="1" id="enabled"/>&nbsp;&nbsp;<label class="control-label" for="enabled">{translate key="rt.admin.settings.enableReadingTools"}</label>
		</div>
	</div><br/>

	<div class="separator"></div>
	
	<div id="rtAdminOptions" class="col-md-12 mag-innert-left">
		<h3>{translate key="rt.admin.options"}</h3>
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="3%"><div class="form-group"><input type="checkbox" name="abstract" id="abstract" {if $abstract}checked="checked" {/if}/></div></td>
					<td class="value" width="97%"><label class="control-label" for="abstract">{translate key="rt.admin.settings.abstract"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="captureCite" id="captureCite" {if $captureCite}checked="checked" {/if}/></div></td>
					<td class="value">
						<label class="control-label" for="captureCite">{translate key="rt.admin.settings.captureCite"}</label><br />
					</td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="viewMetadata" id="viewMetadata" {if $viewMetadata}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="viewMetadata">{translate key="rt.admin.settings.viewMetadata"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="supplementaryFiles" id="supplementaryFiles" {if $supplementaryFiles}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="supplementaryFiles">{translate key="rt.admin.settings.supplementaryFiles"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="printerFriendly" id="printerFriendly" {if $printerFriendly}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="printerFriendly">{translate key="rt.admin.settings.printerFriendly"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="defineTerms" id="defineTerms" {if $defineTerms}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="defineTerms">{translate key="rt.admin.settings.defineTerms"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="emailOthers" id="emailOthers" {if $emailOthers}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="emailOthers">{translate key="rt.admin.settings.emailOthers"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="emailAuthor" id="emailAuthor" {if $emailAuthor}checked="checked" {/if}/></div></td>
					<td class="value"><label class="control-label" for="emailAuthor">{translate key="rt.admin.settings.emailAuthor"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="findingReferences" id="findingReferences" value="1"{if $findingReferences} checked="checked"{/if} /></div></td>
					<td class="value"><label class="control-label" for="findingReferences">{translate key="rt.admin.settings.findingReferences"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="viewReviewPolicy" id="viewReviewPolicy" value="1"{if $viewReviewPolicy} checked="checked"{/if} /></div></td>
					<td class="value"><label class="control-label" for="viewReviewPolicy">{translate key="rt.admin.settings.viewReviewPolicy"}</label></td>
				</tr>
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="enableComments" id="enableComments" value="1"{if $enableComments} checked="checked"{/if} /></div></td>
					<td class="value"><label class="control-label" for="enableComments">{translate key="rt.admin.settings.addComment"}</label></td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td>
						<div class="form-group"><input type="radio" name="enableCommentsMode" id="enableCommentsMode-authenticated" value="{$commentsOptions.COMMENTS_AUTHENTICATED|escape}"{if $enableComments==$commentsOptions.COMMENTS_AUTHENTICATED} checked="checked"{/if} />&nbsp;&nbsp;<label class="control-label" for="enableCommentsMode-authenticated">{translate key="rt.admin.settings.addComment.authenticated"}</label></div><br />
						<div class="form-group"><input type="radio" name="enableCommentsMode" id="enableCommentsMode-anonymous" value="{$commentsOptions.COMMENTS_ANONYMOUS|escape}"{if $enableComments==$commentsOptions.COMMENTS_ANONYMOUS} checked="checked"{/if} />&nbsp;&nbsp;<label class="control-label" for="enableCommentsMode-anonymous">{translate key="rt.admin.settings.addComment.anonymous"}</label></div><br />
						<div class="form-group"><input type="radio" name="enableCommentsMode" id="enableCommentsMode-unauthenticated" value="{$commentsOptions.COMMENTS_UNAUTHENTICATED|escape}"{if $enableComments==$commentsOptions.COMMENTS_UNAUTHENTICATED} checked="checked"{/if} />&nbsp;&nbsp;<label class="control-label" for="enableCommentsMode-unauthenticated">{translate key="rt.admin.settings.addComment.unauthenticated"}</label></div><br />
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="separator">&nbsp;</div>
	
	<div id="rtAdminRelatedItems" class="col-md-12 mag-innert-left">
		<h3>{translate key="rt.admin.relatedItems"}</h3>

		<label class="control-label" for="version">{translate key="rt.admin.settings.relatedItems"}</label>&nbsp;&nbsp;
		<div class="form-group">
			<select name="version" id="version" class="form-control">
				<option value="">{translate key="rt.admin.settings.disableRelatedItems"}</option>
				{html_options options=$versionOptions selected=$version}
			</select>
		</div>
		<br/>
		{url|assign:"relatedItemsLink" op="versions"}
		{translate key="rt.admin.settings.relatedItemsLink" relatedItemsLink=$relatedItemsLink}<br/>
	</div>
	
	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="rtadmin" escape=false}'" /></p>
</form>

{include file="common/footer.tpl"}