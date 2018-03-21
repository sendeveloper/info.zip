<html>
<head>
    <title>State Information New Post</title>
</head>

<%	
	 Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	 Dim strSQL
	 DIM eNotes

	 eNotes =  replace(request("Notes"), "'", "''")	 
	 connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
	 strSQL = "z2t_StateInfo_Automobile_Notes_update('" & request("state") & "','" &  trim(eNotes) &"')"
	'response.Write(strSQL)
	'response.End()
   
   
	connPhilly05.Execute strSQL

%>


<script>
	//window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
