<%
Dim RowMod

Dim sqlConn
Set sqlConn = Server.CreateObject("ADODB.Connection")
'sqlConn.Open "Provider=SQLNCLI10;DataTypeCompatibility=80;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConn.Open "Provider=SQLOLEDB;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
sqlConn.Open "Driver=SQL Server;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"


' Return the result sets from the query in sqlText
Function Sql(sqlText)
  Dim rs 
  Set rs = Server.CreateObject("ADODB.RecordSet")
  'Response.Write(sqlText & "," & typename(rs) & "," & sqlConn & chr(13))
  'Response.Write(sqlText)
  rs.open sqlText, sqlConn, 2, 3
  Set Sql = rs
End Function

' Return the string representation of the resultsets in sqlText
Function SqlTable (sqlText)
  Dim table
  table = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Server.CreateObject("ADODB.RecordSet")
  'table = table & sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  rs.open sqlText, sqlConn, 2, 3
  If (rs Is Nothing) Or (rs.State = 0) Then 
    SqlTable = "<em>No result set.</em>"
    Exit Function
  End If
  Dim totalcount
  totalcount = 0
  table = table & "<span class='resultset'>" & chr(13)


  Do While (Not rs is Nothing) And (rs.State <> 0)
    table = table & "  <table class='resultset'>" & chr(13)
    table = table & "    <thead>" & chr(13)
    table = table & "      <tr>" & chr(13)
    Dim field
    For Each field in rs.Fields
      table = table & "        <th>" & field.Name & "</th>" & chr(13)
    Next
    table = table & "      </tr></thead>" & chr(13)
'' RecordCount seems not to be supported
'    table = table & "    <tfoot>" & chr(13)
'    table = table & "      (" & rs.RecordCount & " rows)"
'    table = table & "    </tfoot>" & chr(13)
    table = table & "    <tbody>" & chr(13)
    Dim count
    count = 0
    Do While Not rs.eof
      count = count + 1
      table = table & "      <tr class='rowmod-" & ((count - 1) Mod RowMod) & "'>" & chr(13)
      For Each field in rs.Fields
        table = table & "        <td>" & field & "</td>" & chr(13)
      Next
      table = table & "      </tr>" & chr(13)
      rs.moveNext
    Loop
    totalcount = totalcount + count
    table = table & "    </tbody>" & chr(13)
    If rs.State = 1 Then 
      Set rsTryNext = rs.NextRecordSet 
      If Not rsTryNext Is Nothing Then Set rs = rsTryNext
    Else 
      table = table & rs.State
      Exit Do
    End If
  'Response.Write(typeName(rs) & "<br>")
  Loop
  If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  table = table & "  </table>" & chr(13)
  table = table & "</span>" & chr(13)
  'Response.Write table
  SqlTable = table
End Function

' Respond with the result set(s) from the query in sqlText as html tables
Sub SqlTableInsert (sqlText)
  Dim rs 
  Dim rsTryNext
  Set rs = Server.CreateObject("ADODB.RecordSet")
  'Response.Write sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  rs.open sqlText, sqlConn, 2, 3
  If (rs Is Nothing) Or (rs.State = 0) Then 
    Response.Write("<em>No result set.</em>")
    Exit Sub
  End If
  
  Dim totalcount
  totalcount = 0
  Response.Write "<span class='resultset'>" & chr(13)

  Do While (Not rs is Nothing) And (rs.State <> 0)
    Response.Write "  <table class='resultset'>" & chr(13)
    Response.Write "    <thead>" & chr(13)
    Response.Write "      <tr>" & chr(13)
    Dim field
    For Each field in rs.Fields
      Response.Write "        <th>" & field.Name & "</th>" & chr(13)
    Next
    Response.Write "      </tr></thead>" & chr(13)
'' RecordCount seems not to be supported
'    Response.Write "    <tfoot>" & chr(13)
'    Response.Write "      (" & rs.RecordCount & " rows)"
'    Response.Write "    </tfoot>" & chr(13)
    Response.Write "    <tbody>" & chr(13)
    Dim count
    count = 0
    Do While Not rs.eof
      count = count + 1
      Response.Write "      <tr class='rowmod-" & ((count - 1) Mod RowMod) & "'>" & chr(13)
      For Each field in rs.Fields
        Response.Write "        <td>" & field & "</td>" & chr(13)
        'debug: Response.Write "        <td>" & typename(field) & "</td>" & chr(13)
      Next
      Response.Write "      </tr>" & chr(13)
      rs.moveNext
    Loop
    totalcount = totalcount + count
    'Response.Write "       <tr class='rowcount'><td>" & totalcount & " rows</td></tr>" & chr(13)
    Response.Write "    </tbody>" & chr(13)
    If rs.State = 1 Then 
      Set rsTryNext = rs.NextRecordSet 
      If Not rsTryNext Is Nothing Then Set rs = rsTryNext
    Else 
      Response.Write rs.State
      Exit Do
    End If
  Loop
  If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  Response.Write "  </table>" & chr(13)
  Response.Write "<p class='rowcount'>" & totalcount & " total rows</p>"
  Response.Write "</span>" & chr(13)
End Sub

' Return one field from the query contained in sqlText
Function SqlValue (sqlText, field)
  Dim rs 
  Set rs = Server.CreateObject("ADODB.RecordSet")
  'table = table & sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  rs.open sqlText, sqlConn, 2, 3
  SqlValue = rs(field)
  If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
End Function


' Return the string representation of the option list from the rows in sqlText
Function SelectOption (sqlText)
  Dim table
  table = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Server.CreateObject("ADODB.RecordSet")
  'table = table & sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  response.write(sqlText)
  rs.open sqlText, sqlConn, 2, 3
  Dim totalcount
  totalcount = 0
  table = table & "<select class='select'>" & chr(13)

  Do While (Not rs is Nothing) And (rs.State <> 0)
    table = table & " <option value=" & chr(34)
    Dim fieldnum
    fieldnum = 0
    Dim field
    For Each field in rs.Fields
      If fieldnum > 0 Then 
        table = table & " - "
      End If
      table = table
      fieldnum = fieldnum + 1
    Next
    table = table & chr(34) & "></option>" & chr(13)
    'If (rs is Nothing) or (rs.State = 0) Then Exit Do
    'Response.Write(rs.BOF, rs.EOF, typename(rs))
    rs.MoveNext
  Loop
  If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  Response.Write table
  SelectOption = table
End Function

' Convert an open resultset into html table(s)
Sub rsTableInsert (rs)
  If (rs Is Nothing) Or (rs.State = 0) Then 
    Response.Write("<em>No result set.</em>")
    Exit Sub
  End If
  Dim rsTryNext
  'Response.Write "[" & typename(rs) & " = " & rs.State & "]" & ", [" & sqlConn & "]" & chr(13)
  Dim totalcount
  totalcount = 0
  Response.Write "<span class='resultset'>" & chr(13)
  Dim field

  Do While (Not rs is Nothing) And (rs.State <> 0)
    Response.Write "  <table class='resultset'>" & chr(13)
    Response.Write "    <thead>" & chr(13)
    Response.Write "      <tr>" & chr(13)
    For Each field in rs.Fields
      Response.Write "        <th>" & field.Name & "</th>" & chr(13)
    Next
    Response.Write "      </tr></thead>" & chr(13)
'' RecordCount seems not to be supported
'    Response.Write "    <tfoot>" & chr(13)
'    Response.Write "      (" & rs.RecordCount & " rows)"
'    Response.Write "    </tfoot>" & chr(13)
    Response.Write "    <tbody>" & chr(13)
    Dim count
    count = 0
    Do While Not rs.eof
      count = count + 1
      Response.Write "      <tr class='rowmod-" & ((count - 1) Mod RowMod) & "'>" & chr(13)
      For Each field in rs.Fields
        Response.Write "        <td>" & field & "</td>" & chr(13)
      Next
      Response.Write "      </tr>" & chr(13)
      rs.moveNext
    Loop
    totalcount = totalcount + count
    Response.Write "    </tbody>" & chr(13)
    If rs.State = 1 Then 
      Set rsTryNext = rs.NextRecordSet 
      If Not rsTryNext Is Nothing Then Set rs = rsTryNext
    Else 
      Response.Write rs.State
      Exit Do
    End If
  Loop
  Response.Write "  </table>" & chr(13)
  Response.Write "</span>" & chr(13)
End Sub

%>

