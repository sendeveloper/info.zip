<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->

<%  
  PageHeading = "Tax Table Differences"
  ColorTab = 3

  ''''' These must be set after sql.asp is included.
  RowMod = 3            ' Colorize every third row.
  ShowRowCount = True   ' Show total number of states
  sqlConnectionString = "Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=z2t_TableDifferences;uid=davewj2o;pwd=get2it;"
  sqlTimeout = 65535
  sqlDebug = False
  Server.ScriptTimeout = 65535
  sqlTimeout = 0
  '''''
%>

<!DOCTYPE html>
<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice-sensible.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  <script type="text/javascript" src="<%=strPathIncludes%>lib.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>dates/ts_picker.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>
  <style>
    em {font-style: italic;}

    .center {display: inline-block; width: auto; text-align: center; margin-left: auto; margin-right: auto;}
    div.vcentering {display: table;}
    .article {display: block; min-width: 85%; max-width: 100%;}
    .divDeskTop {height: 0.7em; text-align: center; background-size: 100% 100%; margin-top: 0em; padding: 0.1px;}
    .divDeskMiddle {height: auto; width: auto; background-size: 100% 100%; padding: 0.1px;}
    .divDeskBottom {height: 0.7em; background-size: 100% 100%; margin-bottom: 2em; padding: 0.1px;}
    .resultset {width: auto; margin: 1.5em; empty-cells: show; border-collapse: collapse; background-color: white;}
    .resultset th {color: black; font-weight: bold; padding-right: 1.5em; text-align: left;}
    .resultset thead tr:first-child {border-bottom: 1px solid black;}
    .resultset td {font-size: 2em;}
    .resultset tfoot {margin-top: 1em;}

    .h2 {font-size: 14pt; font-weight: bold; color: black; line-height: 150%; margin: 0em; margin-left: 2em;}
    .footer {display: inline-block; width: auto;}
    .footer .box {border: 1px solid black; width: 350px; height: auto; margin-left: auto; margin-right: auto;}
    
    body {
    text-align: left; 
/*    width: auto !important; */
    width: 1050px;
    margin-top: 0;
    margin-right: auto;
    margin-bottom: 0;
    margin-left: auto;
    color: #000000;
    background: black url(../images/background.jpg) no-repeat center top fixed !important;
    background-size: 100% 100% !important;
/*    min-width: 0px !important;    Make sure the background isn't cropped when you scroll right */
/*    max-width: auto !important; */
        }

    div.top {text-align: left;}
    form {background-color: #c0c0c0; margin: 1em; display: inline-block;}
    fieldset {margin: .5em; white-space: nowrap; text-align: left;}
    fieldset label {text-align: right; width: 8em; margin-left: auto; margin-right: 2em; display: inline-block;}
    input, select {display: inline-block; margin-right: 1.5em; text-align: left; width: 10em; margin-right: auto; margin-left: 0em;}
    input, input.field {width: 18em;}
    select {width: 18em;}
    select.yesno {width: 4em;}
    input.number {text-align: right; width: 5em;}
    input.date {width: 8em;}
    input.button {width: auto; margin: 1em;}
    #compare {margin-left: 15em;}
    option.disabled {opacity: 20; color: #c0c0c0}
    button.disabled {opacity: 20; color: #c0c0c0; background-color: #808080; border-color: #404040;}
    span.message-area {margin-left: 2em; display: inline-block;}
    span.message {}
    span.error {font-weight: bold; color:darkred;}
    div.status-message {text-align: center; margin: 2em; font-size: 2em;}
    span.sticky-message {display: block;}
    span.sticky-message > label:after {content: ":"; display: inline-block;}
    span.sticky-message > sticky-message-text {display: inline-block;}

    div.date {display: inline-block; vertical-align: top; margin: 1em;}
    div.date span#current-date {font-size: 2em;}

    div.summary {margin-left: 2em;}
    div.summary-results {text-align: left; padding: .1px; display: table-cell;}
    div.summary.stale {opacity: 0.3;}
    div.legend {text-align: center; margin-left: 3em; padding: .1px; display: table-cell; width: auto; vertical-align: middle;}
    span#dir1 {color: green; font-weight: bold; font-size: 2em; margin-bottom: 1em; display: block;}
    span#dir2 {color: darkred; font-weight: bold; font-size: 2em; margin-top: 1em; display: block;}

    .state {width: 1em;}
    .adds {width: 5em;}
    .dels {width: 5em;}
    .changes {width: 5em;}
    .notes {width: auto;}
  </style>

  <script type="text/javascript" language="javascript">
    var log = [];


    function err(string) {
      alert(string);
      var date = new Date();
      var logarea = get("#log");

      log.push([date, string]);
      if (message) {message(node("span", ["class","error"], text(string)));}
      if (logarea) {logarea.appendChild(
        node("span", ["class","log-entry"],
          node("span", ["class","log-date"], date),
          node("span", ["class","log-message"], string)));}
      return;}


    function stickymessage(title, message) {
      get("#message-area").parentNode.appendChild(
        node("span", ["class","sticky-message"],
          node("label", ["for",title], text(title)),
          node("span", ["class","sticky-message-text", "id",title], text(message))));
      return message;}


    // display a message, optionally appending
    function message(string, append) {
      var messages = get("#message-area");
      if (!append) {
        messages.childNodes.forEach(function(e){
          messages.removeChild(e);});}
      messages.appendChild((string.constructor === String) ? text(string) : string);
      return string;}


    function updateSelectOptions(target) {
      try {
      var ajax = new XMLHttpRequest();
      ajax.open("POST", "query.asp", true);
      ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      ajax.onreadystatechange = function() {
        switch (ajax.readyState) {
          case 0, 1, 2, 3:
            break;
          case 4:
            switch (ajax.status) {
              case 404:
                message("<em>Page not found</em>");
                break;
              case 200:
                message(ajax.responseText);
                break;
              default:
                message("<em>Status " + ajax.status + "</em><hr>" + ajax.responseText);
                break;}
            break;
          default:
            break;}
        return;}
      ajax.send(
        "sql=" + encodeURIComponent("select Description from z2t_BackOffice.dbo.z2t_Types where class='States'") + 
        "&new=" + get("#new").value + 
        "&newdate=" + get("#newdate").value + 
        "&old=" + get("#old").value + 
        "&format=" + get("#format").value + 
        "&taxtype=" + get("#taxtype").value + 
        "&state=" + get("#state").value + 
        "&persist=" + get("#persist").value + 
        "&overwrite=" + get("#overwrite").value +
        "&last-compare=" + Request("last-compare"));
      return;
      } catch(error) {err(error.toString());}}


    function filename(path) {
      var pathparts = path.split("\\");
      return pathparts[pathparts.length - 1] + " (" + pathparts[pathparts.length - 4] + ")";}


    function update(event) { // this should be an event
      if (loaded) {
        if (event.target.value != event.target.oldvalue){
          stickymessage(event.target.id + "-changed", event.target.oldvalue + " -> " + event.target.value);
          get("#summary").className += " stale";}
        message(node("span", ["class","message"], text("Updating option lists...", true)));
        //message(entity("hellip", true));
        get("#compare").disabled = true;
        get("#compare").className += " disabled";
        get("#compare").style.opacity = "0.5";}
      else {
        formdata.forEach(function(e){e.oldvalue = e.value;});}

      // Canada has no state tables 
      get("#state").disabled = get("#format").value == "Canada";
      //get("#state").style.visibility = get("#format").value == "Canada" ? "hidden" : "visible";

/*
      // ajax update select option lists
      updateSelectOptions(event.target);
*/
     if (loaded) {
      window.location = "z2t_TableDiff.asp" +
        "?new=" + get("#new").value + 
        "&newdate=" + get("#newdate").value + 
        "&old=" + get("#old").value + 
        "&olddate=" + get("#olddate").value + 
        "&format=" + get("#format").value + 
        "&taxtype=" + get("#taxtype").value + 
        "&state=" + get("#state").value + 
        "&persist=" + get("#persist").value + 
        "&overwrite=" + get("#overwrite").value + 
        "&last-compare=" + "<%=Request("last-compare")%>";}
      loaded = true;
      return true;}


    function px(size) {
      return size.toString() + "px";}


    function validate(event){
      try {
        var form = get("#form");
        get("#last-compare").value = "compare";
        get("#summary").style.width = px(get("#summary").clientWidth);
        get("#summary").style.height = px(get("#summary").clientHeight);
        return (
         (get("#new").value != null) && (get("#new").value != "") && 
         (get("#old").value != null) && (get("#old").value != "") && 
         (get("#format").value != null) && (get("#format").value != ""))
         ? ( 
         (get("#summary").innerHTML = "<div class=\"status-message\">Comparing Tables&hellip;</div>"),
         (get("#summary").style.visibility = "visible"),
         (get("#summary").style.opacity = "1.0"),
         form.submit(),
         true)
         : (
         err("Tables and format must be specified."), false);
      } catch(error) {alert(error); return false;}}

    // ancillary
    function showIds() {
      var message = "<br>";
      get("*").forEach(function(e){return e.id + "<br>";}).filter(function(e){return e != "<br>";}).sort().forEach(function(e){message += e;});
      stickymessage("ids", message);
      return;}

    var loaded = false; // prevent perpetual reload until ajax is finished
    var formdata;

    function init(event){
      try {
        // identify relevant form inputs
        formdata = ["#new", "#newdate", "#old", "#olddate", "#format", "#taxtype", "#state", "#persist", "#overwrite"].forEach(function (e){return get(e);});

        // process posted 
        update.call(event, event);

        var stupidjs;
        stupidjs = get("#dir1"); if (stupidjs) stupidjs.innerHTML = filename(get("#new").value);
        stupidjs = get("#dir2"); if (stupidjs) stupidjs.innerHTML = filename(get("#old").value);

        // register events
        listen(get("#compare"), "click", validate);
        //formdata.forEach(function(e){
        //  listen(e, "DOMAttrModified", update);});
        formdata.forEach(function(e){
          listen(e, "change", update);});
        get(".sticky-message").forEach(function(elt){
          listen(elt, "dblclick", function(e){
            elt.parentNode.removeChild(elt);}, true)});
        return false;
      } catch(error) {alert(error); return false;}
      return false;}

    var img1; // track down undeclared usage -- droptabmenu suspected
    var img2; // track down undeclared usage -- droptabmenu suspected
    listen(window, "load", init);
  </script>
</head>

<body>
  <!--#include virtual="z2t_Backoffice/includes/heading-sensible.inc"-->

  <div class="article">
    <div class="divDeskTop"></div><!-- divDeskTop -->
    <div class="divDeskMiddle">
      <div class="top">
        <form id="form" name="form" method="post" action="http://info.zip2tax.com/z2t_Backoffice/Research/z2t_TableDiff.asp"> <!-- "javascript:void(0);" -->
          <fieldset id="parameters" name="parameters">
<%
  Dim rs
%>
            
            <legend>Tables to be compared: </legend>

            <label for="new">New Table: </label>
            <select id="new" name="new">
<%
  'Response.Write("exec z2t_TableDifferences.dbo.z2t_Research_ProductTables @tabledate = " & nulledq(Request("newdate")) & ", @state = " & nulledq(Request("state")) & ", @format = " & nulledq(Request("format")) & ", @taxtype = " & nulledq(Request("taxtype"))): Response.End
  Set rs = Sql("exec z2t_TableDifferences.dbo.z2t_Research_ProductTables @tabledate = " & nulledq(Request("newdate")) & ", @state = " & nulledq(Request("state")) & ", @format = " & nulledq(Request("format")) & ", @taxtype = " & nulledq(Request("taxtype")))
  Do While Not rs.eof
%>
              <option value="<%=rs("table")%>"<%=iif(rs("table") = Request("new"), " selected=""selected""", "")%>><%=meaningful(rs("table"))%></option>
<%
    rs.MoveNext
  Loop
%>
            </select>
            <label for="newdate">New Date: </label>
            <input id="newdate" name="newdate" value="<%=Request("newdate")%>"></input>
            <a href="javascript:show_calendar('document.form.newdate', document.form.newdate.value); void(0);"><img style="vertical-align: middle;" src="http://info.zip2tax.com/z2t_Backoffice/includes/dates/cal.gif" alt="select date"></img></a><br>
            
            <label for="old">Old Table: </label>
            <select id="old" name="old">
<%
  Set rs = Sql("exec z2t_TableDifferences.dbo.z2t_Research_ProductTables @tabledate = " & nulledq(Request("olddate")) & ", @state = " & nulledq(Request("state")) & ", @format = " & nulledq(Request("format")) & ", @taxtype = " & nulled(Request("taxtype")))
  Do While Not rs.eof
    pathparts = split(rs("table"), "\")
%>
              <option value="<%=rs("table")%>"<%=iif(rs("table") = Request("old"), " selected=""selected""", "")%>><%=meaningful(rs("table"))%></option>
<%
    rs.MoveNext
  Loop
%>
            </select>
            <label for="olddate">Old Date: </label>
            <input id="olddate" name="olddate" value="<%=Request("olddate")%>"></input>
            <a href="javascript:show_calendar('document.form.olddate', document.form.olddate.value); void(0);"><img style="vertical-align: middle;" src="http://info.zip2tax.com/z2t_Backoffice/includes/dates/cal.gif" alt="select date"></img></a><br>
            
            <label for="format">Format: </label>
            <select id="format" name="format">
              <option value="">(ALL)</option>
<%
  Set rs = Sql("select format = Description from z2t_BackOffice.dbo.z2t_Types where Class = 'TableFile' and Description not like '%UseTax%' order by Sequence")
  Do While Not rs.eof
%>
              <option value="<%=rs("format")%>"<%=iif(rs("format") = Request("format"), " selected=""selected""", "")%><%=iif(instr("Basic Magento Sedona UniqueZips Ultracart Volusion Evolution Canada", rs("format")) > 0, "disabled=""disabled"" class=""disabled""", "")%>><%=rs("format")%></option>
<%
    rs.MoveNext
  Loop
%>
            </select>
            <label for="taxtype">Tax Type: </label>
            <select id="taxtype" name="taxtype">
              <option value="">(ALL)</option>
<%
  Set rs = Sql("select value, taxtype = Description from z2t_BackOffice.dbo.z2t_Types where Class = 'TaxType' order by Sequence")
  Do While Not rs.eof
%>
              <option value="<%=rs("value")%>"<%=iif(rs("value") = Request("taxtype"), " selected=""selected""", "")%><%=iif(instr("Automobile Auto Rental Alcohol", rs("taxtype")) > 0, " disabled=""disabled"" class=""disabled""", "")%>><%=rs("taxtype")%></option>
<%
    rs.MoveNext
  Loop
%>
            </select><br>
            
            <label for="state">State: </label>
            <select id="state" name="state">
              <option value=""<%=iif("" = Request("state"), "selected=""selected""", "")%>>(ALL)</option>
              <option value="US"<%=iif("US" = Request("state"), "selected=""selected""", "")%>>Entire US</option>
<%
  Set rs = Sql("select value, state = Description from z2t_BackOffice.dbo.z2t_Types where Class = 'States' and Value <> '' order by Sequence")
  Do While Not rs.eof
%>
              <option value="<%=rs("value")%>"<%=iif(rs("value") = Request("state"), " selected=""selected""", "")%>><%=rs("state")%></option>
<%
    rs.MoveNext
  Loop
%>
            </select><br>
            
            <label for="persist">Save Differences To: </label>
            <!--input name="persist" value="z2t_TableDifferences.dbo.z2t_ZipCodes_diff_FullBreakout_salestax_US"></input-->
            <input id="persist" name="persist" value="<%=Request("persist")%>" placeholder="(Don't Save)"></input>
            <label for="overwrite">Overwrite? </label>
            <select class="yesno" id="overwrite" name="overwrite">
              <option value="1"<%=iif(1 = Request("overwrite"), " selected=""selected""", "")%>>Yes</option>
              <option value="0"<%=iif(1 <> Request("overwrite"), " selected=""selected""", "")%>>No</option>
            </select><br>

            <button id="compare" name="compare" class="button" type="button">Compare</button>
            <span id="message-area"></span>
            <label id="test" for="compare"></label>

            <input id="last-compare-date" name="last-compare-date" type="hidden" value="<%=SqlValue("select create_date from z2t_TableDifferences.sys.tables where name='temp_web_709473696_summary'", "create_date") %>"></input>
            <input id="last-compare" name="last-compare" type="hidden" value="<%=Request("last-compare")%>"></input>
          </fieldset>
        </form>
        <div class="date">
          <span style="border-bottom: 1px solid black;">Current Date: </span><br>
          <span id="current-date"><%=Now()%></span>
        </div><!-- date -->
      </div><!-- top -->

      <div class="h2">Differences: <%=Request("format") & " " & iif(Request("taxtype") = 2, "Use Tax", "Sales Tax") & " " & Request("state")%></div>
        <div id="summary" class="summary vcentering<%=iif(Request("last-compare") <> "", "", " stale")%>"; visibility: <%=iif(Request("last-compare") <> "", "visible", "visible")%>;">
          <div class="summary-results">
<%
  ' Unless tables have been selected for comparison, don't make the user wait; use a default saved comparison.
  sqlConnectionString = "Provider=SQLOLEDB;Data Source=localhost;Initial Catalog=z2t_TableDifferences;uid=davewj2o;pwd=get2it"
  Dim rsSummary
  If Request("last-compare") = "" Then
    'Response.Write("select [State], [add], del, chg, note from " & iif(Request("persist") = "", "z2t_UpdateRates.dbo.z2t_ZipCodes_diff_FullBreakout_salestax_US_summary", Request("persist")) & " order by [State]"): Response.End
    Set rsSummary = Sql("select [State], [add], del, chg, note from " & iif(Request("persist") = "", "z2t_UpdateRates.dbo.z2t_ZipCodes_diff_FullBreakout_salestax_US_summary", Request("persist")) & " order by [State]")
  ElseIf Request("last-compare") <> "compare" Then
    'Response.Write("select [State], [add], del, chg, note from " & iif(Request("persist") = "", Request("last-compare"), Request("persist")) & " order by [State]"): Response.End
    Set rsSummary = Sql("select [State], [add], del, chg, note from " & iif(Request("persist") = "", Request("last-compare"), Request("persist")) & " order by [State]")
  Else
    'Response.Write("exec z2t_TableDifferences.dbo.z2t_ZipCodes_diff " &_
    '    "@newtable = " & nulledq(Request("new")) & ", " &_
    '    "@oldtable = " & nulledq(Request("old")) & ", " &_
    '    "@format = '" & Request("format") & "', " &_
    '    "@taxtype = " & Request("taxtype") & ", " &_
    '    "@state = " & nulledq(Request("state")) & ", " &_
    '    "@newdate = " & nulledq(Request("newdate")) & ", " &_
    '    "@olddate = " & nulledq(Request("olddate")) & ", " &_
    '    "@persist = " & nulledq(Request("persist")) & ", " &_
    '    "@overwrite = " & 0 & ", " &_
    '    "@summarize = 1, " &_
    '    "@debug = 0")
    Dim sql2Text
    ' If @persist is blank, save the results by session id to avoid delays.

    sql2Text = "exec z2t_TableDifferences.dbo.z2t_ZipCode_diff_timeout " &_
        "@newtable = " & nulledq(Request("new")) & ", " &_
        "@oldtable = " & nulledq(Request("old")) & ", " &_
        "@format = '" & Request("format") & "', " &_
        "@taxtype = " & Request("taxtype") & ", " &_
        "@state = " & nulledq(Request("state")) & ", " &_
        "@newdate = " & nulledq(Request("newdate")) & ", " &_
        "@olddate = " & nulledq(Request("olddate")) & ", " &_
        "@persist = " & nulledq(Request("persist")) & ", " &_
        "@overwrite = " & nulled(Request("overwrite")) & ", " &_
        "@summarize = '', " &_
        "@debug = 0"
    'Response.Write("<textarea>" & sql2Text & "</textarea>"): Response.End
    'Set rsSummary = Sql(replace(sql2Text, "'", "''"))
    Set rsSummary = Sql(sql2Text)
  End If
%>
          <%=ListContents(rsSummary, "State")%>
          </div><!-- summary-results -->
          <div class="legend">
            <span id="dir1"></span><br>-vs-<br><span id="dir2"></span></div><!-- legend -->
        </div><!-- summary -->
    </div><!-- divDeskMiddle -->
    <div class="divDeskBottom"></div><!-- divDeskBottom -->
  </div><!-- article -->
</body>
</html>

<% 
' Given item, name, children, 

Function ListContents(rsSummary, name)
   Dim table
   Dim prefoot
   Dim current
   Dim rowcount
   Dim colcount
   Dim href

   table = "<table class=""resultset"">"
   colcount = 0
   For Each field in rsSummary.fields 
     If field.name <> "id" Then
       table = table & "<col class=""" & field.name & """/>"
       colcount = colcount + 1
     End If
   Next
   table = table & "<thead><tr>"
   For Each field in rsSummary.fields 
     If field.name <> "id" Then
       table = table & "<th>" & field.name & "</th>"
     End If
   Next
   table = table & "</tr></thead>"
   prefoot = table
   table = "<tbody>"
   rowcount = 0
   Do While Not rsSummary.eof
     current = rsSummary(name)
     table = table & "<tr>"
     For Each field in rsSummary.fields 
       If field.name <> "id" Then
         Dim link
         link = ((field.name = "add") Or (field.name = "del") Or (field.name = "chg"))
         href = "openPopUp('z2t_TableDiff_details.asp?newtable=' + document.form.new.value + '&oldtable=' + document.form.old.value + '&state=" & rsSummary(name) & "&type=" & field.name & "&load=fast');;"
         'If link Then link = (field.Value > 0) ' for debugging, leave the links
         table = table &_
         "<td>" &_ 
         iif(link, "<a href=""#""" &_
                       "onclick=""" & href & """>", "") &_
           "<span class=""" & field.Name & """>" & field.Value & "</span>" & _
         iif(link, "</a>", "") &_
         "</td>"
       End If
     Next
     rowcount = rowcount + 1
     rsSummary.MoveNext
   Loop
   table = table & "</tbody></table>"
   table = prefoot & "<tfoot><tr><th colspan=""" & colcount & """>&nbsp;</th></tr><tr><th colspan=""" & colcount & """>" & rowcount & " state" & iif(colcount <> 1, "s", "") & " changed</th></tr></tfoot>" & table
   ListContents = table
End Function


Function meaningful(table)
  Dim pathparts
  pathparts = split(table, "\")
  meaningful = pathparts(ubound(pathparts)) & " (" & pathparts(ubound(pathparts) - 3) & ")"
End Function

%>
