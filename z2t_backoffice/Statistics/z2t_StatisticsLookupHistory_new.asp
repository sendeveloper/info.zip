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

  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />


  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>  
   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>


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
    

    function clickSubmit() {
     // if (checkStartDate() && checkEndDate()) {
        document.frm.submit();
	//	}
	}
		
		
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
	dim statTimeLineVal
	dim statShowBySelected
	dim statShowBy
	
	statShowBy = 0 
	vAxisTitle = "'Device Usage Count'"
	if request("statShowBy") = 1 then 
		statShowBySelected = "Selected='selected'"
		statShowBy = 1
		vAxisTitle = "'Server Usage Count'"
		
	end if
	
	statTimeLineVal = Request("statTimeLine")
	
	'''''''' statTimeLineVal = 0 means "History" (Show data for all years)
	if isnull(statTimeLineVal ) or statTimeLineVal = "" then
			statTimeLineVal = 0
	End IF

%>

    <style>
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
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
  <div class="on-desk">
        <div id="log" disabled="disabled"></div>
        
        <div class="statistics-frame">
    	  
          <div style="width: 65%; display: inline-block; vertical-align: top; padding: 10px 20px 0 0; overflow-y: auto;
height: 170px;">
<%

	
	


	sqlConnectionString = "Driver=SQL Server;Server=localhost;uid=davewj2o;pwd=get2it;Database=z2t_Backoffice;"
	sqlText = "EXEC z2t_ActivityStatistics_Summary '" & statTimeLineVal & "'," & statShowBy
	
	SqlTimeout = 90
	ChangePageSize(100)

	Dim table : table = CStr(sqlTable(sqlText))

	If RowCount > 0 Then
		Response.Write(table)
	Else
		Response.Write("No matching records")
	End If
%>

          </div><!-- left 50% -->
          
          <div style="width: 30%; display: inline-block;  vertical-align: top; padding: 10px 0 20px 0;">
            <form method="post" action="<%=Request.ServerVariables("URL")%>" name="frm" style="margin: 0; width:100%">
              <table width='100%' height='100' border='1' cellspacing='0' cellpadding='0'>
                <tr valign='top'>
                  <td>
                    <table width='100%' border='0' cellspacing='5' cellpadding='5'>
                      <tr>
                        <td width='25%' align='right'>
                          Time Line
                        </td>
                        <td width='45%' style="white-space: nowrap;">
                   
							<select id="statTimeLine" style=" width:100px;" name="statTimeLine">


                        <%
							
							set connPhilly05=server.CreateObject("ADODB.Connection")
						    connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Backoffice;"				
							sqlTextTimeLine = "z2t_ActivityStatistics_TimeLine "
							rs.open sqlTextTimeLine, connPhilly05, 3, 3, 4
							
							selectedVal = 0
							
							If isnull(statTimeLineVal) or statTimeLineVal = ""  then  
								selectedVal = 0
							else
								selectedVal = statTimeLineVal
							End If
							
							
							
							DO UNTIL rs.eof
                        
						%>
                        
            		        	<option value="<%=rs("statYear")%>"
                                	 <% if trim(selectedVal) = trim(rs("statYear")) then response.Write("selected=selected") End IF  %>
                                >
									<%=rs("statYearVal")%>
                                </option>
                         <%
						 		rs.movenext
								
							LOOP
							rs.close
						 %>

	                        </select>                        
                        
                        </td>
                        
                        
                      </tr>
                      <tr>
                        <td width='25%' align='right'>
                           Stat. By
                        </td>
                        <td width='45%' style="white-space: nowrap;">
                   
							<select id="statShowBy" style=" width:100px;" name="statShowBy">
                            	<option value="0"  > Devices</option>
                                <option value="1" <%=statShowBySelected%>>  Servers </option>
                             </select>
	                    </td>
                      </tr>
                      
                    </table>
                  
                  </td>
                </tr>
				<tr>
				  <td>
				    <div style="width: 25%; margin-left: auto; margin-right: auto; white-space: nowrap; display: block; text-align:center;">
                    
                          <a href="javascript:clickSubmit();" class="button2" style="margin-top: 6px;">Go</a><br>
                    
				    </div>
				  </td>
				</tr>
              </table>
            </form>
          </div>
		<div id="chart_div" style="margin-top:2px"></div>
        </div><!-- statistics-frame -->
      </div><!-- on-desk -->
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/Footer.inc"-->
      <!--aside>Extra content goes here</aside-->
  <footer>Javascript: <em id="javascript-test">Failed</em></footer>
   <script language="javascript">
  
  		// Google Charts
		
		google.charts.load('current', {packages: ['corechart', 'line']});
		google.charts.setOnLoadCallback(drawLineColors);
		
		
		function drawLineColors() {
      		var data = new google.visualization.DataTable();
	  		data.addColumn('date', 'Year');
	  		data.addColumn('number', 'Total');
	  		<%			
	  			sqlTextYearlySummary = "z2t_ActivityStatistics_Summary ('" & selectedVal & "'," & statShowBy & ")"
				rs.open sqlTextYearlySummary, connPhilly05, 3, 3, 4
		
				addColumnVal = "X"
				CurrentDevice = ""
				CurrentDevices = ""
				PreviousYear = ""
				addRowsVal = "" 	
				PreviousMonth=""
				RowVal = ""
				TotalYears=1
				TotalCount= 0 
		
				if selectedVal = 0 then
					addFirstRowsVal = "new Date("+ cstr(rs("Year")-1) + ",1,1),0" 
				else 
					addFirstRowsVal = "new Date("+ cstr(rs("Year")) + ","+cstr(rs("month")-1)+",1),0" 
				end if 
		
			Do Until rs.eof
		
					'Building Columns for graph
				if  trim(CurrentDevice) <> trim(rs("Device")) and InStr (trim(CurrentDevices),trim(rs("Device")))=0 then 
					CurrentDevice = trim(rs("Device"))
					CurrentDevices = CurrentDevices + trim(rs("Device"))
					addFirstRowsVal = addFirstRowsVal + ",0"
				
			%>
				
			    data.addColumn('number', '<%=trim(CurrentDevice)%>');
			<%
				End If
			
				'Bulding Rows (Data) for graph
			
				if selectedVal = 0 then
					PreviousYear= cstr(rs("Year"))
				else
					PreviousMonth = cstr(rs("Month"))
					PreviousYear= cstr(rs("Year"))
				End If
			
				if RowVal <> "" then 
					RowVal= RowVal + "," + replace(cstr(rs("Count")),",","")
				else
					RowVal= RowVal + "," + replace(cstr(rs("Count")),",","")
				End If
				
			 	TotalCount = TotalCount + rs("Count")
				
				rs.movenext
		
				if (NOT rs.eof ) then
				
					if selectedVal = 0 then
				 		if PreviousYear <> cstr(rs("Year")) then
							addRowsVal =  addRowsVal+ "[new Date("+ PreviousYear + ",1,1)," + cstr(TotalCount) + " "+ RowVal + "],"
							RowVal = ""
							TotalYears = TotalYears + 1
							TotalCount = 0
						end if
					else
						if PreviousMonth <> cstr(rs("Month")) then
							addRowsVal =  addRowsVal+ "[new Date("+ cstr(rs("year")) + "," +  cstr(cint(PreviousMonth)-1) + ")," + cstr(TotalCount) + " "+ RowVal + "],"
							RowVal = ""
							TotalYears = TotalYears + 1
							TotalCount=0
						end if
					end if
				
				elseif rs.eof then
			
					if selectedVal = 0 then
						addRowsVal = addRowsVal + "[new Date("+ PreviousYear + ",1,1)," + cstr(TotalCount) + " "+ RowVal + "]"
						RowVal = ""
						TotalCount=0
				
					else
						addRowsVal =  addRowsVal+ "[new Date("+ PreviousYear + "," +  cstr(cint(PreviousMonth)-1) + ")," + cstr(TotalCount) + " "+ RowVal + "]"
						RowVal = ""
						TotalCount = 0
				
				
					end if		
				
		
				end if'
		
				'if NOT rs.eof then drawInnerChart = drawInnerChart + ","
			Loop		
		
			gridcountval = 12
			formatval = "MMM"
			if selectedVal = 0 then 
				gridcountval = TotalYears
				formatval = "YYYY"
				addRowsVal = "["+addFirstRowsVal+"]," + addRowsVal
			end if
			
		%>
			data.addRows([<%=addRowsVal%>]);
		
      		var options = 
			{
		  
        		'height':358,
        		 hAxis: {
          		 		title: 'Time Line',
		  				gridlines: {
                					count: <%=TotalYears%>
        	    					}
			
				<% if selectedVal <> 0 then response.Write(",format:'"+formatval+ "'")%>
         			},
				
        		vAxis: {
          				title: <%=vAxisTitle%>,
		   				gridlines: {
                					count: 20
            						}
        				},
       					colors: ['#882E72','#B178A6', '#D6C1DE',
								 '#1965B0', '#5289C7', '#7BAFDE',
								 '#4EB265', '#90C987', '#CAE0AB', 
								 '#F7EE55', '#F6C141', '#F1932D', 
								 '#E8601C', '#DC050C']
      		}; //End Options
       		var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

      		chart.draw(data, options);
			
			
    	} // END  drawLineColors
			
		// Google Charts end
	<%if statShowBy = 1 then %>		
		$(document).ready(function(){

			$(".resultset tr th").eq(0).html('Server'); // Change Heading Device with Server when "By Server" is displayed 

		});

	<%end if %>

  </script>
</body>
</html>
