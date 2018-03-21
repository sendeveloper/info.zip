<%
    Response.buffer=true
    If Request("pwd") = "" Then Response.End

	
    Dim rs
    Dim SQL

    dim connPhilly01
    set connPhilly01=server.CreateObject("ADODB.Connection")
	
    'connPhilly01.Open "driver={MySQL ODBC 5.2 unicode Driver};Server=philly01.harvestamerican.net:3306;User=davewj2o;Password=get2it2day;Database=Zip2Tax" '--Philly01
    'connPhilly01.Open "driver={MySQL ODBC 5.1 Driver};Server=philly01.harvestamerican.net:3306;User=davewj2o;Password=get2it2day;Database=Zip2Tax" '--Philly01
    connPhilly01.Open "driver={MySQL ODBC 5.1 Driver};Server=philly01.harvestamerican.net;User=davewj2o;Password=get2it2day;Database=Zip2Tax" '--Philly01
    'connPhilly01.Open "driver={MySQL ODBC 5.1 Driver};Server=208.109.189.101;User=z2t_link;Password=H^2p6~r;Database=Zip2Tax"  '--Barley2
	
    set rs=server.createObject("ADODB.Recordset")

    SQL =  "call zip2tax.z2t_lookup ('" & Request("zip") & "', '" & Request("usr") & "', '" & Request("pwd") & "')"
	
    'Response.write SQL
    rs.open SQL, connPhilly01

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
        response.write("<server>Philly01</server>")
    End If

    response.write("</zip_code_lookup>")

    rs.Close
    set rs = nothing
%>

