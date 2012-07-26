jQuery ->
	if $("ul#attachments li a").length > 0
		index = 0
		$("ul#attachments li a").each ->
	  	attachment_url = $(this).attr("href")
	  	$("div.well img").eq(index).attr("src",attachment_url)
	  	index++