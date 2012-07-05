window.InitLinker = ->
  re = /(https?:\/\/(([-\w\.]+)+(:\d+)?(\/([\w/_\.-]*(\?\S+)?)?)?))/g
  $("p#details").html $("p#details").html().replace(re, "<a href=\"$1\" title=\"\" target=\"_blank\">$1</a>")

jQuery ->
  $('form:not(.filter) :input:visible:first').focus()
  $("form textarea"). wysihtml5()
  $("ul.breadcrumb li[class != 'active']").append('<span class="divider">/</span>')
  $("a[rel=tooltip]").tooltip()
  InitLinker()

