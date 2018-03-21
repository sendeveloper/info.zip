<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ Language="VBScript" %>
<head>
    <title></title>
</head>
<body>
    <h4><center>Z2t_lookup_multiple Call</center></h4>

<%
Response.buffer=true
If Request("pwd") = "" Then 
	Response.write "CHECK PWD"
	Response.End
End if

'Open the connection
Set conn=server.CreateObject("ADODB.Connection")
conn.Open "driver=SQL Server;server=philly01.harvestamerican.net,8143;uid=davewj2o;pwd=get2it;database=zip2tax"

If isnull(Request("zCode")) or Request("zCode") = "" Then
		RequestZip = 90210
	Else
		RequestZip = Request("zCode")
	End If
'Assign values to the input variables
strZipCode = RequestZip  
strUsername = Request("uName")
strPassword = Request("pwd")

'Open the recordset using the stored procedure
Set rs = server.CreateObject("ADODB.Recordset")
rs.open "z2t_link.z2t_lookup_multiple('" & strZipCode & "', '" & strUsername & "', '" & strPassword & "')", conn, 3, 3, 4

'Read the results
Do Until rs.EOF   

    Response.write "Zip Code: " & rs("Zip_Code") & "<br />"
    Response.write "Sales Tax Rate: " & rs("Sales_Tax_Rate") & "<br />"
    Response.write "Post Office City: " & rs("Post_Office_City") & "<br />"
    Response.write "County: " & rs("County") & "<br />"
    Response.write "State: " & rs("State") & "<br />"
    Response.write "Shipping Taxable: " & rs("Shipping_Taxable") & "<br />"
    Response.write "Actual City: " & rs("City") & "<br /><br /><br /><br /><br />"
rs.MoveNext
loop

'Close the Database
rs.Close
conn.Close

%>
</body>
</html>
