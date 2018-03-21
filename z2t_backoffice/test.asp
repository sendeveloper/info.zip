<!--#include virtual="/Website/Includes/Config.asp"-->

<html>
  <head>
   
  </head>
  
  <body>
       test

<%
Dim rs: Set rs=server.createObject("ADODB.Recordset")
		strSQL = "z2t_Login_v25('" & loginUser & "','"& loginPassword & "','" &  Session("CookieID") & "','" & Request.ServerVariables("REMOTE_ADDR") & "','"&clientTypeWeb &"','"& Session.SessionID &"')"		
        rs.open strSQL, connStrPublic, 3, 3, 4
%>
  </body>
</html>
