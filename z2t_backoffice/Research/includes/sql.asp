<%
'''''
' Created: <2011-09-09 Fri nathan>
' Description: Make easy use of SQL queries.
'
'   function: Sql("...") returns a recordset.
'
'   function: sqlTable("...") returns an HTML table as text.
'
'   sub: sqlTableInsert("...") outputs an HTML table.
'
'   function: sqlValue("...", field) return one value from a query.
'
'   --SelectOptions("...") return <select> <options>s from rows of a query.
'   --SelectDefaultedOptions("...") return <select> <options>s from rows of a query -- use default.
'     value, description must be returned in query resultset.
'   --SelectOptionsFields("...") return <select> <options>s from rows of a query -- combine fields.
'
'   function: rsTable(rs) returns an HTML table as text.
'
'   function: rsTableInsert(rs) outputs an HTML table from an open resultset.
'
'   variable:
'

' User variables
Dim RowMod: RowMod = 3 ' Modules for classes to colorize rows
Dim ShowRowNum: ShowRowNum = False ' Boolean whether to number table rows
Dim ShowRowCount: ShowRowCount = True ' Boolean whether to show rowcount
Dim RowCount: RowCount = 0 ' Output global variable of last rowcount (Return number of rows for Table functions)
Dim SqlTimeout: SqlTimeout = 30 ' Driver timeout (seconds)
Dim sqlConnectionString
Dim sqlLock: sqlLock = 1 'read-only (3)
Dim sqlType: sqlType = 2 'dynamic-cursor (2) 'static-cursor (2) 'forward-only (0)
Dim sqlOptions: sqlOptions = 0 'none
Dim sqlPageSize: sqlPageSize = 50
Dim sqlPage: sqlPage = 1
Dim sqlSort: sqlSort = ""
Dim sqlHeaderDecorator: Set sqlHeaderDecorator = Nothing ' function to add decorations to header names (e.g. sort arrows)
Dim sqlHeaderAttributes: Set sqlHeaderAttributes = Nothing ' function to add attributes to header elements (e.g. column widths)
'Dim sqlColumns: Set sqlColumns = "*" ' comma-delimited string specifying column selection and naming (e.g. "[server name]=server, database=db, date=CreatedDate")
Dim sqlFieldTypes: sqlFieldTypes = False ' store each field's type name in the <td rel="...">
Dim sqlLocation: sqlLocation = 3 'client
Dim sqlPaging: sqlPaging = True
Dim sqlDebug: sqlDebug = False
Dim sqlDebugOutput: sqlDebugOutput = ""

' Private globals

' Default values
 'seconds
'sqlConnectionString = "Provider=SQLNCLI10;DataTypeCompatibility=80;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConnectionString = "Provider=SQLOLEDB;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConnectionString = "Driver=SQL Server;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
'sqlConnectionString = "Driver=SQL Server;server=philly05.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util"
sqlConnectionString = "Driver=SQL Server;server=localhost;uid=davewj2o;pwd=get2it;database=util"

' Private code follows
'''''
Function SqlNewConnection()
  Dim sqlConn: Set sqlConn = Server.CreateObject("ADODB.Connection")
  sqlConn.CursorLocation = sqlLocation
  sqlConn.Open sqlConnectionString
  Set SqlNewConnection = sqlConn
End Function

' Return the result sets from the query in sqlText
Function Sql(sqlText)
  'sqlDebugWrite("<div style=""margin-top: 1em;"">sql<hr><ul>" )
  'sqlDebugWrite("<li>" & sqlType & "<br>" )
  'sqlDebugWrite("<li>" & sqlLock & "</li>" )
  'sqlDebugWrite("<li>" & sqlOptions & "</li>" )
  'sqlDebugWrite("<li>" & sqlPageSize & "</li>" )
  'sqlDebugWrite("<li>" & sqlPage & "</li>" )
  'sqlDebugWrite("<li>" & sqlSort & "</li>" )
  'sqlDebugWrite("<li>" & sqlLocation & "</li>" )
  'sqlDebugWrite("<li>" & sqlPaging & "</li>" )
  'sqlDebugWrite("</ul></div>" )

  Dim rs: Set rs = Server.CreateObject("ADODB.RecordSet")
  If sqlText = "" Then
    Set Sql = rs
    Exit Function
  End If
  'sqlDebugWrite("<br>" & typename(rs) & "," & sqlConn & "<br>" & chr(13))
  If sqlDebug = True Then sqlDebugWrite("<br>" & sqlText & "<br>" & chr(13))
  Dim sqlConn: Set sqlConn = SqlNewConnection()
  rs.CursorLocation = sqlLocation
  rs.PageSize = sqlPageSize
  rs.CacheSize = sqlPageSize
  sqlConn.commandTimeout = SqlTimeout
  If sqlDebug = True Then sqlDebugWrite("<br>" & sqlText & "<br>" & chr(13))
  If sqlDebug = True Then Response.Write("<br>" & sqlText & "<br>" & chr(13))
  sqlDebugWrite(sqlType & " " & sqlLock & " " & sqlOptions)
  rs.open sqlText, sqlConn, sqlType, sqlLock, sqlOptions
  'rs.open sqlText, sqlConn, -1, -1

  'sqlDebugWrite(rs.CursorLocation & " "  & typename(rs.AbsolutePage & "<br>"))
  'Set rs.ActiveConnection = Nothing
  'sqlConn.Close
  Set sqlConn = Nothing
  'sqlDebugWrite(sqlSort)
  rs.Sort = sqlSort

  If sqlPaging And (rs.CursorLocation = 3) And (rs.LockType <> 1) Then
    rs.AbsolutePage = sqlIf(sqlPage > 0 And sqlPage <= rs.PageCount, sqlPage, 1)
  End If

  Set Sql = rs
  'sqlDebugWrite("+" & rs.PageSize & "+")
  'sqlDebugWrite("<br>{" & cstr(rs.Status) & "}<br>" & chr(13))
  'sqlDebugWrite("<br>" & rs.eof  & "<br>" & chr(13))
End Function


' Return the string representation of the resultsets in sqlText
Function sqlTable(sqlText)
  'Dim savePaging: sqlPaging = False
  Dim saveLocation: saveLocation = sqlLocation

  sqlTable = rsTable(Sql(sqlText))

  sqlLocation = saveLocation
  'sqlPaging = savePaging
End Function


Function rsTable(rs)
  Dim table: table = ""
  RowCount = 0
  Dim rsTryNext
  If (rs Is Nothing) Or (rs.State = 0) Then
    rsTable = "<em>No result set.</em>"
    Exit Function
  End If
  Dim totalcount: totalcount = 0
  Dim prefooter
  Dim precorner
  table = table & "<div class='resultset'>" & chr(13)

  Do While (Not rs is Nothing) And (rs.State <> 0)
    table = table & "  <table class='resultset'>" & chr(13)
    table = table & "    "
    Dim colcount: colcount = 0
    If ShowRowNum Then
      table = table & "<col class=""rowcount"" />"
      colcount = colcount + 1
    End If
    For Each field in rs.Fields
      table = table & "<col class=""" & replace(field.Name, " ", "-") & """ />"
      colcount = colcount + 1
    Next
    table = table & chr(13)
    table = table & "    <thead>" & chr(13)
    table = table & "      <tr>" & chr(13)
    Dim field
    If ShowRowNum Then
      table = table & "<th"
      If Not sqlHeaderAttributes is Nothing Then
        Response.Write("hey: " & sqlHeaderAttributes("row-num"))
        table = table & " " & sqlHeaderAttributes("row-num")
      End If
      table = table & ">"
    End If
    precorner = table
    If ShowRowNum Then table = "</th>" Else table = ""
    For Each field in rs.Fields
      If left(field.Name, 1) <> " " Then
        table = table & "        <th class=""" & replace(field.Name, " ", "-") & """"
        If Not sqlHeaderAttributes is Nothing Then
          table = table & " " & sqlHeaderAttributes(field.Name)
        End If
        table = table & ">"
        If sqlHeaderDecorator is Nothing Then
          table = table & field.Name
        Else
          table = table & sqlHeaderDecorator(field.Name)
        End If
        table = table & "</th>" & chr(13)
      End If
    Next
    table = table & "      </tr></thead>" & chr(13)
'' RecordCount seems not to be supported
'    table = table & "    <tfoot>" & chr(13)
'    table = table & "      (" & rs.RecordCount & " row" &
'     table = table & sqlIf(rs.RecordCount = 1, "row", "rows") & ")"
'    table = table & "    </tfoot>" & chr(13)

    ' save place to put total rows in footer
    prefooter = table
    table = ""

    table = table & "    <tbody>" & chr(13)
    Dim count: count = 0
    If sqlPaging And (rs.CursorLocation = 3) And rs.RecordCount > 0 Then
      rs.AbsolutePage = sqlIf(sqlPage > 0 And sqlPage <= rs.PageCount, sqlPage, 1)
    End If
    Do While (Not rs.eof) And ((Not sqlPaging) Or (rs.AbsolutePage = sqlPage))
      count = count + 1
      table = table & "      <tr class='rowmod-" & ((count - 1) Mod RowMod) & "'>" & chr(13)
      table = table & sqlIf(ShowRowNum, "<td class=""row-num"">" & count & "</td>", "")
      For Each field in rs.Fields
        If left(field.name, 1) <> " " Then
          table = table & "        <td" & sqlIf(sqlFieldTypes = True, " rel=""" & field.Type & """", "") & " class=""" & replace(field.Name, " ", "-") & """>" & field & "</td>" & chr(13)
        End If
      Next
      table = table & "      </tr>" & chr(13)
      rs.moveNext
    Loop
    totalcount = totalcount + count
    table = table & "    </tbody>" & chr(13)
    If False And rs.State = 1 Then ' FIXME: disabled for now
      Set rsTryNext = rs.NextRecordSet
      If Not rsTryNext Is Nothing Then Set rs = rsTryNext
    Else
      If sqlDebug = True Then table = table & "State: " & rs.State
      Exit Do
    End If
  Loop
  ' The recordset was passed in; let the caller close it.
  'If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  'Set rs = Nothing
  table = table & "  </table>" & chr(13)
  table = table & "</div>" & chr(13)

  ' put total rows in footer & top-left corner
  If ShowRowNum Then
    precorner = precorner & "(" & totalcount & ")"
  End If
  If ShowRowCount Then
    Dim footer: footer = "    <tfoot><tr><th colspan=""" & colcount & """>" & chr(13) & "      (" & totalcount & " "
    footer = footer & sqlIf(totalcount = 1, "row", "rows") & ")" & chr(13) & "    </th></tr></tfoot>" & chr(13)
    table = precorner & prefooter &  footer & table
  Else
    table = precorner & prefooter & table
  End If

  RowCount = totalcount ' Return rowcount in a global variable
  'sqlDebugWrite table
  rsTable = table
End Function


' Respond with the result set(s) from the query in sqlText as html tables
Sub sqlTableInsert (sqlText)
   rsTableInsert(Sql(sqlText))
End Sub

' Convert an open resultset into html table(s)
Sub rsTableInsert (rs)
  Response.Write(rsTable(rs))
End Sub


' Return one field from the query contained in sqlText
Function SqlValue (sqlText, field)
  If sqlDebug = True Then sqlDebugWrite(field)
  Dim saveOptions: saveOptions = sqlOptions
  sqlOptions = sqlOptions Or 512 'one-row
  SqlValue = Sql(sqlText)(field)
  sqlOptions = saveOptions
End Function


Function SelectOption (id, sqlText)
  Dim selectopts: selectopts = ""
  Dim rs: Dim rsTryNext
  Set rs = Sql(sqlText)
  Dim totalcount: totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value="""">(select an option)</option>"
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    selectopts = selectopts & " <option value=""" & rs("value") & """>" & rs(description) & "</option>" & chr(13)
    rs.MoveNext
  Loop
  selectopts = selectopts & "</select>"
  Set rs = Nothing
  'sqlDebugWrite selectopts
  SelectOption = selectopts
End Function


' Return the string representation of the option list from the rows in sqlText -- with default specified.
Function SelectDefaultedOption (id, sqlText, default)
  Dim selectopts: selectopts = ""
  Dim rs: Set rs = Sql(sqlText)
  Dim rsTryNext
  Dim totalcount: totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value=""Default"">(select an option)</option>"
  'If default = "" and Not rs.eof Then default = rs(value)
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    selectopts = selectopts & " <option value=""" & rs("value") & """"
    If rs("value") = default Then selectopts = selectopts & " selected=""selected"""
    selectopts = selectopts & ">" & rs("description") & "</option>" & chr(13)
    'If (rs is Nothing) or (rs.State = 0) Then Exit Do
    'sqlDebugWrite(rs.BOF & " - " &  rs.EOF & " - " & typename(rs))
    rs.MoveNext
  Loop

  selectopts = selectopts & "</select>"

  'If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  'sqlDebugWrite selectopts
  SelectDefaultedOption = selectopts
End Function


' Return the string representation of the option list from the rows in sqlText
Function SelectOptionFields (id, sqlText)
  Dim selectopts: selectopts = ""
  Dim rs: Set rs = Sql(sqlText)
  Dim rsTryNext
  Dim totalcount: totalcount = 0
  selectopts = selectopts & "<select id=""" & id & """ name=""" & id & """ class=""selectopts"">" & chr(13)
  'selectopts = selectopts & "<option value=""Default"">(select an option)</option>"
  Do While (Not rs is Nothing) And (rs.State <> 0) And Not rs.Eof
    Dim fieldnum: fieldnum = 0
    Dim opt: opt = ""
    Dim field
    For Each field in rs.fields
      opt = opt & sqlIf(fieldnum > 0, " - ", "") & field.value
      fieldnum = fieldnum + 1
    Next
    selectopts = selectopts & " <option value=""" & opt & """>" & opt & "</option>" & chr(13)
    'If (rs is Nothing) or (rs.State = 0) Then Exit Do
    'sqlDebugWrite(rs.BOF, rs.EOF, typename(rs))
    rs.MoveNext
  Loop

  selectopts = selectopts & "</select>"

  'If (Not rs is Nothing) And (rs.State <> 0) Then rs.close
  Set rs = Nothing
  'sqlDebugWrite selectopts
  SelectOptionFields = selectopts
End Function


Sub sqlDebugWrite(text)
  sqlDebugOutput = sqlDebugOutput + text
End Sub

' So as not to conflict with files that include the "iif" function
Function sqlIf(condition, consequent, alternative)
  If condition Then sqlIf = consequent Else sqlIf = alternative
End Function
%>
