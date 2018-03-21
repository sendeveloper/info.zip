<%
	' determine if zip query exists
	If isnull(Request("zip")) or Request("zip") = "" Then
		RequestZip = 82009
	Else
		RequestZip = Request("zip")
	End If

	' store link in a variable
	link = "https://" & Request("server") & "-api.zip2tax.com/TaxRate-USA.xml?username=" & Request("usr") & "&password=" & Request("pwd") & "&zip=" & RequestZip
	
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
	
    Response.ContentType = "text/xml"
    Response.Write("<?xml version='1.0' encoding='ISO-8859-1'?>")
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
	
%>
