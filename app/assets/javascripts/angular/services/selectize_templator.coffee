angular.module('Burnup.services.SelectizeTemplator', [])

.factory 'SelectizeTemplator', ($templateCache) ->

  compile = (template, item, escape) ->
    htmlSearchItemTemplate = ""

    if template
      htmlSearchItemTemplate = $templateCache.get(template)
      if htmlSearchItemTemplate
        $.each item, (var_name, var_value) ->
          htmlSearchItemTemplate = htmlSearchItemTemplate.replace("{{#{var_name}}}", var_value)

    return htmlSearchItemTemplate

  return {
    compile: compile
  }
