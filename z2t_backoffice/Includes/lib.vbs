'''''
' Created: <2012-01-27 Fri nathan>
' Description: A library of ubiquitous functions missing from VB ASP
'

Function iif(test, consequent, alternative)
  If test Then iif = consequent Else iif = alternative
End Function


Function nulledq(string)
  nulledq = iif(string = "", "null", "'" & string & "'")
End Function


Function nulled(string)
  nulled = iif(string = "", "null", string)
End Function


Function ifnull(value, default)
  ifnull = iif(value = "", default, value)
End Function


Sub paginate(rs, page)
  sqlPaging = True
  call rsTableInsert(rs)
  Response.Write(GetHitCountAndPageLinks( _
    "javascript:document.frm.page.value = '", _
    rs.RecordCount, _
    rs.PageSize, _
    rs.PageCount, _
    page - 1, _
    "'.replace('?page=', ''); document.frm.submit(); void(0);"))
End Sub


