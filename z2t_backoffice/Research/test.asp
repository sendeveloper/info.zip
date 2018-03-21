<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<!--#include file="../../z2t_BackOffice/includes/sql.asp"-->
<!--#include file="../../z2t_Backoffice/includes/lib.asp"-->

<!DOCTYPE html>
<html>
  <head>
    <title>SQL Repl</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <script type="text/javascript" language="javascript">
      function get(id) {
        return document.getElementById(id);}

      function evaluate(sql) {
        get("history").disabled = false;
        get("history").innerHTML = get("sql").value;
        get("history").value = "hello";
        get("history").disabled = true;

        get("sql").value = get("sql").value.replace("\n", "<br>")

        return true;}
    </script>
    <style>
      textarea.read {width: 100%; height: auto;}
      textarea.history {width: 100%; height: auto;}
    </style>
  </head>

  <body>
    <h1>SQL Repl</h1>
    <form id="repl" name="repl" method="post" action=""> <!-- javascript:window.location='test.asp?history=' + get('history').value + '\n\n' + get('sql').value + ('// => ' + get('history').value).replace('\n', '\n//    ') + '&sql=' + get('sql').value + '&results=' + get('results').value; void(0); -->
      <label for="history" class="history">History:</label>
      <textarea id="history" name="history" class="history" disabled="disabled"><%=Request("history")%></textarea><hr>
      <label for="sql" class="read">SQL:</label>
      <textarea id="sql" name="sql" class="read"><%=Request("sql")%></textarea>
      <input type="submit" value="eval" onclick="evaluate"></input><hr>
      <label for="results" class="print">Results:</label>
      <div id="results" name="results" class="print">
<%
  If 1=1 and Request("sql") <> "" Then
%>
        <%=Request("sql")%>
        <!--%=SqlTable(Request("sql"))%-->
<%
  Else
%>
        <%=Replace(Request("sql"), char(13) & chr(10), "<br>")%>
<%
  End If
%>
      </div>
    </form>
  </body>
</html>
