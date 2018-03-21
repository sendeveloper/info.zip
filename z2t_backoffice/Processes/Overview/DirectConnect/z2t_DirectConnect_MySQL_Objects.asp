<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_FunctionsMisc.inc"-->
  
<%
	Title = "MySQL Direct Connect Objects"	
%>

<html>
<head>
  <title><%=Title%></title>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link href="/z2t_Backoffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
  <script language="javascript" type="text/javascript" src="/z2t_Backoffice/includes/z2t_backoffice_functions.js"></script>
</head>

<body onLoad="SetScreen(1400,750);">

	  <span class="popupHeading"><%=Title%></span>
	  
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">	  
  <tr>
    <td colspan="2">
	
      <table width="98%" border="0" cellspacing="2" cellpadding="2" align="center">

		<tr><td>&nbsp;</td></tr>

        <tr>
	      <td class="ColumnHead1" colspan="4" style="text-align: left;">
			Tables
		  </td>
		</tr>

		<tr>
		  <td class="ColumnHead3" width="2%">
			&nbsp;
		  </td>
		  <td class="ColumnHead2" width="20%">
			Name
		  </td>
		  <td class="ColumnHead2" width="39%">
			Purpose
		  </td>
		  <td class="ColumnHead2" width="39%">
			Update Method
		  </td>
		</tr>
		  
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_Accounts
		  </td>
		  <td>
			Contains Zip2Tax Subscription Information
		  </td>
		  <td>
			z2t_UpdateMySQL.dbo.z2t_Accounts_Subscriptions_table_refresh_mysql
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_CustomerLink_log
		  </td>
		  <td>
			Customer Activity
		  </td>
		  <td>
			z2t_UpdateMySQL.dbo.z2t_MySQL_Import_CustomerLink_Log
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_StateInfo
		  </td>
		  <td>
			Data needed to complete a lookup
		  </td>
		  <td>
			Monthly Update That Angel Performs
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_ZipCodes
		  </td>
		  <td>
			Data needed to complete a lookup
		  </td>
		  <td>
			Monthly Update That Angel Performs
		  </td>
		</tr>

		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
	  </table>
		
      <table width="98%" border="0" cellspacing="2" cellpadding="2" align="center">
	  
        <tr>
	      <td class="ColumnHead1" colspan="3" style="text-align: left;">
			Stored Procedures
		  </td>
		</tr>

		<tr>
		  <td class="ColumnHead3" width="2%">
			&nbsp;
		  </td>
		  <td class="ColumnHead2" width="20%">
			Name
		  </td>
		  <td class="ColumnHead2" width="78%">
			Purpose
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_create_zipcodes_new
		  </td>
		  <td>
			&nbsp;
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_insert_Activity
		  </td>
		  <td>
			Adds a customer activity row.
		  </td>
		</tr>
				
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_Lookup
		  </td>
		  <td>
			Starts the Basic Lookup.
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_Lookup_extended
		  </td>
		  <td>
			Starts the Extended Lookup.
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_Lookup_extended_multiple
		  </td>
		  <td>
			Starts the Extended Lookup with Multiple Rows.
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_lookup_Impl
		  </td>
		  <td>
			&nbsp;
		  </td>
		</tr>
		
		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_Lookup_multiple
		  </td>
		  <td>
			&nbsp;
		  </td>
		</tr>

		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_rename_zipcodes
		  </td>
		  <td>
			&nbsp;
		  </td>
		</tr>

		<tr>
		  <td>
			&nbsp;
		  </td>
		  <td>
			z2t_validate_Account
		  </td>
		  <td>
			&nbsp;
		  </td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
		
      </table>
    </td>
  </tr>
</table>

    <span class="popupCredit"><%=CreditLine(eCreatedBy, eCreatedDate, eEditedBy, eEditedDate)%></span>	

    <span class="popupButtons">
      <a href="javascript:window.close();" class="bo_Button80">Close</a>
    </span>

</body>
</html>
