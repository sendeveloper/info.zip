<html>
<head>
    <title>State Information Final Checked Post</title>
</head>

<%	
	 Dim efilterby
	 Dim OrderBy
	 Dim AscDesc
	 efilterby = request("filterbyval")
	 OrderBy = Request("OrderBy")
	 AscDesc = request("ascDesc")
	Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
	 Dim strSQL
	connPhilly01.Open "driver=SQL Server;server=10.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01
	strSQL = "z2t_StateInfo_FinalCheck_update('" & request("state") & "','" & request("FinalChecked") & "','" & Session("z2t_login") &"')"
	'response.Write(strSQL)
	'response.End()
     '   rs.open strSQL, connPhilly01, 3, 3, 4

	connPhilly01.Execute strSQL

%>

 <script language='JavaScript'>
 var s = window.opener.location.href
 var URLVal=s.substring(0, s.indexOf('?'));

 if (URLVal.length==0)
 	URLVal = window.opener.location.href
	
// alert(URLVal);	
window.opener.location.href =URLVal +			
			'?filterbyval=<%=efilterby%>'+
			'&orderBy=<%=OrderBy%> '+
			'&AscDesc=<%=AscDesc%>';
    window.close()

<%'response.End()%>
</script>
	

</html>
