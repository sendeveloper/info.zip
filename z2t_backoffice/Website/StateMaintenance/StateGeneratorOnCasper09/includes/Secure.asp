<%
  '----- Be sure secure path is used -----
  If LCase(Request.ServerVariables("HTTPS")) <> "on" Then
    'Response.Write("https://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")): Response.End
    Response.Redirect "https://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")
  End If
  
  If Session("z2t_loggedin")<>"True" Or isNull(Session("z2t_loggedin")) _
    Or Session("z2t_status")<>"admin" Or isNull(Session("z2t_status")) Then
      'Response.Write("[" & Session("z2t_status") & "]"): Response.End
      Response.Redirect "https://info.zip2tax.com/z2t_Backoffice/z2t_login.asp"
  End If
%>
