jQuery ->
	if $("p#body")
		text_content = $("p#body").text()
		first_half = text_content.substr(0,300)
		more_link = "<a href='#' id='morelink'>more...</a>"
		second_half = "<span>" + text_content.substr(301,text_content.length) + "</span>"
		$("p#body").html(first_half + more_link + second_half)
		$("p#body span").hide()
		$("a#morelink").click ->
			$("p#body span").show()
			$("a#morelink").hide()
			return false
	if $(".alert")
		$(".alert").delay(5000).fadeOut("slow")
  $('form:not(.filter) :input:visible:first').focus()
  $("form textarea"). wysihtml5()
  $("ul.breadcrumb li[class != 'active']").append('<span class="divider">/</span>')
  $("a[rel=tooltip]").tooltip()
  if $("p#details").length > 0
	  re = /(https?:\/\/(([-\w\.]+)+(:\d+)?(\/([\w/_\.-]*(\?\S+)?)?)?))/g
	  $("p#details").html $("p#details").html().replace(re, "<a href=\"$1\" title=\"\" target=\"_blank\">$1</a>")



