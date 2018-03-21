<%
'''''
' Created: <2011-09-09 Fri nathan>
' Description: Make easy use of SQL queries.
'
'   Sql("...") returns a recordset.
'
'   SqlTable("...") returns an HTML table as text.
'
'   SqlTableInsert("...") outputs an HTML table.
'
'   SqlValue("...", field) return one value from a query.
'
'   SelectOptions("...") return <select> <options>s from rows of a query.
'   SelectDefaultedOptions("...") return <select> <options>s from rows of a query -- use default.
'     value, description must be returned in query resultset. 
'   SelectOptionsFields("...") return <select> <options>s from rows of a query -- combine fields.
'
'   rsTableInsert(rs) outputs an HTML table from an open resultset.
'

' User variables
Dim RowMod ' Modules for classes to colorize rows
Dim ShowRowNum ' Boolean whether to number table rows
Dim ShowRowCount ' Boolean whether to show rowcount
Dim RowCount ' Output global variable of last rowcount
Dim SqlTimeout ' Driver timeout
Dim sqlConnectionString
Dim sqlDebug
'Private global

' Default values
SqlTimeout = 30 'seconds
'sqlConnectionString = "Provider=SQLNCLI10;DataTypeCompatibility=80;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConnectionString = "Provider=SQLOLEDB;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConnectionString = "Driver=SQL Server;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
sqlConnectionString = "Driver=SQL Server;server=localhost;uid=davewj2o;pwd=get2it;database=util" 'philly05.HarvestAmerican.net '208.88.49.22

ShowRowNum = False
ShowRowCount = True   
RowCount = 0 'Return number of rows for Table functions
RowMod = 3 'a nonzero default
sqlDebug = False

' Private code follows
'''''
Function SqlNewConnection()
  Dim sqlConn
  Set sqlConn = Server.CreateObject("ADODB.Connection")
  sqlConn.Open sqlConnectionString
  Set SqlNewConnection = sqlConn
End Function

' Return the result sets from the query in sqlText
Function Sql(sqlText)
  Dim rs 
  Set rs = Server.CreateObject("ADODB.RecordSet")
  If sqlText = "" Then 
   Set Sql = rs
   Exit Function
  End If
  'Response.Write("<br>" & typename(rs) & "," & sqlConn & "<br>" & chr(13))
  If sqlDebug = True Then Response.Write("<br>" & sqlConnectionString & "<br>" & chr(13))
  If sqlDebug = True Then Response.Write("<br>" & sqlText & "<br>" & chr(13))
  Dim sqlConn
  Set sqlConn = SqlNewConnection()

  sqlConn.commandTimeout = SqlTimeout
  If sqlDebug = True Then
   rs.open sqlText, sqlConn, 2, 1
  Else
    rs.open sqlText, sqlConn, 2, 3
    'rs.open sqlText, sqlConn, -1, -1
  End If
  Set Sql = rs
  'Response.Write("<br>{" & cstr(rs.Status) & "}<br>" & chr(13))
  'Response.Write("<br>" & rs.eof  & "<br>" & chr(13))
End Function


' Return the string representation of the resultsets in sqlText
Function SqlTable(sqlText)
  Dim table
  RowCount = 0
  table = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Sql(sqlText)
  'table = table & sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  If (rs Is Nothing) Or (rs.State = 0) Then 
    SqlTable = "<em>No result set.</em>"
    Exit Function
  End If
  Dim totalcount
  totalcount = 0
  Dim prefooter
  Dim precorner
  table = table & "<span class='resultset'>" & chr(13)

  Do While (Not rs is Nothing) And (rs.State <> 0)
    table = table & "  <table class='resultset'>" & chr(13)
    table = table & "    "
    Dim colcount
    colcount = 0
    If ShowRowNum Then
      table = table & "<col class=""rowcount""/>"
      colcount = colcount + 1
    End If
    For Each field in rs.Fields
      table = table & "<col class=""" & field.Name & """ />"
      colcount = colcount + 1
    Next
    table = table & chr(13)
    table = table & "    <thead>" & chr(13)
    table = table & "      <tr>" & chr(13)
    Dim field
    If ShowRowNum Then table = table & "<th>"
    precorner = table
    If ShowRowNum Then table = "</th>" Else table = ""
    For Each field in rs.Fields
      table = table & "        <th>" & field.Name & "</th>" & chr(13)
    Next
    table = table & "      </tr></thead>" & chr(13)
'' RecordCount seems not to be supported
'    table = table & "    <tfoot>" & chr(13)
'    table = table & "      (" & rs.RecordCount & " row" &
'     If rs.RecordCount = 1 Then
'       table = table & "row"
'     Else
'       table = table & "rows"
'     End If
'     table = table & ")"
'    table = table & "    </tfoot>" & chr(13)

    ' save place to put total rows in footer
    prefooter = table
    table = ""

    table = table & "    <tbody>" & chr(13)
    Dim count
    count = 0
    Do While Not rs.eof
      count = count + 1
      table = table & "      <tr class='rowmod-" & ((count - 1) Mod RowMod) & "'>" & chr(13)
      If ShowRowNum Then table = table & "<td>" & count & "</td>"
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

  ' put total rows in footer & top-left corner
  If ShowRowNum Then
    precorner = precorner & "(" & totalcount & ")"
  End If
  If ShowRowCount Then
    Dim footer
    footer = "    <tfoot><tr><th colspan=""" & colcount & """>" & chr(13) & "      (" & totalcount & " "
    If totalcount = 1 Then
      footer = footer & "row"
    Else
      footer = footer & "rows"
    End If
    footer = footer & ")" & chr(13) & "    </th></tr></tfoot>" & chr(13)
    table = precorner & prefooter &  footer & table
  Else 
    table = precorner & prefooter & table
  End If

  RowCount = totalcount ' Return rowcount in a global variable
  'Response.Write table
  SqlTable = table
End Function


' Respond with the result set(s) from the query in sqlText as html tables
Sub SqlTableInsert (sqlText)
  Dim rs 
  Dim rsTryNext
  'Response.Write sqlText & "," & typename(rs) & "," & sqlConn & chr(13)
  Set rs = Sql(sqlText)
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
'    Response.Write "      (" & rs.RecordCount & " "
'    If rs.RecordCount = 1 Then
'      Response.Write "row"
'    Else
'      Response.Write "rows"
'    End If
'    Response.Write "rows"
'    Response.Write ")"
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
    'Response.Write "       <tr class='rowcount'><td>" & totalcount & " "
    'If totalcount = 1 Then
    '  Response.Write "row"
    'Else
    '  Response.Write "rows"
    'End If
    'Response.Write "</td></tr>" & chr(13)
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
  if sqlDebug = True Then Response.Write(field)
  SqlValue = Sql(sqlText)(field)
End Function


Function SelectOption (id, sqlText)
  Dim selectopts

  selectopts = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Sql(sqlText)
  Dim totalcount
  totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value="""">(select an option)</option>"
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    selectopts = selectopts & " <option value=""" & rs("value") & """>" & rs(description) & "</option>" & chr(13)
    rs.MoveNext
  Loop
  selectopts = selectopts & "</select>"
  Set rs = Nothing
  'Response.Write selectopts
  SelectOption = selectopts
End Function


' Return the string representation of the option list from the rows in sqlText -- with default specified.
Function SelectDefaultedOption (id, sqlText, default)
  Dim selectopts

  selectopts = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Sql(sqlText)
  Dim totalcount
  totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value=""Default"">(select an option)</option>"
  'If default = "" and Not rs.eof Then default = rs(value)
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    selectopts = selectopts & " <option value=""" & rs("value") & """"
    If rs("value") = default Then selectopts = selectopts & " selected=""selected"""
    selectopts = selectopts & ">" & rs("description") & "</option>" & chr(13)
    'If (rs is Nothing) or (rs.State = 0) Then Exit Do
    'Response.Write(rs.BOF & " - " &  rs.EOF & " - " & typename(rs))
    rs.MoveNext
  Loop

  selectopts = selectopts & "</select>"

  'If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  'Response.Write selectopts
  SelectDefaultedOption = selectopts
End Function


' Return the string representation of the option list from the rows in sqlText
Function SelectOptionFields (id, sqlText)
  Dim selectopts

  selectopts = ""
  Dim rs 
  Dim rsTryNext
  Set rs = Sql(sqlText)
  Dim totalcount
  totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value=""Default"">(select an option)</option>"
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    Dim fieldnum
    fieldnum = 0
    Dim field
    Dim opt
    opt = ""
    For Each field in rs.fields
      If fieldnum > 0 Then 
        opt = opt & " - "
      End If
      opt = opt & field.value
      fieldnum = fieldnum + 1
    Next
    selectopts = selectopts & " <option value=""" & opt & """>" & opt & "</option>" & chr(13)
    'If (rs is Nothing) or (rs.State = 0) Then Exit Do
    'Response.Write(rs.BOF, rs.EOF, typename(rs))
    rs.MoveNext
  Loop

  selectopts = selectopts & "</select>"

  'If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  'Response.Write selectopts
  SelectOptionFields = selectopts
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
