<%
Response.buffer=true
%>

<html>
<head>
    <title>Zip2Tax Taypes Dates Post</title>
</head>

<%	
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	Dim rs: Set rs=server.createObject("ADODB.Recordset")
	connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_Maintenance"

    Dim strSQL

    strSQL = "z2t_Types_Dates_write(" & _
		"'" & Request("EffectiveDate") & "', " & _
		"'" & Request("ReleaseDate") & "', " & _
		"'" & Request("ResearchingDate") & "')"
	
	'response.write strSQL
	connPhilly01.Execute strSQL

%>

<script>
	window.opener.location.href = window.opener.location.href;
	//var url = 'http://legacy.zip2tax.com/backoffice/TableDistribution_z2t_Accounts/z2t_Accounts_Subscription_Update.asp?z2tID=<%=Request("z2tID")%>';
	//location.href = url;
    window.close()
</script>
	

</html>
