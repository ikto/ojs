{**
 * @file plugins/generic/booksForReview/templates/booksForReview.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of books available for review.
 *
 *}
{assign var="pageTitle" value="plugins.generic.booksForReview.public.booksForReview"}
{include file="common/header.tpl"}


<div id="booksForReviewListing" class="col-md-12 mag-innert-left">

	{if $additionalInformation[$locale]}
		{$additionalInformation[$locale]|strip_unsafe_html|nl2br}
	{/if}

	{if !$isAuthor}
		{url|assign:"registerUrl" page="user" op="register"}
		{url|assign:"loginAuthorUrl" page="author"}
		{translate key="plugins.generic.booksForReview.public.booksForReviewInstructions" registerUrl=$registerUrl loginAuthorUrl=$loginAuthorUrl}
		<br />
	{/if}

	<form role="form" class="form-inline" method="post" action="{url page="booksForReview}">
		<div class="form-group">
			<select name="searchField" size="1" class="form-control">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="form-group">
			<select name="searchMatch" size="1" class="form-control">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			</select>
		</div>
		<div class="form-group"><input type="text" size="30" name="search" class="form-control" value="{$search|escape}" /></div>
		<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>

	<br />

	<div class="table-responsive">
		<table class="table table-striped">
			{iterate from=booksForReview item=bookForReview}
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
				<tr>
					{if $bookForReview->getFileName($locale)}
						<td class="coverPage"><img class="img-responsive" src="{$coverPagePath|escape}{$bookForReview->getFileName($locale)|escape}"{if $bookForReview->getCoverPageAltText($locale) != ''} alt="{$bookForReview->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="plugins.generic.booksForReview.public.coverPage.altText"}"{/if}/></td>
						<td class="coverDetails">
					{else}
						<td class="details" colspan="2">
					{/if}
						<h3><a href="{url op="viewBookForReview" path=$bookForReview->getId()}">{$bookForReview->getLocalizedTitle()|escape}</a></h3>
					{translate key=$bookForReview->getAuthorTypeString()}&nbsp;{$bookForReview->getAuthorString()|escape}
						<br />
						<br />
						{$bookForReview->getYear()|escape}&nbsp;|&nbsp;{$bookForReview->getPublisher()|escape}
						<br />
						{translate key="plugins.generic.booksForReview.public.copy"}:&nbsp;{if $bookForReview->getCopy()}{translate key="plugins.generic.booksForReview.public.copyYes"}{else}{translate key="plugins.generic.booksForReview.public.copyNo"}{/if}
						<br />
						<br />
						{$bookForReview->getLocalizedDescriptionShort()|strip_unsafe_html|nl2br}
						{if $isAuthor}
						<br />
						<br />
						<a href="{url page="author" op="requestBookForReview" path=$bookForReview->getId()}" class="action">{translate key="plugins.generic.booksForReview.author.requestBookForReview}</a>
						{/if}
					</td>
				</tr>
				<tr>
					<td colspan="2" class="{if $booksForReview->eof()}end{/if}separator">&nbsp;</td>
				</tr>
			{/iterate}
			{if $booksForReview->wasEmpty() and $search != ""}
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" class="nodata"><p class="help-block">{translate key="plugins.generic.booksForReview.public.noResults"}</p></td>
				</tr>
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
			{elseif $booksForReview->wasEmpty()}
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" class="nodata"><p class="help-block">{translate key="plugins.generic.booksForReview.public.noneCreated"}</p></td>
				</tr>
				<tr>
					<td colspan="2" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td align="left">{page_info iterator=$booksForReview}</td>
					<td align="right">{page_links anchor="booksForReview" name="booksForReview" iterator=$booksForReview}</td>
				</tr>
			{/if}
		</table>
	</div>
</div>

{include file="common/footer.tpl"}