

<html>
  <head>
   
  </head>
  
  <body>
       test

<%
' Staging
  connStrPublic = "Provider=SQLOLEDB;Data Source=127.0.0.1;Initial Catalog=z2t_WebPublic;UID=davewj2o;PWD=get2it;Application Name=Z2T_V2.5;" 'Philly05

Dim rs: Set rs=server.createObject("ADODB.Recordset")
		strSQL = "z2t_Login_v25('" & loginUser & "','"& loginPassword & "','" &  Session("CookieID") & "','" & Request.ServerVariables("REMOTE_ADDR") & "','"&clientTypeWeb &"','"& Session.SessionID &"')"		
        rs.open strSQL, connStrPublic, 3, 3, 4
%>
  </body>
</html>
