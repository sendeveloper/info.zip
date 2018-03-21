<!--#include virtual="/includes/Config.asp"-->
<!--include virtual="/includes/Secure.asp"-->
<!--#include virtual="/includes/sql.asp"-->
<%
  Dim opid
  Dim EmpId
  Dim rs
  Dim sqlText
  Dim vbcrlf
  vbcrlf = "<br>" 'chr(13) + chr(10)
  sqlConnectionString = "Driver=SQL Server;server=localhost,7943;uid=davewj2o;pwd=get2it;database=tempdb" ' casper09
  sqlConnectionString = "Driver=SQL Server;server=localhost,7943;uid=davewj2o;pwd=get2it;database=z2t_WebPublic" ' casper09
  'sqlDebug = True
%>

<%
  Dim shell
  Set shell = CreateObject("WScript.Shell")
  Dim process: Set process = shell.Exec("cmd /c C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.EXE > &1")
  
  'Dim process: Set process = shell.Exec("cmd /c ""D:\network-administration\cygwin\bin\curl.exe""")

  'Dim process: Set process = shell.Exec("cmd /c ""D:\network-administration\cygwin\bin\echo bye-bye""")

    Do While (process.Status = 0)
      Response.Write(process.StdOut.ReadAll())
    Loop

  Response.Write("Running command... done: status " & process.Status & ".<br>")

  'Response.End()

  'Dim process: Set process = shell.Exec("cmd /c ""C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.bat"" 2>&1")
  'Set shell = CreateObject("WScript.Shell").Exec("""C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.exe""")


  'Server.ScriptTimeout = 65535
  'SqlTimeout = 65535
  
  Response.Write(SqlTable("xp_cmdshell '""C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.bat""'")): Response.End()
  'Response.Write(SqlTable("xp_cmdshell '""C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.exe""'"))
  'Sql("exec xp_cmdshell '""C:\Projects\Zip2Tax\StateRatePageDuplicator\StateRatePageDuplicator.exe""'")
%>
