{**
 * plugins/blocks/fontSize/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- font size selector.
 *
 *}

<!-- Add javascript required for font sizer -->
<script type="text/javascript">
{literal}
	<!--
	$(function(){
		fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
	});
	// -->
{/literal}
</script>

<h4 class="side">{translate key="plugins.block.fontSize.title"}</h4>
<div class="edit-pics" id="sidebarFontSize" style="margin-bottom: 4px;">
	<div id="sizer" style="margin-bottom: 8%; margin-left: 4%;"></div>
</div>
<br />