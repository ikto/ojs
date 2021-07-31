{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
	<div class="pkp_structure_page">

		<nav id="accessibility-nav" class="sr-only" role="navigation" aria-label="{translate|escape key="plugins.themes.bootstrap3.accessible_menu.label"}">
			<ul>
			  <li><a href="#main-navigation">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_navigation"}</a></li>
			  <li><a href="#main-content">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_content"}</a></li>
			  <li><a href="#sidebar">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.sidebar"}</a></li>
			</ul>
		</nav>

		{* Header *}
		<header class="navbar navbar-main" id="headerNavigationContainer" role="banner">

			{* User profile, login, etc, navigation menu*}
			<div class="container">
				<div class="row">
					<nav aria-label="{translate|escape key="common.navigation.user"}">
						{load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right"}
					</nav>
				</div><!-- .row -->
			</div><!-- .container -->

			<div class="container">

				<div class="navbar-header">

					<a class="navbar-brand" href="{url page="index"}">
						<img class="img-responsive" title="Scientific periodicals of Cherkasy National University" alt="Scientific periodicals of Cherkasy National University" src="{$baseUrl}/plugins/themes/ojs_science_theme/images/logo.png" />
					</a>

					{* Mobile hamburger menu *}
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu" aria-expanded="false" aria-controls="nav-menu">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>

				</div>

				{* Primary site navigation *}
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="main-navigation" ulClass="nav navbar-nav navbar-right"}
				{/capture}

				{if !empty(trim($primaryMenu))}
					<nav id="nav-menu" class="navbar-collapse collapse" aria-label="{translate|escape key="common.navigation.site"}">
						{* Primary navigation menu for current application *}
						{$primaryMenu}
					</nav>
				{/if}

			</div><!-- .container -->
			<div class="banner-top">
				<div class="container">
                    {* Logo or site title. Only use <h1> heading on the homepage.
					   Otherwise that should go to the page title. *}
                    {if $requestedPage == 'index' && $requestedOp == 'index'}
					<h1 class="site-name">
					{else}
					<div class="site-name">
					{/if}
					{capture assign="homeUrl"}
						{url page="index" router=$smarty.const.ROUTE_PAGE}
					{/capture}
						<span class="banner-top__title">{$displayPageHeaderTitle}</span>
					{if $requestedPage == 'index' && $requestedOp == 'index'}
					</h1>
                    {else}
					</div>
    	            {/if}
				</div>

			</div>
		</header><!-- .pkp_structure_head -->

		{* Wrapper for page content and sidebars *}
		<div class="pkp_structure_content container">
			<main class="pkp_structure_main col-xs-12 col-sm-8 col-md-8" role="main">
