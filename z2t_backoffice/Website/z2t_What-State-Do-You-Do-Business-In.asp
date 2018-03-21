<%response.buffer=true%>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_BackOffice/includes/sql.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  dim strColor
  dim PageHeading
  dim recordCount
  dim StateAbbr(100)
  dim StateName(100)

  PageHeading = """What States And Provinces Do You Do Business In?"" Section Maintenance"
  ColorTab = 6


%>

<html>
<head>
  <title><%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <script type="text/javascript" src="<%=strPathIncludes%>includes/lib.js"></script>
  <script>
    function init(event) {
      listen(get("#view"), "click", function () {window.open("http://zip2tax.com/index-no.asp", "_mockup"); return;});
      listen(get("#copy"), "click", function(event) {
        if (window.clipboardData) {        
          window.clipboardData.setData("Text", get("#html").innerHTML);}
        else {
          get("#copy-status").innerHTML = "Clipboard only works in IE (considered insecure elsewhere).";
          get("#html").focus();
          get("#html").select();}
        return;});

      get("#html").wrap = "off";}

    listen(window, "load", init);
  </script>


  <style type="text/css">
    td {font-size: 12pt;}
    button.disabled {background-color: darkgrey; color: lightgrey;}
	
    textarea#html 
		{
		font: courier;
		width: 90%; 
		height: 40em; 
		white-space: nowrap;
		}
  </style>

</head>

<body>

  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
  <tr><td>
      <table width="100%" height="100%" border="0" cellspacing="5" cellpadding="5">
        <tr valign="top" style="width: 100%; height: 100%;">
          <td style="width: 100%; height: 100%;">
            <p>Paste the following HTML into the include file for the
              "What States And Provinces Do You Do Business In?" section on the
              Zip2Tax home page.</p>
	    <button id="view" style="margin-bottom: .5em;">View Mockup Page</button><br>
	    <button id="copy" style="margin-bottom: 1em;">Copy to clipboard</button>
	    <span id="copy-status"></span>
	    <textarea id="html">
	      <div id="What States And Provinces Do You Do Business In?">
		    <%=space(2)%><h2 class="title">What States And Provinces Do You Do Business In?</h2>
			
			  <%=space(2)%><div class="entry">
			    <%=paragraphs%>
			
				<%=space(4)%><p><span class="firstword">Provinces And Territories Participating With The Harmonized Sales Tax:</span><br>
				  <%=space(6)%>British Columbia, 
				  <%=space(6)%>New Brunswick, 
				  <%=space(6)%>Newfoundland and Labrador, 
				  <%=space(6)%>Nova Scotia and
				  <%=space(6)%>Ontario
				<%=space(4)%></p>

				<%=space(4)%><p><span class="firstword">Provinces And Territories Using An Individual Retail Sales Tax:</span><br> 
				  <%=space(6)%>Manitoba, 
				  <%=space(6)%>Prince Edward Island, 
				  <%=space(6)%>Saskatchewan and 
				  <%=space(6)%><span class="ref-QC">Quebec</span><span class="footnote-QC">**</span>
				<%=space(4)%></p>
			
				<%=space(4)%><p><span class="firstword">Provinces And Territories Requiring Only The Goods and Services Tax (GST):</span><br> 
				  <%=space(6)%>Alberta, 
				  <%=space(6)%>Northwest Territories, 
				  <%=space(6)%>Nunavut and
				  <%=space(6)%>Yukon
				<%=space(4)%></p>

                <%=space(4)%><p>
				  <%=space(6)%><span "unfootnote-HI">*</span><span name="footnote-HI">Technically, Hawaii has an excise tax, not a sales tax</span><br>
                  <%=space(6)%><span "unfootnote-QC">**</span><span name="footnote-QC">Quebec administers both the federal GST and its own Quebec Sales Tax (QST)</span>
				<%=space(4)%></p>
				  
	          <%=space(2)%></div><!-- End Entry -->
		  </div><!-- What States And Provinces Do You Do Business In? -->
	    </textarea>
          </td>
        </tr>
      </table>

      </td>
    </tr>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
  
  </body>
</html>

<%
'Mark up as html paragraphs 
Function paragraphs
  Dim sqlText
  sqlText = "select Description, TaxType = case when Value < 6 then 'Sales' else 'Use' end " &_
            "from z2t_BackOffice.dbo.z2t_Webpage_Types " &_
            "where Class = 'Webpage Home Class' " &_
            "and Value <= 8 " &_
            "order by Sequence "
  'Response.Write(sqlText)
  Dim rs
  Set rs = Sql(sqlText)
  paragraphs = ""
  
  Do While Not rs.eof
    paragraphs = paragraphs & space(4) & "<p><span class=""firstword"">" & rs("Description") & ": " & "</span><br>" & vbCrLf & _
	  listify(rs("Description"), rs("TaxType")) & vbCrLf & space(4) & "</p></br>" & vbCrLf & vbCrLf
    rs.movenext
  Loop
  
End Function


'Format a list according to English rules with comma delimiters and final conjunction for more than two items.
Function listify(taxClass, taxType)
  Dim sqlType
  Select Case taxType
  Case "Sales"
    sqlType = "left join z2t_BackOffice.dbo.z2t_Webpage_Types as c on c.Class = 'Webpage Home Class' and c.Value = convert(nvarchar(max), d.[What-States-Do-You-Do-Business-In-SalesTax]) "
  Case "Use"
    sqlType = "left join z2t_BackOffice.dbo.z2t_Webpage_Types as c on c.Class = 'Webpage Home Class' and c.Value = convert(nvarchar(max), d.[What-States-Do-You-Do-Business-In-UseTax]) "
  End Select

  Dim sqlText
  sqlText = "select State = t.Description " &_
	    "from z2t_BackOffice.dbo.z2t_Webpage_Duplication_States_data as d " &_
            "join z2t_BackOffice.dbo.z2t_Webpage_Types as t on t.Value = d.[State] " &_
            sqlType &_
            "where c.Description = '" & taxClass & "' "
  'Response.Write(sqlText) & vbCrLf
  Dim rs
  Set rs = Sql(sqlText)

  If rs.eof Then
    listify = "None" & vbCrLf
    Exit Function
  Else
    listify = linkify(rs("State"), taxType)
  End If
  
  rs.movenext
  Dim Previous
  
  If rs.eof Then
    Exit Function
  Else
    previous = linkify(rs("State"), taxType)
  End If
  
  rs.movenext
  If rs.eof Then
    listify = listify & " and" & vbcrlf & previous
  End If
  
  Do While Not rs.eof
    listify = listify & "," & vbcrlf & previous
    previous = linkify(rs("State"), taxType)
    rs.movenext
  Loop
  
  If listify > "" Then
    listify = listify & " and" & vbcrlf & previous
  Else
    listify = previous
  End If
End Function


Function linkify(text, taxtype)
  linkify = space(6) & "<a href=""" & "http://Zip2Tax.com/State/" & replace(text, " ", "-") & "-State-Rates""" & vbcrlf & _
	space(10) & "   " & "target=""State " & taxType& " Tax Rates""" & vbcrlf & _
	space(10) & "   " & "title=""" & text & " " & taxtype & " Tax Rates"">" & _
		replace(text, "Hawaii", "<span class=""ref-HI"">Hawaii</span><span class=""footnote-HI"">*</span>") & "</a>"
End Function

Function space(quantity)
	For i = 1 to quantity
		space = space & "&nbsp;"
	Next
End Function

%>
