<%
 if 1 = 2 then
  '----- Be sure secure path is used -----
  If LCase(Request.ServerVariables("HTTPS")) <> "on" Then
    'Response.Write("https://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")): Response.End
    Response.Redirect "http://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")
  End If
  
  If UCase(Session("z2t_loggedin"))<>"TRUE" Or isNull(Session("z2t_loggedin")) _
    Or UCase(Session("z2t_status"))<>"ADMIN" Or isNull(Session("z2t_status")) Then
      'Response.Write("[" & Session("z2t_loggedin") & "]<br>")	
      'Response.Write("[" & Session("z2t_status") & "]<br>"): Response.End
      Response.Redirect "https://info.zip2tax.com/z2t_Backoffice/z2t_login.asp"
  End If
  end if
  
%>
