<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->

<%  
  PageHeading = "Tax Table Differences - Details"

  ''''' These must be set after sql.asp is included.
  RowMod = 3             ' Colorize every third row.
  ShowRowNum = True      ' Show row numbers.
  ShowRowCount = False   ' Don't show row count in table footer.
  Server.ScriptTimeout=65535
  sqlTimeout = 0
  'sqlDebug = True
  '''''
%>

<!DOCTYPE html>
<html>
  <head>
    <title>Zip2Tax.info - <%=PageHeading%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <!-- script type="text/javascript" src="<%=strPathIncludes%>lib.js" language="javascript"></script -->
    <script type="text/javascript" language="javascript">
      function px(pixels) {
        return parseFloat(pixels).toString() + "px";}

      function message(string) {
        document.getElementById("debug").innerHTML = string;
        document.getElementById("debug").style.height="auto";
        document.getElementById("debug").style.width="auto";}


      function setActiveStylesheet(title) {
        var i, a, main;
        for(i=0; (a = document.getElementsByTagName("link") [i]); i++) {
        if(a.getAttribute("rel").indexOf("style") != -1
           && a.getAttribute("title")) {
          a.disabled = true;
          if(a.getAttribute("title") == title) a.disabled = false;}}}

      function init() {
        var status = document.getElementById("status");
        status.style.zIndex = 2;
        message(px((document.getElementsByTagName("body")[0].clientWidth - status.clientWidth) / 2));
        status.style.left = px((document.getElementsByTagName("body")[0].clientWidth - status.clientWidth) / 2);
        //window.resizeTo(Math.min(document.body.clientWidth * 8, screen.width), Math.min(document.body.clientHeight, screen.height));
        //window.moveTo(400, 0);
<%
  Dim vars
  vars = ""
  Dim var
  For Each var In Session.Contents
   vars = vars & "<span class=\""label\"">" & var & ": " & "</span><span class=\""value\"">" & Session(var) & "</span><br>"
  Next
%>
      message("<%=vars%>")}
      
      window.onload = init;

      // Any errors will prevent init from running, so set the popup dimensions here.
      window.resizeTo(Math.min(800, screen.width), Math.min(900, screen.height));
      window.moveTo(300, 50);
    </script>

    <style media="print">
      .noprint {display: none;}
      button {display: none;}
    </style>
    <style>
      div.status-message {text-align: center; margin: 2em; font-size: 2em;}

      * {z-index: 1}
      div.status {position: absolute; z-index: -1; top: 0em; width: auto; text-align: center; margin-top: 1em; display: none;}
      div.center {position: relative; width: auto; margin-right: auto; margin-left: auto; z-index: 2;}
      div.status-text {width: auto; margin-left: auto; margin-right: auto; text-align: center; background-color: white; border: 1px solid black; font-size: 2em; z-index: 2; /* opacity: .75; */}
      hr.progress {width: 1%; text-decoration: blink;}
      span.debug {font-size: .5em; height: 1em; text-align: left; display: <%=iif(Session("z2t_UserName") = "nathan", "block", "none")%>}

      span.label {margin-left: auto; margin-right: 1em; text-align: right; width: 8em; overflow: hidden; display: inline-block;}
      span.value {margin-left: 0em; margin-right: auto; text-align: left; width: 8em; overflow: hidden; display: inline-block;}
      
      table.resultset {margin-left: auto; margin-right: auto; empty-cells: show; border-collapse: collapse; border-bottom: 1px solid black}
      table.resultset th {border-bottom: 1px solid black;}
      table.resultset th, table.resultset td {text-align: left; padding-left: .5em; padding-right: 1.5em;}
      table.resultset tr.rowmod-0 {background-color: lightcyan;}
      table.resultset td {color: <%=iif(Request("type") = "add", "green", iif(Request("type") = "del", "red", "black"))%>;}
      
      .new {color: green;}
      .old {color: red;}

      td .what {margin-left: auto; margin-right: auto; display: block; text-align: center; line-height: 110%; font-size: 75%; display: block;}
      td .old {margin-right: .5em; display: inline-block; text-decoration: line-through; line-height: 110%; font-size: 75%; display: inline-block;}
      td .new {margin-left: .5em; display: inline-block; font-weight: bold; line-height: 100%; font-size: 75%; display: inline-block;}

      col.rowcount {border-right: 1px solid black;}
      td.rowcount {background-color: lightgrey; text-align: right;}

      button.close {margin-top: 2em; display: inline-block; text-align: center;}
      button.close.top {margin-top: 2em; display: inline-block; position: absolute; top: 1em; right: 1em;}
      /*
      div.print {margin-top: 2em; display: inline-block; left: 2em; position: absolute;}
      div.print button {display: block; width: 100%; margin-bottom: 0.25em;}
      div.print.top {margin-top: 2em; display: inline-block; position: absolute; top: 1em; left: 1em;}
      */
      .print {display: none;}

      body {text-align: center;}
    </style>
  </head>
  
  <body>
    <button class="button close top" onclick="window.close();">Close</button> <!-- keep this first in case of errors -->
    <div class="print top">
        <button class="button" onclick="window.print();">Print</button>
        <button class="button" onclick="window.print();">Preview</button>
    </div><!-- print top -->
    <h1>Tax Table Difference - Details<br><%=Now%><br><%=Request("state")%> - <%=Request("type")%></h1>
    <h2><span class="new"><%=meaningful(Request("newtable"))%></span><br>-vs-<br><span class="old"><%=meaningful(Request("oldtable"))%></span></h2>
    <hr>
<%
  If Request("load") = "fast" Then
   Response.Write("<div class=""status-message"">Comparing Tables&hellip;</div>")
  Else
    Dim sql2Text: sql2Text = "z2t_Zipcode_diff_details " &_
             "@type = "  & nulledq(Request("type")) & ", " &_
             "@newtable = " & nulledq(Request("newtable")) & ", " &_
             "@oldtable = " & nulledq(Request("oldtable")) & ", " &_
             "@format = " & nulledq(Request("format")) & ", " &_
             "@taxtype = " & nulled(Request("taxtype")) & ", " &_
             "@state = " & nulledq(Request("state")) & ", " &_
             "@newdate = " & nulledq(Request("newdate")) & ", " &_
             "@olddate = " & nulledq(Request("olddate")) & ", " &_
             "@persist = " & nulledq(Request("persist")) & ", " &_
             "@overwrite = 0, " &_ 
             "@summarize = null, " &_
             "@debug = 0"

    'Response.Write("<textarea>" & sql2Text & "</textarea>")
    sqlConnectionString = "Provider=SQLOLEDB;Server=philly04.harvestamerican.net,8443;Initial Catalog=z2t_TableDifferences;uid=davewj2o;pwd=get2it;"  
    Call SqlTableInsert(sql2Text)
  End If
%>

    <button class="button close" onclick="window.close();">Close</button>
    <div class="print">
        <button class="button print" onclick="window.print();">Print</button>
        <button class="button print" onclick="setActiveStylesheet('print');">Preview</button>
    </div><!-- print -->

    <div id="status" class="status">
      <div class="center">
        <div class="status-text" onclick="this.style.visibility='hidden'">
          Loading&hellip;
          <hr class="progress">
          <span id="debug" class="debug"></span>
        </div>
      </div>
    </div><!-- status -->
<%
  If Request("load") = "fast" Then
%>
    <script type="text/javascript" language="javascript">
      window.location = window.location.toString().replace("&load=fast", "");
    </script>
<%
  End If
%>
  </body>
</html>

<%
' Add enough of the path to make files from the same month meaningful to the (human) viewer.
Function meaningful(table)
  Dim pathparts: pathparts = split(table, "\")
  meaningful = pathparts(ubound(pathparts)) & " (" & pathparts(ubound(pathparts) - 3) & ")"
End Function

%>


