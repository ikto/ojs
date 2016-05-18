<?php

import('pages.admin.AdminFunctionsHandler');

class ScienceAdminFunctionsHandler extends AdminFunctionsHandler {

    /**
     * Clear compiled templates.
     */
    function clearTemplateCache() {
        $this->validate();
        $templateMgr =& TemplateManager::getManager();
        $templateMgr->clearTemplateCache();

        foreach (array('t_cache', 't_compile', 't_config') as $cacheSubdir) {
            /**
             * If .gitignore was removed when cache has being cleared,
             * restore it to default (ikto/ojs-science#5).
             * Smarty completely wipes the cache directory, so
             * this workaround is really needed.
             */
            $cacheDir = CacheManager::getFileCachePath() . '/' . $cacheSubdir;
            $gitignore = $cacheDir . '/.gitignore';
            if (!file_exists($gitignore)) {
                file_put_contents($gitignore, "*\n!.gitignore\n");
            }
        }

        Request::redirect(null, 'admin');
    }

    /**
     * Clear the data cache.
     */
    function clearDataCache() {
        $this->validate();

        // Clear the CacheManager's caches
        $cacheManager =& CacheManager::getManager();
        $cacheManager->flush(null, CACHE_TYPE_FILE);
        $cacheManager->flush(null, CACHE_TYPE_OBJECT);

        // Clear ADODB's cache
        $userDao =& DAORegistry::getDAO('UserDAO'); // As good as any
        $userDao->flushCache();

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

        Request::redirect(null, 'admin');
    }
}
