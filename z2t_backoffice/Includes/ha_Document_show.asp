   
<%   
	'Open connection
	Dim connCasper10: Set connCasper10 = Server.CreateObject("ADODB.Connection")
	connCasper10.Open "driver=SQL Server;server=66.119.55.118,7043;uid=davewj2o;pwd=get2it;database=ha_BackOffice"

	'Declare Variables
    Dim rs
    Dim PhotoID,strSQL
    
	PhotoID = Request("PhotoId")
	If PhotoID = "" Then PhotoID = 0
   
	'Instantiate Objects
	Set rs = Server.CreateObject("ADODB.Recordset")
   
   
	'Get the specific image based on the ID passed in a querystring
    strSQL = "ha_Document_read(" & PhotoID & ")"
    rs.Open strSQL, connCasper10, 3, 3, 4	
	
    if rs.eof then 'No records found
        Response.End
    else 'Display the contents
        Response.ContentType = "image/jpg" 
        Response.BinaryWrite(rs("FileData")) 
    end if
   
   'destroy the variables.
   rs.Close
   connCasper10.Close
   set rs = Nothing
   set connCasper10 = Nothing
   
 %>