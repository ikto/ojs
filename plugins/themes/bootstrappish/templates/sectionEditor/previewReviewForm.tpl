{**
 * templates/sectionEditor/previewReviewForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Preview of a review form.
 *
 *}
{strip}
{assign var="pageId" value="manager.reviewFormElements.previewReviewForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<h3>{$reviewForm->getLocalizedTitle()}</h3>
	<p class="help-block">{$reviewForm->getLocalizedDescription()}</p>

	{foreach from=$reviewFormElements name=reviewFormElements item=reviewFormElement}
		<p class="help-block">{$reviewFormElement->getLocalizedQuestion()}{if $reviewFormElement->getRequired()}*{/if}</p>
		<p>
			{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
				<div class="form-group"><input type="text" size="10" maxlength="40" class="form-control" /></div>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
				<div class="form-group"><input type="text" size="40" maxlength="120" class="form-control" /></div>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
				<div class="form-group"><textarea rows="4" cols="40" class="form-control" /></textarea></div>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
					<div class="form-group">
						<input id="check-{$responseId|escape}" type="checkbox"/>
						<label class="control-label" for="check-{$responseId|escape}">{$responseItem.content}</label>
						<br/>
					</div>
				{/foreach}
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
					<div class="form-group">
						<input id="radio-{$responseId|escape}" name="{$reviewFormElement->getId()}" type="radio">
						<label class="control-label" for="radio-{$responseId|escape}">{$responseItem.content}</label>
						<br/>
					</div>
				{/foreach}
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
				<div class="form-group">
					<select size="1" class="form-control">
						{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
						{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
							<option>{$responseItem.content}</option>
						{/foreach}
					</select>
				</div>
			{/if}
		</p>
	{/foreach}

	<br/>

	<form role="form" id="previewReviewForm" method="post" action="{url op="selectReviewForm" path=$articleId|to_array:$reviewId}">
		<p><input type="submit" value="{translate key="common.close"}" class="btn btn-warning" /></p>
	</form>

	<p class="help-block">{translate key="common.requiredField"}</p>
</div>

{include file="common/footer.tpl"}