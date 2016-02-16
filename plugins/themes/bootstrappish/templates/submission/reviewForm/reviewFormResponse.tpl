{**
 * templates/submission/reviewForm/reviewFormResponse.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Review Form to enter responses/comments/answers.
 *
 *}
{strip}
{if $editorPreview}
	{include file="submission/comment/header.tpl"}
{else}
	{translate|assign:"pageTitleTranslated" key="submission.reviewFormResponse"}
	{assign var="pageCrumbTitle" value="submission.reviewFormResponse"}
	{include file="common/header.tpl"}
	{include file="common/formErrors.tpl"}
{/if}
{/strip}

{assign var=disabled value=0}
{if $isLocked || $editorPreview}
	{assign var=disabled value=1}
{/if}

<div id="reviewFormResponse" class="col-md-12 mag-innert-left">
	<h3>{$reviewForm->getLocalizedTitle()}</h3>
	<p class="help-block">{$reviewForm->getLocalizedDescription()}</p>

	<form role="form" id="saveReviewFormResponse" method="post" action="{url op="saveReviewFormResponse" path=$reviewId|to_array:$reviewForm->getId()}">
		{foreach from=$reviewFormElements name=reviewFormElements key=elementId item=reviewFormElement}
			<p class="help-block">{$reviewFormElement->getLocalizedQuestion()} {if $reviewFormElement->getRequired() == 1}*{/if}</p>
			<p>
				{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
					<div class="form-group"><input {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}type="text" name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" value="{$reviewFormResponses[$elementId]|escape}" size="10" maxlength="40" class="form-control" /></div>
				{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
					<div class="form-group"><input {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}type="text" name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" value="{$reviewFormResponses[$elementId]|escape}" size="40" maxlength="120" class="form-control" /></div>
				{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
					<div class="form-group"><textarea {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" rows="4" cols="40" class="form-control">{$reviewFormResponses[$elementId]|escape}</textarea></div>
				{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
					{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
					{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
						<div class="form-group"><input {if $disabled}disabled="disabled" {/if}type="checkbox" name="reviewFormResponses[{$elementId}][]" id="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}" value="{$smarty.foreach.responses.iteration}"{if !empty($reviewFormResponses[$elementId]) && in_array($smarty.foreach.responses.iteration, $reviewFormResponses[$elementId])} checked="checked"{/if} /><label class="control-label" for="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}">{$responseItem.content}</label></div><br/>
					{/foreach}
				{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
					{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
					{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
						<div class="form-group"><input {if $disabled}disabled="disabled" {/if}type="radio"  name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}" value="{$smarty.foreach.responses.iteration}"{if $smarty.foreach.responses.iteration == $reviewFormResponses[$elementId]} checked="checked"{/if}/><label class="control-label" for="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}">{$responseItem.content}</label></div><br/>
					{/foreach}
				{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
					<div class="form-group">
						<select {if $disabled}disabled="disabled" {/if}name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" size="1" class="form-control">
							<option label="" value=""></option>
							{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
							{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
								<option label="{$responseItem.content}" value="{$smarty.foreach.responses.iteration}"{if $smarty.foreach.responses.iteration == $reviewFormResponses[$elementId]} selected="selected"{/if}>{$responseItem.content}</option>
							{/foreach}
						</select>
					</div>
				{/if}
			</p>
		{/foreach}

		<br />

		{if $editorPreview}
			<p><input type="button" value="{translate key="common.close"}" class="btn btn-danger" onclick="window.close()" /></p>
		{else}
			<p><input {if $disabled}disabled="disabled" {/if}type="submit" name="save" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.close"}" class="btn btn-danger" onclick="document.location.href='{url op="submission" path=$reviewId}'" /></p>
		{/if}

		<p class="help-block">{translate key="common.requiredField"}</p>
	</form>
</div>

{include file="submission/comment/footer.tpl"}