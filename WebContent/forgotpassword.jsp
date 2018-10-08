<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ResourceBundle"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child Portal Forgot Login | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="./jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="./jsp/kycpanel/niceforms-default.css" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">

	function checkLogin(){  

	if(document.loginForm.username.value==""){
	
		alert("User Name should not be empty");
		return false;
	} 
	if(document.loginForm.emailid.value==""){
	
		alert("E-Mail ID should not be empty");
		return false;
	}
	if(!email_Validation(document.loginForm.emailid,"Mail Id",true))
   {
 	return false;
   }
	if(document.loginForm.userstate[0].checked){
		document.loginForm.action="forgotsubmit.jsp?flage=parent";
		//document.loginForm.submit(); 
	}       
	else{
  		document.loginForm.action="forgotsubmit.jsp?flage=others";
		//document.loginForm.sumbit();  
	}
	
	
}
function backLogin()
{
	document.loginForm.action="indexv1.jsp";
	//document.loginForm.submit();
}
</script>

<script language="javascript" type="text/javascript" src="./jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="./jsp/kycpanel/niceforms-default.css" />
<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
<body onload="document.loginForm.username.focus()">
<form name="loginForm" action="" method="post">  
<div id="main_container" >

	<div class="header_login">
    <div class="logo"><a href="#"><img src="<%=request.getContextPath()%>/images/Virtualkyc_logo-v2.png" alt="" title="" border="0" style="visibility:visible"/></a></div>
        </div> 

         <div class="login_form" style="clip:rect(10px,10px,10px,10px)">  
               <h3>Forgot Password </h3> 
         

                <fieldset>
                   <table border="0" cellpadding="10" cellspacing="0" align="center">
                   <tbody><tr><td colspan="2">

                    
                   </td></tr>
                    <tr>
                    <td valign="top" class="tablebold">


                       Username:</td><td>
                       <input type="text" name="username" maxlength="50" id="" size="45">

                    </td></tr>
                    <tr><td class="tablebold">

                       E-Mail ID :</td><td>
                      <input type="text" name="emailid" id="" maxlength="50" size="45">

                    </td></tr></tbody></table>

                     <table border="0" width="25%" align="center">
                    <tbody><tr>
                    <td valign="top">
                   
                       <input type="radio" name="userstate" value="parent" id="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Parent</td> 
                       <td valign="top"><input type="radio" name="userstate" value="others" id="" checked="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Others</td>
                  </tr>
                  <tr>
                  <td valign="top" colspan="2" align="center">    
                   <input type="submit" name="submit" id="submit" value="Enter" onclick="checkLogin()">
                        
                   <input type="submit" name="Back" id="submit" value="Back" onclick="backLogin()">
                   </td>
                  </tr>
                  </tbody></table>


                </fieldset>
                   
       
         </div>         
	
    
    <div class="footer_login">
   	 <div class="left_footer_login"><%=bundle.getString("label.login.footer")%><a href="http://www.igrandee.com" target="_blank">i-Grandee </a></div>
    	<div class="right_footer_login"></div>
    
    </div> 

</div>		
  </form> 
</body>
</html>