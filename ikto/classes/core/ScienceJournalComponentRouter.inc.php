<?php

import('lib.pkp.classes.core.PKPComponentRouter');

class ScienceJournalComponentRouter extends PKPComponentRouter {

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
}
