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
  
  <title>Zip2Tax.info - <%=PageHeading%></title>
   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <script language="javascript">
		
		
		// Google Charts
		
		google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawDualX);

function drawDualX() {
      var data = google.visualization.arrayToDataTable([
        ['City', '2010 Population', '2000 Population',{ role: 'style' }],
        ['New York City, NY', 8175000, 8008000, 'stroke-width: 20;'],
        ['Los Angeles, CA', 3792000, 3694000, 'stroke-width: 20;'],
        ['Chicago, IL', 2695000, 2896000, 'stroke-width: 20;'],
        ['Houston, TX', 2099000, 1953000, 'stroke-width: 20;'],
        ['Philadelphia, PA', 1526000, 1517000, 'stroke-width: 20;']
      ]);

      var options = {
        chart: {
          title: 'Population of Largest U.S. Cities',
          subtitle: 'Based on most recent and previous census data'
        },
		width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        hAxis: {
          title: 'Total Population'
        },
        vAxis: {
          title: 'City'
        },
        bars: 'horizontal',
        series: {
          0: {axis: '2010'},
          1: {axis: '2000'}
        },
        axes: {
          x: {
            2010: {label: '2010 Population (in millions)', side: 'top'},
            2000: {label: '2000 Population'}
          }
        }
      };
      var material = new google.charts.Bar(document.getElementById('chart_div'));
      material.draw(data, options);
    }
		// Google Charts end
</script>

</head>

<body>
 <div id="chart_div"></div>

  <script type="text/javascript" src="<%=strPathIncludes%>lib-dev.js"></script>
</body>
</html>
