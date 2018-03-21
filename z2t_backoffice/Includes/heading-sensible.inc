<div class="heading">
  <span class="logo">
    <img src="<%=strPathImages%>z2t-icon.png" alt="Zip2Tax Logo"
         Title="Zip2Tax, LLC Tax Data Providers"><br>
    BACKOFFICE
  </span>

  <span class="title">
    <hr>
    <%=PageHeading%>
    <hr>
  </span>

  <span class="logout white">
    <a href="<%=strBasePath%>z2t_Logout.asp" style="color: #FFFFFF; margin-bottom: 3em;">Logout <%=Session("z2t_UserName")%></a>
  </span>
  
  <!-- isolate the abused table to this file -->
  <table class="nav" width="1200" cellspacing="1" cellpadding="0" padding="0" border="0" align="center">
    <!--#include virtual="z2t_Backoffice/includes/menu/PageMenu.inc"-->
  </table><!-- nav -->
</div><!-- heading -->


<%
Function DateCode

    DateCode = Right(Day(Date), 1) & _
        Left(Right("00" & day(Date), 2),1) & _
        Right(Ucase(MonthName(Month(Date))), 1) & _
        Left(Ucase(MonthName(Month(Date))), 1)

End Function
%>
