<?php

import('classes.user.UserDAO');

class ScienceUserDAO extends UserDAO {

    function flushCache() {
        parent::flushCache();

        /**
         * If .gitignore was removed when cache has being cleared,
         * restore it to default (ikto/ojs-science#5).
         * ADODB completely wipes the cache directory, so
         * this workaround is really needed.
         */
        $cacheDir = CacheManager::getFileCachePath() . '/_db';
        $gitignore = $cacheDir . '/.gitignore';
        if (!file_exists($gitignore)) {
            file_put_contents($gitignore, "*\n!.gitignore\n");
        }
    }

}
