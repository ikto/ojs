{**
 * templates/sectionEditor/submission/rounds.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate displaying past rounds for a submission.
 *
 *}

<div id="rounds" class="col-md-12 mag-innert-left">
	<div id="regretsAndCancels" class="table-responsive">
		<h3>{translate|escape key="sectionEditor.regrets.regretsAndCancels"}</h3>
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
				<tr valign="top">
					<td class="heading" width="30%"><label>{translate key="user.name"}</label></td>
					<td class="heading" width="25%"><label>{translate key="submission.request"}</label></td>
					<td class="heading" width="25%"><label>{translate key="sectionEditor.regrets.result"}</label></td>
					<td class="heading" width="20%"><label>{translate key="submissions.reviewRound"}</label></td>
				</tr>
				<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>
				{foreach from=$cancelsAndRegrets item=cancelOrRegret name=cancelsAndRegrets}
					<tr valign="top">
						<td>{$cancelOrRegret->getReviewerFullName()|escape}</td>
						<td>
							{if $cancelOrRegret->getDateNotified()}
								{$cancelOrRegret->getDateNotified()|date_format:$dateFormatTrunc}
							{else}
								&mdash;
							{/if}
						</td>
						<td>
							{if $cancelOrRegret->getDeclined()}
								{translate key="sectionEditor.regrets"}
							{else}
								{translate key="common.cancelled"}
							{/if}
						</td>
						<td>{$cancelOrRegret->getRound()}</td>
					</tr>
					<tr>
						<td colspan="4" class="{if $smarty.foreach.cancelsAndRegrets.last}end{/if}separator">&nbsp;</td>
					</tr>
				{foreachelse}
					<tr valign="top">
						<td colspan="4" class="nodata"><p class="help-block">{translate key="common.none}</p></td>
					</tr>
					<tr>
						<td colspan="4" class="endseparator">&nbsp;</td>
					</tr>
				{/foreach}
			</table>
		</div>
	</div>
	
	{section name=round loop=$numRounds-1}
		{assign var=round value=$smarty.section.round.index}
		{assign var=roundPlusOne value=$round+1}
		{assign var=roundAssignments value=$reviewAssignments[$roundPlusOne]}
		{assign var=roundDecisions value=$editorDecisions[$roundPlusOne]}
		<div id="reviewRound" class="table-responsive">
			<h3>{translate key="sectionEditor.regrets.reviewRound" round=$roundPlusOne}</h3>
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{translate key="submission.reviewVersion"}</td>
					<td class="value" width="80%">
						{assign var="reviewFile" value=$reviewFilesByRound[$roundPlusOne]}
						{if $reviewFile}
							<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
						{else}
							{translate key="common.none"}
						{/if}
					</td>
				</tr>
			</table>
		</div>
		{assign var="start" value="A"|ord}
		{assign var=reviewKey value=0}

		{foreach from=$roundAssignments item=reviewAssignment}
			{assign var="reviewId" value=$reviewAssignment->getId()}

			{if !$reviewAssignment->getCancelled()}
			
				<div class="separator"></div>
			
				<div id="reviewer">
					<h4>{translate key="user.role.reviewer"} {$reviewKey+$start|chr} {$reviewAssignment->getReviewerFullName()|escape}</h4>
					<div class="table-responsive">
						<table width="100%" class="table table-striped">
							<tr valign="top">
								<td width="20%">{translate key="reviewer.article.schedule"}</td>
								<td width="20%" class="heading"><label>{translate key="submission.request"}</label></td>
								<td width="20%" class="heading"><label>{translate key="submission.underway"}</label></td>
								<td width="20%" class="heading"><label>{translate key="submission.due"}</label></td>
								<td width="20%" class="heading"><label>{translate key="submission.acknowledge"}</label></td>
							</tr>
							<tr valign="top">
								<td>&nbsp;</td>
								<td>
									{if $reviewAssignment->getDateNotified()}
										{$reviewAssignment->getDateNotified()|date_format:$dateFormatTrunc}
									{else}
										&mdash;
									{/if}
								</td>
								<td>
									{if $reviewAssignment->getDateConfirmed()}
										{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatTrunc}
									{else}
										&mdash;
									{/if}
								</td>
								<td>
									{if $reviewAssignment->getDateDue()}
										{$reviewAssignment->getDateDue()|date_format:$dateFormatTrunc}
									{else}
										&mdash;
									{/if}
								</td>
								<td>
									{if $reviewAssignment->getDateAcknowledged()}
										{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatTrunc}
									{else}
										&mdash;
									{/if}
								</td>
							</tr>
							<tr valign="top">
								<td>{translate key="submission.recommendation"}</td>
								<td colspan="4">
									{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
										{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
										{translate key=$reviewerRecommendationOptions.$recommendation}
									{else}
										{translate key="common.none"}
									{/if}
								</td>
							</tr>
							{if $reviewFormResponses[$reviewId]}
								<tr valign="top">
									<td>{translate key="submission.reviewFormResponse"}</td>
									<td>
										<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="letter"}</a>
									</td>
								</tr>
							{/if}
							<tr valign="top">
								<td>{translate key="reviewer.article.reviewerComments"}</td>
								<td colspan="4">
									{if $reviewAssignment->getMostRecentPeerReviewComment()}
										{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
										<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a> {$comment->getDatePosted()|date_format:$dateFormatShort}
									{else}
										<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
									{/if}
								</td>
							</tr>
							<tr valign="top">
								<td>{translate key="reviewer.article.uploadedFile"}</td>
								<td colspan="4">
									<table width="100%" class="table table-striped">
										{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
											<tr valign="top">
												<td valign="middle">
													<form role="form" id="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
														<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
														<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
														<input type="hidden" name="articleId" value="{$submission->getId()}" />
														<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
														<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
														{translate key="editor.article.showAuthor"} <div class="form-group"><input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} /></div>
														<input type="submit" value="{translate key="common.record"}" class="btn btn-success" />
													</form>
												</td>
											</tr>
										{foreachelse}
											<tr valign="top">
												<td>{translate key="common.none"}</td>
											</tr>
										{/foreach}
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
			{/if}
			{assign var=reviewKey value=$reviewKey+1}
		{/foreach}
		
		<div class="separator"></div>
		
		<div id="decisionRound" class="col-md-12 mag-innert-left">
			<h3>{translate key="sectionEditor.regrets.decisionRound" round=$roundPlusOne}</h3>

			{assign var=authorFiles value=$submission->getAuthorFileRevisions($roundPlusOne)}
			{assign var=editorFiles value=$submission->getEditorFileRevisions($roundPlusOne)}

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td width="20%">{translate key="editor.article.decision"}</td>
						<td class="value" width="80%">
							{foreach from=$roundDecisions item=editorDecision key=decisionKey}
								{if $decisionKey neq 0} | {/if}
								{assign var="decision" value=$editorDecision.decision}
								{translate key=$editorDecisionOptions.$decision} {$editorDecision.dateDecided|date_format:$dateFormatShort}
							{foreachelse}
								{translate key="common.none"}
							{/foreach}
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">{translate key="submission.notifyAuthor"}</td>
						<td class="value" width="80%">
							{translate key="submission.editorAuthorRecord"}
							{if $submission->getMostRecentEditorDecisionComment()}
								{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
								<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a> {$comment->getDatePosted()|date_format:$dateFormatShort}
							{else}
								<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
							{/if}
						</td>
					</tr>
					{foreach from=$authorFiles item=authorFile key=key}
						<tr valign="top">
							{if !$authorRevisionExists}
								{assign var="authorRevisionExists" value=true}
								<td width="20%" rowspan="{$authorFiles|@count}">{translate key="submission.authorVersion"}</td>
							{/if}
							<td width="80%" class="value"><a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}</td>
						</tr>
					{foreachelse}
						<tr valign="top">
							<td width="20%">{translate key="submission.authorVersion"}</td>
							<td width="80%" colspan="4" class="nodata"></p class="help-block">{translate key="common.none"}</p></td>
						</tr>
					{/foreach}
					{foreach from=$editorFiles item=editorFile key=key}
						<tr valign="top">
							{if !$editorRevisionExists}
								{assign var="editorRevisionExists" value=true}
								<td width="20%" rowspan="{$editorFiles|@count}">{translate key="submission.editorVersion"}</td>
							{/if}

							<td width="30%"><a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}</td>
						</tr>
					{foreachelse}
						<tr valign="top">
							<td width="20%">{translate key="submission.editorVersion"}</td>
							<td width="80%" colspan="4" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
						</tr>
					{/foreach}
				</table>
			</div>
		</div>
		
		<div class="separator"></div>
	{/section}
</div>