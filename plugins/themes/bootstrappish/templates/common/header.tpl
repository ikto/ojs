<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
{strip}
{translate|assign:"applicationName" key="common.openJournalSystems"}
{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>{$pageTitleTranslated}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}
		
	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="//www.google.com/jsapi"></script>
	<script type="text/javascript">
	{literal}
		<!--
		// Provide a local fallback if the CDN cannot be reached
		if (typeof google == 'undefined') {
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
		} else {
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
		}
		// -->
	{/literal}</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	<script type="text/javascript">
	{literal}
		<!--
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
		});
		// -->
	{/literal}
	</script>

	<script type="text/javascript">
	{literal}
		<!--
		// initialise plugins
		$(function(){
			{/literal}{if $validateId}{literal}
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			$("form[name={/literal}{$validateId}{literal}]").validate({
				errorClass: "error",
				highlight: function(element, errorClass) {
					$(element).parent().parent().addClass(errorClass);
				},
				unhighlight: function(element, errorClass) {
					$(element).parent().parent().removeClass(errorClass);
				}
			});
			{/literal}{/if}{literal}
			$(".tagit").live('click', function() {
				$(this).find('input').focus();
			});
		});
		// -->
		{/literal}
	</script>

	{if $hasSystemNotifications}
		{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
		<script type="text/javascript">
			$(function(){ldelim}
				$.get('{$fetchNotificationUrl}', null,
					function(data){ldelim}
						var notifications = data.content;
						var i, l;
						if (notifications && notifications.general) {ldelim}
							$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
								$.each(notificationList, function(notificationId, notification) {ldelim}
									console.log(notification);
									$.pnotify(notification);
								{rdelim});
							{rdelim});
						{rdelim}
				{rdelim}, 'json');
			{rdelim});
		</script>
	{/if}{* hasSystemNotifications *}

	{$additionalHeadData}

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
    //Load the new jQuery locally if it could not be loaded from the CDN
	{literal}
    if (typeof jQuery == 'undefined' || jQuery.fn.jquery != '1.9.1')
    {
        document.write(unescape("%3Cscript src='{/literal}{$baseUrl|escape:"javascript"}{literal}/plugins/themes/bootstrappish/js/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
    }
    </script>

    <script type="text/javascript">
	
    //Ensure the new jQuery doesn't conflict. 
    var jQueryNew = window.jQuery.noConflict(true);
    </script>
    {/literal}
	
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
	
	<script src="{$baseUrl}/plugins/themes/bootstrappish/sliders/src/skdslider.min.js"></script>
<link href="{$baseUrl}/plugins/themes/bootstrappish/sliders/src/skdslider.css" rel="stylesheet">
<script type="text/javascript">{literal}
		jQuery(document).ready(function(){
			jQuery('#demo1').skdslider({'delay':5000, 'animationSpeed': 2000,'showNextPrev':true,'showPlayButton':true,'autoSlide':true,'animationType':'fading'});
			
			jQuery('#responsive').change(function(){
			  $('#responsive_wrapper').width(jQuery(this).val());
			});
			
		});{/literal}
</script>
	
</head>
<body>
<!--JS-->
  <script type="text/javascript" src="{$baseUrl}/plugins/themes/bootstrappish/js/bootstrap-3.1.1.min.js"></script>
<!--/.navbar-->
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
				<a class="navbar-brand" href="{url page="index"}"><h1>E<span> - Journal</span></h1> </a>
			</div>
			<!--/.navbar-header-->
			{include file="common/navbar.tpl"}
			<!--/.navbar-->
			 </div>
			</nav>
		  </div>
		 </div>

{if $smarty.server.REQUEST_URI === "/index.php/phys" || $smarty.server.REQUEST_URI === "/index.php/phys/" || $smarty.server.REQUEST_URI === "/index.php/phys/index" || $smarty.server.REQUEST_URI === "/index.php/phys/index/"}
<!--/start-banner-->
<ul id="demo1">
<li>
<img class="img-responsive" src="{$baseUrl}/plugins/themes/bootstrappish/sliders/slides/1.jpg" />
<!--Slider Description example-->
 <div class="slide-desc">
		<h2>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
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
								{/if}</h2>
		<p>{get_debug_info}
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
							{call_hook name="Templates::Common::Footer::PageFooter"}<a class="more" <a href="{url page="about" op="submissions" anchor="onlineSubmissions"}">{translate key="about.onlineSubmissions"}</a></p>
  </div>
</li>
<li><img class="img-responsive" src="{$baseUrl}/plugins/themes/bootstrappish/sliders/slides/2.jpg" />
   <div class="slide-desc">
		<h2>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
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
								{/if}</h2>
		<p>{get_debug_info}
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
							{call_hook name="Templates::Common::Footer::PageFooter"}<a class="more" href="{url page="about"}"}>{translate key="navigation.about"}</a></p>
  </div>
</li>
<li><img class="img-responsive" src="{$baseUrl}/plugins/themes/bootstrappish/sliders/slides/3.jpg" />
<div class="slide-desc">
		<h2>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
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
								{/if}</h2>
		<p>{get_debug_info}
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
							{call_hook name="Templates::Common::Footer::PageFooter"}<a class="more" href="{url page="issue" op="current"}">{translate key="navigation.current"}</a></p>
  </div>
</li>
<li><img class="img-responsive" src="{$baseUrl}/plugins/themes/bootstrappish/sliders/slides/4.jpg" />
  <div class="slide-desc">
		<h2>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
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
								{/if}</h2>
		<p>{get_debug_info}
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
							{call_hook name="Templates::Common::Footer::PageFooter"}<a class="more" href="{url page="user" op="register"}">{translate key="navigation.register"}</a></p>
  </div>
</li>
<li><img class="img-responsive" src="{$baseUrl}/plugins/themes/bootstrappish/sliders/slides/5.jpg" />
<div class="slide-desc">
		<h2>{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
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
								{/if}</h2>
		<p>{get_debug_info}
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
							{call_hook name="Templates::Common::Footer::PageFooter"}<a class="more" href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a></p>
  </div>
</li>
</ul>
<!--//end-banner-->
{else}
<!--/start-banner-->
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
	       <h2 class="inner-tittle" style="float:right;">{$pageTitleTranslated}</h2>
    </div>
</div>
   <!--//end-banner-->
{/if}
											
<!--/start-main-->
   <div class="main-content">
	   <div class="container">
	        <div class="mag-inner">
			
			 {include file="common/breadcrumbs.tpl"}
				   
				   {call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
				   {if $leftSidebarCode}
						<div class="col-md-4 mag-inner-right">
							{$leftSidebarCode|regex_replace:'/<\/div>.*?<div/s':'</div><li class="divider"></li><div'|replace:'<br />':''|replace:'<div':'<li'|replace:'div>':'li>'|replace:'ul':'ul class="nav nav-list"'|replace:'span':'li'|replace:'li class="blockTitle"':'li class="nav-header"'|replace:'blockSubtitle':'nav-header sub-header'|replace:'<form':'<li><form'|replace:'/form>':'/form></li>'}
						</div>	
				{/if}
	
			<div class="col-md-8 mag-innert-left">		
<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
{/if}
						    
