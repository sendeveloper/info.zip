<!DOCTYPE html>
<!--#include virtual="/z2t_Backoffice/includes/sql.asp"-->
<% RowMod = 3 %>
<html>
  <head>
    <title>New Page</title>

    <script type="text/javascript">
      function init(){
        (function(footer) {
          footer.innerHTML = "Passed";
          footer.style.color = "green";})(document.getElementsByTagName("footer")[0].getElementsByTagName("em")[0]);
        return;}
      
      window.onload = init;
    </script>

    <style>
      html {height: 100%; max-height: 100%; overflow: hidden; white-space: nowrap;}
      body {display: table; max-height: 100%; height: 100%; overflow: hidden; white-space: nowrap; margin: 0em; padding: 0em; table-layout: fixed;}
      header {display: table-header; text-align: center; font-size: 2em; font-weight: bold; margin-top: .5em; margin-bottom: 1em;}
      div.body {display: table-row; width: 100%; height: 100%}
      article {display: table-cell; width: 60%; height: 100%;}
      aside {display: table-cell; border-left: 1px solid black; padding-left: .5em; width: 20%; height: 100%;}
      footer {display: table-footer; bottom: 0em; position: absolute;}
      footer > em {color: red;}

      .resultset {margin-left: auto; margin-right: auto;}
    </style>
  </head>
  <body>
    <header>New Page Template</header>
    <div class="body">
      <article>
        <div class="excel-document">
          <%=SqlTable("select 1")%>
        </div>
      </article>
    </div>
    <aside><div>Extra content goes here</div></aside>
    
    <footer>Javascript: <em>Failed</em></footer>
  </body>
</html>
