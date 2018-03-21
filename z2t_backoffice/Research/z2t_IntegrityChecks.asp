<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->

<%


   PageHeading = "Tax Data Integrity Check"
   ColorTab = 3
   'sqlDebug = True
   'sqlConnectionString = "Driver=SQL Server;server=philly04.harvestamerican.net,8443;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates"
   sqlConnectionString = "Driver=SQL Server;server=philly05.harvestamerican.net,8543;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates"
%>


<%
   sqlText = "exec z2t_UpdateRates.dbo.z2t_UpdateRates_IntegrityCheck "
   Select Case Request("action")
   Case "status"
     Set rs = Sql(sqlText & "@action = '" & Request("action") & "', @stage = '" & Request("stage") & "'")
     If rs("status") = 0 Then
       Response.Write("Passed")
     Else
       Response.Write("Failed")
     End If
     Dim fn: Set fn = GetRef("print")
     'Dim ignore: ignore = maprows( _
     '  fn, _
     '  Sql("select value = '<span style=""color: green; font-weight: bold;"">Passed</span>'"))
     ''Response.Write("Passed? " & ignore & ".")
   Case "alerts"
     Set rs = Sql(sqlText & "@action = '" & Request("action") & "', @stage = '" & Request("stage") & "'")
         Response.Write("<table>")
         Do While Not rs.eof
           Response.Write("<tr>" &_
                            "<td title=""" & rs("description") & """>" & rs("check") & ":</td>" &_
                            "<td style=""padding-left: 2em;"" class=""" & iif(rs("success") = "True", "success", "failed") & """> " & iif(rs("success") = "True", "Success", "Failed") & "</td>" &_
                            "<td><a href=""javascript:details('" & Replace(rs("check"), "'", "\'") & "'); void(0);"" style=""margin-left: 0em; padding-left: 0em;""><img src=""" & strPathIncludes & "help/questionmark.gif"" height=""14px"" width=""10px"" alt=""Details"" title=""Details""</a></td></tr>")
           rs.MoveNext
         Loop
         Response.Write("</table></fieldset>")
   Case "details"
     'Response.Write(sqlText & "@action = '" & Request("action") & "', @stage = '" & Request("stage") & "'")
     SqlTableInsert(sqlText & "@action = '" & Replace(Request("action"), "'", "''") & "', @stage = '" & Replace(Request("stage"), "'", "''") & "'")
   Case Else
%>

<html>
<head>
    <title>Zip2Tax Integrity Check</title>
    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />


    <!--link rel="stylesheet" href="z2t_backoffice.css" type="text/css"-->
    <!--link rel="stylesheet" href="sensible.css" type="text/css"-->
    <!--link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css"-->
    <!--link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" /-->

    <script type="text/javascript" src="<%=strPathIncludes%>lib-dev.js" language="javascript"></script>
    <script type="text/javascript" src="http://www.zip2tax.com/includes/z2t.js" language="javascript"></script>
    <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
    <script type="text/javascript">
      var overallStatus = (function(){
        var taxdataStatus = null;
        var zipcodesStatus = null;
        var taxtablesStatus = null;

        window.doCheck = function doCheck(){
          var status = get("#status");
          status.innerHTML = "";
          //status.childNodes.forEach(function(e){status.removeChild(e);});
          status.appendChild(node("em", [], text("Checking...")));
          taxdataStatus = null;
          zipcodesStatus = null;
          taxtablesStatus = null;
          checkTaxData();
          checkZipCodes();
          /*checkTaxTables();*/}

        return function overallStatus(taxdata, zipcodes, taxtables) {
          if ((typeof(taxdata) != "undefined") && taxdata) {
            taxdataStatus = taxdata;}
          if ((typeof(zipcodes) != "undefined") && zipcodes) {
            zipcodesStatus = zipcodes;}
//          if ((typeof(taxtables) != "undefined") && taxtables) {
//            taxtablesStatus = taxtables;}
          if (taxdataStatus && zipcodesStatus /*&& taxtablesStatus*/) {
            var statusValue = (taxdataStatus == 'Passed') && (zipcodesStatus == 'Passed') /* && (taxtablesStatus == 'Passed') */;
            get("#status").innerHTML = "<span style=\"color: " + (statusValue ? "green" : "red") + "; font-weight: bold;\">" + (statusValue ? "Success" : "Failed") + "</span>";}}})();

      function checkTaxData(){
        var alerts = get("#tax-data-alerts");
        alerts.childNodes.forEach(function(e){if (e && e.tagName && (e.tagName.toLowerCase() != "legend")) {e.parentNode.removeChild(e);}});
        alerts.appendChild(node("em", [], text("Checking...")));
        ajax("<%=strBasePath%>Research/z2t_IntegrityChecks.asp?action=status&stage=taxdata", 
          function(body){
            return body == "Passed";
            //get("#status").innerHTML = body;
            }).get();
        ajax("<%=strBasePath%>Research/z2t_IntegrityChecks.asp?action=alerts&stage=taxdata", 
          function(body){
            get("#tax-data-alerts").childNodes.forEach(function(e){if (e && e.tagName && (e.tagName.toLowerCase() != "legend")) {e.parentNode.removeChild(e);}});
            get("#tax-data-alerts").innerHTML = body;}).get();
            //get("#tax-data-alerts").appendChild(node("fieldset", [], node("legend", [], text(body))));}).get();
            overallStatus('Passed', null);}

      function checkZipCodes(){
        var alerts = get("#zip-codes-alerts");
        alerts.childNodes.forEach(function(e){if (e && e.tagName && (e.tagName.toLowerCase() != "legend")) {e.parentNode.removeChild(e);}});
        alerts.appendChild(node("em", [], text("Checking...")));
        ajax("<%=strBasePath%>Research/z2t_IntegrityChecks.asp?action=status&stage=zipcodes", 
          function(body){
            return body == "Passed";
            //get("#status").innerHTML = body;
            }).get();
        ajax("<%=strBasePath%>Research/z2t_IntegrityChecks.asp?action=alerts&stage=zipcodes", 
          function(body){
            get("#zip-codes-alerts").childNodes.forEach(function(e){if (e && e.tagName && (e.tagName.toLowerCase() != "legend")) {e.parentNode.removeChild(e);}});
            get("#zip-codes-alerts").innerHTML = body;}).get();
            //get("#zip-codes-alerts").appendChild(node("fieldset", [], node("legend", [], text(body))));}).get();
            overallStatus(null, 'Passed');}

      function details(helpId) {
        var win = ajax("<%=strBasePath%>Research/z2t_IntegrityChecks.asp?action=details&stage=" + helpId, function(body){this.result.children[0].children[0].innerHTML = body; this.result.style.visibility = "visible"; return;});
        var titleHelp = ["integrity-checks", "help-add-jurisdiction", "integrity-checks"].indexOf(helpId) >= 0;
        win.result = inlinePopUp(titleHelp ? "Loading..." : helpId,  "position: fixed; top: 4em; left: 5em; border: 1px solid blue; background: lightblue url('<%=strPathIncludes%>help/HelpBackground.jpg') repeat scroll left top; color: black; width: 20em; height: 20em; padding: 0em; font-size: 2em; visibility: scroll;");
        if (titleHelp) {win.result.style.width = "auto"; win.result.style.maxWidth="90%"; win.result.style.right="5%"; win.result.style.height = "40em;"; win.result.maxHeight = "90%"; win.result.style.top="5%";}
        win.get();
        return win;}

    </script>
    <style type="text/css">
      * {resize: both;}
      html {width: 100%; height: 100%;}
      body {margin-left: auto; margin-right: auto; width: 90%; min-width: 90%; max-width: 90%; height: 100%; overflow: scroll; text-align: left; -moz-box-sizing: border-box;}
      table.header {overflow: auto; min-width: 100%; width: 100%; max-width: 100%; min-height: 0%; height: auto; max-height: 20%; border: none; text-align: center; border-spacing: 0em; padding: 0em; overflow: auto;}
      .content-inner {margin: 0em auto 0em auto; width: 100%; min-width: 10%; max-width: 100%; text-align: left; -moz-box-sizing: border-box; overflow: hidden;}
      .contented {margin: .5em 1em .5em 1em;  -moz-box-sizing: border-box; overflow: hidden;}

      /* #date  {display: inline-block; width: 9em;} */
      form {background-color: transparent; padding: 0em; margin: 0em; white-space: nowrap; display: inline-block; min-width: 100%; width: 100%; max-width: 100%; margin-top: 2em; margin-bottom: 2em;}
      label {margin-right: 0.5em}

      fieldset {display: inline-block; vertical-align: top; min-width: 65%; width: 65%; /*max-width: 65%;*/ margin-top: -.5em; margin-bottom: 2em; background-color: lightgrey; -moz-box-sizing: border-box;}
      fieldset > legend {}
      div.help {display: inline-block; white-space: normal; min-width: 32%; width: 32%; /*max-width: 32%;*/ border-left: 1px solid black; background: lightgrey;}
      div.help > div {margin-left: 1em;}

      ol {list-style-position: outside;}
      li {display: list-item !important; padding-left: 0em;}

      span.resultset, table.resultset {display: block; width: 85%; margin-top: 1em; overflow: auto; background-color: white;}
      table.resultset th {background-color: white; color: black; font-weight: bold;}

      #alerts ol {display: table; border: 1px solid black;}
      #alerts li {display: table-row; border: 1px solid red;}
      #alerts span.check {display: table-cell; border: 1px solid blue; margin-left: 7em; margin-right: 0em;}
      #alerts span.success {display: table-cell; color: green; font-weight: bold; border: 1px solid green; margin-left: 7em; margin-right: 0em;}
      #alerts span.failed {display: table-cell; color: red; font-weight: bold;border: 1px solid orange; margin-left: 7em; margin-right: 0em;}

      .alerts td.check {}
      .alerts td.success {color: green; font-weight: bold;}
      .alerts td.failed {color: red; font-weight: bold;}

      .resultset td, .resultset th {padding-right: 1em; font-size: 1em; white-space: nowrap;}

      /* .in form, .in fieldset, .in table {border: 1px solid black;} */
    </style>
</head>
<body>
  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
      <div class="content-inner">
      <div class="contented">
	<h style="text-align: center; margin-left: auto; margin-left: 2em; margin-right: auto; display: inline-block; width: 90%;"><span style="font-weight: bold;"><%=Date()%></span> <span style="margin-left: 1em; font-weight: bold;"><%=Time()%></span></h>
        <form>
          <fieldset>
            <legend>Basic Data Integrity Checks</legend>
            <label for="IntegrityCheck">Integrity Check:</label><a class="button" href="javascript:doCheck(); void(0);">Check Now</a>
            <label for="status" style="margin-left: 1em;">Status:</label>
            <span id="status" name="status" style="vertical-align: top;">
              <em style="font-weight: bold;">Not Checked</em>
            </span>
          </fieldset>

          <div class="help">
            <div>
	      Do all the checks at once.  This can be done after running z2t_UpdateAll_NEW.
<!-- 
              <h>Perform basic integrity checks:</h>
              <ol>
                <li>There are no <em>Null</em> Effective Dates.</li>
                <li>The hand-calculated rates match the auto-generated sums.</li>
                <li>All JurMax entries are on City(3) jurisdiction type.</li>
                <li>Rates are non-negative.</li>
              </ol>
-->
            </div>
          </div><!-- help -->
        </form>
        <form>
	  <fieldset>
            <legend>Tax Data</legend>
	    <div id="tax-data-alerts" class="alerts">
<%
  Dim rs
  'Set rs = Sql("util.dbo.maptable 'if @colid = 0 select @value as Description else exec (@value)', 'select id, 1 as colid, sql from z2t_UpdateRates.dbo.z2t_IntegrityCheck_alerts union select id, 0 as colid, description from z2t_UpdateRates.dbo.z2t_IntegrityCheck_alerts order by id, colid'")
  Set rs = Sql(sqlText & "@action='" & "alerts" & "', @stage='" & "taxdata" & "'")
  If rs.eof Then
%>
          <!-- No Alerts -->
<%
  Else
  '  Do While Not rs.eof
%>
<%
  '  Set rs = rs.nextRecordset
  '  Do While Not rs.eof
  '    rsTableInsert rs
  '    If (rs is Nothing) Or (rs.state <> 1) Then Exit Do
  '  Loop

  Response.Write("<table>")
  Do While Not rs.eof
    Response.Write("<tr><td title=""" & rs("description") & """>" & rs("check") & ":</td> <td style=""padding-left: 2em;"" class=""" & "unchecked" & """> " & "Not checked" & "</td>" &_
                       "<td><a href=""javascript:details('" & Replace(rs("check"), "'", "\'") & "'); void(0);"" style=""margin-left: 0em; padding-left: 0em;""><img src=""" & strPathIncludes & "help/questionmark.gif"" height=""14px"" width=""10px"" alt=""Details"" title=""Details""</a></td></tr>")
    rs.MoveNext
  Loop
  Response.Write("</table>")

%>
<%
  '  If rs.state <> 1 Then Exit Do
  '  Set rs = rs.nextRecordset
  '  Loop
  End If
%>
	  </div></fieldset>

          <div class="help">
            <div>
              <h>These checks should be performed before running z2t_UpdateAll_NEW.  The checks are performed upon the z2t_UpdateRates.dbo.z2t_TaxData table.</h>
            </div>
          </div><!-- help -->
	</form>

        <form>
	  <fieldset>
            <legend>ZIP codes</legend>
	    <div id="zip-codes-alerts" class="alerts">
<%
  Set rs = Sql(sqlText & "@action='" & "alerts" & "', @stage='" & "zipcodes" & "'")
  Response.Write("<table>")
  Do While Not rs.eof
    Response.Write("<tr><td title=""" & rs("description") & """>" & rs("check") & ":</td> <td style=""padding-left: 2em;"" class=""" & "unchecked" & """> " & " Not checked" & "</td>" &_
                       "<td><a href=""javascript:details('" & Replace(rs("check"), "'", "\'") & "'); void(0);"" style=""margin-left: 0em; padding-left: 0em;""><img src=""" & strPathIncludes & "help/questionmark.gif"" height=""14px"" width=""10px"" alt=""Details"" title=""Details""</a></td></tr>")
    rs.MoveNext
  Loop
  Response.Write("</table>")

%>

	  </div></fieldset>

          <div class="help">
            <div>
              <h>These checks should be performed after running z2t_UpdateAll_NEW.  The checks are performed upon the z2t_UpdateZipcodes.dbo.z2t_Zipcodes table.</h>
            </div>
          </div><!-- help -->
	</form>


<%
   If Session("debug") <> "" Then
%>

<%=SqlTable("exec z2t_UpdateRates.dbo.z2t_UpdateRates_IntegrityCheck")%>
<% 
   End If
%>

      </div><!-- contented -->
    </div><!-- content-->
    <!--#include virtual="/z2t_Backoffice/includes/BodyParts/footer.inc"-->
</body>
</html>
<%
  End Select

  Function print(rs)
      Response.Write (rs("value"))
      print = "Pass"
  End Function

  Function maprows(fn, rs)
    Do While Not rs.eof
      maprows = (fn(rs) = "Pass")
      rs.MoveNext
    Loop 
  End Function
%>
