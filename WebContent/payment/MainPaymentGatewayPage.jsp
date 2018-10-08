<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Payment Gateway</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script>
function submitfees()
{
if(confirm("Do you want to proceed...?"))
{
	document.paymentgatewayform.action="https://test.authorize.net/gateway/transact.dll";
	document.paymentgatewayform.submit();
}
}
function backfun()
{
	document.paymentgatewayform.action="../jsp/Fees/FeesCollectionFromParent.jsp";
	document.paymentgatewayform.submit();
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../jsp/include/userheader.jsp" %>

    </div>

    <div class="main_content">

<%@ include file="../../jsp/include/header.jsp" %>

    <div class="center_content">

    <div class="left_content">

    </div>

    <div class="right_content">
    <% 
	    String amount1=request.getParameter("amount1");
	    String termfeesid=request.getParameter("termfeesid");
    %>
<form name='paymentgatewayform' method='post' action=''>
<br>
<iframe src="./checkoutform.jsp?amount1=<%=amount1%>&termfeesid=<%=termfeesid%>"  frameborder=1 width="100%" height="500px" ></iframe>
<a href="#" class="bt_blue" onclick="backfun()" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feespaidlist.Back")%></strong><span class="bt_blue_r"></span></a>
 
  </FORM>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->


<%@ include file="../../jsp/include/footer.jsp" %>



</div>
</body>
</html>