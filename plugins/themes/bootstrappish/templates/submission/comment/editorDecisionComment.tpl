{**
 * templates/submission/comment/editorDecisionComment.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to enter comments.
 *
 *}
{strip}
{include file="submission/comment/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
// In case this page is the result of a comment submit, reload the parent
// so that the necessary buttons will be activated.
window.opener.location.reload();
// -->
{/literal}
</script>

<div id="existingComments" class="table-responsive">
	<table class="table table-striped" width="100%">
		{foreach from=$articleComments item=comment}
			<div id="comment">
				<tr valign="top">
					<td width="25%">
						<div class="commentRole">{translate key=$comment->getRoleName()}</div>
						<div class="commentDate">{$comment->getDatePosted()|date_format:$datetimeFormatShort}</div>
					</td>
					<td width="75%">
						{if $comment->getAuthorId() eq $userId and not $isLocked}
							<div style="float: right"><a href="{url op="deleteComment" path=$articleId|to_array:$comment->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.comments.confirmDelete"}')" class="action">{translate key="common.delete"}</a></div>
						{/if}
						<div id="{$comment->getId()}"></a>
							{if $comment->getCommentTitle() neq ""}
								<div class="commentTitle">{translate key="submission.comments.subject"}: {$comment->getCommentTitle()|escape}</div>
							{/if}
						</div>
						<div class="comments">{$comment->getComments()|strip_unsafe_html|nl2br}</div>
					</td>
				</tr>
			</div>
		{foreachelse}
			<tr>
				<td class="nodata"><p class="help-block">{translate key="submission.comments.noComments"}</p></td>
			</tr>
		{/foreach}
	</table>
</div>

<br />
<br />

{if not $isLocked and $isEditor}
	<form role="form" method="post" action="{url op=$commentAction}">

		{if $hiddenFormParams}
			{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
				<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
			{/foreach}
		{/if}


		<div id="new" class="col-md-12 mag-innert-left">
		
			{include file="common/formErrors.tpl"}

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td>{fieldLabel name="commentTitle" key="submission.comments.subject"}</td>
						<td class="value"><div class="form-group"><input type="text" name="commentTitle" id="commentTitle" value="{$commentTitle|escape}" size="50" maxlength="255" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td>{fieldLabel name="comments" key="submission.comments.addComment"}</td>
						<td class="value"><div class="form-group"><textarea id="comments" name="comments" rows="10" cols="50" class="form-control">{$comments|escape}</textarea></div></td>
					</tr>
				</table>
			</div>

			<p><input type="submit" name="save" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.close"}" class="btn btn-danger" onclick="window.close()" /></p>

			<p class="help-block">{translate key="common.requiredField"}</p>
		</div>
	</form>
{else}
	<input type="button" value="{translate key="common.close"}" class="btn btn-danger" style="width: 5em" onclick="window.close()" />
{/if}

{include file="submission/comment/footer.tpl"}