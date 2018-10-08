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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>

<script language='javascript'>

	function loadDepartment()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select")){
			document.wprkallotment.submit();
		}
	}	
	
	function loadRole()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.department,"select")){
			document.wprkallotment.submit();
		}
	}	


	function loadStaffs()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.department,"select",document.wprkallotment.role,"select")){
			document.wprkallotment.submit();
		}
	}
	
	function loadSubjectsStaff(obj)
	{
	 	document.wprkallotment.staffid.value 		= obj.getAttribute("staffid");
	 	document.wprkallotment.staffname.value 		= obj.getAttribute("staffname");
	 	document.wprkallotment.remaining.value 		= obj.getAttribute("remaining");
	 	document.wprkallotment.allotted.value 		= obj.getAttribute("allotted");
	 	document.wprkallotment.noofhours.value 		= obj.getAttribute("noofhours");
	 	document.wprkallotment.sessionname.value 	= document.wprkallotment.session.options[document.wprkallotment.session.options.selectedIndex].text;
	 		 	
	 	document.wprkallotment.action = "AssignSubjects.jsp";
		document.wprkallotment.submit();
	}	
	
	function updateAllottment(obj){
	 	if(confirm("Do you want to Update the Staff Allotment...?"))
		{
	 	document.wprkallotment.staffid.value 		= obj.getAttribute("staffid");
	 	document.wprkallotment.staffname.value 		= obj.getAttribute("staffname");
	 	document.wprkallotment.remaining.value 		= obj.getAttribute("remaining");
	 	document.wprkallotment.allotted.value 		= obj.getAttribute("allotted");
	 	document.wprkallotment.noofhours.value 		= obj.getAttribute("noofhours");
	 	document.wprkallotment.sessionname.value 	= document.wprkallotment.session.options[document.wprkallotment.session.options.selectedIndex].text;
	 	
	 	document.wprkallotment.action = "RemoveSubjects.jsp";
		document.wprkallotment.submit();
	}
	
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



    <div class="left_content">

    </div>

    <div class="right_content">
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <h2><%=bundle.getString("label.schedule.staffallotment")%></h2>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
	
<%
	WorkAllotment wallot 	= new WorkAllotment();
	String instituteid		= (String)session.getValue("instituteid");
	ArrayList academicList	= wallot.loadAcadamicYear(instituteid);
	ArrayList deptList		= wallot.loadActiveDepartments(instituteid);
	//ArrayList roleList		= wallot.loadActiveRoles(instituteid);
	ArrayList roleList		= wallot.loadActiveRolesnew(instituteid,"Teaching");

	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sessionname		= request.getParameter("sessionname");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	ArrayList staffList		= null;
	ArrayList allottedList	= null;
	String staffid			= "";
	int datacount 			= 0;			
	
	
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && deptid != null && !deptid.equals("") && !deptid.equalsIgnoreCase("null") && roleid != null && !roleid.equals("") && !roleid.equalsIgnoreCase("null")){
		staffList			= wallot.loadDeptRoleStaffsWork(sessionid,deptid,roleid);
	}
%>
	<form name='wprkallotment' method='post'>

								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
        	 								<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.staffallotmentdetails")%></th>      
						        			<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.schedule.mandatory")%></th> 
        								</tr>
    								</thead>
								    <tr>
								    	<td colspan='2'>							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='session' validate='Academic Year' onChange='loadDepartment()'>
														<option value='0'>-Select Academic Year-</option>
														<%
															if(academicList != null && academicList.size()>0){
																for(int y=0;y<academicList.size();y++){
																	hashmap		= (HashMap)academicList.get(y);
																	
																	if(sessionid != null && sessionid.equals(""+hashmap.get("sessionid")))
																		out.print("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
			
																}
															}
														%>
														</select>
													</td>
													
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.department")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='department' validate='Department' onChange='loadRole()'>
														<option value='0'>-Select Department-</option>
														<%
															if(deptList != null && deptList.size()>0){
																for(int y=0;y<deptList.size();y++){
																	hashmap		= (HashMap)deptList.get(y);
																	if(deptid != null && deptid.equals(hashmap.get("departmentid")+""))
																		out.print("<option selected value='"+hashmap.get("departmentid")+"'>"+hashmap.get("departmentname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("departmentid")+"'>"+hashmap.get("departmentname")+"</option>");
																}
															}
														%>											
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.role")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='role' validate='Role' onchange='loadStaffs()'>
															<option value='0'>-Select Role-</option>
															<%
																if(roleList != null && roleList.size()>0){
																	for(int y=0;y<roleList.size();y++){
																		hashmap		= (HashMap)roleList.get(y);
																		if(roleid != null && roleid.equals(hashmap.get("roleid")+""))
																			out.print("<option selected value='"+hashmap.get("roleid")+"'>"+hashmap.get("rolename")+"</option>");
																		else
																			out.print("<option value='"+hashmap.get("roleid")+"'>"+hashmap.get("rolename")+"</option>");
																			
																	}
																}
															%>												
														</select>
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
								        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.schedule.slno")%></th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.staffname")%></th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.qualification")%></th>
								            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schedule.experience")%></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schedule.workhours")%></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schedule.allottedhours")%></th>
								            <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.schedule.update")%></th>
								            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.schedule.pendinghours")%></th>
								        </tr>
								    </thead>

									<%
										int total 				= 0;
										int remaining			= 0; 
										String noofhours 		= "";
										String allotted 		= "";
										boolean	flag			= false;
										boolean	flag1			= false;
										HashMap hashmap1		= null;
										String staffidtemp		= null;
										String qualification	= null;
										String experience		= null;
							    		int experiencedayint 	= 0;



										if(staffList != null && staffList.size()>0){
											for(int y=0;y<staffList.size();y++){
												
												total 			= 0;
												hashmap			= (HashMap)staffList.get(y);
												staffid			= (String)hashmap.get("staffid");
												flag			= false;
												flag1			= false;
												noofhours		= (String)hashmap.get("noofhours");
												allotted		= (String)hashmap.get("allotted");
												qualification	= (String)hashmap.get("qualification");
												experience		= (String)hashmap.get("experienceday");
												experiencedayint= Integer.parseInt(experience);
												if(allotted == null || allotted.equals("") || allotted.equalsIgnoreCase("null"))
													allotted	 = "0";
												remaining	= Integer.parseInt(noofhours)-Integer.parseInt(allotted);
												out.print("<tr><td class='tablelight'>"+(y+1)+".</td><td class='tablelight' allotted='"+allotted+"' noofhours='"+noofhours+"' remaining='"+remaining+"' staffid='"+hashmap.get("staffid")+"' staffname='"+hashmap.get("name")+"' onclick='loadSubjectsStaff(this)'><a href='#cls'>"+hashmap.get("name")+"</a></td>");
												
												out.print("<td class='tablelight'>");
												datacount++;
												out.print(qualification);									
												out.print("</td>");

												
												out.println("<td>");
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
									 		   	//out.println(experienceday+" days");

									 		   	out.println("</td>");
												out.print("<td>"+noofhours+"</td>");
												out.print("<td>");
													if(allotted != null && !allotted.equals("0"))
														out.print(allotted+"</td> <td><a href='#' allotted='"+allotted+"' noofhours='"+noofhours+"' remaining='"+remaining+"' staffid='"+hashmap.get("staffid")+"' staffname='"+hashmap.get("name")+"' onclick='updateAllottment(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='Edit' title='Edit' border='0' /></a>");
													else
														out.print("0</td> <td>-");
												
													out.print("</td>");
												out.print("<td>"+remaining+"</td>");
												out.print("</tr>");
											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.print("<tr><td align='center' class='tablelight' colspan='8'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
										}
									%>
								</table>
							
							
							
		
		<input type='hidden' name='staffid' 		value=''>
		<input type='hidden' name='staffname' 		value=''>
		<input type='hidden' name='remaining' 		value=''>
		<input type='hidden' name='allotted' 		value=''>
		<input type='hidden' name='noofhours' 		value=''>
		<input type='hidden' name='sessionname' 	value=''>
		
	</form>



    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>