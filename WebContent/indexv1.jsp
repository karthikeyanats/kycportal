<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ResourceBundle"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child Portal Login Panel| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="./jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="./jsp/kycpanel/niceforms-default.css" />

<script type="text/javascript">

	function checkLogin(){

	if(document.loginForm.username.value==""){

		alert("User Name should not be empty");
		return false;
	}
	if(document.loginForm.password.value==""){

		alert("Password should not be empty");
		return false;
	}


	if(document.loginForm.userstate[0].checked){
		document.loginForm.action="./loginverifyparent.jsp";
		//document.loginForm.submit();
	}
	else{

		document.loginForm.action="./loginverify.jsp";
	//	document.loginForm.submit();
	}

}
</script>

</head>
<body onload="document.loginForm.username.focus()">
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

<div id="main_container">

	<div class="header_login">
    <div class="logo"><a href="#"><img src="<%=request.getContextPath()%>/images/Virtualkyc_logo-v2.png" alt="" title="" border="0" style="visibility:visible"/></a></div>

    </div>

         <div class="login_form">

         <h3>KYC Login Panel </h3>

         <a href="./forgotpassword.jsp" class="forgot_pass">Forgot password</a>

         <form name="loginForm" action="" method="post" >

                <fieldset>
                   <table border=0 cellpadding=10 cellspacing=0 align="center">
                   <tr><td colspan=2>

                    <%
                    	       // out.print((String)session.getValue("invalid"));
                    	        if(session.getValue("invalid") != null)
                    	        {
                    	        out.print("<center><font color='red'>"+(String)session.getValue("invalid")+"</font></center>");
                    	        session.putValue("invalid",null);
                    	        }

                    	        %>
                   </td></tr>
                    <tr>
                    <td valign="top" class=tablebold>


                       Username:</td><td>
                        <input type="text" name="username" id="" size="38" class=tablelight maxlength="50"/>

                    </td></tr>
                    <tr><td class=tablebold>

                       Password:</td><td>
                       <input type="password" name="password" id="" size="40" maxlength="50" onkeydown="if(event.keyCode==13) return checkLogin();"/>

                    </td></tr></table>

                     <table border=0 width="25%" align="center">
                    <tr>
                    <td valign="top">

                     <input type="radio" name="userstate" value="parent" id="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();" /> Parent
                        <input type="radio" name="userstate" value="others" id="" checked size="54" onkeydown="if(event.keyCode==13) return checkLogin();" /> Others</dd>
                </td>
                         </tr>
                  </table>
                  <table border=0 width="25%" align="center">
                    <tr>
                    <td valign="top" align=center>

                    <input type="submit" name="submit" id="submit" value="Enter" onclick="checkLogin()"/>
                      </td>
                   </tr>
                  </table>


                </fieldset>

         </form> 
         </div>

    <div class="footer_login">

    	<div class="left_footer_login"><%=bundle.getString("label.login.footer")%><a href="http://www.igrandee.com" target="_blank">i-Grandee </a></div>
    	<div class="right_footer_login"></div>

    </div>

</div>
</body>
</html>