

<html>
<title>CodeAve.com(Create Excel on Server)</title>
<body bgcolor="#FFFFFF">
<%
' Name of the access db being queried
'accessdb="state_info" 

' Connection string to the access db
'cn="DRIVER={Microsoft Access Driver (*.mdb)};"
'cn=cn & "DBQ=" & server.mappath(accessdb)

' Create a server recordset object
'Set rs = Server.CreateObject("ADODB.Recordset")
Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
Dim rs: Set rs=server.createObject("ADODB.Recordset")
connPhilly05.Open "driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_Export" ' philly05

' Query the states table from the state_info db
'sql = "select state,statename,capital,year,order from states " 

' Execute the sql
'rs.Open sql, cn
 strSQL = "z2t_TableExport_Basic(1,'NY')"
		
 rs.open strSQL, connPhilly05, 3, 3, 4

' Move to the first record
rs.MoveFirst

' Name for the ouput document 
file_being_created= "states.xls"

' create a file system object
set fso = createobject("scripting.filesystemobject")

' create the text file - true will overwrite any previous files
' Writes the db output to a .xls file in the same directory 
Set act = fso.CreateTextFile(server.mappath(file_being_created), true)

' All non repetitive html on top goes here
act.WriteLine("<html><body>")
act.WriteLine("<table border=""1"">")
act.WriteLine("<tr>")
act.WriteLine("<th nowrap>z2t_ID</th>")
act.WriteLine("<th nowrap>ZipCode</th>")
act.WriteLine("<th nowrap>SalesTaxRate</th>")
act.WriteLine("<th nowrap>Jurisdiction</th>")
act.WriteLine("<th nowrap>ReportingCode</th>")
act.WriteLine("<th nowrap>City</th>")
act.WriteLine("<th nowrap>PostOffice</th>")
act.WriteLine("<th nowrap>State</th>")
act.WriteLine("<th nowrap>County</th>")
act.WriteLine("<th nowrap>ShippingTaxable</th>")
act.WriteLine("<th nowrap>PrimaryRecord</th>")
act.WriteLine("</tr>")

' For net loop to create seven word documents from the record set
' change this to "do while not rs.eof" to output all the records
' and the corresponding next should be changed to loop also

for documents= 1 to 7

Act.WriteLine("<tr>")
act.WriteLine("<td align=""right"">" & rs("z2t_ID") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("ZipCode") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("SalesTaxRate") & "</td>")
act.WriteLine("<td align=""right"">"& rs("Jurisdiction") & "</td>")
act.WriteLine("<td align=""right"">"& rs("ReportingCode") & "</td>")
act.WriteLine("<td align=""right"">" & rs("City") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("PostOffice") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("State") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("County") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("ShippingTaxable") & "</td>" )
act.WriteLine("<td align=""right"">" & rs("PrimaryRecord") & "</td>" )
act.WriteLine("</tr>")

' move to the next record
rs.movenext

' return to the top of the for - next loop
' change this to "loop" to output all the records
' and the corresponding for statement above should be changed also
next

' All non repetitive html on top goes here
act.WriteLine("</table></body></html>")

' close the object (excel)
act.close

' Writes a link to the newly created excel in the browser
response.write "<a href='states.xls'>States</a> (.xls) has been created on " & now() & "<br>"
%>
</body>
</html>