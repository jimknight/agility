jQuery -> 
	$("#addUserModal").on "shown", ->
		$("input#email").focus()
	$("#user_search_submit").click ->
		$("form#user_search").submit()