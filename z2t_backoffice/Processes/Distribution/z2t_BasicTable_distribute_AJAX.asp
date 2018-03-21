<%

	RequestServer = Request("s")
	Requestdb = Request("db")

	'response.write RequestServer & "<br>"
	'response.write Requestdb & "<br>"
	
	set conn=server.CreateObject("ADODB.Connection")
	set rs=server.createObject("ADODB.Recordset")

	conn.open "FILEDSN=C:\Inetpub\DSN\" & RequestServer & "SQLServerTableDistribution.DSN"
	Server.ScriptTimeout = 240
	conn.CommandTimeout = 240
	
	'This is run from the requestion server inside the database ha_TableDistribution
	SQL = "z2t_Basic_distribution('" & Requestdb & "')"
				
	rs.open SQL, conn, 3, 3, 4

	Response.write "SUCCESS" 
	
%>