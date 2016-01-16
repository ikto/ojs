{**
 * templates/manager/reviewForms/previewReviewForm.tpl
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

{assign var=reviewFormId value=$reviewForm->getId()}
{if $completeCounts[$reviewFormId]==0 && $incompleteCounts[$reviewFormId]==0}
	{assign var=canEdit value=1}
{else}
	{assign var=canEdit value=0}
{/if}

{if $canEdit}
	<ul class="stay">
		<li><a href="{url op="editReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.edit"}</a></li>
		<li><a href="{url op="reviewFormElements" path=$reviewFormId}">{translate key="manager.reviewFormElements"}</a></li>
		<li class="current"><a href="{url op="previewReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.preview"}</a></li>
	</ul>
{/if}

<br/>

<h3>{$reviewForm->getLocalizedTitle()}</h3>
<p>{$reviewForm->getLocalizedDescription()}</p>

{foreach from=$reviewFormElements name=reviewFormElements item=reviewFormElement}
	<p>{$reviewFormElement->getLocalizedQuestion()}{if $reviewFormElement->getRequired()}*{/if}</p>
	<p>
		{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
			<input type="text" size="10" maxlength="40" class="textField" />
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
			<input type="text" size="40" maxlength="120" class="textField" />
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
			<textarea rows="4" cols="40" class="textArea"></textarea>
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
				<input id="check-{$responseId|escape}" type="checkbox"/>
				<label class="control-label" for="check-{$responseId|escape}">{$responseItem.content}</label>
				<br/>
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
				<input id="radio-{$responseId|escape}" name="{$reviewFormElement->getId()}" type="radio"/>
				<label class="control-label" for="radio-{$responseId|escape}">{$responseItem.content}</label>
				<br/>
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
			<select size="1" class="selectMenu">
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
					<option>{$responseItem.content}</option>
				{/foreach}
			</select>
		{/if}
	</p>
{/foreach}

<br/>

<form id="previewReviewForm" method="post" action="{if !$canEdit}{url op="reviewForms"}{else}{url op="editReviewForm" path=$reviewFormId}{/if}">
	<p><input type="submit" value="{translate key="common.close"}" class="btn btn-warning" /></p>
</form>

<p><p class="help-block">{translate key="common.requiredField"}</p></p>
{include file="common/footer.tpl"}

