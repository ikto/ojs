<?php

import('classes.core.PageRouter');

class ScienceJournalPageRouter extends PageRouter {

    /**
     * A generic method to return an array of context paths (e.g. a Press or a Conference/SchedConf paths)
     * @param $request PKPRequest the request to be routed
     * @param $requestedContextLevel int (optional) the context level to return in the path
     * @return array of string (each element the path to one context element)
     */
    function getRequestedContextPaths(&$request) {
        // Handle context depth 0
        if (!$this->_contextDepth) return array();

        // Validate context parameters
        assert(isset($this->_contextDepth) && isset($this->_contextList));

        $isPathInfoEnabled = $request->isPathInfoEnabled();
        $userVars = array();
        $url = null;

        // Determine the context path
        if (empty($this->_contextPaths)) {
            if ($isPathInfoEnabled) {
                // Retrieve url from the path info
                if (isset($_SERVER['PATH_INFO'])) {
                    $url = $_SERVER['PATH_INFO'];
                }
            } else {
                $url = $request->getCompleteUrl();
                $userVars = $request->getUserVars();
            }

            $this->_contextPaths = ScienceJournalCoreHelper::getContextPaths($url, $isPathInfoEnabled,
                $this->_contextList, $this->_contextDepth, $userVars, $request->getServerHost());

            HookRegistry::call('Router::getRequestedContextPaths', array(&$this->_contextPaths));
        }

        return $this->_contextPaths;
    }

    /**
     * Get the page requested in the URL.
     * @param $request PKPRequest the request to be routed
     * @return String the page path (under the "pages" directory)
     */
    function getRequestedPage(&$request) {
        if (!isset($this->_page)) {
            $this->_page = $this->_getRequestedUrlParts(array('ScienceJournalCoreHelper', 'getPage'), $request);
        }
        return $this->_page;
    }

    /**
     * Get the operation requested in the URL (assumed to exist in the requested page handler).
     * @param $request PKPRequest the request to be routed
     * @return string
     */
    function getRequestedOp(&$request) {
        if (!isset($this->_op)) {
            $this->_op = $this->_getRequestedUrlParts(array('ScienceJournalCoreHelper', 'getOp'), $request);
        }
        return $this->_op;
    }

    /**
     * Get the arguments requested in the URL.
     * @param $request PKPRequest the request to be routed
     * @return array
     */
    function getRequestedArgs(&$request) {
        return $this->_getRequestedUrlParts(array('ScienceJournalCoreHelper', 'getArgs'), $request);
    }

    /**
     * Retrieve part of the current requested
     * url using the passed callback method.
     * @param $callback array Core method to retrieve
     * page, operation or arguments from url.
     * @param $request PKPRequest
     * @return array|string|null
     */
    function _getRequestedUrlParts($callback, &$request) {
        $url = null;
        assert(is_a($request->getRouter(), 'PKPPageRouter'));
        $isPathInfoEnabled = $request->isPathInfoEnabled();

        if ($isPathInfoEnabled) {
            if (isset($_SERVER['PATH_INFO'])) {
                $url = $_SERVER['PATH_INFO'];
            }
        } else {
            $url = $request->getCompleteUrl();
        }

        $userVars = $request->getUserVars();
        return call_user_func_array($callback, array($url, $isPathInfoEnabled, $userVars, $request->getServerHost()));
    }

    /**
     * @see PKPRouter::getCacheFilename()
     */
    function getCacheFilename(&$request) {
        if (!isset($this->_cacheFilename)) {
            $cacheKey = $this->getCacheKey($request);
            $path = dirname(INDEX_FILE_LOCATION);
            $this->_cacheFilename = $path . '/cache/_web/wc-' . $cacheKey . '.html';
        }
        return $this->_cacheFilename;
    }

    /**
     * Creates the cache key for the web cache
     *
     * @param PKPRequest $request
     * @return string
     */
    function getCacheKey($request) {
        if ($request->isPathInfoEnabled()) {
            $id = implode('-', $this->getRequestedContextPaths($request));
            $id .= isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : 'index';
            $id .= '-' . AppLocale::getLocale();
        } else {
            $id = '';
            $application =& $this->getApplication();
            foreach($application->getContextList() as $contextName) {
                $id .= $request->getUserVar($contextName) . '-';
            }
            $id .= $request->getUserVar('page') . '-' . $request->getUserVar('op');
            $id .= '-' . $request->getUserVar('path') . '-' . AppLocale::getLocale();
        }

        // Stolen from Drupal 7 (mostly)
        return strtr(base64_encode(sha1($id)), array('+' => '-', '/' => '_', '=' => ''));
    }

    /**
     * @param PKPRequest $request
     */
    function route($request) {

        // Need for ikto/ojs-science#14
        if ($request->isPathInfoEnabled()) {
            $pathInfo = $_SERVER['PATH_INFO'];
            $pathInfo = trim($pathInfo);
            $pathInfo = trim($pathInfo, '/');
            if (empty($pathInfo)) {
                $request->redirect(null, 'index');
            }
        }

        parent::route($request);
    }
}
