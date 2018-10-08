<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.parentforgotpasswordlist.title") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript">

</script>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

</head>
<body>
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

    <h2><%=bundle.getString("label.forgotpasswordlist.parentrootpath") %> </h2>
  <form name="f1" method="post" action="" >
       <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.InstitutionQurey"%>
<%
	String date_str="";
	ArrayList forgotList = null;
	InstitutionQurey staffquery=new InstitutionQurey();
	String userid=null;
	String instituid=null;
	String departid=null;

	userid=(String)session.getValue("userid");
	
	if(userid!=null)
	{
	try
	{
			String instituteid="";
			instituid=(String)session.getValue("instituteid");
			forgotList =staffquery.listForgotPasswordRequest(instituid,"parent");
	}
	catch(NullPointerException e){}
%>
<form name="f1" method="post" action="" >
<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td align=right><a href="ForgotPasswordRequestList.jsp" class=tablebold><%=bundle.getString("label.schedule.otherpasswordrequestlist")%></td></tr>
</table>
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.forgotpasswordlist.slno") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.forgotpasswordlist.username") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.forgotpasswordlist.password") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.forgotpasswordlist.email") %></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.forgotpasswordlist.dateofrequest") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
        	
        	<%
		try
		{
			if(forgotList.size()!=0)
			{
	 		HashMap forgotMap = null;
	 		
	 		for(int i=0;i<forgotList.size();i++) {
	 			forgotMap = (HashMap)forgotList.get(i);
	 			String forgotpassid = (String)forgotMap.get("forgotpassid");
	 			String username = (String)forgotMap.get("username");
	 			String email = (String)forgotMap.get("email");
	 			String dateofrequest = (String)forgotMap.get("dateofrequest");
	 			String requserid = (String)forgotMap.get("userid");
	 			String status = (String)forgotMap.get("status");
	 			String requestedby = (String)forgotMap.get("requestedby");
	 			String passwords = (String)forgotMap.get("password");
	 			
	 		   	out.println("<tr>");
	 		   	out.println("<td align=center>"+(i+1)+"</td>");
	 		   	out.println("<td>"+username+" </td>");
	 		   out.println("<td>"+passwords+" </td>");
	 			out.println("<td><a href=mailto:'"+email+"'>"+email+"</a></td>");
	 			out.println("<td>"+dateofrequest+"</td>");
	 		   	out.println("</tr>");

	 		}
			}
			else
			{
				out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				//out.println("<tr>");
	 		   	//out.println("<td colspan=5 align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td>");
				//out.println("</tr>");
			}
		}
		catch(NullPointerException npe)
		{
			//System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
			npe.printStackTrace();
			}
	}
	%>
    </tbody>
</table>
	

</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>