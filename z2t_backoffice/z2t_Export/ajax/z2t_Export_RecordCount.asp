
<%
tableName = request.QueryString("tableName")
Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Export" '

Dim rs
Set rs=server.createObject("ADODB.Recordset")

Dim rsObject
Set rsObject=server.createObject("ADODB.Recordset")
			RecourdCount =0
Sql="SELECT ISNULL(OBJECT_ID(N'[dbo].["&tableName&"]'),0) AS ObjectID"
	 rsObject.open SQL, connPhilly05
If Not rsObject.Eof and rsObject("ObjectID") >0 then
If Len(tableName) > 0 then

	 strSQL = "SELECT Count(*) c FROM " & tableName
	 rs.open strSQL, connPhilly05

		If not rs.EOF Then
			RecourdCount = rs("C")
	    End If
	End If
	 rs.Close
	End if

rsObject.close

response.write RecourdCount
%>
