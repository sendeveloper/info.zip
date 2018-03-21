<%
''''' Changelog
'
' Modified: <2012-04-20 Fri nathan>
' Description: Prevent &nbsp; characters from making their way into the database. (Especially the JurCode field.)
'


FUNCTION iif(boolEval, trueStr, falseStr)

    if boolEval then
	iif = trueStr
    else 
	iif = falseStr
    end if

END FUNCTION

FUNCTION iisNull(fieldstr)

    if isNull(fieldstr) then
   iisNull = ""
    else 
	iisNull = trim(fieldstr)
    end if

END FUNCTION
%>
