<html>
<head>
    <title>State Information New Post</title>
</head>

<%	
	 Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	 Dim strSQL
	 DIM eUsed

	 eUsed =  replace(request("New"), "'", "''")	 
	 connPhilly05.Open "driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
	 strSQL = "z2t_StateInfo_Automobile_Used_update('" & request("state") & "','" &  trim(eUsed) &"')"
	'response.Write(strSQL)
	'response.End()
   
   
	connPhilly05.Execute strSQL

%>


<script>
	//window.opener.location.href = window.opener.location.href;
    window.close()
</script>
	

</html>
