<html>
<head>
    <title>State Information New Post</title>
</head>

<%	

	 Dim efilterby
	 Dim OrderBy
	 Dim AscDesc
	 Dim pageviewtype
	 efilterby = request("filterbyval")
	 OrderBy = Request("OrderBy")
	 AscDesc = request("ascDesc")
	 pageviewtype = Request("pageviewtype")

	 Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
	 Dim strSQL
	 DIM eNew

	 eNew =  replace(request("New"), "'", "''")	 
	 connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
	 strSQL = "z2t_StateInfo_Automobile_new_update('" & request("state") & "','" &  trim(eNew) &"')"
	'response.Write(strSQL)
	'response.End()
   
   
	connPhilly05.Execute strSQL

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
			'&AscDesc=<%=AscDesc%>'+
			'&pageviewtype=<%=pageviewtype%>';
    window.close()

<%'response.End()%>
</script>
	

</html>
