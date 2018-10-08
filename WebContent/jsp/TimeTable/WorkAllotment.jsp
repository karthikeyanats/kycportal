<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
function checkNnmerickey(e) {
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	var character = String.fromCharCode(code);

	if(code!=9 && code!=46 && code!=8 && code!=118 && code!=99 && code!=37 && code!=38 && code!=39 && code!=40)
	{
	if (code==47||code<46||code>57)
	{
		code=0;
		alert("Enter  Number only")

	if(window.event != null)
	{
		window.event.keyCode 	= 505;
		event.cancelBubble		= true;
		event.returnValue		= false;
	}
	else
	{
		e.preventDefault();
	}
		 return false;
	}
	}
	}
	var count	= 0;
	
	function loadStaffs()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.department,"select",document.wprkallotment.role,"select")){
			document.wprkallotment.submit();
		}
	}
	
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
	var flagstatus = false; 
	function submitWorks()
	{
		
		
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.department,"select",document.wprkallotment.role,"select")){
		
			/* if(count >0){ */
				
				/* for(var i=0;i<document.wprkallotment.staffs.length;i++){
					if(document.wprkallotment.staffs[i].checked){
						if(isNaN(document.wprkallotment.workhour[i].value)){
							alert("work hour should only be a number.")
							document.wprkallotment.workhour[i].value = "0";
							document.wprkallotment.workhour[i].focus();
							status = false;
							break;
						}
					}
				} */
				
				 for(var i=0;i<document.wprkallotment.staffs.length;i++){
					if(!document.wprkallotment.staffs[i].checked){
						document.wprkallotment.workhour[i].disabled = true;
					}
					if(document.wprkallotment.staffs[i].checked){
						document.wprkallotment.workhour[i].disabled = false;
					}
				}			
				
				 for(var i=0;i<document.wprkallotment.workhour.length;i++){
					if(document.wprkallotment.workhour[i].value ==""){
						document.wprkallotment.workhour[i].disabled = true;
					}
					
					/* if(document.wprkallotment.workhour[i].value !=""){
						document.wprkallotment.workhour[i].disabled = false;
					} */
				}  
				
			for(var i=0;i<document.wprkallotment.staffs.length;i++){
				
				if(document.wprkallotment.staffs[i].checked){
						flagstatus = true;
						break;
					
				}
			}
							
				if(flagstatus){ 
					
					
					
					document.wprkallotment.action = "SubmitWorkAllotment.jsp";
					document.wprkallotment.submit();
				}
				else
					{
					flagstatus=false;
					
					
					 for(var i=0;i<document.wprkallotment.staffs.length;i++){
							if(!document.wprkallotment.staffs[i].checked){
								document.wprkallotment.workhour[i].disabled = false;
							}
						}			
						
						 for(var i=0;i<document.wprkallotment.workhour.length;i++){
							/* if(document.wprkallotment.workhour[i].value ==""){ */
								document.wprkallotment.workhour[i].disabled = false;
/* 							} */
						}  
					alert("Select any of the options.")
					}
			/* }
			else{
				alert("Please select atleast one staff to set working hour");
			} */
		}
	}
	
	
	function countChecked(obj)
	{
		var i 		= obj.getAttribute("pos");
		if(obj.checked)
		{
			/* if(document.wprkallotment.staffs.length>1)
				{
					 if(document.wprkallotment.workhour.value == "")
						{
						alert("Hours should not be empty");
						document.wprkallotment.workhour.focus();
						document.wprkallotment.staffs.checked=false;
						}
				}else
			{ */
					if(document.wprkallotment.workhour[i].value == "")
					{
						alert("Hours should not be empty");
						document.wprkallotment.workhour[i].focus();  
						document.wprkallotment.staffs[i].checked=false;
						document.wprkallotment.workhour[i].disabled =false;
						
				//	}
			}		
			else
				{
				document.wprkallotment.workhour[i].disabled =true;  
				
				}
		
	}	
		else
			{
			document.wprkallotment.workhour[i].disabled =false;
			}
		
	}
	
	function checkValue(obj){
		var i 		= obj.getAttribute("pos");
	

		
		if(isNaN(document.wprkallotment.workhour[i].value)){
			
			alert("The working hour should only be a number.")
			document.wprkallotment.workhour[i].value = document.wprkallotment.workhour[i].getAttribute("oldvalue");
			document.wprkallotment.workhour[i].focus();
			return false;
		}	
	
		if(parseInt(obj.value,10)<0 || parseInt(obj.value,10)>168){
			alert("The working hour must be between 0 to 168.");
			obj.value	= obj.getAttribute("oldvalue");
		}
		
		if(parseInt(document.wprkallotment.workhour[i].getAttribute("scheduledhours"),10) > parseInt(document.wprkallotment.workhour[i].value,10)){
			alert("Staff already scheduled for "+document.wprkallotment.workhour[i].getAttribute("scheduledhours")+" hours in this session, So please remove the staff from schedule and update.");
			document.wprkallotment.workhour[i].value = document.wprkallotment.workhour[i].getAttribute("scheduledhours");
			document.wprkallotment.workhour[i].focus();
			return false;		
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.workallotment")%></h2>

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
	String sessionid		= request.getParameter("session");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	ArrayList staffList		= null;
	String scheduledhours	= "";
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && deptid != null && !deptid.equals("") && !deptid.equalsIgnoreCase("null") && roleid != null && !roleid.equals("") && !roleid.equalsIgnoreCase("null"))
		staffList			= wallot.loadDeptRoleStaffs(sessionid,deptid,roleid);
%>
	<form name='wprkallotment' method='post'>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
  	 								<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.workallotmentdetails")%></th>      
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
								<select name='session' validate='Academic Year' onchange='loadDepartment()'>
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
								<select name='department' validate='Department'  onchange='loadRole()'>
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
		<table id="rounded-corner" border=0 summary="Staff List" width="100%">
			 <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.schedule.staffname")%></th>
		            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.schedule.allotmentstatus")%></th>
		            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schedule.workhoursperweek")%></th>
		            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.schedule.check")%></th>
		        </tr>
		    </thead>
			<%
				if(staffList != null && staffList.size()>0){
					for(int y=0;y<staffList.size();y++){
						hashmap			= (HashMap)staffList.get(y);
						scheduledhours	= (String)hashmap.get("scheduledhours");
						if(scheduledhours == null || scheduledhours.equals("") || scheduledhours.equalsIgnoreCase("null"))
							scheduledhours	= "0";
						
						out.print("<tr><td class='tablelight'>"+(y+1)+"</td><td class='tablelight'>"+hashmap.get("name")+"</td><td class='tablelight'>"+hashmap.get("status")+"</td><td class='tablelight'><input type='text' value='"+hashmap.get("noofhours")+"' oldvalue='"+hashmap.get("noofhours")+"' scheduledhours='"+scheduledhours+"' size='4' pos='"+y+"' maxlength='3' name='workhour' onblur='checkValue(this)' onkeypress='checkNnmerickey(event)'></td><td class='tablelight'><input type='checkbox' name='staffs' value='"+hashmap.get("staffid")+"' pos='"+y+"' onclick='countChecked(this)'></td></tr>");
					}
				}
				else{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
					//out.print("<tr><td align='center' class='tablelight' colspan='5'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
				}
			%>
			
			</table>
									
			<%										
				if(staffList != null && staffList.size()>0){
			%>
					<a href="#" id="savebut"  class="bt_green" onclick='submitWorks()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.addupdate")%></strong><span class="bt_green_r"></span></a>
			<%
				}
			%>
									

 		<input type='hidden' name='staffs' disabled> 
		<input type='hidden' name='workhour' disabled>
	</form>



    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>