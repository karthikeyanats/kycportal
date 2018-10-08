<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Admission Process | Powered by i-Grandee</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function loadfun()
{
	if(document.f1.cnt.value =="1")
	{
		document.f1.action="RegPrintPreview.jsp";
		document.f1.submit();
	}
	else
	{
		//document.f1.appno.value = document.f1.appno.value;
		document.f1.state.value = "Sorry, insertion failure, try again";
		document.f1.action="AppNoChk.jsp";
		document.f1.submit();
	}
}

</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" bottommargin="0" onload=loadfun()>
 
    <form name=f1 action="" method="post">

     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
		com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
		com.iGrandee.Application.RegistrationBean registrationBean = new com.iGrandee.Application.RegistrationBean();
		int cnt = 0;
	    String regno = "";
	    String applicationno = "";
     	String reg_sessionid = "";
     	String reg_sessiontext = "";
     	String reg_boardid = "";
     	String reg_boardname = "";
     	String reg_coursepubid = "";
     	String reg_coursename = "";
     	String applicationid = "";
		String createdby = (String)session.getValue("userid");     	
     try{
     		String receptno = request.getParameter("receptno");
     		regno = request.getParameter("regno");
     		String regfees = request.getParameter("regfees");
     		applicationid = request.getParameter("applicationid");
     		applicationno = request.getParameter("applicationnos");
     		String applicantname = request.getParameter("applicantname");
     		String applcant_name = request.getParameter("applcant_name");

     		reg_sessionid = request.getParameter("reg_sessionid");
     		reg_sessiontext = request.getParameter("reg_sessiontext");
     		reg_boardid = request.getParameter("reg_boardid");
     		reg_boardname = request.getParameter("reg_boardname");
     		reg_coursepubid = request.getParameter("reg_coursepubid");
     	 	reg_coursename = request.getParameter("reg_coursename");
     	 	int standardscheduleId = Integer.parseInt(reg_coursepubid); 

     	 	registrationBean.setApplicationid(applicationid);
    		registrationBean.setRegistrationamount(regfees);
    		registrationBean.setStandardscheduleid(standardscheduleId);
    		registrationBean.setCreatedby(createdby);
    		//registrationBean.setIpaddress(ipaddress);
    		//registrationBean.setInstituteid(instituteid);
 	 	
     		//cnt = registrationQuery.registrationInsert(applicationid,regfees,reg_coursepubid,createdby);
     	 	cnt = registrationQuery.registrationInsert(registrationBean);
     	 	

     }catch(Exception e){
    	 //System.out.println("exception :"+e.getMessage());
     }     
    
    %>
	<input type=hidden name="cnt" value="<%= cnt%>">
	<input type=hidden name="regno" value="<%= regno%>">
	<input type=hidden name="applicationid" value="<%= applicationid%>">
	
	<input type=hidden name="appno" value="<%= applicationno%>">
	<input type=hidden name="state"> 
	<input type=hidden name=reg_sessionid value="<%=reg_sessionid %>">
	<input type=hidden name=reg_sessiontext value="<%=reg_sessiontext %>">
	<input type=hidden name=reg_boardid value="<%=reg_boardid %>">
	<input type=hidden name=reg_boardname value="<%=reg_boardname %>">
	<input type=hidden name=reg_coursename value="<%=reg_coursename %>">
	<input type=hidden name=reg_coursepubid value="<%=reg_coursepubid %>">    
    <tr><td><td><table id="rounded-corner1" width="100%">
    <!--  <tr ><td>Standard Name <font color="red">*</font></td><td><input type="text" class=tablelight name="standardname" size="38" maxlength="50"></td>
    <tr><td>Standard Name </td><td><textarea name="standarddescription" class=tablelight  rows=2 cols=40></textarea></td>
    </table></td><td></td></tr>-->
    </tbody>
</table>
    
</form>
 

</body>
</html>
