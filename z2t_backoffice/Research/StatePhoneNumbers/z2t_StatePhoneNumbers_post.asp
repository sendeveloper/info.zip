<html>
<head>
    <title>State Phone Numbers Post</title>
</head>

<%	
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01

    Dim strSQL

    strSQL = "UPDATE z2t_StateInfo " & _
		"SET ContactNumber = '" & Request("PhoneNumber") & "' " & _
		"WHERE State = '" & Request("State") & "'"
	
	'response.write strSQL
	connPhilly01.Execute strSQL

%>

<script>
	window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
