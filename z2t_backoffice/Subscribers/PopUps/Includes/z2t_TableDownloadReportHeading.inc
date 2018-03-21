
<%
	Function ColumnHeading(pHeading, pFieldName)
		Response.write vbCrLf
		'Response.write "<th align='center' valign='middle' height='25'>" & vbCrLf
		Response.write "  <table border='0' cellspacing='2' cellpadding='2' align='center' >" & vbCrLf
		Response.write "    <tr>" & vbCrLf
		Response.write "      <th >" & vbCrLf
		Response.write "        " & pHeading & vbCrLf
		Response.write "      </th>" & vbCrLf
		Response.write "      <td>" & vbCrLf
		Response.write "        <table border='0' cellspacing='0' cellpadding='0'>" & vbCrLf
		Response.write "          <tr>" & vbCrLf
		Response.write "            <td>" & vbCrLf
		Response.write "              <a href='#' onClick='sortFrm(""" & pFieldName & """, ""a"");'>" & vbCrLf
		Response.write "                <img src='" & strPathImages & "ArrowAscending.jpg' style='border: none'" & vbCrLf
		Response.write "				     title='" & pHeading & " Ascending' alt='" & pHeading & " Ascending'>" & vbCrLf
		Response.write "			  </a>" & vbCrLf
		Response.write "            </td>" & vbCrLf
		Response.write "          </tr>" & vbCrLf
		Response.write "          <tr>" & vbCrLf
		Response.write "            <td>" & vbCrLf
		Response.write "              <a href='#' onClick='sortFrm(""" & pFieldName & """, ""d"");'>" & vbCrLf
		Response.write "                <img src='" & strPathImages & "ArrowDescending.jpg' style='border: none'" & vbCrLf
		Response.write "                     title='" & pHeading & " Descending' alt='" & pHeading & " Descending'>" & vbCrLf
		Response.write "			  </a>" & vbCrLf
		Response.write "            </td>" & vbCrLf
		Response.write "          </tr>" & vbCrLf
		Response.write "        </table>" & vbCrLf
		Response.write "      </td>" & vbCrLf
		Response.write "    </tr>" & vbCrLf
		Response.write "  </table>" & vbCrLf
		'Response.write "</th>" & vbCrLf
	End Function
%>


