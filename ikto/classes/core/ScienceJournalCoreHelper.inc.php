<?php

class ScienceJournalCoreHelper
{

    /**
     * Get context paths present into the passed
     * url information.
     * @param $urlInfo string Full url or just path info.
     * @param $isPathInfo boolean Whether the
     * passed url info string is a path info or not.
     * @param $contextList array (optional)
     * @param $contextDepth int (optional)
     * @param $userVars array (optional) Pass GET variables
     * if needed (for testing only).
     * @param $hostInfo string (optional) The hostname
     * @return array
     */
    function getContextPaths($urlInfo, $isPathInfo, $contextList = null, $contextDepth = null, $userVars = array(), $hostInfo = null)
    {
        $contextPaths = array();
        $application =& Application::getApplication();

        if (!$contextList) {
            $contextList = $application->getContextList();
        }
        if (!$contextDepth) {
            $contextDepth = $application->getContextDepth();
        }

        // Handle context depth 0
        if (!$contextDepth) return $contextPaths;

        $masterContextPath = self::getContextByHostAndUrlInfo($urlInfo, $hostInfo);

        if ($isPathInfo) {
            // Split the path info into its constituents. Save all non-context
            // path info in $contextPaths[$contextDepth]
            // by limiting the explode statement.
            $contextPaths = explode('/', trim($urlInfo, '/'), $contextDepth + 1);
            // Remove the part of the path info that is not relevant for context (if present)
            unset($contextPaths[$contextDepth]);

            // If we've successfully determined master context path
            if ($masterContextPath) {
                $contextPaths = array($masterContextPath);
            }
        } else {
            // Retrieve context from url query string
            foreach ($contextList as $key => $contextName) {
                $contextPaths[$key] = Core::_getUserVar($urlInfo, $contextName, $userVars);
            }

            if ($masterContextPath) {
                $contextPaths[0] = $masterContextPath;
            }
        }

        // Canonicalize and clean context paths
        for ($key = 0; $key < $contextDepth; $key++) {
            $contextPaths[$key] = (
            isset($contextPaths[$key]) && !empty($contextPaths[$key]) ?
                $contextPaths[$key] : 'index'
            );
            $contextPaths[$key] = Core::cleanFileVar($contextPaths[$key]);
        }

        return $contextPaths;
    }

    /**
     * Get the page present into
     * the passed url information. It expects that urls
     * were built using the system.
     * @param $urlInfo string Full url or just path info.
     * @param $isPathInfo boolean Tell if the
     * passed url info string is a path info or not.
     * @param $userVars array (optional) Pass GET variables
     * if needed (for testing only).
     * @param $hostInfo string (optional) The hostname
     * @return string
     */
    function getPage($urlInfo, $isPathInfo, $userVars = array(), $hostInfo = null)
    {
        $page = self::_getUrlComponents($urlInfo, $isPathInfo, 0, 'page', $userVars, $hostInfo);
        return Core::cleanFileVar(is_null($page) ? '' : $page);
    }

    /**
     * Get the operation present into
     * the passed url information. It expects that urls
     * were built using the system.
     * @param $urlInfo string Full url or just path info.
     * @param $isPathInfo boolean Tell if the
     * passed url info string is a path info or not.
     * @param $userVars array (optional) Pass GET variables
     * if needed (for testing only).
     * @param $hostInfo string (optional) The hostname
     * @return string
     */
    function getOp($urlInfo, $isPathInfo, $userVars = array(), $hostInfo = null)
    {
        $operation = self::_getUrlComponents($urlInfo, $isPathInfo, 1, 'op', $userVars, $hostInfo);
        return Core::cleanFileVar(empty($operation) ? 'index' : $operation);
    }

    /**
     * Get the arguments present into
     * the passed url information (not GET/POST arguments,
     * only arguments appended to the URL separated by "/").
     * It expects that urls were built using the system.
     * @param $urlInfo string Full url or just path info.
     * @param $isPathInfo boolean Tell if the
     * passed url info string is a path info or not.
     * @param $userVars array (optional) Pass GET variables
     * if needed (for testing only).
     * @param $hostInfo string (optional) The hostname
     * @return array
     */
    function getArgs($urlInfo, $isPathInfo, $userVars = array(), $hostInfo = null)
    {
        return self::_getUrlComponents($urlInfo, $isPathInfo, 2, 'path', $userVars, $hostInfo);
    }

    /**
     * Get url components (page, operation and args)
     * based on the passed offset.
     * @param $urlInfo string
     * @param $isPathInfo string
     * @param $offset int
     * @param $varName string
     * @param $userVars array (optional) GET variables
     * (only for testing).
     * @param $hostInfo string (optional) The hostname
     * @return mixed array|string|null
     */
    function _getUrlComponents($urlInfo, $isPathInfo, $offset, $varName = '', $userVars = array(), $hostInfo = null)
    {
        $component = null;

        $isArrayComponent = false;
        if ($varName == 'path') {
            $isArrayComponent = true;
        }
        $masterContextPath = self::getContextByHostAndUrlInfo($urlInfo, $hostInfo);
        if ($isPathInfo) {
            $application = Application::getApplication();
            $contextDepth = $application->getContextDepth();
            if ($masterContextPath) {
                $contextDepth = self::getContextPathInfoOffset($masterContextPath);
            }

            $vars = explode('/', trim($urlInfo, '/'));
            if (count($vars) > $contextDepth + $offset) {
                if ($isArrayComponent) {
                    $component = array_slice($vars, $contextDepth + $offset);
                    for ($i = 0, $count = count($component); $i < $count; $i++) {
                        $component[$i] = Core::cleanVar(get_magic_quotes_gpc() ? stripslashes($component[$i]) : $component[$i]);
                    }
                } else {
                    $component = $vars[$contextDepth + $offset];
                }
            }
        } else {
            $component = Core::_getUserVar($urlInfo, $varName, $userVars);
        }

        if ($isArrayComponent) {
            if (empty($component)) $component = array();
            elseif (!is_array($component)) $component = array($component);
        }

        return $component;
    }

    function getAvailableContextsFromConfig()
    {
        $contextBaseUrls = Config::getContextBaseUrls();

        $contexts = array();
        foreach ($contextBaseUrls as $contextPath => $url) {
            $contexts[$contextPath] = parse_url($url);
        }

        return $contexts;
    }

    function getContextByHostAndUrlInfo($urlInfo, $hostInfo = null)
    {
        $contexts = self::getAvailableContextsFromConfig();
        $candidates = array();

        // Try to find proper context by hostname
        foreach ($contexts as $contextPath => $context) {
            if (!empty($hostInfo) && !empty($context['host']) && ($hostInfo == $context['host'])) {
                if (empty($context['path'])) {
                    $candidates[$contextPath] = 0;
                }
                elseif (strpos(trim($urlInfo, '/'), trim($context['path'], '/')) === 0) {
                    $candidates[$contextPath] = strlen(trim($context['path'], '/'));
                }
            }
        }

        if (empty($candidates)) {
            return null;
        }

        arsort($candidates, SORT_NUMERIC);

        $candidatesPaths = array_keys($candidates);

        return reset($candidatesPaths);
    }

    function getContextPathInfoOffset($contextPath)
    {
        $contexts = self::getAvailableContextsFromConfig();

        if (!isset($contexts[$contextPath])) {
            $application =& Application::getApplication();
            return $application->getContextDepth();
        }

        if (!empty($contexts[$contextPath]['path'])) {
            $path = $contexts[$contextPath]['path'];
            $path = trim($path, '/');

            return count(explode('/', $path));
        }

        return 0;
    }
}
