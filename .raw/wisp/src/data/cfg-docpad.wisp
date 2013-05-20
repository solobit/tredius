
;; Sequences, lists, collections
(import [cons conj list list? seq vec
         empty? count
         first second third rest last butlast
         take drop
         concat reverse sort
         map filter reduce] "../src/sequence")
(import [str inc dec even? odd? vals =] "../src/runtime")

;; Docpad sample config
;; http://docpad.org/docs/config
(def config-docpad {
  :airbrakeToken nil
  :catchExceptions true
  :checkVersion false
  :collections {}
  :configPaths ["docpad.js" "docpad.coffee" "docpad.json" "docpad.cson"]
  :detectEncoding false
  :documentsPaths ["documents"]
  :enabledPlugins {:pokemon false :digimon true}
  :enabledUnlistedPlugins true
  :env nil
  :environments {:development {:maxAge false :port 9005}}:pluginsPaths ["node_modules" "plugins"]
  :events {:serverExtend (fn nil)}
  :extendServer true
  :filesPaths ["files" "public"]
  :growl true
  :helperUrl "https//docpad.org/helper/"
  :ignoreCommonPatterns true
  :ignoreCustomPatterns false
  :ignoreHiddenFiles false
  :ignorePaths false
  :layoutsPaths ["layouts"]
  :localeCode nil
  :logger nil
  :logLevel nil 
  :maxAge 86400000
  :middleware404 true
  :middleware500 true
  :middlewareBodyParser true
  :middlewareExpressRouter true
  :middlewareMethodOverride true
  :middlewareStandard true
  :mixpanelToken nil
  :outPath "out"
  :packagePath "package.json"
  :pluginPaths []
  :plugins {:stylus {:useNib false } }
  :port nil
  :prompts false
  :regenerateDelay 100
  :regenerateEvery false
  :regeneratePaths []
  :reloadPaths []
  :renderPasses 1
  :renderSingleExtensions false
  :reportErrors nil 
  :reportStatistics nil 
  :rootPath (process.cwd)
  :safeMode false
  :serverExpress nil
  :serverHttp nil
  :skipUnsupportedPlugins true
  :srcPath "src"
  :welcome false
  :templateData {
    :site {
      :url "http//website.com"

      :title  "Your Website"

      :description "When your website appears in search
       results in say Google the text here will be shown
       underneath your websites title."

      :keywords "place your website keywoards here keep them
       related to the content of your website"}}
  
})

(.log console config-docpad)
