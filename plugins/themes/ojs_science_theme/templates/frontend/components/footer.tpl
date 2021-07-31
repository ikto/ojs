{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

	</main>

	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<aside id="sidebar" class="pkp_structure_sidebar left col-xs-12 col-sm-4 col-md-4" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
				{$sidebarCode}
			</aside><!-- pkp_sidebar.left -->
		{/if}
	{/if}
	</div><!-- pkp_structure_content -->

	<footer class="footer" role="contentinfo">

		<div class="container">
			{if $pageFooter}
			<div class="row">
				<div class="col-md-12">
					{$pageFooter}
				</div>
			</div>
			{/if}

			<div class="row">
				<div class="col-md-4">
					{capture assign="footerMenu"}
						{load_menu name="footer" id="footer-navigation" ulClass="footer-navigation-menu"}
					{/capture}
					{if !empty(trim($footerMenu))}
					<h4>Menu</h4>
					{$footerMenu}
					{/if}
				</div>
				<div class="col-md-4">
					{capture assign="contactsAreaCode"}{call_hook name="Templates::ojs_science::Area::Contacts"}{/capture}
					<h4>Contacts</h4>
					{$contactsAreaCode}
				</div>
				<div class="col-md-4">
					{capture assign="infoAreaCode"}{call_hook name="Templates::ojs_science::Area::Info"}{/capture}
					<h4>Info</h4>
					{$infoAreaCode}
				</div>

			</div> <!-- .row -->
		</div><!-- .container -->
	</footer>
</div><!-- pkp_structure_page -->

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
