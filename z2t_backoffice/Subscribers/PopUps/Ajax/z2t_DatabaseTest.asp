<%
    ' 12, 10, 1, 9, 2, 13, 3, 5, 6, 7,8, 14, 4, 11
    ' AjaxURL(1) AjaxURL(2)
    RequestZip   = Request("zip")
    RequestUsr   = Request("usr")
    RequestPass  = Request("pwd")

    Response.buffer=true
    ' Start 12
    Dim rs
    Dim SQL

    dim conn
    set conn=server.CreateObject("ADODB.Connection")
    conn.Open "driver=SQL Server;server=10.88.49.20;uid=davewj2o;pwd=get2it;database=z2t_WebPublic"  'Philly03 backdoor
    set rs=server.createObject("ADODB.Recordset")

    SQL =  "z2t_LookUp_v25('" & RequestZip & "', '', '" & RequestUsr & "','', '', '', 0)"

    rs.open SQL, conn, 3, 3, 4

    response.ContentType = "text/xml"
    response.write("<?xml version='1.0' encoding='ISO-8859-1'?>")
    response.write("<zip_code_lookups>")
    response.write("<zip_code_lookup>")

    If not rs.eof then
        response.write("<zip>" & Request("zip") & "</zip>")
        response.write("<city>" & rs("City") & "</city>")
        response.write("<county>" & rs("County") & "</county>")
        response.write("<state>" & rs("State") & "</state>")
        response.write("<rate>" & rs("Rate") & "</rate>")
        response.write("<shippingtaxable>n/a</shippingtaxable>")
        response.write("<server>Philly03</server>")
    End If

    response.write("</zip_code_lookup>")

    rs.Close
    set rs = nothing  

    ' Start 10
      

    ' Start 1
    If RequestPass = "" Then Response.End

    set conn=server.CreateObject("ADODB.Connection")
    conn.Open "driver=SQL Server;server=212.224.124.196,9243;uid=davewj2o;pwd=get2it;database=z2t_WebPublic"
    set rs=server.createObject("ADODB.Recordset")

	SQL =  "z2t_LookUp_v25('" & RequestZip & "', '', '" & RequestUsr & "','', '', '', 0)"

    rs.open SQL, conn, 3, 3, 4

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

    ' Start 2

    ' store link in a variable
    link = "http://dev.api.zip2tax.com/TaxRate-USA.xml?username=" & RequestUsr & "&password=" & RequestPass & "&zip=" & RequestZip
    ' declare and set variable to an object that can retrieve XML information
    Dim xhr: Set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")

    ' open object using link
    xhr.open "GET", link, False

    ' send request
    xhr.send

    'Write the results to a doc 
    Set xmlResponse = Server.CreateObject("MSXML2.DomDocument.6.0")
    xmlResponse.setProperty "SelectionLanguage", "XPath"
    xmlResponse.async = false
    xmlResponse.LoadXml(xhr.responseText)
    'Response.ContentType = "text/plain": Response.Write(xhr.responseText & chr(13)): Response.End()   ' debug line

    'Traverse the doc
    Set objLst = xmlResponse.getElementsByTagName("address")

    'Response.Write objLst.length & "<br>"

    'Grab only the first result in address
    Set objHdl = objLst.item(0)
    'Response.Write objHdl.nodeName & "<br>"

    'Response.Write(typename(objHdl))
    If objHdl is Nothing Then
        'Response.ContentType = "text/plain": Response.Write(xmlResponse.getElementsByTagName("errorMessage").item(0).text): Response.End   ' debug line
        city = xmlResponse.getElementsByTagName("errorMessage").item(0).text
        zip = ""
        county = ""
        salestax = ""
        rate = ""
        shippingtaxable = ""
    Else
    'Loop the child nodes
        For Each child In objHdl.childNodes
            'Response.Write child.nodeName & " = " & child.text & "<br>"
            Select case lcase(child.nodeName)
                Case "place"
                    city = child.text
                Case "zipcode"
                    zip = child.text
                Case "state"
                    state = child.text
                Case "county"
                    county = child.text
                Case "salestax"
                  Set objRate = child.firstChild.firstChild
                  'Response.Write objRate.nodeName & " = " & objRate.text & "<br>"
                    rate = objRate.text
                Case "notes"
                  'Set objNote = child.firstChild.firstChild.nextSibling.nextSibling
                Set objNote = xmlResponse.selectNodes("//address[1]//notes/noteDetail[./category[text() = 'Tax on Shipping']]/note")
                shippingtaxable = 0
                If Not objNote.item(0) Is Nothing Then
                    If objNote.item(0).text = "Shipping charges are taxable" Then shippingtaxable = 1
                    'shippingtaxable = objNote.item(0).text
                    End If
            End Select
        Next
    End If    
    Set xmlResponse = Nothing
    
    
    Response.Write("<zip_code_lookup>")

        Response.Write("<zip>" & zip & "</zip>")
        Response.Write("<city>" & city & "</city>")
        Response.Write("<county>" & county & "</county>")
        Response.Write("<state>" & state & "</state>")
        Response.Write("<rate>" & rate & "</rate>")
        Response.Write("<shippingtaxable>" & shippingtaxable & "</shippingtaxable>")
        response.write("<server></server>")

    Response.Write("</zip_code_lookup>")

    response.write("</zip_code_lookups>")
%>

