<?php

/**
 * @file ikto/classes/core/ScienceApplication.inc.php
 *
 * This file contains an overridden application class
 * for specific purposes of certain website.
 */

import('classes.core.Application');

class ScienceJournalApplication extends Application {
    function ScienceJournalApplication() {
        parent::Application();

        HookRegistry::register('LoadHandler', array($this, 'hookLoadHandlerCallback'));
    }

    function hookLoadHandlerCallback($hookName, $args) {
        if (empty($args[0]) || empty($args[1])) {
            return false;
        }

        if ($args[0] == 'admin') {
            switch ($args[1]) {
                case 'clearTemplateCache':
                case 'clearDataCache':
                    define('HANDLER_CLASS', 'ScienceJournalAdminFunctionsHandler');
                    import('ikto.pages.admin.ScienceJournalAdminFunctionsHandler');

                    return true;
                    break;
            }
        }

        return false;
    }
}
