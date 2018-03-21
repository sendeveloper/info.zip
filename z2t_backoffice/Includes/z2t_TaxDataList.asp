<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<%  
    IF session("z2t_loggedin")<>"True" OR isNULL(session("z2t_loggedin")) THEN
        Response.Redirect "z2t_login.asp"
    END IF

    if Request("s") = "" or isnull(Request("s")) then
    else
	Session("WorksheetState") = Request("s")
    end if

    if Session("ToggleTaxType") = "" then
        Session("ToggleTaxType") = 1
    end if

    if Session("ToggleTaxTypeVar") = "" then
        Session("ToggleTaxTypeVar") = 0
    end if

    if Session("ToggleJurType") = "" then
        Session("ToggleJurType") = 0
    end if

    if Session("ToggleJurSize") = "" then
        Session("ToggleJurSize") = 0
    end if

    Dim rs
    Dim SQL
    set rs = server.createObject("ADODB.Recordset")

    if Request("Event") = "Sequence" then
        Session("StateListOrder") = Request("Data")
    end if

    if Request("Event") = "Toggle" then
        Session(Request("Data")) = Session(Request("Data")) + 1
    end if

    if Session("ToggleTaxType") > 2 then
        Session("ToggleTaxType") = 1
    end if

    if Session("ToggleTaxTypeVar") > 2 then
        Session("ToggleTaxTypeVar") = 0
    end if

    if Session("ToggleJurType") > 4 then
        Session("ToggleJurType") = 0
    end if

    if Session("ToggleJurSize") > 4 then
        Session("ToggleJurSize") = 0
    end if

%>

<html>
<head>
  <title>Zip2Tax - <%=Session("WorksheetState")%> Tax Data</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="/BackOffice/includes/z2t_backoffice.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="/BackOffice/includes/menu/dropdowntabfiles/ddcolortabs.css" />
    <script language="javascript" src="/Includes/z2t.js" type="text/javascript"></script>
    <script type="text/javascript" src="/BackOffice/includes/menu/dropdowntabfiles/dropdowntabs.js"></script>

    <script language="javascript" src="/website/includes/javascript/z2t.js" type="text/javascript"></script>

</head>

<% 
    PageHeading = "Tax Data for "& Session("WorksheetState")
%>

<body>

<form>
<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

  <!--#include virtual="/backoffice/includes/heading.inc"-->
  

<%
  sql = "select ProcedureText, Link, LinkHomePage from z2t_UpdateRates.dbo.z2t_StateInfo where State = '" + Session("WorksheetState") + "'"
  rs.open SQL, connBackOffice, 2
%>

  <tr>
    <td>
     <fieldset style="width: 100%; height: auto;"><legend>Procedure:</legend><iframe src='../procedures/<%=rs("ProcedureText")%>' style="width:100%; height: auto;"></iframe></fieldset><br>
     <fieldset style="width: 47%; display: inline-block;"><legend>Home:</legend><iframe src='<%=rs("LinkHomePage")%>' style="width: 100%;"></iframe></fieldset>
     <fieldset style="width: 47%; display: inline-block;"><legend>Data:</legend><iframe src='<%=rs("Link")%>' style="width: 100%;"></iframe></fieldset>
    </td>
  </tr>

<% rs.close %>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
         <tr>
           <td>

                       <%
			    SQL="z2t_TaxDataDescriptionString(" & Session("ToggleTaxType") & ", " & _
			        Session("ToggleTaxTypeVar") & ", " & _
			        Session("ToggleJurType") & ", " & _
			        Session("ToggleJurSize") & ")"
			    rs.open SQL, connAdmin, 3, 3, 4

			    if not rs.eof then
			        Response.Write "<tr><td>" & rs("Result") & "</td></tr><br><br>"        
			    end if

			    rs.close
			%>
           </td>
         </tr>
        </table>
	    <table width="100%" border="0" cellspacing="1" cellpadding="0" align="center">
                <tr bgcolor='red'>
                  <!-- <th width='10'>New</th> -->
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Toggle&Data=ToggleTaxType">Tax Type</a>
                  </th>
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Toggle&Data=ToggleTaxTypeVar">TT Var</a>
                  </th>
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=RateTotal">Total Rate</a>
                  </th>
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=RateJur">Jur Rate</a>
                  </th>
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Toggle&Data=ToggleJurType">Jur Type</a>
                  </th>
                  <th width='50'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Toggle&Data=ToggleJurSize">Jur Size</a>
                  </th>
                  <th width='100'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=JurCode">Jur Code</a>
                  </th>
                  <th width='150'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=County">County</a>
                  </th>
                  <th width='150'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=akaCounty">aka County</a>
                  </th>
                  <th width='250'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=City">City</a>
                  </th>
                  <th width='250'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=akaCity">aka City</a>
                  </th>
                  <th width='100'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=EffFrom">Eff From</a>
                  </th>
                  <th width='100'>
                    <a href="/BackOffice/z2t_TaxDataList.asp?Event=Sequence&Data=EffTo">Eff To</a>
                  </th>
                </tr>

<%

    SQL="z2t_WorksheetState_list('" & Session("WorksheetState") & "', '" & Session("StateListOrder") & "',1, " & _
        Session("ToggleTaxType") & ", " & _
        Session("ToggleTaxTypeVar") & ", " & _
        Session("ToggleJurType") & ", " & _
        Session("ToggleJurSize") & ")"
    rs.open SQL, connBackoffice, 3, 3, 4

    if not rs.eof then
        do while not rs.eof
   
            linecount = linecount + 1
            if linecount mod 3 = 1 then
                bgcolor = "#DDDDDD"
            else
                bgcolor = "#FFFFFF"
            end if
%>

		<tr bgcolor=<%=bgColor%>>
                  <!-- <td align='center'><span style="font-weight: bold;">X</span></td> -->
		  <td align='center'>
                    <%=rs("TaxType")%>                
                  </td>
		  <td align='center'>
                    <%=rs("TaxTypeVariation")%>
                  </td>
		  <td align='center'>
                    <%=rs("RateTotal")%>
                  </td>
		  <td align='center'>
                    <%=rs("RateJur")%>
                  </td>
		  <td align='center'>
                    <%=rs("JurType")%>
                  </td>
		  <td align='center'>
                    <%=rs("JurSize")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("JurCode")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("County")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("akaCounty")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("City")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("akaCity")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("EffFrom")%>                 
                  </td>
		  <td align='center'>
                    <%=rs("EffTo")%>                 
                  </td>
                </tr>
                
<%
                rs.MoveNext
            loop
        end if
%>


            </table>

    </td>
  </tr>
</table>
</form>
</body>
</form>
</html>
