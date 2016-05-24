<?php

import('lib.pkp.classes.core.Dispatcher');

class ScienceJournalDispatcher extends Dispatcher {

    /**
     * Instantiate a router
     * @param $routerName string
     * @param $shortcut string
     */
    function &_instantiateRouter($routerName, $shortcut) {
        if (!isset($this->_routerInstances[$shortcut])) {
            // Routers must belong to the classes.core or lib.pkp.classes.core package
            // NB: This prevents code inclusion attacks.
            $allowedRouterPackages = array(
                'ikto.classes.core',
                'classes.core',
                'lib.pkp.classes.core'
            );

            // Instantiate the router
            $router =& instantiate($routerName, 'PKPRouter', $allowedRouterPackages);
            if (!is_object($router)) {
                fatalError('Cannot instantiate requested router. Routers must belong to the core package and be of type "PKPRouter".');
            }
            $router->setApplication($this->_application);
            $router->setDispatcher($this);

            // Save the router instance for later re-use
            $this->_routerInstances[$shortcut] =& $router;
        }

        return $this->_routerInstances[$shortcut];
    }
}
