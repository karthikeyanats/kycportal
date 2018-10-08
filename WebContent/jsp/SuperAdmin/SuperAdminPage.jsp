<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Dash Board  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />  



<script language='javascript'>


function  circularFun(obj)
	{
	var circularid= obj.getAttribute("circularidss");
	
	document.wprkallotment.circularid.value=circularid;
	document.wprkallotment.action = "../Parent/circularViewParentHomePage.jsp";
		document.wprkallotment.submit();
		
	} 
	function studenttimetable()
	{
	document.wprkallotment.action = "../Principal/TimeTableForStaff.jsp";
			document.wprkallotment.submit();
	
	}
	function studentabbsentess()
	{
	document.wprkallotment.action = "../Attendance/YearofsessionAttendanceView.jsp";
	document.wprkallotment.submit();
	}
	function studentfess()
	{
	
	document.wprkallotment.action = "../Fees/FeesCollection_pre.jsp";
	document.wprkallotment.submit();
	}
	function profileview(obj)
	{
	document.wprkallotment.Staffid.value=obj.getAttribute("Staffid");
	document.wprkallotment.action = "/kycportal/jsp/Registration/StaffProfileView.jsp";
	document.wprkallotment.submit();
	}
	function clickFun(obj)
	{
		document.superadminForm.instituteid.value=obj.getAttribute("instituteid");
		document.superadminForm.institutename.value=obj.getAttribute("institutename");
		document.superadminForm.action = "./AcademicYearInfo.jsp";
		document.superadminForm.submit();
	}
	
	
	
</script>
<style type="text/css">
</style>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>                   
     
</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>

  
<div class="center_content">



<div class="left_content"></div>

<div class="right_content">


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>

<form name='superadminForm' method='post'>
<input type="hidden" name="instituteid" value="">
<input type="hidden" name="institutename" value="">
<%

try
{
	com.iGrandee.Registration.InstitutionQurey  institutionQuery = new com.iGrandee.Registration.InstitutionQurey();
	ArrayList institutionList= null;
	institutionList	=	(ArrayList)institutionQuery.listInstitution();
	%>
	<br><br>
	<h2><%=bundle.getString("label.superadmin.homepagerootpath")%></h2>
	<br>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.common.slno")%></th>
	            <th scope="col" class="rounded" width="50%"><%=bundle.getString("label.common.schoolname")%></th>                                   
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.superadmin.staff")%></th>
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.superadmin.student")%></th>
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.superadmin.fees")%></th>
	            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.superadmin.exam")%></th>
	        </tr>
	    </thead>
	    <tfoot>
	    	<tr>
	        	<td colspan=5 class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	
	<% 
			if(institutionList.size()!=0)
			{
				for(int i=0;i<institutionList.size();i++)
				{
					HashMap institutionListMap=(HashMap)institutionList.get(i);
				
					out.print("<tr><td>"+(i+1)+"</td><td><a href='./ProfileInfo.jsp?instituteid="+institutionListMap.get("instituteid")+"'>"+institutionListMap.get("institutename")+"</a></td>");
					out.print("<td><a href='./Staff_List.jsp?instituteid="+institutionListMap.get("instituteid")+"'>View</a></td>");
					out.print("<td><a href='./Stud_Year_List.jsp?req_instituteid="+institutionListMap.get("instituteid")+"'>View</a></td>");
					out.print("<td><a href='./Fees_Year_List.jsp?req_instituteid="+institutionListMap.get("instituteid")+"'>View</a></td>");
					out.print("<td><a href='#'  institutename='"+institutionListMap.get("institutename")+"' instituteid='"+institutionListMap.get("instituteid")+"' onclick='clickFun(this)'>View</a></td>");
					out.print("</tr>");
				}
			}
			else
			{			
				out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");	
			}
}
catch(Exception ex){
	System.out.print("Exception :"+ex);		
}			
		//out.print("totPendingCount"+totPendingCount);
	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>

<table style="hidden" class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		<table border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				
				</td>
			</tr>
		</table>
		<br>
		</td>
	</tr>
</table>
<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="backward" value="adminhome"/>


</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>