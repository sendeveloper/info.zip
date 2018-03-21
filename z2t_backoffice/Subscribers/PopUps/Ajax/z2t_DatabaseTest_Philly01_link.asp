<%
Response.buffer=true
If Request("pwd") = "" Then Response.End
	
'Open the connection
Set conn=server.CreateObject("ADODB.Connection")
conn.Open "driver=SQL Server;server=philly01.harvestamerican.net,8143;uid=davewj2o;pwd=get2it;database=zip2tax"

If isnull(Request("zip")) or Request("zip") = "" Then
		RequestZip = 82009
	Else
		RequestZip = Request("zip")
	End If
'Assign values to the input variables
strZipCode = RequestZip  
strUsername = Request("usr")
strPassword = Request("pwd")

'Open the recordset using the stored procedure
Set rs = server.CreateObject("ADODB.Recordset")
rs.open "z2t_link.z2t_lookup('" & strZipCode & "', '" & strUsername & "', '" & strPassword & "')", conn, 3, 3, 4

 Response.ContentType = "text/xml"
    Response.Write("<?xml version='1.0' encoding='ISO-8859-1'?>")
    Response.Write("<zip_code_lookup>")
'Read the results
If not rs.EOF then
		response.write("<zip>" & rs("Zip_Code") & "</zip>")
        response.write("<city>" & rs("Post_Office_City") & "</city>")
        response.write("<county>" & rs("County") & "</county>")
        response.write("<state>" & rs("State") & "</state>")
        response.write("<rate>" & rs("Sales_Tax_Rate") & "</rate>")
        response.write("<shippingtaxable>" & rs("Shipping_Taxable") & "</shippingtaxable>")
        response.write("<server>Philly01</server>")
End If
response.write("</zip_code_lookup>")
'Close the Database
rs.Close
conn.Close


%>