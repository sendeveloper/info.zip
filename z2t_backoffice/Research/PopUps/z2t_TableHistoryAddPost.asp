<html>
<head>
    <title>Zip2Tax Table History Post</title>
</head>

<%	
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_Maintenance"

    Dim strSQL

    strSQL = "z2t_TableEffectiveDateHistory_new"
	connPhilly01.Execute strSQL
%>

<script>
	window.opener.location.href = window.opener.location.href;
    window.close()
</script>

</html>
