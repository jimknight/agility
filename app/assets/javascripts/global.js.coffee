window.InitLinker = ->
  re = /(https?:\/\/(([-\w\.]+)+(:\d+)?(\/([\w/_\.-]*(\?\S+)?)?)?))/g
  $("div.content section p#details").html $("div.content section p#details").html().replace(re, "<a href=\"$1\" title=\"\">$1</a>")

jQuery ->
  $('form:not(.filter) :input:visible:first').focus()
  $("form textarea"). wysihtml5()
  $("ul.breadcrumb li[class != 'active']").append('<span class="divider">/</span>')
  InitLinker()

