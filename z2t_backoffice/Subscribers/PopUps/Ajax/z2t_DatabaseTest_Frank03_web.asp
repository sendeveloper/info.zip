<%
    Response.buffer=true
    If Request("pwd") = "" Then Response.End

    Dim rs
    Dim SQL

    dim connBarley2
    set connBarley2=server.CreateObject("ADODB.Connection")
    connBarley2.Open "driver=SQL Server;server=208.109.189.101;uid=z2t_link;pwd=H^2p6~r;database=Zip2Tax"  '--Barley2
    set rs=server.createObject("ADODB.Recordset")

    SQL =  "z2t_link.z2t_lookup ('" & Request("zip") & "', '" & Request("usr") & "', '" & Request("pwd") & "')"

	
    'Response.write SQL
    rs.open SQL, connBarley2, 3, 3, 4

    response.ContentType = "text/xml"
    response.write("<?xml version='1.0' encoding='ISO-8859-1'?>")
    response.write("<zip_code_lookup>")

    If not rs.eof then
        response.write("<zip>" & rs("Zip_Code") & "</zip>")
        response.write("<city>" & rs("Post_Office_City") & "</city>")
        response.write("<county>" & rs("County") & "</county>")
        response.write("<state>" & rs("State") & "</state>")
        response.write("<rate>" & rs("Sales_Tax_Rate") & "</rate>")
        response.write("<shippingtaxable>" & rs("Shipping_Taxable") & "</shippingtaxable>")
        response.write("<server></server>")
    End If

    response.write("</zip_code_lookup>")

    rs.Close
    set rs = nothing
%>

