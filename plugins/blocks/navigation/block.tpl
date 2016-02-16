{**
 * plugins/blocks/navigation/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- navigation links.
 *
 *}

{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	<h4 class="side">{translate key="plugins.block.navigation.journalContent"}</h4>
	<div class="edit-pics" id="sidebarNavigation">
		<form role="form" id="simpleSearchForm" action="{url page="search" op="search"}">
			<div class="table-responsive">
				<table class="table table-striped" id="simpleSearchInput">
					<tr>
						<td>
							{capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
							{if empty($filterInput)}
								<div class="form-group">
									<label class="control-label" for="simpleQuery">{translate key="navigation.search"} <br />
									<input type="text" id="simpleQuery" name="simpleQuery" size="15" maxlength="255" value="" class="form-control" /></label>
								</div>
							{else}
								{$filterInput}
							{/if}
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
								<label class="control-label" for="searchField">
								{translate key="plugins.block.navigation.searchScope"}
								<br />
								<select id="searchField" name="searchField" size="1" class="form-control">
									{html_options_translate options=$articleSearchByOptions}
								</select></label>
							</div>
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="{translate key="common.search"}" class="btn btn-info" /></td>
					</tr>
				</table>
			</div>
		</form>


		{if $currentJournal}
			<p class="help-block">{translate key="navigation.browse"}</p>
			<ul class="stay">
				<li><a href="{url page="issue" op="archive"}">{translate key="navigation.browseByIssue"}</a></li>
				<li><a href="{url page="search" op="authors"}">{translate key="navigation.browseByAuthor"}</a></li>
				<li><a href="{url page="search" op="titles"}">{translate key="navigation.browseByTitle"}</a></li>
				{call_hook name="Plugins::Blocks::Navigation::BrowseBy"}
				{if $hasOtherJournals}
					<li><a href="{url journal="index"}">{translate key="navigation.otherJournals"}</a></li>
					{if $siteCategoriesEnabled}<li><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>{/if}
				{/if}
			</ul>
		{/if}
	</div>
{/if}