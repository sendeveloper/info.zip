<script type="text/vbscript" language="vbscript" runat="server">

  '''''
  ' Created: <2012-01-27 Fri nathan>
  ' Description: A library of ubiquitous functions missing from VB ASP
  '

  Dim crlf
  crlf = chr(13) & chr(10)

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
</script>

