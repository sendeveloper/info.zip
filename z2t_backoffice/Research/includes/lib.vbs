' Return -consequent- when -condition- is true; otherwise return -alternative-.
'   Both get evaluated though -- what do you want from vbscript?
'
'  Example: Dim bigger: bigger = iif(x >= y, x, y)
Function iif(condition, consequent, alternative)
  If (condition = True) Then iif = consequent Else iif = alternative
End Function

' Zip two arrays together into a recordset
'
'  Example: ' Give me this data: ((first, 1), (second, 2), (third, 3))
'    Dim pairs: pairs = zip(Split("first second third", " "), Split("1,2,3", ","))
Function zip(name1, name2, array1, array2)
  Dim rs: Set rs = Server.CreateObject("ADODB.Recordset")
  rs.CursorLocation = 3
  rs.Fields.Append name1, 12 'adVariant
    rs.Fields.Append name2, 12 'adVariant
    rs.Open
    For index = 0 to min(Ubound(array1), Ubound(array2))
      rs.AddNew
      rs(0) = array1(index)
      rs(1) = array2(index)
    Next
    rs.MoveFirst
  Set zip = rs
End Function

Function js(rs)
  Dim json: json = "[{"""
  rs.MoveFirst
  Do While Not rs.eof
    For Each field in rs.Fields
      json = json & field.Name & """: """ & field.Value & """, """
    Next
    json = Left(json, Len(json) - 3) + "}, {"""
    rs.MoveNext
  Loop
  json = Left(json, Len(json) - 4) & "]"
  js = json
End Function


' Return the minimum of two numbers
Function min(a, b)
  min = iif(a <= b, a, b)
End Function


Function iif(condition, consequent, alternative)
  If condition Then iif = consequent Else iif = alternative
End Function
