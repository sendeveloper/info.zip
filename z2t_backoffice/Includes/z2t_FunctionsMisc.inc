<%

  Function CreditLine(eCreatedBy, eCreatedDate, eEditedBy, eEditedDate)
  	  
	CreditLine = "<span class='popupCreditLeft'>" & CreditInfo("Created", eCreatedBy, eCreatedDate) & "</span>" & _
		"<span class='popupCreditRight'>" & CreditInfo("Edited", eEditedBy, eEditedDate) & "</span>"
  End Function
  
  Function CreditInfo(iPrefix, iWho, iWhen)
	Dim s
	
	If iWho > "" Then
		s = "by " & iWho & " "
	End If
	
	If iWhen > "" Then
		s = s & "on " & ConvDate(iWhen, "%a, %b %d, %Y  %I:%M %P")
	End If
	
	If s > "" Then
		s = iPrefix & " " & s
	End If
	
	CreditInfo = s
	
  End Function
  
  Function ConvDate(strDate, strFormat)

   Dim intPosItem
   Dim intHourPart
   Dim strHourPart
   Dim strMinutePart
   Dim strSecondPart
   Dim strAMPM

   If not IsDate(strDate) Then
      ConvDate = strDate
      Exit Function
   End If
	
   intPosItem = Instr(strFormat, "%m")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      DatePart("m",strDate) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%m")
   Loop

   intPosItem = Instr(strFormat, "%b")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      MonthName(DatePart("m",strDate),True) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%b")
   Loop
	
   intPosItem = Instr(strFormat, "%B")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      MonthName(DatePart("m",strDate),False) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%B")
   Loop
	
   intPosItem = Instr(strFormat, "%d")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      DatePart("d",strDate) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%d")
   Loop

   intPosItem = Instr(strFormat, "%j")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      DatePart("y",strDate) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%j")
   Loop

   intPosItem = Instr(strFormat, "%y")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      Right(DatePart("yyyy",strDate),2) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%y")
   Loop

   intPosItem = Instr(strFormat, "%Y")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      DatePart("yyyy",strDate) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%Y")
   Loop

   intPosItem = Instr(strFormat, "%w")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      DatePart("w",strDate,1) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%w")
   Loop

   intPosItem = Instr(strFormat, "%a")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      WeekDayName(DatePart("w",strDate,1),True) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%a")
   Loop

   intPosItem = Instr(strFormat, "%A")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & _
      WeekDayName(DatePart("w",strDate,1),False) & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%A")
   Loop

   intPosItem = Instr(strFormat, "%I")
   Do While intPosItem > 0
      intHourPart = DatePart("h",strDate) mod 12
      if intHourPart = 0 then intHourPart = 12
      strFormat = Left(strFormat, intPosItem-1) & _
      intHourPart & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%I")
   Loop

   intPosItem = Instr(strFormat, "%H")
   Do While intPosItem > 0
      strHourPart = DatePart("h",strDate)
      if strHourPart < 10 Then strHourPart = "0" & strHourPart
      strFormat = Left(strFormat, intPosItem-1) & _
      strHourPart & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%H")
   Loop

   intPosItem = Instr(strFormat, "%M")
   Do While intPosItem > 0
      strMinutePart = DatePart("n",strDate)
      if strMinutePart < 10 then strMinutePart = "0" & strMinutePart
      strFormat = Left(strFormat, intPosItem-1) & _
      strMinutePart & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%M")
   Loop

   intPosItem = Instr(strFormat, "%S")
   Do While intPosItem > 0
      strSecondPart = DatePart("s",strDate)
      if strSecondPart < 10 then strSecondPart = "0" & strSecondPart
      strFormat = Left(strFormat, intPosItem-1) & _
      strSecondPart & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%S")
   Loop

   intPosItem = Instr(strFormat, "%P")
   Do While intPosItem > 0
      if DatePart("h",strDate) >= 12 then
         strAMPM = "PM"
      Else
         strAMPM = "AM"
      End If
      strFormat = Left(strFormat, intPosItem-1) & strAMPM & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%P")
   Loop

   intPosItem = Instr(strFormat, "%%")
   Do While intPosItem > 0
      strFormat = Left(strFormat, intPosItem-1) & "%" & _
      Right(strFormat, Len(strFormat) - (intPosItem + 1))
      intPosItem = Instr(strFormat, "%%")
   Loop

   ConvDate = strFormat
	
	'%m Month as a decimal no. 02
	'%b Abbreviated month name Feb
	'%B Full month name February
	'%d Day of the month 23
	'%j Day of the year 54
	'%y Year without century 98
	'%Y Year with century 1998
	'%w Weekday as integer 5 (0 is Sunday)
	'%a Abbreviated day name Fri
	'%A Weekday Name Friday
	'%I Hour in 12 hour format 12
	'%H Hour in 24 hour format 24
	'%M Minute as an integer 01
	'%S Second as an integer 55
	'%P AM/PM Indicator PM
	'%% Actual Percent sign %% 

End Function

%>