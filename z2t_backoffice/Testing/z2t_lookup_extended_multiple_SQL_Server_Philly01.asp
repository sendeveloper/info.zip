<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ Language="VBScript" %>
<head>
    <title></title>
</head>
<body>
    <h4><center>Z2t_lookup_extended_multiple Call</center></h4>

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
rs.open "z2t_link.z2t_lookup_extended_multiple('" & strZipCode & "', '" & strUsername & "', '" & strPassword & "')", conn, 3, 3, 4

'Read the results
Do Until rs.EOF   

    Response.write "Zip Code: " & rs("Zip_Code") & "<br />"
    Response.write "Sales Tax Rate: " & rs("Sales_Tax_Rate") & "<br />"
    Response.write "Post Office City: " & rs("Post_Office_City") & "<br />"
    Response.write "County: " & rs("County") & "<br />"
    Response.write "State: " & rs("State") & "<br />"
    Response.write "Shipping Taxable: " & rs("Shipping_Taxable") & "<br />"
    Response.write "Sales Tax Rate State: " & rs("Sales_Tax_Rate_State") & "<br />"
    Response.write "Sales Tax Rate County: " & rs("Sales_Tax_Rate_County") & "<br />"
    Response.write "Sales Tax Rate City: " & rs("Sales_Tax_Rate_City") & "<br />"
    Response.write "Sales Tax Rate Special: " & rs("Sales_Tax_Rate_Special") & "<br />"
    Response.write "Sales Tax Reporting Code Total: " & rs("Sales_Tax_Reporting_Code_Total") & "<br />"
    Response.write "Sales Tax Reporting Code State: " & rs("Sales_Tax_Reporting_Code_State") & "<br />"
    Response.write "Sales Tax Reporting Code County: " & rs("Sales_Tax_Reporting_Code_County") & "<br />"
    Response.write "Sales Tax Reporting Code City: " & rs("Sales_Tax_Reporting_Code_City") & "<br />"
    Response.write "Sales Tax Reporting Code Special: " & rs("Sales_Tax_Reporting_Code_Special") & "<br /><br /><br /><br />"
rs.MoveNext
loop

'Close the Database
rs.Close
conn.Close

%>
</body>
</html>
