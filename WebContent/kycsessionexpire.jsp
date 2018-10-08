<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="./jsp/kycpanel/niceforms-default.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

</script>
</head>
<body>
<%
		java.util.ResourceBundle bundle  = java.util.ResourceBundle.getBundle("resources.ApplicationResources");
	%>
<div id="main_container" >

	<div class="header_login">
    <div class="logo"><a href="#"><img src="<%=request.getContextPath()%>/images/Virtualkyc_logo-v2.png" alt="" title="" border="0" style="visibility:visible"/></a></div>
        </div> 

         <div class="login_form" style="clip:rect(10px,10px,10px,10px)">  
               <h3>KYC Info </h3>
<form name="standardform" action="" method="post">

    
    
    <table width="100%" border=0 cellpadding=5 cellspacing=3>
    <tr>
    <td align=center>
    	<h2><br><br><br><br> Your session has been expired, Login again <a href="./indexv1.jsp">Home</a>
    </td>
    </table>

    
</form>
    </div>         
	
    
    <div class="footer_login">
    
    	<div class="left_footer_login"><%=bundle.getString("label.login.footer")%> | Powered by <a href="http://www.igrandee.com">i-Grandee </a></div>
    	<div class="right_footer_login"></div>
    
    </div>

</div>		
</body>
</html>