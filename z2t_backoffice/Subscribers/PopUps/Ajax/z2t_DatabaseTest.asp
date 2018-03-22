<!--#include virtual="z2t_Backoffice/subscribers/popups/Ajax/Includes/connections.asp"-->
<!--#include virtual="z2t_Backoffice/subscribers/popups/Ajax/Includes/z2t_pinpoint_api_call_basic.asp" -->

<%
    ' 12, 10, 1, 9, 2, 13, 3, 5, 6, 7,8, 14, 4, 11
    ' AjaxURL(1) AjaxURL(2)
    RequestZip   = Request("zip")
    RequestUsr   = Request("usr")
    RequestPass  = Request("pwd")

    If RequestPass = "" Then Response.End
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
    set conn=server.CreateObject("ADODB.Connection")
    conn.open "FILEDSN=C:\Inetpub\DSN\Casper06SQLServerTableDistribution.DSN"
    set rs=server.createObject("ADODB.Recordset")

    SQL =  "z2t_WebPublic.dbo.z2t_LookUp_v25('" & RequestZip & "', '', '" & RequestUsr & "','', '', '', 0)"

    rs.open SQL, conn, 3, 3, 4

    response.write("<zip_code_lookup>")

    If not rs.eof then
        response.write("<zip>" & Request("zip") & "</zip>")
        response.write("<city>" & rs("City") & "</city>")
        response.write("<county>" & rs("County") & "</county>")
        response.write("<state>" & rs("State") & "</state>")
        response.write("<rate>" & rs("Rate") & "</rate>")
        response.write("<shippingtaxable>n/a</shippingtaxable>")
        response.write("<server>Casper06</server>")
    End If

    response.write("</zip_code_lookup>")

    rs.Close
    set rs = nothing

    ' Start 1

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

    ' Start 9
    set conn=server.CreateObject("ADODB.Connection")
    conn.Open "driver=SQL Server;server=208.88.49.22;uid=davewj2o;pwd=get2it;database=z2t_WebPublic"  'Philly05 Backdoor
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
        response.write("<server>Philly05</server>")
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

    ' Start 13

    Set conn=server.CreateObject("ADODB.Connection")
    conn.Open "driver=SQL Server;server=philly01.harvestamerican.net,8143;uid=davewj2o;pwd=get2it;database=zip2tax"

    'Open the recordset using the stored procedure
    Set rs = server.CreateObject("ADODB.Recordset")
    rs.open "z2t_link.z2t_lookup('" & RequestZip & "', '" & RequestUsr & "', '" & RequestPass & "')", conn, 3, 3, 4

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

    ' Start 3
    Dim ZipCode
    Dim Password
    Dim ApiError 'Matched to ErrorCode and ErrorMessage to match the old version
    Dim ErrorMessage(99)

    ErrorMessage(0) = "No Errors"
    ErrorMessage(1) = "Missing Zip Code"
    ErrorMessage(2) = "Missing Password"
    ErrorMessage(3) = "Connection Error"
    ErrorMessage(4) = "Zip Code Less than 5 Characters"
    ErrorMessage(5) = "Zip Code Out of Range for Sample"
    ErrorMessage(6) = "Incorrect Username/Password"
    ErrorMessage(7) = "Zip Code Not Found"
    ErrorMessage(8) = "Missing Username"
    ErrorMessage(99) = "Error Unknown"

    Error = 0

    If isnull(RequestZip) Or RequestZip = "" Then
        Error = 1
    End If

    If Error = 0 Then
        If isnull(RequestUsr) Or RequestUsr = "" Then
            Error = 8
        End If
    End If

    If Error = 0 Then
        If isnull(RequestPass) Or RequestPass = "" Then
            Error = 2
        End If
    End If
    If Error = 0 Then

        Dim LookupResults    'Class instance for primary lookup results
        Set LookupResults = New CLookupResults
        LookupResults.ApiCall RequestUsr,RequestPass,RequestZip
        ApiError = LookupResults.ErrorCode
        If ApiError = 0 Then    
            LookupResults.SetBasicLookupData()
            Zip_Code =  RequestZip
            City = LookupResults.DisplayCity
            County = LookupResults.County
            State = LookupResults.State
            Rate = LookupResults.SalesRate
            Shipping_Taxable = LookupResults.IsShippingTaxable
        End If

    End If
    If ApiError = 55 Then
            Zip_Code =  ZipCode
            City = "Invalid Sample Zip"
            County = "Error"
            State = "Error"
            Rate = 0
            Shipping_Taxable = 0
            Error = 0
    End If

    If ApiError = 8 Then
            Error = 6
            Zip_Code =  ZipCode
            Rate = 0
            Shipping_Taxable = 0
    End If

    If ApiError = 1 Then
            Zip_Code =  ZipCode
            City = "Invalid Zip"
            County = "Error"
            State = "Error"
            Rate = 0
            Shipping_Taxable = 0
            Error = 0
    End If

    If ApiError = 113 Then
            Zip_Code =  ZipCode
            City = "Invalid Zip"
            County = "Error"
            State = "Error"
            Rate = 0
            Shipping_Taxable = 0
            Error = 0
    End If

    
    If ApiError = 100 Then
            Zip_Code =  ZipCode
            City = "Invalid Zip"
            County = "Error"
            State = "Error"
            Rate = 0
            Shipping_Taxable = 0
            Error = 0
    End If

    
    If ApiError = 3 Then
            Error = 3
            Zip_Code =  ZipCode
            Rate = 0
            Shipping_Taxable = 0
    End If

    response.write("<zip_code_lookup>")
    response.write("<zip>" & Zip_Code & "</zip>")
    response.write("<city>" & City & "</city>")
    response.write("<county>" &County  & "</county>")
    response.write("<state>" & State & "</state>" )
    response.write("<rate>" &Rate & "</rate>")
    response.write("<shippingtaxable>" & Shipping_Taxable & "</shippingtaxable>")
    response.write("<server>Various</server>")
    response.write("<error_code>" & Error & "</error_code>")
    response.write("<error_message>" & ErrorMessage(Error) & "</error_message>")
    response.write("</zip_code_lookup>")

    ' Start 5
    set connPhilly01=server.CreateObject("ADODB.Connection")
    
    'connPhilly01.Open "driver={MySQL ODBC 5.1 Driver};Server=philly01.harvestamerican.net;User=davewj2o;Password=get2it2day;Database=Zip2Tax" '--Philly01
    connPhilly01.Open "driver={MySQL ODBC 5.1 Driver};Server=philly01.harvestamerican.net;User=root;Password=start2gosoon;Database=Zip2Tax" '--Philly01
    
    set rs=server.createObject("ADODB.Recordset")

    SQL =  "call zip2tax.z2t_lookup ('" & Request("zip") & "', '" & Request("usr") & "', '" & Request("pwd") & "')"
    
    'Response.write SQL
    rs.open SQL, connPhilly01

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

    ' Start 6
    DatabaseTest_api "Philly02"

    ' Start 7
    DatabaseTest_api "Philly04"

    ' Start 8
    DatabaseTest_api "Casper06"

    ' Start 14
    DatabaseTest_api "Frank02"

    ' Start 4
    DatabaseTest_api "Casper09"

    ' Start 11
    DatabaseTest_api "Philly05"    

    response.write("</zip_code_lookups>")
Function DatabaseTest_api(server_name)
    ' store link in a variable
    Dim link
    link = "https://" & server_name & "-api.zip2tax.com/TaxRate-USA.xml?username=" & RequestUsr & "&password=" & RequestPass & "&zip=" & RequestZip
    
    ' declare and set variable to an object that can retrieve XML information
    Dim xhr: 'Set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
    Set xhr = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")
    xhr.option(9) = 2720: 'SSL3 TLS1.0 TLS1.1 and TLS1.2
    'xhr.option(9) = 128

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
        'Response.ContentType = "text/plain": Response.Write child.nodeName & " = " & child.text & "<br>" & vbCrLf
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
            'Response.Write objNote.nodeName & " = " & objNote.text & "<br>"
            'shippingtaxable = objNote.text
        Set objNote = xmlResponse.selectNodes("//address[1]//notes/noteDetail[./category[text() = 'Tax on Shipping']]/note")
        shippingtaxable = 0
        If Not objNote.item(0) Is Nothing Then
          If objNote.item(0).text = "Shipping charges are taxable" Then shippingtaxable = 1
          'shippingtaxable = objNote.item(0).text
        End If
        End Select
    Next
  End If    
    
    'Get the Error Information
    Set objLst = xmlResponse.getElementsByTagName("errorInfo")
    For Each child In objLst.item(0).childNodes
        'Response.ContentType = "text/plain": Response.Write child.nodeName & " = " & child.text & "<br>" & vbCrLf
  
        Select case lcase(child.nodeName)
        Case "servername"
              ServerName = child.text
              If len(ServerName) > 0 Then
                ServerName = Left(ServerName,1) & Mid(lCase(ServerName),2,Len(ServerName)-1)
              End If
        Case "version"
              Version = child.text
        End Select
    Next
    

    'Done with this
    Set xmlResponse = Nothing
    
    Response.Write("<zip_code_lookup>")

        Response.Write("<zip>" & zip & "</zip>")
        Response.Write("<city>" & city & "</city>")
        Response.Write("<county>" & county & "</county>")
        Response.Write("<state>" & state & "</state>")
        Response.Write("<rate>" & rate & "</rate>")
        Response.Write("<shippingtaxable>" & shippingtaxable & "</shippingtaxable>")
        Response.Write("<server>" & ServerName & "</server>")
        Response.Write("<version>" & Version & "</version>")

    Response.Write("</zip_code_lookup>")
End Function
%>

