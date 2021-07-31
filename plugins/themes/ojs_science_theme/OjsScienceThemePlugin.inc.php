<?php

import('lib.pkp.classes.plugins.ThemePlugin');

class OjsScienceThemePlugin extends ThemePlugin {

	/**
	 * {@inheritdoc}
	 */
	function getDisplayName()
	{
		return 'OJS Science project theme';
	}

	/**
	 * {@inheritdoc}
	 */
	function getDescription()
	{
		return 'OJS Science project theme based on Bootstrap 3.';
	}

	/**
	 * {@inheritdoc}
	 */
	public function init()
	{
		$this->setParent('bootstrapthreethemeplugin');

		$bootstrapTheme = $this->getOption('bootstrapTheme');
		if (empty($bootstrapTheme) || $bootstrapTheme === 'bootstrap3') {
			$styleId = 'bootstrap';
		}
		else {
			$styleId = 'bootstrapTheme-' . $bootstrapTheme;
		}

		$this->modifyStyle($styleId, ['addLess' => ['styles/custom.less']]);

		$this->addMenuArea('footer');
	}

}
