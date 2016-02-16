{**
 * templates/about/editorialTeamBio.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * View the biography of an editorial team member.
 *
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{translate key="about.editorialTeam"}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rt.css" type="text/css" />

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

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
	<link href="{$baseUrl}/plugins/themes/bootstrappish/css/style.css" rel='stylesheet' type='text/css' />	
	<script src="{$baseUrl}/plugins/themes/bootstrappish/js/jquery.min.js"> </script>
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/easing.js"></script>	
</head>

<body id="pkp-{$pageTitle|replace:'.':'-'}">
	<script type="text/javascript">
	{literal}
	<!--
		if (self.blur) { self.focus(); }
	// -->
	{/literal}
	</script>

	{assign var=pageTitleTranslated value=$user->getFullName()|escape}
	{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}

<div id="container">
	
	<div class="header" id="home">
		<div class="content white">
			<nav class="navbar navbar-default" role="navigation">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand"><h1>{translate key="about.editorialTeam"}</h1> </a>
					</div>
				</div>
			</nav>
		</div>
	</div>

	<div class="main-content">
		<div class="container">
			<div class="mag-inner">			
				<script type="text/javascript">
				{literal}
				<!--
					if (self.blur) { self.focus(); }
				// -->
				{/literal}
				</script>				

				<div id="profilePicContent" class="col-md-4 mag-innert-left">
					{assign var="profileImage" value=$user->getSetting('profileImage')}
					{if $profileImage}
						<img class="img-responsive" height="{$profileImage.height|escape}" width="{$profileImage.width|escape}" alt="{translate key="user.profile.profileImage"}" src="{$sitePublicFilesDir}/{$profileImage.uploadName}" />
					{/if}
				</div>

				<div id="mainContent" class="col-md-8 mag-innert-left">
					<h2>{$pageTitleTranslated}</h2>
					<p class="text">
						<em>{$user->getFullName()|escape}</em>
						{if $publishEmail}
							{assign_mailto var=address address=$user->getEmail()|escape}
							{icon name="mail" url=$address}
						{/if}
						<br />
						{if $user->getUrl()}<a href="{$user->getUrl()|escape:"quotes"}" target="_new">{$user->getUrl()|escape}</a><br/>{/if}
						{if $user->getLocalizedAffiliation()}{$user->getLocalizedAffiliation()|escape}{assign var=needsComma value=1}{/if}{if $country}{if $needsComma}, {/if}{$country|escape}{/if}
					</p>
					<p class="text">{$user->getLocalizedBiography()|nl2br|strip_unsafe_html}</p>
					<input type="button" onclick="window.close()" value="{translate key="common.close"}" class="btn btn-danger" />
				</div>
			</div><!-- mag-inner -->
		</div><!-- container -->
	</div><!-- mainContent -->
</div><!-- container -->
</body>
</html>