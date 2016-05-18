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
    }

    function getDAOMap() {
        return array_merge(parent::getDAOMap(), array(
            'UserDAO' => 'custom.classes.user.ScienceUserDAO',
        ));
    }
}
