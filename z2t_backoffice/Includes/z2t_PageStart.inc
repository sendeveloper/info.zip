
<%  
    '----- Be sure secure path is used -----
    'if LCase(Request.ServerVariables("HTTPS")) <> "on" then
    '    response.redirect "http://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")
    'end if
	
    '----- Be sure the user is logged in with and administrator access -----
    IF UCASE(Session("z2t_LoggedIn"))<>"TRUE" _
		OR isNULL(session("z2t_loggedin")) _
		OR UCASE(Session("z2t_Status"))<>"ADMIN" _
		OR isNULL(session("z2t_status")) THEN
			'Response.write UCASE(Session("z2t_LoggedIn")) & "<br>"
			'Response.write UCASE(Session("z2t_Status")) & "<br>"
			'Response.end
			Response.Redirect strBasePath & "z2t_login.asp"
    END IF
%>
