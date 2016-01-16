<?php

/**
 * @file BootstrappishThemePlugin.inc.php
 *
 * Copyright (c) 2013 Christopher Anderton
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class BootstrappishThemePlugin
 * @ingroup plugins_themes_bootstrappish
 *
 * @brief "Bootstrappish" theme plugin
 */

//$Id$

import('classes.plugins.ThemePlugin');

class BootstrappishThemePlugin extends ThemePlugin {
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'BootstrappishThemePlugin';
	}

	function getDisplayName() {
		return 'Bootstrappish Theme';
	}

	function getDescription() {
		return 'Remaps twitter Bootstrap to fit PKP without modifying templates';
	}
	
	function getStylesheetFilename() {
		return 'bootstrap-3.1.1.min.css';
	}

	/**
	 * Activate the theme.
	 */
	function activate(&$templateMgr) {
		// Subclasses may override this function.
		
		$templateMgr->template_dir[0] = Core::getBaseDir() 
										. DIRECTORY_SEPARATOR 
										. 'plugins' 
										. DIRECTORY_SEPARATOR 
										. 'themes' 
										. DIRECTORY_SEPARATOR 
										. 'bootstrappish' 
										. DIRECTORY_SEPARATOR 
										. 'templates';
										
		// Add in Bootstrap JS
		$templateMgr->addJavaScript('plugins/themes/bootstrappish/js/bootstrap-3.1.1.min.js');
		$templateMgr->addJavaScript('plugins/themes/bootstrappish/js/jquery.min.js');
		
		if (($stylesheetFilename = $this->getStylesheetFilename()) != null) {
			$path = Request::getBaseUrl() . '/' . $this->getPluginPath() . '/css/' . $stylesheetFilename .'?bootstrappish';
			$templateMgr->addStyleSheet($path);
		}
	}
}

?>
