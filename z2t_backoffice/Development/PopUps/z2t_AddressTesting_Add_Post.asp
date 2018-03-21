<%
Response.buffer=true
%>

<html>
<head>

<%
      
       
        Title = "Address Testing: Add New Address"

		
		Dim connPhilly04: Set connPhilly04=server.CreateObject("ADODB.Connection")
			Dim rs: Set rs=server.createObject("ADODB.Recordset")
			connPhilly04.Open "driver=SQL Server;server=208.88.49.21,8443;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' philly04
            strSQL = "z2t_Address_Testing_addAddress('" & Request("AddressLine1") & "',"& _
													  "'" & Request("AddressLine2") & "',"& _
													  "'" & Request("city") & "'," & _
													  "'" & Request("state") & "'," & _
													  "'" & Request("zip") & "')"
			'response.Write(strSQL)
			'response.End()
            rs.open strSQL, connPhilly04, 3, 3, 4		
			
       

%>

<script>
	window.opener.location.href = window.opener.location.href;	
    window.close()
</script>
	

</html>