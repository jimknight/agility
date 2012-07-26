jQuery ->
  $('form:not(.filter) :input:visible:first').focus()
  $("form textarea"). wysihtml5()
  $("ul.breadcrumb li[class != 'active']").append('<span class="divider">/</span>')
  $("a[rel=tooltip]").tooltip()
  re = /(https?:\/\/(([-\w\.]+)+(:\d+)?(\/([\w/_\.-]*(\?\S+)?)?)?))/g
  $("p#details").html $("p#details").html().replace(re, "<a href=\"$1\" title=\"\" target=\"_blank\">$1</a>")
	if $("ul#attachments li a").length > 0
		index = 0
		$("ul#attachments li a").each ->
	  	attachment_url = $(this).attr("href")
	  	$("div.well img").eq(index).attr("src",attachment_url)
	  	index++ 



