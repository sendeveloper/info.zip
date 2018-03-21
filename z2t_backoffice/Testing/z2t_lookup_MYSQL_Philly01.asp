<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <%@ Language="VBScript" %>
<head>
    <title></title>
</head>
<body>
    <h4><center>Z2t_lookup Call</center></h4>

<%

	
'Open the connection
Set conn=server.CreateObject("ADODB.Connection")
conn.Open "driver={MySQL ODBC 5.1 Driver};server=Philly01.HarvestAmerican.net:3306;uid=swati;pwd=s1Intern;database=zip2tax"


strZipCode = "13210"
strUsername = "pinhead"
strPassword = "pinwheel"

'Open the recordset using the stored procedure
Set rs = server.CreateObject("ADODB.Recordset")
rs.open "z2t_link.z2t_lookup('" & strZipCode & "', '" & strUsername & "', '" & strPassword & "')", conn, 3, 3, 4

'Read the results
If not rs.EOF then
	Response.write "Zip Code: " & rs("Zip_Code") & "<br />"
    Response.write "Sales Tax Rate: " & rs("Sales_Tax_Rate") & "<br />"
    Response.write "Post Office City: " & rs("Post_Office_City") & "<br />"
    Response.write "County: " & rs("County") & "<br />"
    Response.write "State: " & rs("State") & "<br />"
    Response.write "Shipping Taxable: " & rs("Shipping_Taxable") & "<br />"
End If
response.write("</zip_code_lookup>")
'Close the Database
rs.Close
conn.Close


%>