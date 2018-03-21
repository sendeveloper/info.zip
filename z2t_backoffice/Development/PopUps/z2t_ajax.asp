<%
'Retrieve z2t API data
  Dim pathLookupAPI
	pathLookupAPI = Replace(Lcase(pathBase),"http://www.","https://") 'IF http://www.zip2tax.com then API path will have HTTPS and WWW will be removed.
	pathLookupAPI = Replace(Lcase(pathLookupAPI),"https://www.","https://") 'IF already https, then just remove www. from it
    pathLookupAPI  = Replace(pathLookupAPI,"zip2tax","api.zip2tax")  ' In second step we will replace zip2tax with api.zip2tax.com
	'So after above two steps , new live UR will be https://api.zip2tax.com/
	'While other links will become: e.g http://dev.zip2tax.com --> http://dev.api.zip2tax.com   
									   'http://frank02.zip2tax.com  --> http://frank02.api.zip2tax.com

Dim ajax: Set ajax = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
Dim postData: postData = "username=" & Request("username") & "&password=" & Request("password") & "&AddressLine1=" & Request("addressLine1") & "&AddressLine2=" & Request("addressLine2") & "&City=" & Request("city") & "&State=" & Request("state") & "&Zip=" & Request("zip")
'ajax.open "POST", vURL, false
'ajax.setRequestHeader "Content-type","application/json"
'ajax.setRequestHeader "Accept","application/json"
ajax.open "get", pathLookupAPI + "TaxRate-USA.web?" + postData, False
ajax.send

Dim results
If ajax.status = 200 Then
'results = ajax.responseXML.xml ' ajax.responseText  ajax.responseStream
results = ajax.responseText

Response.ContentType = "application/json; charset=utf-8"
Else
' Handle missing response or other errors here
results = ""
'results = "<?xml version=""1.0"" encoding=""utf-16""?><div class=""z2tLookup""><div class=""errorInfo""><span class=""errorCode"">" & ajax.status & "</span><span class=""errorMessage"">" & ajax.responseText & "</span><ul class=""warnings""><li class=""warning"">Load Error: " & ajax.responseText & "</li></ul></div></div>"
'Response.ContentType = "text/plain"
Response.ContentType = "application/json; charset=utf-8"
End If
response.write(results) 

%>
