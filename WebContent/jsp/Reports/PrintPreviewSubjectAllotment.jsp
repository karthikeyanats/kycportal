<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff Alloted List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript">
	function goBack()
	{
	window.close();
	}
	
	function printfun()
	{	
	document.getElementById("printbutt").style.visibility='hidden';
	document.getElementById("backbutt").style.visibility='hidden';
	window.print();
	alert("Successfully Printed");
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body><%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
<%
	//ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	WorkAllotment wallot 	= new WorkAllotment();
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	ArrayList academicList	= wallot.loadAcadamicYear(instituteid);
	ArrayList deptList		= wallot.loadActiveDepartments(instituteid);
	ArrayList roleList		= wallot.loadActiveRoles(instituteid);
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("req_sessionid");
	String sessionname		= request.getParameter("sessionname");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	String departmentname	= request.getParameter("departmentname");
	String rolename			= request.getParameter("rolename");
	ArrayList staffList		= null;
	ArrayList allottedList	= null;
	ArrayList expList		= null;
	ArrayList quaList		= null;
	String staffid			= "";
	String userid			= "";
	int datacount 				= 0;			
	
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && deptid != null && !deptid.equals("") && !deptid.equalsIgnoreCase("null") && roleid != null && !roleid.equals("") && !roleid.equalsIgnoreCase("null")){
		staffList			= wallot.loadDeptRoleStaffsWork(sessionid,deptid,roleid);
		expList				= wallot.loadAllottedStaffsExperience(sessionid,deptid,roleid);
		//quaList				= wallot.loadAllottedStaffsQualification(sessionid,deptid,roleid);
	}
%>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width="640" align="center" >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr color=grey>
		</td></tr>
		<tr align=center><td valign=top>Staff Alloted List</td>
		</tr>
		<tr><td valign=top>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							<td width='20%' class='tablebold' align='left'>Department</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
								<%=departmentname %>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold' align='left'>Role</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=request.getParameter("rolename") %>
								
							</td>
							
						</tr>
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' >Archival Details</td>
													<td  class='tablebold' width='1' >:</td>
													<td valign=top class='tablelight' align=left colspan=4><h2>This is an Archived Year</h2></td>
											</tr>
											<%
											} 
											%>		
					</table>					    	
		    	</td>
		    </tr>
		</table>
</td></tr><tr><td>
	
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr  class='tablebold'>
					        	<th align=left width="7%">Sl.No</th>
								            <th   align=left  width="20%">Staff Name</th>
								            <th   align=left  width="20%">Qualification</th>
								            <th  align=left   width="15%">Experience</th>
								            <th   align=left  width="10%">Work Hours</th>
								            <th   align=left width="10%">Allotted Hours</th>
								             <th  align=left  width="10%">Pending Hours</th>
								            
					        </tr>
					    </thead>
						<%
										int total 			= 0;
										int remaining		= 0; 
										String noofhours 	= "";
										String allotted 	= "";
										boolean	flag		= false;
										boolean	flag1		= false;

										if(staffList != null && staffList.size()>0){
											for(int y=0;y<staffList.size();y++){
												
												total 		= 0;
												hashmap		= (HashMap)staffList.get(y);
												staffid		= (String)hashmap.get("staffid");
												userid		= (String)hashmap.get("userid");
												String qualification= (String)hashmap.get("qualification");
												String experience= (String)hashmap.get("experienceday");
									    		int experiencedayint =Integer.parseInt(experience);
												flag		= false;
												flag1		= false;
												noofhours	= (String)hashmap.get("noofhours");
												allotted	= (String)hashmap.get("allotted");
												if(allotted == null || allotted.equals("") || allotted.equalsIgnoreCase("null"))
													allotted	 = "0";
												remaining	= Integer.parseInt(noofhours)-Integer.parseInt(allotted);
												out.print("<tr class='tablelight' ><td class='tablelight'>"+(y+1)+".</td><td class='tablelight'>"+hashmap.get("name")+"</td>");
												out.print("<td class='tablelight'>");
												out.print(qualification);						
												out.print("</td>");
												datacount++;
												out.println("<td class='tablelight' >");
									 		   	int year=(experiencedayint/365);
									 		   	int month=((experiencedayint%365)/30);
									 		   	int day=(((experiencedayint%365)%30));
									 		   	if(year==1)
												{
									 		   	out.println((year+" year").replaceAll("-",""));
												}
									 		   	else if(year!=0)
												{
									 		   	out.println((year+" years").replaceAll("-",""));
												}
									 		   	if(month==1)
												{
									 		  	out.println((month+" month").replaceAll("-",""));
												}
									 		   	else if(month!=0)
												{
									 		  	out.println((month+" months").replaceAll("-",""));
												}
									 		  	if(day==1)
												{
									 		   	out.println((day+" day").replaceAll("-",""));
												}
									 		  	else if(day!=0)
												{
									 		   	out.println((day+" days").replaceAll("-",""));
												}
									 		  	else
									 		  	{
										 		   out.println("No Experience");
									 		  	}

									 		   	out.println("</td>");
												out.print("<td>"+noofhours+"</td>");
												out.print("<td>");
													if(allotted != null && !allotted.equals("0")){
														//out.print(allotted+"</td> <td><a href='#' allotted='"+allotted+"' noofhours='"+noofhours+"' remaining='"+remaining+"' staffid='"+hashmap.get("staffid")+"' staffname='"+hashmap.get("name")+"' onclick='updateAllottment(this)'>Update</a>");
														out.print(allotted+"</td>");
													}
													else
														out.print("0</td>");
												

												out.print("<td>"+remaining+"</td>");
												out.print("</tr>");
											}
										}
										else
											out.print("<tr><td align='center' class='tablelight' colspan='7'>No Staff Found For This Department and Role</td></tr>");
									%>
					</table>
				</td></tr>
					
		</table>
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		//out.print("datacount-->"+datacount);
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>