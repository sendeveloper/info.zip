<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_BackOffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBFunctions.asp"-->

<%
  PageHeading = "Zip2Tax Statistics Devices"
  ColorTab = 4 ' Second menu tab

  ''''' These must be set after sql.asp is included.
  RowMod = 3            ' Colorize every third row.
  ShowRowCount = True   ' Show total number of states
  'sqlDebug = True
  '''''
%>

<!-- script type="text/vbscript" language="vbscript" runat="server" src="/z2t_Backoffice/includes/lib.vbs"></script -->

<!DOCTYPE html>
<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css" />
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice-sensible.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>sensible.css" />

  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>  
   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


  <script type="text/javascript">
    var tooltip;
function removeIfNot(fn) {
  var length = this.length;
  if (typeof(fn) != "function") {
    return undefined; // jQuery compatibility hack
    throw new TypeError("removeIfNot: fn is not a function");}
  var arg = arguments[1];
  var result = [];
  for (var i = 0, j = 0; i < length; i++) {
    if (i in this) {
      //alert(i + "," + this[i]);
      var value = fn.call(this, this[i]);
      if (value) {
        result.push(this[i]);}}}
  return result;}
removeIfNot.replace = function(){return "removeIfNot";}; // jQuery compatibility hack

// document.getElementsByClass
document.getElementsByClass = function(className) {
  return document.getElementsByTagName("*").removeIfNot(function(e){
    return e.className.split(" ").removeIfNot(function(e) {
      return (e == className);}).length > 0;})}

	// compatible events

var listeners = []; // [[element, event, fn, bubblep]]
var listen =
(function(){
  function chain (event){
    listeners.removeIfNot(function(e){return (event.target == e[0]) && (event.type == e[1]) /*&& (!!bubblep == e[3])*/;}).forEach(function(e){return e[2](event);})}
  return (
  function listen(element, event, fn, /*optional*/ bubblep) {
    if (listeners.indexOf([element, event, fn, !!bubblep]) > -1) {return "Event handler already installed";}
    if (element.addEventListener) { // mozilla
      element.addEventListener(event, fn, !!bubblep);}
    else { // others -- chain the event handlers
      if (element["on" + event] != chain) {
        if (element["on" + event]) {
          listeners.push = [element, event, element["on" + event], !!bubblep];}
        element["on" + event] = chain;}}
    listeners.push([element, event, fn, !!bubblep]);
    return fn;});})();

function unlisten(element, event, fn, bubblep) {
  if (element.removeEventListener) { // mozilla
    element.removeEventListener(event, fn, !!bubblep);}
  listeners.splice(listeners.indexOf([element, event, fn, !!bubblep]), 1);
  return fn;}


    function init(){
      get("#javascript-test").innerHTML = "Passed";
      get("#javascript-test").style.color = "green";

      //listen(window, "keypress", keytest);

      // put help on the page title
      var title = get(".title")[0];
      //title.insertBefore(node("a", ["href","javascript:help(\"" + "help-add-jurisdiction" + "\"); void(0);", "style","{margin-left: 0em; padding-left: 0em;}"], node("img", ["src","<%=strPathIncludes%>help/questionmark.gif", "alt","Help"])), title.childNodes[3]);

      (function(footer) {
        footer.innerHTML = "Passed";
        footer.style.color = "green";})(get("footer")[0].getElementsByTagName("em")[0]);

      tooltip = node("div", ["style","background: lightyellow; position: absolute; visibility: hidden; top: 100px; left: 100px; height: 2em; width: 10em;"]);
      get("body")[0].appendChild(tooltip);
      //get("div").forEach(function(e){listen(e, "mouseover", toolTip); /*listen(e, "mouseout", hideToolTip);*/ return;});
      //nodeEvents.push(["mouseover", toolTip, function(e){return e.nodeName.toLowerCase() == "div"}]);
      return;}

    function toolTip(event) {
      tooltip.innerHTML = event.target.style.overflow.toString();
      tooltip.style.left = px(event.screenX);
      tooltip.style.top = (event.screenY);
      tooltip.style.zIndex = 100; //event.target.style.zIndex + 1; // + window.getComputedStyle(tooltip).getPropertyValue("zIndex");
      show(tooltip);
      return;}

    function hideToolTip(event) {
      hide(tooltip);
      return;}

    function identity(e){return e;}
    listen(window, "load", init);
	
	  </script>

  <script type="text/javascript" language="javascript" src="<%=strBasePath%>includes/dates/checkDate.js"></script>
  <script type="text/javascript" language="javascript" src="<%=strBasePath%>includes/dates/ts_picker.js"></script>

  <script language="javascript">
    function changeDates(StartDate, EndDate) {
      if (EndDate == '') {
        EndDate = StartDate;}
      document.frm.startdate.value = StartDate;
      document.frm.enddate.value = EndDate;
      clickSubmit();}

    function checkStartDate() {
      var d = document.frm.startdate;
      if (d.value.length != 0) {
        if (isDate(d.value)==false) {
          d.focus();
          return false;}
        return true;}
      alert('Please enter a start date');
      d.focus();
      return false;}

    function checkEndDate() {
      var d = document.frm.enddate;
      if (d.value.length != 0) {
        if (isDate(d.value)==false) {
          d.focus();
          return false;}
        return true;}
      alert('Please enter an end date');
      d.focus();
      return false;}

    function clickSubmit() {
      if (checkStartDate() && checkEndDate()) {
        document.frm.submit();}}
		
		
</script>

<%
    dim searchText
    dim StartDate
    dim EndDate
    dim eDate
	dim StartMonth
	dim StartYear
	dim EndMonth
	dim EndYear

    if isnull(Request("StartDate")) or Request("StartDate") = "" then
      StartDate = date()
    else
      StartDate = Request("StartDate")
    end if
    eDate = StartDate

    if isnull(Request("EndDate")) or Request("EndDate") = "" then
      EndDate = date()
    else
      EndDate = Request("EndDate")
    end if

    searchText = "From " & StartDate & " to " & EndDate
%>

    <style>
      html {height: 100%; max-height: 100%; overflow: hidden;}
      body {display: block; height: 100%; width: 100%; white-space: nowrap;}
      header {display: block; text-align: center; font-size: 2em; font-weight: bold; margin-top: .5em; margin-bottom: 0em;}
/*
      article {display: inline-block; width: 90%; height: 100%;}
      aside {display: inline-block; border-left: 1px solid black; padding-left: .5em; min-width: 30%; width: 30%; height: 100%;}
*/
      footer {display: block; bottom: 0em; position: absolute; background-color: black; color: grey;}
      footer > em {color: red;}

      article 
      {
          display: block;
          width: 1200px;
          margin: 0 auto;
      }
      .divDeskTop {height: 0.7em; text-align: center; background-size: 100% 100%; margin-top: 0em; padding: 0.1px;}
      .divDeskMiddle {height: auto; width: 100%; background-size: 100% 100%; padding: 0.1px;}
      .divDeskBottom {height: 0.7em; text-align: center; background-size: 100% 100%; margin-bottom: 2em; padding: 0.1px;}
      .on-desk {margin-left: 2em; width: 100%;}

      input[type='submit'] {width: auto;}
      select {width: auto;}
      div#log {display: block; width: auto;}

      .statistics-frame {width: 95%; max-width: 95%; margin-top: 1.5em; margin-bottom: 1.5em; border: 1px solid black; white-space: nowrap; text-align: center;}

      .resultset 				{width: 100%;}
      .resultset * 				{margin: 0em; font-size: 10pt !important; }
      .resultset td 			{padding-right: 2em; width: auto;}
      .resultset td 			{width: 23%;}
      .resultset .rowmod-0 		{border-bottom: 2px solid #E5E5E5;}

      .resultset th.Id 			{text-align: center; width: 2em;}
      .resultset th.Activity-Item, .resultset td.Activity-Item {width: auto;}
      .resultset th.Count 		{text-align: left; width: 2em;}
      .resultset th.Uniques 	{text-align: right; width: 2em;}


      .resultset td.Id 			{text-align: right; width: 2em;}
      .resultset td.Count 		{text-align: left; width: 2em;}
      .resultset td.Uniques 	{text-align: right; width: 2em;}
	  
	  .resultset tfoot th 		{padding-top: 1em;}

	</style>
</head>

<body>
  <!--#include virtual="/z2t_Backoffice/includes/heading-sensible.inc"-->
  <article>
    <div class="divDeskTop"></div><!-- divDeskTop -->
    <div class="divDeskMiddle">
      <div class="on-desk">
        <div id="log" disabled="disabled"></div>
        
        <div class="statistics-frame">
          <div style="padding-top: 10px; font-weight: bold;">
<%
  Dim isDateRange: isDateRange = datediff("d", StartDate, EndDate) <> 0
%>
              <%=iif(isDateRange, "From ", "")%><%=WeekDayName(WeekDay(StartDate))%>&nbsp;<%=StartDate%>
<%
  If isDateRange Then
%>
               to <%=WeekDayName(WeekDay(EndDate))%>&nbsp;<%=EndDate%>
<%
  End If
%>
          </div>
		  
          <div style="width: 55%; overflow-y: auto;
height: 200px; display: inline-block; vertical-align: top; padding: 10px 20px 0 0;">
<%

	
	StartMonth = DatePart("m",StartDate)
	StartYear = DatePart("yyyy",StartDate)
	EndMonth = DatePart("m",StartDate)
	EndYear = DatePart("yyyy",StartDate)
	
'response.write(DatePart("m",d))

	sqlConnectionString = "Driver=SQL Server;Server=localhost;uid=davewj2o;pwd=get2it;Database=z2t_Backoffice;"
	sqlText = "EXEC z2t_ActivityStatisticsDevices_Summary '" & StartYear & "', '" & StartMonth & "','"  & EndYear & "', '" & EndMonth & "'"
	
	'response.Write(sqlText)
	'response.End()
	SqlTimeout = 90

	Dim table : table = CStr(sqlTable(sqlText))

	If RowCount > 0 Then
		Response.Write(table)
	Else
		Response.Write("No matching records")
	End If
%>

          </div><!-- left 50% -->
          
          <div style="width: 40%; display: inline-block;  vertical-align: top; padding: 10px 0 20px 0;">
            <form method="post" action="<%=Request.ServerVariables("URL")%>" name="frm" style="margin: 0;">
              <table width='100%' height='350' border='1' cellspacing='0' cellpadding='0'>
                <tr valign='top'>
                  <td>
                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr>
                        <td width='25%' align='right'>
                          Start&nbsp;Date
                        </td>
                        <td width='45%' style="white-space: nowrap;">
                          <input type="Text" name="startdate" value="<%=d1%>" size="10" style="width: 10em;">
                          <a href="javascript:show_calendar('document.frm.startdate', document.frm.startdate.value);">
                            <img src="<%=strBasePath%>includes/dates/cal.gif" width="16" height="16"
                                 border="0" alt="Calendar"></a>
                        </td>
                      </tr>
                      
                      <tr>
                        <td align='right'>
                          End&nbsp;Date
                        </td>
                        <td style="white-space: nowrap;">
                          <input type="Text" name="enddate" value="<%=d2%>" size="10" style="width: 10em;">
                          <a href="javascript:show_calendar('document.frm.enddate', document.frm.enddate.value);">
                            <img src="<%=strBasePath%>includes/dates/cal.gif" width="16" height="16"
                                 border="0" alt="Calendar"></a>
                        </td>
                        <td width='25%' valign='bottom'>
                          <a href="javascript:clickSubmit();" class="button">Go</a><br>
                        </td>
                      </tr>
                      
                      <tr>
                        <td colspan='3'>
                          <hr>
                        </td>
                      </tr>
                      
                    </table>
                    
                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr valign='top'>
                        <td align='right'>
                          <a href="javascript:changeDates('<%=DateAdd("d",-1,eDate)%>', '');"
                             class="button90">&lt; Previous</a>
                        </td>
                        <td align='center'>
                          <a href="javascript:changeDates('<%=date()%>', '');" class="button90">
                            Today</a>
                        </td>
                        <td>
                          <a href="javascript:changeDates('<%=DateAdd("d",1,eDate)%>', '');"
                             class="button90">Next &gt;</a>
                        </td>
                      </tr>
                    </table>
                    
                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr valign='top'>
                        <td align="right"></td>
                        <td align='center'>
                          <a href="javascript:changeDates('<%=DateAdd("d", -(Weekday(date) - 1), date())%>','<%=DateAdd("d", 7 - (Weekday(date())) - 1, date())%>');"
                             class="button90">This Week</a>
                        </td>
                        <td align="left">
                        </td>
                      </tr>
                    </table>
                    
                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr>
                        <td align='right'>
<%
    sMonth = Month(DateAdd("m",-1,eDate)) & "/1/" & Year(DateAdd("m",-1,eDate))
    eMonth = DateAdd("d",-1,DateAdd("m",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');"
                             class="button90">&lt; Previous</a>
                        </td>
                        <td align='center'>
<%
    sMonth = Month(date()) & "/1/" & Year(date())
    eMonth = DateAdd("d",-1,DateAdd("m",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');" class="button90">This Month</a>
                        </td>
                        <td>
<%
    sMonth = Month(DateAdd("m",1,eDate)) & "/1/" & Year(DateAdd("m",1,eDate))
    eMonth = DateAdd("d",-1,DateAdd("m",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');"
                             class="button90">Next &gt;</a>
                        </td>
                      </tr>
                    </table>

                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr>
                        <td align='right'>
<%
    sMonth = "1/1/" & Year(DateAdd("yyyy",-1,eDate))
    eMonth = DateAdd("d",-1,DateAdd("yyyy",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');"
                             class="button90">&lt; Previous</a>
                        </td>
                        <td align='center'>
<%
    sMonth = "1/1/" & Year(date())
    eMonth = DateAdd("d",-1,DateAdd("yyyy",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');"
                             class="button90">This Year</a>
                       </td>
                       <td>
<%
    sMonth = "1/1/" & Year(DateAdd("yyyy",1,eDate))
    eMonth = DateAdd("d",-1,DateAdd("yyyy",1,sMonth))
%>
                          <a href="javascript:changeDates('<%=sMonth%>', '<%=eMonth%>');"
                             class="button90">Next &gt;</a>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
				<tr>
				  <td>
				    <div style="width: 90%; margin-left: auto; margin-right: auto; white-space: nowrap; display: block;">
				      <p style="display: inline-block; margin-right: 1em; width: 10%; vertical-align: top;">Note:</p>
				      <p style="display: inline-block; width: 80%; white-space: normal;">The "Uniques" column is only displayed for date ranges at most 31-days long.</p>
				    </div>
				  </td>
				</tr>
              </table>
            </form>
          </div><!-- right 50% -->
	          <!--div style="width: 55%; display: inline-block; vertical-align: top; padding: 10px 20px 0 0;">
    	      </div>
        	  <div style="width: 40%; display: inline-block;  vertical-align: top; padding: 10px 0 20px 0;">
          	  </div-->
		
        </div>
        <div id="chart_div"></div>
        <!-- statistics-frame -->
      </div><!-- on-desk -->
    </div><!-- divDeskMiddle -->
    
    <div class="divDeskBottom"></div><!-- divDeskBottom -->
  </article>

    <!--aside>Extra content goes here</aside-->
  <footer>Javascript: <em id="javascript-test">Failed</em></footer>
  <script language="javascript">
  
  		// Google Charts
		
		google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawDualX);

function drawDualX() {
      var data = google.visualization.arrayToDataTable([
<%	  

sqlConnectionString = "Driver=SQL Server;Server=localhost;uid=davewj2o;pwd=get2it;Database=z2t_Backoffice;"
	sqlText1234 = "EXEC z2t_ActivityStatisticsDevices_SummaryCharts '" & StartYear & "', '" & StartMonth & "','"  & EndYear & "', '" & EndMonth & "'"
		rs.open sqlText1234, sqlConnectionString, 2, 1
		
		Do While (Not rs.eof)
		
		drawInnerChart =  drawInnerChart + rs("chartval")
		rs.movenext
		if NOT rs.eof then drawInnerChart = drawInnerChart + ","
		Loop
		
		response.Write(drawInnerChart)

	
%>
        /*['City', '2010 Population', '2000 Population'],
        ['New York City, NY', 8175000, 8008000],
        ['Los Angeles, CA', 3792000, 3694000],
        ['Chicago, IL', 2695000, 2896000],
        ['Houston, TX', 2099000, 1953000],
        ['Philadelphia, PA', 1526000, 1517000]*/
      ]);

      var options = {
        chart: {
          
        },
		
        height: 200,
        bar: {groupWidth: "90%"},
        hAxis: {
          title: 'Devices by Year'
        },
        vAxis: {
          title: 'Devices'
        },
        bars: 'horizontal',
        series: {
          0: {axis: '<%=EndYear%>'},
         
        },
        axes: {
          x: {
            <%=EndYear%>: {label: '<%=EndYear%>', side: 'top'},
            
          }
        }
      };
      var material = new google.charts.Bar(document.getElementById('chart_div'));
      material.draw(data, options);
    }
		// Google Charts end

  </script>
</body>
</html>
