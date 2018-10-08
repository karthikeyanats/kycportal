<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>

<script language='javascript'>


	function loadRole()
	{
		if(check_ForParticularElements(document.wprkallotment.department,"select")){
			document.wprkallotment.submit();
		}
	}	

	function loadStaffs()
	{
		if(check_ForParticularElements(document.wprkallotment.department,"select",document.wprkallotment.role,"select")){
			document.wprkallotment.submit();
		}
	}
	
	function loadSubjectsStaff(obj)
	{
	 	document.wprkallotment.staffid.value 		= obj.getAttribute("staffid");
	 	document.wprkallotment.userid.value 		= obj.getAttribute("userid");	 	
	 	document.wprkallotment.staffname.value 		= obj.getAttribute("staffname");
	 	document.wprkallotment.remaining.value 		= obj.getAttribute("remaining");
	 	document.wprkallotment.allotted.value 		= obj.getAttribute("allotted");
	 	document.wprkallotment.noofhours.value 		= obj.getAttribute("noofhours");
	 	//document.wprkallotment.sessionname.value 	= document.wprkallotment.session.options[document.wprkallotment.session.options.selectedIndex].text;
	 	document.wprkallotment.sessionname.value 	= document.wprkallotment.req_sessionname.value;
	 	document.wprkallotment.deptname.value 		= document.wprkallotment.department.options[document.wprkallotment.department.options.selectedIndex].text;
	 	document.wprkallotment.rolename.value 		= document.wprkallotment.role.options[document.wprkallotment.role.options.selectedIndex].text;
	 		 	
	 	document.wprkallotment.action = "StaffHomepage.jsp";
		document.wprkallotment.submit();
	}	

	function backfun()
	{
	 	document.wprkallotment.action = "ReportIndexView.jsp";
		document.wprkallotment.submit();
	}
	
	function printfun()
	{
	window.open("PrintPreviewSubjectAllotment.jsp?&req_sessionname="+document.wprkallotment.req_sessionname.value+"&req_sessionid="+document.wprkallotment.req_sessionid.value+"&department="+document.wprkallotment.department.value+"&departmentname="+document.wprkallotment.department.options[document.wprkallotment.department.options.selectedIndex].text+"&role="+document.wprkallotment.role.value+"&rolename="+document.wprkallotment.role.options[document.wprkallotment.role.options.selectedIndex].text+"&req_sessionstatus="+document.wprkallotment.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsstaffallotmentlist")%></h2>


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
	ArrayList roleList		= wallot.loadActiveRoles(instituteid);
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("req_sessionid");
	String sessionname		= request.getParameter("sessionname");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	ArrayList staffList		= null;
	ArrayList allottedList	= null;
	ArrayList expList		= null;
	ArrayList quaList		= null;
	String staffid			= "";
	String userid			= "";
	int datacount 				= 0;			
	
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && deptid != null && !deptid.equals("") && !deptid.equalsIgnoreCase("null") && roleid != null && !roleid.equals("") && !roleid.equalsIgnoreCase("null")){
		staffList			= wallot.loadDeptRoleStaffsWork(sessionid,deptid,roleid);
	}
%>
	<form name='wprkallotment' method='post'>
		<table  border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="99%" colspan='2'><%=bundle.getString("label.schedule.staffallotmentdetails")%></th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
								    </thead>
									<tfoot>
									   	<tr>
									       	<td colspan="2" class="rounded-foot-left"><em></em></td>
									       	<td class="rounded-foot-right">&nbsp;</td>
									    </tr>
									</tfoot>								    
								    <tr>
								    	<td colspan='3'>							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=request.getParameter("req_sessionname") %>
													</td>
													
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.department")%></td>
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
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.role")%></td>
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
											<%
											if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' valign=top ><%=bundle.getString("label.schedule.archivaldetails")%></td>
													<td  class='tablebold' width='1' valign=top >:</td>
													<td valign=top class='tablelight' align=left><h2><%=bundle.getString("label.schedule.archivalmessage1")%></h2></td>
											</tr>
											<%
											} 
											%>												
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr height='10'>
							<td align='left'>
							</td>
						</tr>					
						<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.schedule.slno")%></th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.staffname")%></th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.qualification")%></th>
								            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schedule.experience")%></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schedule.workhours")%></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schedule.allottedhours")%></th>
								            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.schedule.pendinghours")%></th>
								        </tr>
								    </thead>
									<tfoot>
									   	<tr>
									       	<td colspan="6" class="rounded-foot-left"><em></em></td>
									       	<td class="rounded-foot-right">&nbsp;</td>
									    </tr>
									</tfoot>								    

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
												String qualification		= (String)hashmap.get("qualification");

												flag		= false;
												flag1		= false;
												String experience= (String)hashmap.get("experienceday");
									    		int experiencedayint =Integer.parseInt(experience);

												noofhours	= (String)hashmap.get("noofhours");
												allotted	= (String)hashmap.get("allotted");
												if(allotted == null || allotted.equals("") || allotted.equalsIgnoreCase("null"))
													allotted	 = "0";
												remaining	= Integer.parseInt(noofhours)-Integer.parseInt(allotted);
												out.print("<tr><td class='tablelight'>"+(y+1)+".</td><td class='tablelight' allotted='"+allotted+"' noofhours='"+noofhours+"' remaining='"+remaining+"' staffid='"+hashmap.get("staffid")+"' userid='"+hashmap.get("userid")+"' staffname='"+hashmap.get("name")+"' onclick='loadSubjectsStaff(this)'><a href='#cls'>"+hashmap.get("name")+"</a></td>");
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
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.print("<tr><td align='center' class='tablelight' colspan='7'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
										}
									%>
								</table>
							</td>
						</tr>					
					</table>
				</td>
			</tr>
		</table>
				<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
				<%if(datacount>0){%> 
						<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
				<%} %>				
		<input type='hidden' name='staffid' 		value=''>
		<input type='hidden' name='userid' 		value=''>		
		<input type='hidden' name='staffname' 		value=''>
		<input type='hidden' name='remaining' 		value=''>
		<input type='hidden' name='allotted' 		value=''>
		<input type='hidden' name='noofhours' 		value=''>
		<input type='hidden' name='sessionname' 	value=''>
		
		<input type='hidden' name='deptname' 		value=''>
		<input type='hidden' name='rolename' 		value=''>

<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid")%>">
<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">		
	</form>



    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>