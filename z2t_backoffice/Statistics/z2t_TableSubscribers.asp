<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/Secure.asp"-->
<!--#include virtual="/z2t_BackOffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBFunctions.asp"-->
<%
  PageHeading = "Zip2Tax Statistics"
  ColorTab = 6 ' Second menu tab

  ''''' These must be set after sql.asp is included.
  RowMod = 3            ' Colorize every third row.
  ShowRowCount = True   ' Show total number of states
  'sqlDebug = True
  '''''

  sqlText = _
    "select [Table Format] =  t.description, [# Subscribers] = count(*) " &_
    "from z2t_Backoffice.dbo.z2t_Accounts_Subscriptions_repl as a " &_
    "join z2t_Backoffice.dbo.z2t_Types as t on class='tabletype' and t.value = a.tabletype " &_
    "where a.deleteddate is null " &_
    "and datediff(day, a.expirationdate,  getdate()) > 0 " &_
    "and t.value > '' " &_
    "group by t.description order by t.description"
%>
<!DOCTYPE html>
<html>
  <head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice-sensible.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>sensible.css" />
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>z2t_Backoffice_functions.js"></script>
  <style>
    .on-desk {margin-left: 5em; margin-right: auto; display: inline-block; white-space: nowrap; vertical-align: top;}
    .on-desk * {white-space: normal;}
    .download-xlsx {display: block; margin-left: 10em; margin-right: auto; margin-top: 1em;}

    .subscribers {display: inline-block;}
    .subscribers table.resultset th {font-size: 150%;}
    .subscribers table.resultset td {padding-left: 2em; text-align: right; font-size: 150%;}
    .subscribers table.resultset td:first-child {padding-left: 0em; text-align: left;}

    .bob-note {display: inline-block; vertical-align: top; margin-top: 5em; width: 30%;}
  </style>
  </head> 
  <body>  
  <table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

  <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->
    <tr>
	 <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="content">
    	<tr>
	      <td width="100%" align="left" height="10" class="divDeskTop">
    	  </td>
	    </tr>
        <tr>
          <td width="100%" align="left" class="divDeskMiddle" style="vertical-align:top;">
        <div class="on-desk">
          <div class="subscribers">
            <%=SqlTable(sqlText)%>
          </div>
          <div class="bob-note">Bob: It would be nice if the use-tax was
            to the right of the matching sales-tax table format, with a
            total.  And whatever else you need to do to make this page
            nice.  The download button doesn't work yet either.</div><br/>
          <button onclick="alert('Excel download is not implemented (yet)')">Download .xlsx</button>
        </div>
        </td>
      </tr>
        <tr>
            <td width="100%" align="left" height="10" class="divDeskBottom">
            </td>
        </tr>
	   </table>
	 </td>
	</tr>
   </table>
 
  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
  </body> 
</html>


