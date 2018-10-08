<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Profile | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.Student_Form.action="./StudentView.jsp";
	document.Student_Form.submit();
	}
	
function studentprofileview(obj)
{
document.Student_Form.StudentPersonid.value=obj.getAttribute("personid");
document.Student_Form.action="./StudentProfileView.jsp";
document.Student_Form.submit();
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

    <h2> Student  /  Student Profile  View  / Student List</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

PrinicipalQuery prinicipalquery			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;	
		DateTime dateobj=new DateTime();
		String sessionid			= session.getValue("sessionid")+"";
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		String sectionscheduleid	= request.getParameter("sectionscheduleid");
		
		String sessionname			= request.getParameter("sessionname");
		String boardname			= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("standardname");
		String sectionschedulename	= request.getParameter("sectionname");

		String condition	= request.getParameter("attendanceradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		//out.println(standardscheduleid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);
		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			studentList			= prinicipalquery.loadstudentforsectionscheduleid(sectionscheduleid,"T");
			//studentList			= prinicipalquery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid); 
		}
		
%>

<form name="Student_Form" action="" method="post">
		<input type=hidden name=hiddensession value="<%=sessionid%>">
		<input type=hidden name=hiddenboard value="<%=boardid%>">
		<input type=hidden name=standardscheduleid value="<%=standardscheduleid%>">
		<input type=hidden name=sectionscheduleid value="<%=sectionscheduleid%>">
		
		<input type="hidden" name="sessionname" value="<%=sessionname%>">
		<input type="hidden" name="boardname" value="<%=boardname%>">
		<input type="hidden" name="standardname" value="<%=standardschedulename%>">
		<input type="hidden" name="sectionname" value="<%=sectionschedulename%>">
		
		<input type="hidden" name="StudentPersonid" value="">
		<input type="hidden" name="condition" value="studentlist">
		
		
		
		<table width='80%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" ></th>
		            <th scope="col" class="rounded" colspan=6 width="100%">Selected Details</th>
		        	<th scope="col" class="rounded-q4"   ></th>
		        </tr>
		    </thead>
			<tr>
			<td></td>
				<td width='20%' class='tablebold'>Academic Year</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
				<%=session.getValue("sessionname")%>
				</td>
				<td width='5%' class='tablebold'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=boardname%>
				</td>
				<td></td>
			</tr>
			<tr>
			<td></td>
				<td width='20%' class='tablebold' >Standard</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=standardschedulename%>
				</td>
				<td  class='tablebold'>Section</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sectionschedulename%>
				</td>
				<td></td>
			</tr>
			</table>
		<br>
					<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%">SL No.</th>
					            <th scope="col" class="rounded" 		width="50%">Student Name</th>
					            <th scope="col" class="rounded-q4"		width="40%">Roll No</th>
					        </tr>
					    </thead>
							<%
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("uname");
								String rollno		= hashmap.get("rollno")+"";
								if(rollno.equals("null"))
									rollno="-";
								String studallocationid	= (String)hashmap.get("studentallocationid");
								String personid	= (String)hashmap.get("personid");

								out.print("<tr>");
								out.print("<td>"+j+".</td>");
								out.print("<td><a href='#studentprofile' name='studentprofile' personid='"+personid+"' onclick='studentprofileview(this)' >"+Studname+"</a></td>");
								out.print("<td>"+rollno+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
						}
							out.print("</table>");
						%>
					
				

		</table>
		<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>