<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language='javascript'>

	function callSection(obj){
	
		document.wprkallotment.status.value			= obj.getAttribute("status");
		document.wprkallotment.subjectid.value		= obj.getAttribute("subjectscheduleid"); 
		document.wprkallotment.subjectname.value	= obj.getAttribute("subjectname");
		document.wprkallotment.staffname.value		= obj.getAttribute("facultyname"); 
		document.wprkallotment.action 				= "ReportSubjectStudentList.jsp";
		document.wprkallotment.submit();
	}
		
	function goBack(){
	
		document.wprkallotment.action 				= "ReportStandard.jsp";
		document.wprkallotment.submit();
	}	
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

<%
	ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.standardwisesubjectreport")%></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Report.Reports"%>
	
<%
	Reports reports 		= new Reports();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	HashMap	hashmap			= null;
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	String examnameid		= request.getParameter("examnameid");
	String examname			= request.getParameter("examname");
	String standardid		= request.getParameter("standardid");
	String standardname		= request.getParameter("standardname");
	String sectionname		= request.getParameter("sectionname");
	String sectionid		= request.getParameter("sectionid");
	ArrayList staffList		= null;
	ArrayList examList		= reports.standardSubjectPassDetails(standardid,examnameid);
	
%>
	<form name='wprkallotment' method='post'>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=5 cellpadding=0>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=sessionname %>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.examname")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=examname %>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=standardname %>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
			     				
			     				
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schedule.subjectname")%></th>
		            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.staffname")%></th>
		            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.passpercentage")%></th>
		            <th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.schedule.studentlist")%></th>
		        </tr>
		    </thead>
					
		<%
			String subjectid		= "";
			int totalsubject		= 0;
			int totalpassed			= 0;
			int totalstudents		= 0;
			float percent			= 0.0f;
			String totasubject		= "";
			String passedsubject	= "";
			HashMap hashmap1		= null;
			String staffname		= "";
			
			if(examList != null && examList.size()>0){
				for(int y=0;y<examList.size();y++){
					hashmap			= (HashMap)examList.get(y);
					subjectid		= (String)hashmap.get("subjectscheduleid");
					
					totasubject		= (String)hashmap.get("totalstudents");	
					passedsubject	= (String)hashmap.get("passedcount");
					try{
						
						if(totasubject == null || totasubject.equals("") || totasubject.equalsIgnoreCase("null"))
							totasubject	= "0";
						
						if(passedsubject == null || passedsubject.equals("") || passedsubject.equalsIgnoreCase("null"))
							passedsubject	= "0";
					
						
						totalpassed		= Integer.parseInt(totasubject);
						totalstudents	= Integer.parseInt(passedsubject);
						
						percent			= (totalstudents*100/totalpassed);
						
					}
					catch(Exception e){
						percent		= 0;
					}

					staffList		= reports.sectionSubjectStaffDetails(subjectid);
					out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td><table width='100%' cellspacing='0' cellpadding='0'>");
					staffname		= "";
					//out.print(staffList);
					if(staffList != null && staffList.size()>0){
						for(int x=0;x<staffList.size();x++){
							hashmap1	= (HashMap)staffList.get(x);
							out.print("<tr><td>"+hashmap1.get("staffname")+"</td></tr>");
							staffname		+= hashmap1.get("staffname")+",";
						}
					}
					
					if(staffname != null && staffname.length()>2)
						staffname	= staffname.substring(0,staffname.length()-1);
					out.print("</table></td><td>"+percent+"</td><td><a href='#cls' subjectscheduleid='"+subjectid+"' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' status='Passed' onclick='callSection(this)'>"+bundle.getString("label.schedule.passedlist")+"</a>&nbsp;|&nbsp;<a href='#cls' subjectscheduleid='"+subjectid+"' status='Failed' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' onclick='callSection(this)'>"+bundle.getString("label.schedule.failedlist")+"</a></td></tr>");
					
					
					//out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("staffname")+"</td><td>"+percent+"</td><td><a href='#cls' subjectscheduleid='"+subjectid+"' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' status='Passed' onclick='callSection(this)'>"+bundle.getString("label.schedule.passedlist")+"</a>&nbsp;|&nbsp;<a href='#cls' subjectscheduleid='"+subjectid+"' status='Failed' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' onclick='callSection(this)'>"+bundle.getString("label.schedule.failedlist")+"</a></td></tr>");
						
				}
			}
			else{
				out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				//out.print("<tr><td colspan='5' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
			}

		%>											
		</table>
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='examname' 		value='<%=examname%>'>
		<input type='hidden' name='examnameid'		value='<%=examnameid%>'>
		<input type='hidden' name='standardid'		value='<%=standardid%>'>
		<input type='hidden' name='standardname'	value='<%=standardname%>'>
		<input type='hidden' name='subjectid'		value=''>
		<input type='hidden' name='subjectname'		value=''>
		<input type='hidden' name='staffname'		value=''>
		<input type='hidden' name='status'			value=''>
		
		
	</form>
    </div><!-- end of right content-->
  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>