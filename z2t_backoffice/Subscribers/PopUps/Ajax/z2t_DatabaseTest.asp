<%
    Response.buffer=true
    RequestZip   = Request("zip")
    RequestUsr   = Request("usr")
    RequestPass  = Request("pwd")

    If Request("pwd") = "" Then Response.End

    Dim rs
    Dim SQL

    dim conn
    set conn=server.CreateObject("ADODB.Connection")
    conn.Open "driver=SQL Server;server=212.224.124.196,9243;uid=davewj2o;pwd=get2it;database=z2t_WebPublic"
    set rs=server.createObject("ADODB.Recordset")

	SQL =  "z2t_LookUp_v25('" & RequestZip & "', '', '" & RequestUsr & "','', '', '', 0)"

    rs.open SQL, conn, 3, 3, 4

    response.ContentType = "text/xml"
    response.write("<?xml version='1.0' encoding='ISO-8859-1'?>")
    response.write("<zip_code_lookup>")

    If not rs.eof then
        response.write("<zip>" & Request("zip") & "</zip>")
        response.write("<city>" & rs("City") & "</city>")
        response.write("<county>" & rs("County") & "</county>")
        response.write("<state>" & rs("State") & "</state>")
        response.write("<rate>" & rs("Rate") & "</rate>")
        response.write("<shippingtaxable>n/a</shippingtaxable>")
        response.write("<server>Frank02</server>")
    End If

    response.write("</zip_code_lookup>")

    rs.Close
    set rs = nothing


%>

