</div>
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
		{if $rightSidebarCode}
			<div class="col-md-4 mag-inner-right">
				{$rightSidebarCode}
			</div>
		{/if}
		</div>
    </div>
</div>
    
<script>{literal}
	var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
	(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
	g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
	s.parentNode.insertBefore(g,s)}{/literal}(document,'script'));
</script>
	
<!--start-footer-section-->
<div class="footer-section">
	<div class="container">
		<div class="footer-grids">
			<div class="col-md-4 footer-grid">
				<h4>Menu</h4>
				<ul class="td-pb-padding-side">
					<li id="home"><a href="{url page="index"}">{translate key="navigation.home"}</a></li>
					<li id="about"><a href="{url page="about"}">{translate key="navigation.about"}</a></li>

					{if $isUserLoggedIn}
						<li id="userHome"><a href="{url journal="index" page="user"}">{translate key="navigation.userHome"}</a></li>
					{else}
						<li id="login"><a href="{url page="login"}">{translate key="navigation.login"}</a></li>
						{if !$hideRegisterLink}
							<li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.register"}</a></li>
						{/if}
					{/if}{* $isUserLoggedIn *}

					{if $siteCategoriesEnabled}
						<li id="search"><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>
					{/if}{* $categoriesEnabled *}

					{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
						<li id="search"><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
					{/if}

					{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
						<li id="current"><a href="{url page="issue" op="current"}">{translate key="navigation.current"}</a></li>
						<li id="archives"><a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a></li>
					{/if}

					{if $enableAnnouncements}
						<li id="announcements"><a href="{url page="announcement"}">{translate key="announcement.announcements"}</a></li>
					{/if}{* enableAnnouncements *}

					{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

					{foreach from=$navMenuItems item=navItem}
						{if $navItem.url != '' && $navItem.name != ''}
							<li id="navItem"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{url page=""}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
						{/if}
					{/foreach}
				</ul>		
			</div>
			
			<div class="col-md-4 footer-grid">
				<h4>Contacts</h4>
				<div class="editor-pics">
					<p style="color:#ccc;">
						<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d2180.997093338742!2d32.04568959265556!3d49.45319457135277!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1suk!2sua!4v1451386015704" width="300" height="200" frameborder="0" style="border:0" allowfullscreen></iframe>
					</p>
				</div>			
			</div>
			
			<div class="col-md-4 footer-grid">
				<h4>Info</h4>
				<div class="editor-pics">
					<p style="color:#ccc;">
						<script type="text/javascript" src="//ra.revolvermaps.com/0/0/6.js?i=0a54gsmvfcp&amp;m=7&amp;s=170&amp;c=ff0000&amp;cr1=ffffff&amp;f=arial&amp;l=0" async="async"></script>
					</p>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<!--//end-footer-section-->	
		
<!--start-copyright-section-->
<div class="copyright">
	<p>&copy; 2016 Scientific periodicals of Cherkasy National University</p>
</div>

<!--start-smoth-scrolling-->
<script type="text/javascript">
	{literal}
	$(document).ready(function() {
		/*
		var defaults = {
			containerID: 'toTop', // fading element id
			containerHoverID: 'toTopHover', // fading element hover id
			scrollSpeed: 1200,
			easingType: 'linear' 
		};
		*/
		
		$().UItoTop({ easingType: 'easeOutQuart' });	
	});
	{/literal}
</script>
<a href="#home" id="toTop" class="scroll" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>
		
</body>
</html>