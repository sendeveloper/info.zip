<html>
<head>
    <title>State Information Procedure Post</title>
</head>

<%	
	Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	 Dim strSQL
	 DIM eProcedure

	 eProcedure =  replace(request("Procedure"), "'", "''")
		connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
	strSQL = "z2t_StateInfo_Research_write('" & request("state") & "','" &  trim(eProcedure) & "','" & Session("z2t_login") &"')"
	'response.Write(strSQL)
	'response.End()
   
   
	connPhilly05.Execute strSQL

%>


<script>
	//window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
