{**
 * @file plugins/generic/booksForReview/templates/author/submissionBooksForReview.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of books for review for an author during article submission.
 *
 *}

<h3>{translate key="plugins.generic.booksForReview.author.booksForReview"}</h3>
<p class="help-block">{translate key="plugins.generic.booksForReview.author.submitInstructions"}:</p>

<div class="table-responsive">
	<table width="100%" class="table table-striped">
		{iterate from=booksForReview item=bookForReview}
			{assign var=bookId value=$bookForReview->getId()}
			<tr valign="top">
				<td><div class="form-group"><input type="radio" name="bookForReviewId" id="bookForReviewId-{$bookId|escape}" value="{$bookId|escape}" /> <label class="control-label" for="bookForReviewId-{$bookId|escape}">{$bookForReview->getLocalizedTitle()|escape|truncate:100:"..."}</label></div></td>
			</tr>
		{/iterate}
	</table>
</div>

<div class="separator"></div>