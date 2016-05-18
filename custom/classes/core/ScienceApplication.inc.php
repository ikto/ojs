<?php

/**
 * @file custom/classes/core/ScienceApplication.inc.php
 *
 * This file contains an overridden application class
 * for specific purposes of certain website.
 */

import('classes.core.Application');

class ScienceApplication extends Application {
    function ScienceApplication() {
        parent::Application();

        HookRegistry::register('LoadHandler', array($this, 'hookLoadHandlerCallback'));
    }

    function getDAOMap() {
        return array_merge(parent::getDAOMap(), array(
            'UserDAO' => 'custom.classes.user.ScienceUserDAO',
        ));
    }

    function hookLoadHandlerCallback($hookName, $args) {
        if (empty($args[0]) || empty($args[1])) {
            return false;
        }

        if (($args[0] == 'admin') && ($args[1] == 'clearTemplateCache')) {
            define('HANDLER_CLASS', 'ScienceAdminFunctionsHandler');
            import('custom.pages.admin.ScienceAdminFunctionsHandler');
            return true;
        }

        return false;
    }
}
