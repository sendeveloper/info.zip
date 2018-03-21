<% 
  ''''' Changelog
  ' <2011-03-22 Tue nathan> Make US table always appear in State list.
  ' <2012-01-17 Tue nathan> Make CAN table always appear in State list.
  ' <2013-07-27 Sun Dave> Moved to Philly05
%>
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackOfficeConnection.asp"-->
<!--#include file="includes/StateList.asp"-->

<%
     Dim rs, strSQL
     set rs = server.createObject("ADODB.Recordset")
		if request("user") <> ""  then
			session("User")= request("user")
		End if
	'Get the states that are on file for this account
    SQL="z2t_StateEdit_list(" & Request("z2tID") & ")" 
'	Response.Write(SQL)
'	Response.End()
    rs.open SQL,connBackoffice, 3, 3, 4
	if not rs.Eof Then
    StateList = rs("StateList")
	end if
    rs.close
%>

<html>
<head>
    <title>Zip2Tax Subscription Edit</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	

<script language="javascript" type = "text/javascript">

    var subFolder = '<%=strPathIncludes%>dates/';
	var subType = '<%=Request("SubType")%>';
	var screenStatus = 0;
	var screenStatusInitial = 0;
	
    function checkChecked() 
		{
		screenStatus = 0;
		for(cc = 0; cc < document.forms[0].elements.length; cc++) 
			{
			var testobj = document.forms[0].elements[cc];
			if (testobj.type == 'checkbox') 
				{
				if (testobj.checked) 
					{
					switch (testobj.value) 
						{
						case 'US':
						  screenStatus = 1;
						  break;
						case 'CAN':
						  screenStatus = 3;
						  break;
						default:
						  screenStatus = 2;
						  break;
						}
					}
				}
			}

			var extras = 2; // entire countries: US, CAN
			switch (screenStatus) 
				{
				case 0: // Blank 
					for(cc = 0; cc < document.forms[0].elements.length; cc++) 
						{
						var testobj = document.forms[0].elements[cc];
						if (testobj.type == 'checkbox') 
							{
							testobj.disabled = false;
							}
						}
				break;
				case 1: // US
					for(cc = 0; cc < document.forms[0].elements.length; cc++) 
						{
						var testobj = document.forms[0].elements[cc];
						if (testobj.type == 'checkbox') 
							{
							if (testobj.value == 'US') 
								{
								testobj.disabled = false;
								}
							else 
								{
								testobj.disabled = true;
								}
							}
						}
				break;
				case 2: // Individual States
					for(cc = 0; cc < document.forms[0].elements.length; cc++) 
						{
						var testobj = document.forms[0].elements[cc];
						if (testobj.type == 'checkbox') 
							{
							if ((testobj.value == 'US') || (testobj.value == 'CAN')) 
								{
								testobj.disabled = true;
								}
							else 
								{
								testobj.disabled = false;
								}
							}
						}
				break;
				}
		}
	
    function clickCancel() 
		{
        checkChecked();
		if (screenStatus == 0  || screenStatusInitial == 0)
			{
			alert('Please submit entries before canceling form');
			}
		else
			{
			window.close();
			}
		}
		
    function clickSubmit() 
		{
        checkChecked();
		if (screenStatus == 0)
			{
			alert('Please make entries before submitting form');
			}
		else
			{
			document.frm.submit();
			}
		}
		
    function formLoad() 
		{
        SetScreen(850,800);
        checkChecked();
		screenStatusInitial = screenStatus;
		
		if (subType == 'Tab')
			{
			document.getElementById('buttonsBack').style.display='block';
			document.getElementById('buttonsSubmit').style.display='none';
			}
		else
			{
			document.getElementById('buttonsBack').style.display='none';
			document.getElementById('buttonsSubmit').style.display='block';
			}
		}

    function clickBack() 
		{
		var url = 'z2t_SubscriptionEdit.asp?z2tID=<%=Request("z2tID")%>';
		location.href = url;
		}
		
</script>

<style type="text/css">

td
	{
	font-size: 	10pt;
	text-align: left;
	}


</style>

</head>



<body onLoad="formLoad();">
<FORM METHOD="Post" ACTION="z2t_StatesPost.asp?z2tID=<%=Request("z2tID")%>" name="frm">

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="10" cellpadding="0" align="center">

              <tr>
                <td class="popupHeading">
                  Zip2Tax Product Edit State List
                </td>
              </tr>

            </table>	

          </td>
        </tr>
      </table>


      <table width="100%" border="0" cellspacing="10" cellpadding="0">
        <tr valign='top'>

          <td width="33%">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">

<%
    For i = 0 to 50
        If instr(StateList,States(i,1) & ",") Then
            strChecked = "Checked"
        Else
            strChecked = ""
        End If
		
		If i = 18 or i = 36 Then
			Response.Write "          </table>" & vbCrLf
			Response.Write "            </td>" & vbCrLf
			Response.Write "" & vbCrLf
			Response.Write "            <td width='33%'>" & vbCrLf
			Response.Write "          <table width='100%' border='0' cellspacing='0' cellpadding='0'>" & vbCrLf
		End If
		
        
		Response.Write "<tr valign='top'><td width='8%'>"
		Response.Write "<input type='checkbox' name='chkAction' "
		Response.Write "value='" & States(i,1) & "' onClick='checkChecked();' " & strChecked & ">"
		Response.Write "</td><td width='9%'>" & States(i,1) & "</td><td> - " & States(i,2) & "</td></tr>" & vbCrLf
    Next
	
    'US
    If instr(StateList,"US,") Then
        strChecked = "Checked"
    Else
        strChecked = ""
    End If

	Response.Write "<tr><td>&nbsp</td></tr>" & vbCrLf
	Response.Write "<tr><td>&nbsp</td></tr>" & vbCrLf
	
	Response.Write "<tr valign='top'><td width='8%'>"
	Response.Write "<input type='checkbox' name='chkAction' "
	Response.Write "value='US' onClick='checkChecked();' " & strChecked & ">&nbsp;&nbsp;"
	Response.Write "</td><td width='9%'>US</td><td> - United States</td></tr>" & vbCrLf
%>
            </table>	
          </td>

        </tr>

        <tr>
          <td>&nbsp;
            
          </td>
        </tr>
      </table>  

    </td>
  </tr>
</table>

    <!-- Buttons -->
    <div ID="buttonsSubmit" Name="buttonsSubmit" class="center" style="margin-top: 2em; display: none;">
      <a href="javascript:clickSubmit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:clickCancel();" class="buttons bo_Button80">Cancel</a>
    </div>

    <div ID="buttonsBack" Name="buttonsBack" class="center" style="margin-top: 2em; display: none;">
      <a href="javascript:clickBack();" class="buttons bo_Button80">Back</a>
      <a href="javascript:clickSubmit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:clickCancel();" class="buttons bo_Button80">Cancel</a>
    </div>

</form>
</body>
</html>
