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

        import('ikto.classes.core.ScienceJournalCoreHelper');

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

    /**
     * Get the dispatcher implementation singleton
     * @return Dispatcher
     */
    function &getDispatcher() {
        $dispatcher =& Registry::get('dispatcher', true, null);

        if (is_null($dispatcher)) {
            import('ikto.classes.core.ScienceJournalDispatcher');

            // Implicitly set dispatcher by ref in the registry
            $dispatcher = new ScienceJournalDispatcher();

            // Inject dependency
            $dispatcher->setApplication(PKPApplication::getApplication());

            // Inject router configuration
            $dispatcher->addRouterName('ikto.classes.core.ScienceJournalComponentRouter', ROUTE_COMPONENT);
            $dispatcher->addRouterName('ikto.classes.core.ScienceJournalPageRouter', ROUTE_PAGE);
        }

        return $dispatcher;
    }
}
