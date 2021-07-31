<?php

import('lib.pkp.classes.plugins.GenericPlugin');

class ojsScienceBobikPlugin extends GenericPlugin {

	/**
	 * {@inheritdoc}
	 */
	function getDisplayName() {
		return 'OJS Science Bobik';
	}

	/**
	 * {@inheritdoc}
	 */
	function getDescription() {
		return 'Common things related to OJS Science project.';
	}

	/**
	 * {@inheritdoc}
	 */
	function register($category, $path, $mainContextId = null) {
		if (!parent::register($category, $path, $mainContextId)) {
			return false;
		}

		if (!Config::getVar('general', 'installed') || defined('RUNNING_UPGRADE')) {
			return true;
		}

		if ($this->getEnabled($mainContextId)) {
			HookRegistry::register('Templates::ojs_science::Area::Contacts', [$this, 'contactsAreaHandler']);
			HookRegistry::register('Templates::ojs_science::Area::Info', [$this, 'infoAreaHandler']);

			HookRegistry::register('NavigationMenus::itemTypes', [$this, 'menuItemTypesHandler']);
			HookRegistry::register('NavigationMenus::displaySettings', [$this, 'menuDisplaySettingsHandler']);
		}

		return true;
	}

	function contactsAreaHandler($hookName, $args) {
		$params =& $args[0];
		$smarty =& $args[1];
		$output =& $args[2];

		$output .= '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d2180.997093338742!2d32.04568959265556!3d49.45319457135277!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1suk!2sua!4v1451386015704" width="300" height="200" frameborder="0" style="border:0" allowfullscreen></iframe>';
	}

	function infoAreaHandler($hookName, $args) {
		$params =& $args[0];
		$smarty =& $args[1];
		$output =& $args[2];

		$output .= '<script type="text/javascript" src="//ra.revolvermaps.com/0/0/6.js?i=0a54gsmvfcp&amp;m=7&amp;s=170&amp;c=ff0000&amp;cr1=ffffff&amp;f=arial&amp;l=0" async="async"></script>';
	}

	function menuItemTypesHandler($hookName, $args) {
		$types =& $args[0];

		// No idea what happens here.
		AppLocale::requireComponents(LOCALE_COMPONENT_APP_COMMON, LOCALE_COMPONENT_PKP_USER, LOCALE_COMPONENT_APP_EDITOR);

		$ojsScienceTypes = [
			OJS_SCIENCE_NMI_TYPE_HOME => [
				'title' => 'Home',
				'description' => 'Home link',
			],
		];

		$types = array_merge($types, $ojsScienceTypes);
	}

	function menuDisplaySettingsHandler($hookName, $args) {
		/** @var NavigationMenuItem $navigationMenuItem */
		$navigationMenuItem =& $args[0];

		$request = Application::get()->getRequest();
		$dispatcher = $request->getDispatcher();

		$menuItemType = $navigationMenuItem->getType();

		switch ($menuItemType) {
			case OJS_SCIENCE_NMI_TYPE_HOME:
				$navigationMenuItem->setUrl($dispatcher->url(
					$request,
					ROUTE_PAGE,
					null,
					'index',
				));
		}
	}

}
