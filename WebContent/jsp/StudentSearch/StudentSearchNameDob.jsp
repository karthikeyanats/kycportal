<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Search | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language="JavaScript" src="../../js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="TCGenerateView.jsp";
	document.approvalForm.submit();
}

function searchFun()
{

		if(check_ForParticularElements(document.approvalForm.studentname,"text",document.approvalForm.fathername,"text",document.approvalForm.dateOfBirth,"text"))
		{
			document.approvalForm.action="StudentSearchNameDobView.jsp";
			document.approvalForm.submit(); 
		}
		else
		{
			return false;
		}
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Common.DateTime"%>

<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="approvalForm" action="" method="post">
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

    <h2>Search / Student Search</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
<%
DateTime dateobj=new DateTime();
String todate=dateobj.showTime("calendar"); 

%>
	 <%
		//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 	//com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();

		String studentallocationid="";
		String dateofallocation=null;
		String tcgenerationStatus=null;

		String rollNo="";
		//String sessionid=request.getParameter("req_sessionid");
 		//String boardid=request.getParameter("req_boardid");

		//ArrayList registeredList= null;
		//registeredList	=	(ArrayList)tcgenerationQuery.displayTCIssueDetails(request.getParameter("req_sectionpubid"));
       %>

			<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="80%">Student Search </th>
            <th scope="col" class="rounded-q4" width="20%"> <font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>
        </tr>
    </thead>

        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tr><td colspan=2>
    <table border=0 align=center  width="100%">
		<tr>
			<td class=tablebold width=25%>Student First Name  <font color=red>*</font></td>
			<td width='1%' class='tablebold'>:</td>
			<td><input type=text name=studentname validate="Student Name" size=27></td>
		</tr>

<tr>
	
	<td class=tablebold >Father Name  <font color=red>*</font></td>
	<td width='1%' class='tablebold'>:</td>
	<td><input type=text name=fathername  validate="Father Name" size=27></td>
</tr>

<tr>
	
	<td class=tablebold >Date of Birth <font color=red>*</font></td>
	<td width='1%' class='tablebold'>:</td>
	<td class=tablelight ><input type=text class='tablelight' name='dateOfBirth' validate='Date of Birth' onkeypress='this.blur();'><input type=button class=buttons value='^' onclick=Calendar_Fun('../../js/Calendar/CalendarWindow.html','approvalForm.dateOfBirth','0',event,'Not_Greater_Than_CurrentDate',document.approvalForm.server_date);></td>
</tr>
</table>
</td></tr>
</table>

<br>

<a href="#" class="bt_green" onclick="searchFun()"><span class="bt_green_lft"></span><strong>Search</strong><span class="bt_green_r"></span></a>


<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>

<input type='hidden' name='studentallocationid_hidden' value='<%=request.getParameter("studentallocationid_hidden")%>'>
<input type='hidden' name='rollno_hidden'>
<input type='hidden' name='applicantname_hidden'>
<input type='hidden' name='server_date' value="<%=todate %>">








     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>


</div>
</form>
</body>

</html>