<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/DBConstants.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackOfficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%


	Dim cmd
	Dim rs
	Dim ErrMsg
	Dim MainRowCnt
	Dim SubRowCnt

	Dim reqTaxType
	Dim reqTaxTypeVariation
	Dim reqJurType
	Dim reqState
	Dim reqCounty
	Dim reqCity
	Dim reqDistrict
	Dim reqRate
	Dim reqTotal
	Dim reqCode
	Dim reqFrom
	Dim reqTo
	Dim reqID
	Dim reqAction

	ErrMsg = ""

	If Request("taxType")="" or isnull(Request("taxType")) Then
		ErrMsg = ErrMsg & "Missing TaxType. "
	Else
		reqTaxType = request("taxType")
	End If

	If Request("taxTypeVariation")="" or isnull(Request("taxTypeVariation")) Then
		ErrMsg = ErrMsg & "Missing TaxTypeVariation. "
	Else
		reqTaxTypeVariation = request("taxTypeVariation")
	End If

	If Request("jurType")="" or isnull(Request("jurType")) Then
		ErrMsg = ErrMsg & "Missing JurType. "
	Else
		reqJurType = request("jurType")
	End If

	If Request("state")="" or isnull(Request("state")) Then
		ErrMsg = ErrMsg & "Missing State. "
	Else
		reqState = request("state")
	End If

	If Request("county")="" or isnull(Request("county")) Then
		reqCounty = ""
	Else
		reqCounty = request("county")
	End If

	If Request("city")="" or isnull(Request("city")) Then
		reqCity = ""
	Else
		reqCity = request("city")
	End If
	'
	If Request("districtname")="" or isnull(Request("districtname")) Then
		reqDistrict = ""
	Else
		reqDistrict = request("districtname")
	End If

	If Request("id")="" or isnull(Request("id")) Then
		reqID = -1
	Else
		reqID = request("id")
	End If

	If Request("action")="" or isnull(Request("action")) Then
		ErrMsg = ErrMsg & "Missing Action. "
	Else
		reqAction = Request("action")
	End If

	If LCase(reqAction) = "delete" Then
		reqRate  = "0"
		reqTotal = "0"
		reqCode  = ""
		reqFrom  = "1/1/1900"
		reqTo    = "1/1/1900"
	Else
		If Request("eRate")="" or isnull(Request("eRate")) Then
			reqRate = "0"
		Else
			reqRate = Trim(Request("eRate"))
			If Not isNumeric(reqRate) Then
				reqRate = "0"
			End If
		End If

		If Request("eTotal")="" or isnull(Request("eTotal")) Then
			reqTotal = "0"
		Else
			reqTotal = Trim(Request("eTotal"))
			If Not isNumeric(reqTotal) Then
				reqTotal = "0"
			End If
		End If

		If Request("eCode")="" or isnull(Request("eCode")) Then
			reqCode = ""
		Else
			reqCode = request("eCode")
		End If

		If Request("eFrom")="" or isnull(Request("eFrom")) Then
			ErrMsg = ErrMsg & "Missing 'From' Date. "
		Else
			reqFrom = request("eFrom")
		End If

		If Request("eTo")="" or isnull(Request("eTo")) Then
			ErrMsg = ErrMsg & "Missing 'To' Date. "
		Else
			reqTo = request("eTo")
		End If
	End If

	RetPage = "z2t_TaxData_Edit.asp?taxType=" & reqTaxType & "&taxTypeVariation=" & reqTaxTypeVariation & "&jurType=" & reqJurType & "&state=" & reqState & "&county=" & Server.URLEncode(reqCounty) & "&city=" & Server.URLEncode(reqCity)  & "&districtname=" & Server.URLEncode(reqDistrict)
	dim spcall

    If ErrMsg = "" Then
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = connUpdateRates

		cmd.CommandText = "z2t_TaxData_post"
		cmd.CommandType = adCmdStoredProc
		cmd.Parameters.Refresh	
		spcall = spcall & "exec z2t_TaxData_post "

		cmd.Parameters("@ID").value                = cLng(reqID)
		cmd.Parameters("@Action").value            = reqAction
		cmd.Parameters("@TaxType").value           = cLng(reqTaxType)
		cmd.Parameters("@TaxTypeVariation").value  = cLng(reqTaxTypeVariation)
		cmd.Parameters("@JurType").value           = cLng(reqJurType)
		cmd.Parameters("@JurRate").value           = cDbl(reqRate)
		cmd.Parameters("@Rate").value              = cDbl(reqTotal)
		cmd.Parameters("@JurCode").value           = reqCode
		cmd.Parameters("@EffFrom").value           = reqFrom
		cmd.Parameters("@EffTo").value             = reqTo
		cmd.Parameters("@State").value             = reqState
		
				''For Debugging Purpose only

			'	spcall = spcall & cLng(reqID) & ", " & reqAction & " ," & cLng(reqTaxType) & ", " & cLng(reqTaxTypeVariation) & ", " & cLng(reqJurType) & ", " & cDbl(reqRate)& ", " & cDbl(reqTotal) & ", " & reqCode & ", " & reqFrom & " ," & reqTo & ", " & reqState
				
		If reqCounty = "(Null)" Then
			cmd.Parameters("@County").value  = Null
			'spcall = spcall & ", Null "
		ElseIf reqCounty = "(Blank)" Then
			cmd.Parameters("@County").value  = ""
			'spcall = spcall & ", "
		Else
			cmd.Parameters("@County").value  = reqCounty
			'spcall = spcall & "," & reqCounty
		End If

		If reqCity = "(Null)" Then
			cmd.Parameters("@City").value  = Null
			'spcall = spcall & ",NULL" 
		ElseIf reqCity = "(Blank)" Then
			cmd.Parameters("@City").value  = ""
			'spcall = spcall & "," 
		Else
			cmd.Parameters("@City").value  = reqCity
			'spcall = spcall & "," & reqCity
		End If
		
		If reqDistrict = "(Null)" Then
			cmd.Parameters("@districtname").value  = Null
			'spcall = spcall & ",NULL" 
		ElseIf reqDistrict = "(Blank)" Then
			cmd.Parameters("@districtname").value  = ""
			'spcall = spcall & "," 
		Else
			cmd.Parameters("@districtname").value  = reqDistrict
			'spcall = spcall & "," & reqDistrict
		End If
		
		
		cmd.Parameters("@UserName").value    = Session("z2t_UserName")
		'spcall = spcall & "," & Session("z2t_UserName")
		
		''For Debugging Purpose
		'response.Write(spcall) 
		'response.Write("<br/>")
		'response.Write(response.Parameters)
		'response.End()
		Set rs = cmd.Execute
		ErrMsg = ErrMsg & Trim(rs("ErrMsg"))
		MainRowCnt = rs("MainRowCnt")
		SubRowCnt = rs("SubRowCnt")
		
		rs.close
		
		Set rs = Nothing
		Set cmd = nothing
	End If
	
	If ErrMsg = "" Then
		Response.redirect RetPage & "&mainRowCnt=" & MainRowCnt & "&subRowCnt=" & SubRowCnt
	Else
%>
		<html>
		<head>
			<title>Zip2Tax.info - Edit Tax Rates</title>

			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		</head>

		<body>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
		  <tr>
			<td align="center">
				<b>An error occurred: <%=ErrMsg%></b>
			</td>
		  </tr>
		</table>

		</body>
		</html>
<%
	End If
%>
