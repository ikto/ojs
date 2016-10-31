{**
 * templates/article/header.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>{$article->getLocalizedTitle()|strip_tags|escape} | {$article->getFirstAuthor(true)|strip_tags|escape} | {$currentJournal->getLocalizedTitle()|strip_tags|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}
	<meta name="viewport" content="width=device-width, initial-scale=1">

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	{if $journalRt && $journalRt->getEnabled()}
		<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rtEmbedded.css" type="text/css" />
	{/if}

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="http://www.google.com/jsapi"></script>
		<script type="text/javascript">
		{literal}
			// Provide a local fallback if the CDN cannot be reached
			if (typeof google == 'undefined') {
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
			} else {
				google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
				google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
			}
		{/literal}
		</script>
	{else}
		<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
		<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	<script type="text/javascript">{literal}
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
		});
	{/literal}</script>

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}
	<!-- Template Plugin -->
	<script type="application/x-javascript"> {literal}addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } {/literal}</script>
	<link href="{$baseUrl}/plugins/themes/bootstrappish/css/bootstrap-3.1.1.min.css" rel="stylesheet" type="text/css">
	
	<!-- Custom Theme files -->
	<link href="{$baseUrl}/plugins/themes/bootstrappish/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all" />
	<link href="{$baseUrl}/plugins/themes/bootstrappish/css/style.css" rel='stylesheet' type='text/css' />	
	<script src="{$baseUrl}/plugins/themes/bootstrappish/js/jquery.min.js"> </script>
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/move-top.js"></script>
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/easing.js"></script>	
</head>
<body>
<!--JS-->
<script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/bootstrap-3.1.1.min.js"></script>
<!--.navbar-->
<div class="header" id="home">
	<div class="content white">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="{url page="index"}"><img class="img-responsive" title="Scientific periodicals of Cherkasy National University" alt="Scientific periodicals of Cherkasy National University" src="{$baseUrl}/plugins/themes/bootstrappish/images/logo.png" /></a>
				</div>
				<!--/.navbar-header-->
				{include file="common/navbar.tpl"}
				<!--/.navbar-->
			</div>
		</nav>
	</div>
</div>
<!--start-banner-->
<div class="banner two">
	<div class="container">
		<h4 class="inner-tittle" style="float:right;">{get_debug_info}
		{if $enableDebugStats}{include file=$pqpTemplate}{/if}

		{strip}
			{if $pageFooter==''}
				{if $currentJournal && $currentJournal->getSetting('onlineIssn')}
					{assign var=issn value=$currentJournal->getSetting('onlineIssn')}
				{elseif $currentJournal && $currentJournal->getSetting('printIssn')}
					{assign var=issn value=$currentJournal->getSetting('printIssn')}
				{/if}
				{if $issn}
					{translate|assign:"issnText" key="journal.issn"}
					{assign var=pageFooter value="$issnText: $issn"}
				{/if}
			{/if}
		{/strip}
		{if $displayCreativeCommons}
			{translate key="common.ccLicense"}
		{/if}
		{if $pageFooter}
			{$pageFooter}
		{/if}
		{call_hook name="Templates::Common::Footer::PageFooter"}</h4>
		<h2 class="inner-tittle" style="float:right;">
			{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
				<img class="img-responsive" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
			{/if}
			{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
				<img class="img-responsive" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
			{elseif $displayPageHeaderTitle}
				{$displayPageHeaderTitle}
			{elseif $alternatePageHeader}
				{$alternatePageHeader}
			{elseif $siteTitle}
				{$siteTitle}
			{else}
				{$applicationName}
			{/if}
		</h2>
    </div>
</div>
<!--//end-banner-->

<!--start-main-->
<div class="main-content">
	<div class="container">
		<div class="mag-inner">		
			
			<div id="breadcrumb" class="col-md-12 mag-innert-left">
				<a href="{url page="index"}" target="_parent">{translate key="navigation.home"}</a> &gt;
				{if $issue}<a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a> &gt;{/if}
				<a href="{url page="article" op="view" path=$articleId|to_array:$galleyId}" class="current" target="_parent">{$article->getFirstAuthor(true)|escape}</a>
			</div>

			{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
			{if $leftSidebarCode}
				<div class="col-md-4 mag-inner-right">
					{$leftSidebarCode}
				</div>	
			{/if}

			<div class="col-md-8 mag-innert-left">