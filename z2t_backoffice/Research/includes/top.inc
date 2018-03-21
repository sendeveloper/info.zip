<!DOCTYPE html>
<!-- include virtual="/z2t_Backoffice/includes/sql.asp"-->
<!--#include virtual="/z2t_Backoffice/Research/includes/sql.asp"-->
<% 
   RowMod = 3 
   sqlConnection = "driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_BackOffice" ' philly05
%>
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/config.asp"-->

<html>
<head>
  <title>Harvest American BackOffice - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
  referrer = Request("referrer")
  If referrer = "" Then
  referrer = Request.Servervariables("HTTP_REFERER")
  End If
%>

  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>z2t_Backoffice.css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>z2t_Backoffice-sensible.css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>sensible.css" />

  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <!--script type="text/javascript" src="<%=strPathIncludes%>lib.js"></script-->
  <script type="text/javascript" src="includes/lib.js"></script>
  

  <style id="top">
    body {white-space: nowrap;}
    header {}
    /* nav {height: 20%;} */
    aside {display: inline-block; width: 18%; overflow: hidden; border-right: 1px solid blue; vertical-align: top;}
    article {display: inline-block; width: 78%; height: 78%; overflow: hidden; margin-top: 0em;}
    footer {}
    div.wonky-table-look-alike {margin-left: auto; margin-right: auto; overflow: hidden; text-align: left; padding: 0em .5em .5em .5em}
    h {text-align: center; font-weight: bold; font-size: 14pt; display: inline-block;}
    aside > h {border-bottom: 1px solid black; margin-top: 1em;}
    aside > h:first-child {margin-top: 0em;}
    table.resultset {background: lightblue;}
    table.resultset tr.rowmod-0 {background: lightyellow;}
    table.resultset tr.rowmod-1 {background: lightpink;}
    table.resultset tr.rowmod-2 {background: lightgreen;}
    aside > select {display: block;}

    /* Temporarily make it readable for development */
    /* div.wonky-table-look-alike {width: 100%;} */

    .layout {list-style: none;}



    html {width: 100%; height: 100%;}
    body {margin-left: auto; margin-right: auto; width: 90%; min-width: 90%; max-width: 90%; height: 100%; overflow: hidden; text-align: left; -moz-box-sizing: border-box;}
    table.header {overflow: hidden; min-width: 100%; width: 100%; max-width: 100%; min-height: 0%; height: auto; max-height: 20%; border: none; text-align: center; border-spacing: 0em; padding: 0em; overflow: hidden;}
    .divDeskTop {height: 0.7em; width: 100%; text-align: left; background-size: 100% 100%; margin-top: 0em; margin-left: auto; margin-right: auto; margin-bottom: 0em; -moz-box-sizing: border-box;}
    .divDeskMiddle {height: auto; width: 100%; min-width: 100%; max-width: 100%; min-height: 0%; height: 79%; max-height: 80%; background-size: 100% 100%; margin-left: auto; margin-right: auto; margin-top: 0em; margin-bottom: 0em; -moz-box-sizing: border-box; overflow: hidden;}
    .divDeskBottom {height: 0.7em; width: 100%; background-size: 100% 100%; margin-bottom: 2em; margin-left: auto; margin-right: auto; margin-top: 0em; -moz-box-sizing: border-box;}
    
    .content {margin: 0em auto 0em auto; width: 100%; min-width: 10%; max-width: 100%; text-align: left; -moz-box-sizing: border-box; overflow: hidden;}
    .contented {margin: .5em 1em .5em 1em;  -moz-box-sizing: border-box; overflow: hidden;}
  </style>

  <script type="text/javascript" language="javascript">
    function init(){
      return;
    }
    window.onload = init;
  </script>
</head>

<body class="gray_desktop">
  <header></header>
<div class="wonky-table-look-alike MainBody">
  <nav><!--#include virtual="/z2t_Backoffice/includes/heading-sensible.inc"--></nav>
  <div class="divDeskTop"></div><!-- divDeskTop -->
  <div class="divDeskMiddle">
    <div class="content">
      <div class="contented">

  <aside>
<%
  Dim rs
  Set rs = sql("select name from philly05.master.sys.databases order by owner_sid, name")
%>
    <h>Catalog</h>
    <select id="catalog">
<%
   Do While not rs.eof
%>
      <option value="<%=rs("name")%>"><%=rs("name")%></option>
<%
     rs.MoveNext
   Loop
%>
    </select>
    <h>Table</h>
    <select id="table">
<%
  Set rs = sql("select * from philly05.z2t_Canada.information_schema.tables")
  Do While Not rs.eof
%>
      <option rel="<%=rs("table_catalog")%>.<%=rs("table_schema")%>.<%=rs("table_name")%>">
        <%=rs("table_name")%>
      </option>
<%
    rs.MoveNext
  Loop
  rs.Close
  Set rs = sql("select class, sequence, value, description, isdefault from philly05.z2t_Backoffice.dbo.z2t_Types order by sequence")
%>
    </select>
    <h>Columns</h>
    <select id="columns" size="10" multiple="multiple">
<% Do While Not rs.eof %>
      <option rel="rs("class")" value="rs("value")">
        <%=rs("description")%>
      </option>
<% 
     rs.MoveNext 
   Loop
   rs.Close
%>
    </select>
  </aside>

  <article>
