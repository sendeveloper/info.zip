<% Option Explicit %>
<!--#include file="includes/lib.asp"-->
<!--#include file="includes/sql.asp"-->
<%
Function sqlify(text)
  sqlify = Replace(text, "'", "''")
End Function

'GetRef wrapper also supporting object methods and arguments
Dim gensym: gensym = 0
Dim fnMemo: Set fnMemo = Server.CreateObject("Scripting.Dictionary")
Function GetFn(procedure)                   
  gensym = gensym + 1
  ExecuteGlobal "Function GetFn" & gensym & "(parameter): GetFn" & gensym & " = " & Replace(procedure, "CDec", "Cdbl") & "(parameter): End Function"
  Dim reference
  If fnMemo.Exists(procedure) Then
     Set reference = fnMemo.item(procedure)
  Else
    Set reference = GetRef("GetFn" & gensym)
    Call fnMemo.Add(procedure, reference)
  End If
  Set GetFn = reference
End Function


'FIXME: Types 1, 9, 12, 13, 
Dim sqlFieldTypeFunctions: Set sqlFieldTypeFunctions = Server.CreateObject("Scripting.Dictionary")
Dim sqlFieldTypeFunctionNames: sqlFieldTypeFunctionNames = Array( _
  GetFn("GiveMeNothing"), GetFn("CInt"), GetFn("CLng"), GetFn("CSng"), GetFn("CDbl"), GetFn("CDec"), GetFn("CDate"), GetFn("CStr"), GetFn("Error"), GetFn("CInt"), GetFn("CBool"),  _
  GetFn("Error"), GetFn("Error"), GetFn("CDec"), GetFn("CByte"), GetFn("CByte"), GetFn("CInt"), GetFn("CLng"), GetFn("CDec"), GetFn("CDec"),  _
  GetFn("CDate"), GetFn("CStr"), GetFn("CStr"), GetFn("CStr"), GetFn("CStr"), GetFn("CDec"), GetFn("Cobj"), GetFn("CDate"), GetFn("CDate"), GetFn("CDate"), GetFn("CLng"), GetFn("CObj"), _
  GetFn("CDbl"), GetFn("CStr"),  GetFn("CStr"), GetFn("CStr"), GetFn("CStr"), GetFn("CStr"), GetFn("CObj"))
Dim sqlFieldTypeNumbers: sqlFieldTypeNumbers = Array(_
   "0", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", _
   "12", "13", "14", "16", "17", "18", "19", "20", "21", _
   "64", "72", "128", "129", "130", "131", "132", "133", "134", "135", "136", "138", "139", _
   "200", "201", "202", "203", "204", "205", "8192")
Dim sqlFieldTypeNames: sqlFieldTypeNames = Array(_
   "adEmpty", "adSmallInt", "adInteger", "adSingle", "adDouble", "adCurrency", "adDate", "adBSTR", "adIDispatch", "adError", "adBoolean", _
   "adVariant", "adIUnknown", "adDecimal", "adTinyInt", "adUnsignedTinyInt", "adUnsignedSmallInt", "adUnsignedInt", "adBigInt", "adUnsignedBigInt", _
   "adFileTime", "adGUID", "adBinary", "adChar", "adWChar", "adNumeric", "adUserDefined", "adDBDate", "adDBTime", "adDBTimeStamp", "adChapter", "adPropVariant", "adVarNumeric", _
   "adVarChar", "adLongVarChar", "adVarWChar", "adLongVarWChar", "adVarBinary", "adLongVarBinary", "AdArray")
Dim index
For index = 0 to UBound(sqlFieldTypeFunctionNames)
   Call sqlFieldTypeFunctions.Add(sqlFieldTypeNumbers(index), sqlFieldTypeFunctionNames(index))
Next


Function GiveMeNothing()
  GiveMeNothing = Nothing
End Function


Function Error()
  Response.Write("This type is not supported by ADO.")
  Response.End
  Error = Nothing
End Function


' Act as appropriate for Request("command")
Function Dispatch()
  sqlConnectionString = "Driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_Canada" 'philly05

  Dim sqlText   
  Select Case Request("command")
  Case "save"
   Dim fn: Set fn = sqlFieldTypeFunctions.Item(Cstr(Request("type")))
   If IsEmpty(fn) Then Response.Write("Unknown data type: " & Request("type")): Response.End()
   Dim quote: quote = iif(fn is sqlFieldTypeFunctions.Item("8"), "'", "")
   sqlText = "update t " &_
             "  set " & Request("field") & " = " & quote & sqlify(sqlFieldTypeFunctions.Item(CStr(Request("type")))(Request("value")))& quote & " " &_
             "from " & sqlify(Request("table")) & " as t " &_
             "where " & sqlify(Request("where")} & " " &_
             iif(Request("orderby") = "", "", "order by " & sqlify(Request("orderby")))
   'Response.Write(sqlText)
   'Response.Write(SqlTable(sqlText))
   Call Sql(sqlText)


  Case Else
    Response.Write("Unknow request: " & Request.Form)
    Response.Write(Split(Request.Form, "&")(0))
    For Each PairString In Split(Request.Form, "&")
      Dim pair: pair = Split(PairString, "=")
      Response.Write(pair(0) & ": " & pair(1))
    Next
  End Select
End Function


Call Dispatch()
%>

