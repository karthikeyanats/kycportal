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
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>

<script language='javascript'>

	function goBack()
	{
		document.wprkallotment.action	= "ClassTeacher.jsp";
		document.wprkallotment.submit();
	}	
	
	function deleteTeacher(){
	
		if(confirm("Do you want to remove the Class Teacher?")){
		
			document.wprkallotment.action	= "ClassTeacherSubmit.jsp";
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.viewclassteacher")%></h2>


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
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String sessionname		= request.getParameter("sessionname");
	String standardname		= request.getParameter("standardname");
	String sectionname		= request.getParameter("sectionname");
	String boardname		= request.getParameter("boardname"); 
	ArrayList staffList		= wallot.loadClassTeacherAllotted(sectionid);
	
	
%>
	<form name='wprkallotment' method='post'>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.classteacherdetails")%></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>
					<table  border=0  width="100%">
		    	<tr>
					<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
					<td  class='tablebold' width='1'>:</td>
					<td  class='tablelight' >
						<%=sessionname %>				
					</td>
				</tr>
				<tr  height='23'>
					<td  class='tablebold' width='20%' ><%=bundle.getString("label.schedule.board")%></td>
					<td  class='tablebold' width='1'>:</td>
					<td  class='tablelight' >
						<%=boardname %>
					</td>
				</tr>			
				<tr  height='23'>
					<td  class='tablebold' width='20%' ><%=bundle.getString("label.schedule.standardname")%></td>
					<td  class='tablebold' width='1'>:</td>
					<td  class='tablelight' >
						<%=standardname %>
					</td>
				</tr>
				<tr height='23'>
					<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
					<td  class='tablebold' width='1'>:</td>
					<td  class='tablelight' >
						<%=sectionname %>
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
		        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schedule.staffname")%></th>
		            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schedule.subjectname")%></th>
		        </tr>
		    </thead>
	        <%
	        		String status	= "";
					if(staffList != null && staffList.size()>0){
						for(int y=0;y<staffList.size();y++){
							hashmap		= (HashMap)staffList.get(y);
								out.print("<tr><td>"+(y+1)+"</td><td>"+hashmap.get("staffname")+"</td><td>"+hashmap.get("subjectname")+" - "+hashmap.get("subjectcode")+"</td><input type='hidden' name='staffid' value='"+hashmap.get("staffid")+"'></tr>");
						}
					}
					else{
						out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
						//out.print("<tr><td colspan='3' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
					}
	        %>
		</table>

		<%if(staffList != null && staffList.size()>0){ %>
			<a href="#" class="bt_red" onclick='deleteTeacher()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.removeclassteacher")%></strong><span class="bt_red_r"></span></a>
		<%} %>
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
		<input type='hidden' name='session' 		value='<%=sessionid%>'>
		<input type='hidden' name='standard' 	value='<%=standardid%>'>
		<input type='hidden' name='section'			value='<%=sectionid%>'>
		<input type='hidden' name='status'			value='update'>
		
		
		
	</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>