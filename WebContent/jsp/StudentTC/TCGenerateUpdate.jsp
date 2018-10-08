<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TC Update View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language="JavaScript" src="../../js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="TCGenerateList.jsp";
	document.approvalForm.submit();
}

function tcIssueFun()
{
		
		if(check_ForParticularElements(document.approvalForm.tcIssueDate,"text",document.approvalForm.Reason,"text"))
		{
			if(confirm("Do you want to Update TC Details for this Student..?"))
			{
			document.approvalForm.action="tcGenerateUpdateSubmit.jsp";
			document.approvalForm.submit();
			}
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
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
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

    <h2>Certificate / Transfer Certificate Update</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">Student Information </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 	//com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();
		String studentallocationid="";
		//String sessionid=request.getParameter("req_sessionid");
 		//String boardid=request.getParameter("req_boardid");

		//ArrayList registeredList= null;
		//registeredList	=	(ArrayList)tcgenerationQuery.displayTCIssueDetails(request.getParameter("req_sectionpubid"));
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
	<td class=tablebold>Board </td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
<td class=tablebold width="25%">Section</td><td class=tablelight><%=request.getParameter("req_sectionname")%></td>
</tr>
<tr><td class=tablebold width="25%">Student Name</td><td class=tablelight><%=request.getParameter("applicantname_hidden") %></td>
<td class=tablebold width="25%">Roll No</td><td class=tablelight><%=request.getParameter("rollno_hidden")%></td>
</tr>
</table>
</td><td></td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">TC Issue </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Date</td><td class=tablelight ><input type=text class='tablelight' name='tcIssueDate' value='<%=request.getParameter("tcissuedate_hidden")%>' validate='Issue Date' onkeypress='this.blur();'><input type=button class=buttons value='^' onclick=Calendar_Fun('../../js/Calendar/CalendarWindow.html','approvalForm.tcIssueDate','0',event,'Not_Less_Than_Todaydate',document.approvalForm.serverdate_cal);></td>
</tr>

<tr>
	<td class=tablebold width="25">Reason</td>
	<td><textarea name='Reason' rows='2' cols='50' validate='Description' onkeypress="calculateRemaining(this,500,'remaining')" onkeyup="calculateRemaining(this,500,'remaining')"><%=request.getParameter("reason_hidden")%></textarea><br><span id='remaining'><font color='red'>500 characters remaining</font></span></td>
</tr>
</table>
</td><td></td></tr>
</table>

<br>

<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="tcIssueFun()"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>


<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>

<input type='hidden' name='studentallocationid_hidden' value='<%=request.getParameter("studentallocationid_hidden")%>'>
<input type='hidden' name='tcissueid_hidden' value='<%=request.getParameter("tcissueid_hidden")%>'>
<input type='hidden' name='rollno_hidden'>
<input type='hidden' name='applicantname_hidden'>







   

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>