<%
Session("z2t_status") = ""
Session("z2t_AccountID") = ""
Session("z2t_loggedin") = ""
Session("z2t_UserName") = ""
Session("z2t_login") = ""  'Old (.com) backoffice username

Response.Redirect "http://info.zip2tax.com/z2t_Backoffice/z2t_login.asp"
%>
