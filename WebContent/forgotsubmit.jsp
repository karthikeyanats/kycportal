<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Status| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function backtopagefun()
{
	document.operationform.action	= document.operationform.returnurl.value;
	document.operationform.submit();
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">   
   
    </div>

    <div class="main_content">

 

    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
    		<form name="operationform"  id="operationform" method="post">
    
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<jsp:useBean id="login_object" scope="page" class="com.iGrandee.Login.LoginAction"/>
<jsp:useBean id="temppswd" scope="page" class="com.iGrandee.Password.TempPassword"/>
<jsp:useBean id="changpwd" scope="page" class="com.iGrandee.Password.PasswordQuery"/>
<jsp:useBean id="SendMail" scope="page" class="com.iGrandee.SendMail.SendMail"/>


<%@ page language="java" import="java.util.*"%>
<%
	String flage			= request.getParameter("flage");
	String username			= request.getParameter("username");
	String emailid			= request.getParameter("emailid");
	String message			= "";
	String password			= "";
	ArrayList returnpsw			= new ArrayList();
	ArrayList instDetailList 	=  new ArrayList();
	HashMap returnpswmap	= null;
	String uname			= "";
	String uid				= "";
	String temp_password = null;
	
	String userstate		= request.getParameter("userstate");
	int namewise			= 0;
	
	if(flage.equals("parent"))
	{	namewise=login_object.checkUserForForgotpsw(username,"parent"); 
	
		returnpsw=login_object.getpasswordforparent(username,emailid);
		instDetailList=login_object.getInstDetailForgotPass(username,emailid,"parent");
		//System.out.print("***********"+namewise);
	
		if(returnpsw!=null && returnpsw.size()>0)
		{
			for(int i=0;i<returnpsw.size();i++)
			{
				returnpswmap=(HashMap)returnpsw.get(i);
				uname		= (String)returnpswmap.get("uname");
				//password	= (String)returnpswmap.get("parentpassword");
				//password	= (String)returnpswmap.get("parentpassword");
				uid			= (String)returnpswmap.get("userid");
			}
			
			int result	= login_object.insertPasswordRequest(username,emailid,flage,uid);
			
		}
		temp_password = com.iGrandee.Password.TempPassword.generateRandomPassword();
		int s= changpwd.updateChangePasswordforparent(username,temp_password);
	
	}
	else if(flage.equals("others"))
	{	namewise=login_object.checkUserForForgotpsw(username,"others"); 
		instDetailList=login_object.getInstDetailForgotPass(username,emailid,"others");
	
		returnpsw=login_object.getpasswordforothers(username,emailid);
		if(returnpsw!=null && returnpsw.size()>0)
		{
			for(int i=0;i<returnpsw.size();i++)
			{
				returnpswmap=(HashMap)returnpsw.get(i);
				uname		= (String)returnpswmap.get("uname");
				password	= (String)returnpswmap.get("password");  
				uid			= (String)returnpswmap.get("userid");
			}
			temp_password = com.iGrandee.Password.TempPassword.generateRandomPassword();
			int s= changpwd.updateChangePassword(username,temp_password);
			int result	= login_object.insertPasswordRequest(username,emailid,flage,uid);
		}
	
	}
	
	
	if(returnpsw!=null && returnpsw.size()>0)
	{
		
	
	//	SendMail.send(emailid,"Admin",password,uname,"");
		//SendMail.send(emailid,"Admin",temp_password,uname,"");
		SendMail.send(emailid,"Admin",temp_password,uname,"",request,instDetailList);
		message = "Successfully Password Sent to "+emailid;   
		
	
	}
	else
	{
		if(namewise==1)
		{
			message = "This user Name Does not match with E-Mail ID";
		}
		else
		{
		message = "Invalid Username and E-Mail ID ";
		}
	}
		if(returnpsw!=null && returnpsw.size()>0){
							
							%>
								<br><br><br><br><h2>Result Info</h2>
								
								<div class="valid_box">
								
							        <center><%=message%></center>
							     </div>
						     	<% 
						}   
						else{
						%>
						<br><br><br><br><h2>Result Info</h2>
							<div class="error_box">
						        <center><%=message%></center>
						     </div>
						<% 
						}
						%>  
		<%
			String return_file =request.getContextPath()+"/forgotpassword.jsp"; 
		 	response.sendRedirect(request.getContextPath()+"/forgotpasswordresult.jsp?message="+message+"&result="+returnpsw.size()+"&returnurl="+return_file);
		 	%>
	</form>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="./jsp/include/footer.jsp" %>
    

</div>
</body>
</html>