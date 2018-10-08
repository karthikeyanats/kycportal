<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Send Mail  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">
function sendmailfun()
{
	if(document.sendmailform.usercategoryoption.value=="SA")
	{
	if(document.sendmailform.validwhom.value=="")
	{
		alert("Select any one type");
		return false;
	}
	}
	
	if(document.sendmailform.mailsubject.value == "")
	{
		alert("Subject Should not be empty");
		document.sendmailform.mailsubject.focus();
		return false;
	}

	if(document.sendmailform.mailmessage.value == "")
	{
		alert("Subject Should not be empty");
		document.sendmailform.mailmessage.focus();
		return false;
	}
	
	document.sendmailform.action="./SendMailSubmit.jsp";
	document.sendmailform.submit();
}
function selectwhom(obj)
{
	document.sendmailform.validwhom.value = obj.getAttribute("value");
}
</script>
</head>
<body>

<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
     </div>
    <div class="main_content">
<%@ include file="../include/header.jsp" %>
    <div class="center_content">
   <div class="left_content">
    </div>
    <div class="right_content">
    <h2>General/Send Mail</h2>
 		  <form name="sendmailform" method="post" action="">
 		  <input type=hidden name="retvalue" value="<%=request.getParameter("retvalue") %>">
 		  
 <TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>
		<table border=0 cellpadding=0 cellspacing=0 align=center>
		<tr><%
				if(request.getParameter("retvalue")==null)
					{out.print("");}
				else
					{out.print("<td><center><b>Mail Successfully Sent</b></center></td>"); request = null;}
			
			%></tr>
		</table>
<table id="rounded-corner" border=0 summary="Send Mail" width="100%" cellspacing=0
	cellpadding=0>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%">Send Mail</th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font>&nbsp;<%=bundle.getString("label.announcement.mandatoryfields") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
</table>
  <table id="rounded-corner" border=0 summary="Send Mail" width="100%" cellspacing=0
	cellpadding=0>
    <thead>   
   <table border=0 bgcolor=white cellspacing=0 width=100% align=center height=350 cellpadding=0>
   <Tr><td>
   <%
   
   String instituteid = null;
   try{
		loginusercategory 	= (String)session.getValue("usercategory");
		instituteid 	= (String)session.getValue("instituteid");
  // out.println("sentstatus after "+sentstatus);
   }catch(Exception e){e.printStackTrace();}
   %>
   </td></Tr>
  <tr valign=top>
      <td>
		<table id="rounded-corner" border=0 summary="Department List" width="100%" cellspacing=0 cellpadding=0>
		<tr valign='top'>
		  		  	<td><a class=tablebold>To: </a>
		  		  	<% if(loginusercategory.equals("T"))
		  		  	{%>
		  		  	<input type="radio" name="towhom" checked value="SendAllStudent"/>Send All Parents
		  		  	<% }else if(loginusercategory.equals("SA")){%>
		  		  	<input type="radio" name="towhom" value="SendAll" onclick='selectwhom(this)'/>Send All
		  		  	<input type="radio" name="towhom" value="SendAllParents" onclick='selectwhom(this)'/>Send All Parents
		  		  	<input type="radio" name="towhom" value="SendAllStaffs" onclick='selectwhom(this)'/>Send All Staff
		  		  	<%} %>
		  		  	</td>
		 </tr>
		  	
		  	<tr valign='top'>
		  		  	<td><a class=tablebold>Subject : </a><input type=text name="mailsubject" class=tablelight size="70"></input></td>
		  	</tr>
		  	<tr>
		  	<td colspan=2><a class=tablebold>Message:</a></td></tr>
		  	<tr>
		  	<td colspan=2><textarea rows=10 cols=100 name="mailmessage" class=tablelight></textarea></td>
		  	
		  	</tr>
		  </table>
		 <a href="#" onclick="sendmailfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Send Mail </strong><span class="bt_blue_r"></span></a>
</TABLE>
</div>
    
    </thead>
</table>
 
 
     </td>
     </tr>
     </TABLE>
     <input type=hidden name="validwhom"></input>
     <input type=hidden name="usercategoryoption" value="<%=loginusercategory %>"></input>
     
     
     </form>
     
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>