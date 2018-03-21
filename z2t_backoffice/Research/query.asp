<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="z2t_Backoffice/includes/sql.asp"-->
<!--#include virtual="z2t_Backoffice/includes/lib.asp"-->

<script type="text/javascript" language="javascript" runat="server">
  //var sqlConn = Server.CreateObject("ADODB.Connection");
  //sqlConn.Open("Driver=SQL Server;server=dallas01.HarvestAmerican.net;uid=davewj2o;pwd=get2it;database=util");

  // Return the result sets from the query in sqlText
  function sql(sqlText) {
    var rs = Server.CreateObject("ADODB.RecordSet");
    rs.Open(sqlText, connBackoffice, 2, 3);
    return rs;}

  var rs;
  rs = sql(Request("sql"));
  Response.Write(">> Query << <hr>");
/*
  while (!rs.eof) {
    Response.Write(rs("Description") + "<br>");
    rs.MoveNext();}
*/
</script>
