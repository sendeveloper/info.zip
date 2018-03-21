<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%  


    PageHeading = "Special Rules"
	ColorTab = 1



    if Request("ID")="" OR isnull(Request("ID")) then
        NoteID = ""
	else
        NoteID = Request("ID")
    end if

    if Request("retPage")="" OR isnull(Request("retPage")) then
        RetPage = "z2t_SpecialRules.asp"
	else
        RetPage = Request("retPage")
    end if

    if Request("action")="" OR isnull(Request("action")) then
        Response.Redirect RetPage
	else
        Action = Request("action")
    end if

	State    = ""
	County   = ""
	City     = ""
	Zip      = ""
	Category = ""
	Note     = ""

    if NoteID > "" then
		set objRS=Server.CreateObject("ADODB.Recordset")
		objRS.CursorLocation = 3

		strSQL = "z2t_SpecialRules_read (" & NoteID & ")"

		objRS.open strSQL, connBackoffice, 3, 3, 4

		if not objRS.eof then
			State    = objRS("State")
			County   = objRS("County")
			City     = objRS("City")
			Zip      = objRS("Zip")
			Category = objRS("Category")
			Note     = objRS("Note")
		end if
		
		objRS.close
	end if
%>

	<!--#include virtual='z2t_Backoffice/includes/DBConstants.inc'-->
	<!--#include virtual='z2t_Backoffice/includes/DBFunctions.asp'-->

<html>
<head>
    <title>Zip2Tax.info - Special Rules</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<script language="javascript" type="text/javascript">
    function clickSubmit()
        {
			var validated = true;

			if (document.editform.action.value == "Add")
				{
				var state = document.editform.state.value;
				var category = document.editform.category.value;
			
				if (state == "")
					{validated = false;
					alert ("Please choose a state.");
					};

				if (category == "")
					{validated = false;
					alert ("Please choose a category.");
					};
				}
				
		<%if LCase(Category) = "tax on shipping" then %>
			var objShipTax = document.getElementsByName("taxOnShipping");
			var objNotes = document.getElementsByName("selectNote");
			
			if (objShipTax[0].checked)
				{document.editform.note.value = objNotes[0].value;
				 document.editform.shippingTaxable.value = 'Y'
				}
			else if (objShipTax[1].checked)
				{document.editform.note.value = objNotes[1].value;
				 document.editform.shippingTaxable.value = 'N'
				}
			else
				{
				validated = false;
				alert ("Please specify whether the shipping charges are taxable");
				};
		<%end if%>
			
			if (validated)
				document.editform.submit();
        }
    function clickCancel()
        {
			document.cancelform.submit();
        }
	</script>

</head>

<body onKeyPress="keytest(event);">

  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
        <form name='editform' action='z2t_SpecialRules_Post.asp' method='Post'>
        <tr valign="top">
          <td width="100%" align="left">
		  
		    <input type="hidden" name="ID"              id="ID"      value="<%=NoteID%>">
		    <input type="hidden" name="action"          id="action"  value="<%=Action%>">
		    <input type="hidden" name="retPage"         id="retPage" value="<%=RetPage%>">
		    <input type="hidden" name="shippingTaxable" id="shippingTaxable">
			
            <table width="50%" border="0" cellspacing="10" cellpadding="0" align="center" bgcolor="#FFFFFF">
              <tr>
				<td width="15%" align="right">State:</td>
				<td width="85%">
				<% 'If editing an existing note, don't allow changes to State or Category
				   if NoteID > "" then %>
					<%=State%>
					<input type="hidden" name="state" id="state" value="<%=State%>" />
				<% else %>
					<select name="state" id="state" tabindex="1">
						<option value=""></option>
						<option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AS">American Samoa</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option>
						<option value="AA">Armed Forces Americas</option>
						<option value="AP">Armed Forces Pacific</option>
						<option value="AE">Armed Forces Other</option>
						<option value="CA">California</option>
						<option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="DC">District of Columbia</option>
						<option value="FM">Federated States of Micronesia</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="GU">Guam</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MH">Marshall Islands</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="MP">Northern Mariana Islands</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PW">Palau</option>
						<option value="PA">Pennsylvania</option>
						<option value="PR">Puerto Rico</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VI">Virgin Islands</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option>
					</select>
				<% end if %>
                </td>
			  </tr>
			  <tr>
                <td align="right">County:</td>
                <td><input type="text" name="county" id="county" size="25" tabindex="2" value="<%=County%>"></td>
			  </tr>
			  <tr>
                <td align="right">City:</td>
                <td><input type="text" name="city" id="city" size="25" tabindex="3" value="<%=City%>"></td>
			  </tr>
			  <tr>
                <td align="right">Zip:</td>
                <td><input type="text" name="zip" id="zip" size="5" tabindex="4" value="<%=Zip%>"></td>
			  </tr>
			  <tr>
                <td align="right">Category:&nbsp;</td>
				<td>
				<% 'If editing an existing note, don't allow changes to State or Category
				   if NoteID > "" then %>
					<%=Category%>
					<input type="hidden" name="category" id="category" value="<%=Category%>" />
				<% else %>
					<select name="category" id="category" tabindex="5">
						<option value=""></option>
					<%
					set rsCategory=Server.CreateObject("ADODB.Recordset")
					rsCategory.CursorLocation = 3

					strSQL = "z2t_SpecialRules_dropdown"

					rsCategory.open strSQL, connBackoffice, 3, 3, 4

					Do until rsCategory.eof
					%>
						<option value="<%=rsCategory("Category")%>"><%=rsCategory("Category")%></option>
					<%
						rsCategory.MoveNext
					Loop

					rsCategory.Close
					set rsCategory = nothing
					%>
					</select>
				<% end if %>
                </td>
			  </tr>
			  <tr>
			<% 'The Tax on Shipping category allows only two possible values for the Note.
			if LCase(Category) = "tax on shipping" then %>
                <td align="left" colspan="2">
					<br />
					&nbsp;Shipping charges are:
					<input type="hidden" name="note" id="note" value="<%=Note%>">
				</td>
			  </tr>
			  <tr>
				<td align="right">
					<input type="radio" name="taxOnShipping" id="taxOnShipping" <%if LCase(Note)="shipping charges are taxable" then%>checked="true"<%end if%> tabindex="6" />
				</td>
				<td align="left" nowrap>
					&nbsp;Taxable
					<input type="hidden" name="selectNote" id="selectNote" value="Shipping charges are taxable" />
				</td>
			  </tr>
			  <tr>
				<td align="right">
					<input type="radio" name="taxOnShipping" id="taxOnShipping" <%if LCase(Note)="shipping charges are not taxable" then%>checked="true"<%end if%> tabindex="7" />
				</td>
				<td align="left" nowrap>
					&nbsp;Not taxable
					<input type="hidden" name="selectNote" id="selectNote" value="Shipping charges are not taxable" />
				</td>
			<% else %>
                <td align="right">Note:</td>
                <td><textarea name="note" id="note" rows="4" cols="50" tabindex="6"><%=Note%></textarea></td>
			<% end if %>
			  </tr>				
            </table>
          </td>
        </tr>

	    <tr valign="top">
          <td width="100%" align="left">
            <table width="50%" border="0" cellspacing="20" cellpadding="0" align="center">
			  <tr>
				<td valign='center' align='right'>
				  <a href="javascript:clickSubmit();" class="button">Submit</a>
				</td>
				<td valign='center' align='left'>
				  <a href="javascript:clickCancel();" class="button">Cancel</a>
				</td>
              </tr>
            </table>
          </td>
        </tr>

	    </form>

		<form name='cancelform' action='<%=RetPage%>' method='Post'>
		</form>

  <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
