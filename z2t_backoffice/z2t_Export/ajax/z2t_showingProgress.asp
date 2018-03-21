<%
dim showProgress: showProgress=request.querystring("Progress")

If len(showProgress) > 0 and showProgress= 1 and Session("CurrentProgress")<> "" Then
	response.write Session("CurrentProgress")
Else
	response.write "NoProgress"
End If


%>