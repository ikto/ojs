{**
 * templates/article/interstitial.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Interstitial page used to display a note
 * before downloading a file
 *
 *}

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>{translate key="article.nonpdf.title"}</title>

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/articleView.css" type="text/css" />

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	<meta http-equiv="refresh" content="2;URL={url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}"/>
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
	<link rel="stylesheet" href="{$baseUrl}/plugins/themes/bootstrappish/css/flexslider.css" type="text/css" media="screen" />
</head>

<body>
<!--JS-->
  <script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/bootstrap-3.1.1.min.js"></script>

<!--start-main-->
   <div class="main-content">
	   <div class="container">
	        <div class="mag-inner">
				<div class="col-md-8 mag-innert-left">
					<h3>{translate key="article.nonpdf.title"}</h3>
					{url|assign:"url" op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}
					<p class="help-block">{translate key="article.nonpdf.note" url=$url}</p>

					{if $pageFooter}
						<br /><br />
						{$pageFooter}
					{/if}
					{call_hook name="Templates::Article::Interstitial::PageFooter"}
</div>
</div>
</div>
</div>
</body>
</html>