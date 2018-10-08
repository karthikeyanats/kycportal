<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Report View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.StudentReport_Form.action="./StudentReport.jsp";
	document.StudentReport_Form.submit();
	}

	function printfun()
	{
	window.open("PrintPreviewStudentReportView.jsp?boardname="+document.StudentReport_Form.req_boardname.value+"&req_sessionname="+document.StudentReport_Form.req_sessionname.value+"&standardscheduleid="+document.StudentReport_Form.standardscheduleid.value+"&sectionscheduleid="+document.StudentReport_Form.sectionscheduleid.value+"&req_standardnamegp="+document.StudentReport_Form.req_standardnamegp.value+"&req_sectionname="+document.StudentReport_Form.req_sectionname.value+"&req_sessionid="+document.StudentReport_Form.req_sessionid.value+"&board="+document.StudentReport_Form.board.value+"&req_sessionstatus="+document.StudentReport_Form.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}
		
function studentprofileview(obj)
{
document.StudentReport_Form.StudentPersonid.value=obj.getAttribute("personid");
document.StudentReport_Form.req_rollno.value=obj.getAttribute("rollno");
document.StudentReport_Form.action="./SeesionStudentProfileView.jsp";
//document.StudentReport_Form.action="./StudentReportProfileView.jsp";
document.StudentReport_Form.submit();
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
    <h2><%=bundle.getString("label.reports.reportsstudentlistview")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>

<form name="StudentReport_Form" action="" method="post">

		
		<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D','A','C";
		%>
		<table>		
		<tr>
			<td width='20%' valign=top class='tablebold'><%=bundle.getString("label.schedule.archivaldetails")%></h2></td>
			<td width='1%' valign=top class='tablebold'>:</td>
			<td valign=top class='tablelight' width='79%'>
				<h2><%=bundle.getString("label.schedule.archivalmessage1")%></h2>
			</td>
		</tr>
		</table>
		<%		
			}
		%>		
<%

		PrinicipalQuery prinicipalquery			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;	
		DateTime dateobj=new DateTime();
		String sessionid			= request.getParameter("req_sessionid");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		String sectionscheduleid	= request.getParameter("sectionscheduleid");
		
		String sessionname			= request.getParameter("req_sessionname");
		String boardname			= request.getParameter("req_boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
		String sectionschedulename	= request.getParameter("req_sectionname");

		String condition	= request.getParameter("attendanceradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		//out.println(standardscheduleid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);
		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			studentList			= prinicipalquery.loadSectionwiseStudent(sectionscheduleid,status);
			//studentList			= prinicipalquery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid); 
		}
		
%>
		<input type=hidden name=hiddensession value="<%=sessionid%>">
		<input type=hidden name=hiddenboard value="<%=boardid%>">
		<input type=hidden name=standardscheduleid value="<%=standardscheduleid%>">
		<input type=hidden name=sectionscheduleid value="<%=sectionscheduleid%>">
		
		<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
		<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
		<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
		<input type="hidden" name="board" value="<%=boardid%>">
		
		<input type="hidden" name="req_boardname" value="<%=boardname%>">
		<input type="hidden" name="req_standardnamegp" value="<%=standardschedulename%>">
		<input type="hidden" name="req_sectionname" value="<%=sectionschedulename%>">
		<input type="hidden" name="req_rollno" >
		
		<input type="hidden" name="StudentPersonid" value="">
		<input type="hidden" name="condition" value="studentlist">
		
		
		<table width='100%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		        	
		            <th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
		        	<th scope="col" class="rounded-q4"   ></th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td  class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>
			<tbody>		    
			<tr>
			<td colspan=2>
			<table width=100% border=0>
			<tr>
				<td  class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td  class='tablebold'>:</td>
				<td class='tablelight' >
				<%=sessionname%>
				</td>
				<td  class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
				<td  class='tablebold'>:</td>
				<td class='tablelight' >
					<%=boardname%>
				</td>
				
			</tr>
			<tr>
			
				<td  class='tablebold' ><%=bundle.getString("label.schedule.standardname")%></td>
				<td  class='tablebold'>:</td>
				<td class='tablelight'>
					<%=standardschedulename%>
				</td>
				<td  class='tablebold'><%=bundle.getString("label.schedule.section")%></td>
				<td  class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sectionschedulename%>
				</td>
				
			</tr>
			</table>
			</td></tr></tbody></table>
		<br>
					<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schedule.studentname")%></th>
					            <th scope="col" class="rounded"	width="15%"><%=bundle.getString("label.schedule.rollno")%></th>
					            <th scope="col" class="rounded"	width="25%"><%=bundle.getString("label.schedule.fathername")%></th>
					            <th scope="col" class="rounded"	width="10%"><%=bundle.getString("label.schedule.mobileno")%></th>
					            <th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.schedule.email")%></th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="5" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
							<%
							String firstname = null;
							String lastname = null;
							String middlename = null;
							
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("uname");
								

firstname		= (String)hashmap.get("firstname");
								 middlename		= (String)hashmap.get("middlename");
								 lastname		= (String)hashmap.get("lastname");
								 
								 if(middlename==null || middlename.equals("") || middlename.equals("-")){
									 middlename="";
								 }
								 else
								 {
									 middlename=" "+middlename;
								 }
								 
								 if(lastname==null || lastname.equals("") || lastname.equals("-")){
									 lastname="";
							}
							 else
							 {
								 lastname=" "+lastname;
							 }
								 Studname = firstname+middlename+lastname;
								String rollno		= hashmap.get("rollno")+"";
								String fathername		= (String)hashmap.get("fathername");
								if(rollno.equals("null"))
									rollno="-";
								String mobilenumber		= hashmap.get("mobilenumber")+"";
								if(mobilenumber.equals("null"))
									mobilenumber="-";
								String emailid		= hashmap.get("emailid")+"";
								if(emailid.equals("null"))
									emailid="-";								
								
								String studallocationid	= (String)hashmap.get("studentallocationid");
								String personid	= (String)hashmap.get("personid");

								out.print("<tr>");
								out.print("<td>"+j+".</td>");
								out.print("<td><a href='#studentprofile' name='studentprofile' personid='"+personid+"' rollno='"+rollno+"' onclick='studentprofileview(this)' >"+Studname+"</a></td>");
								out.print("<td>"+rollno+"</td>");
								out.print("<td>"+fathername+"</td>");
								out.print("<td>"+mobilenumber+"</td>");
								out.print("<td><a href=mailto:"+emailid+">"+emailid+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
						}
							out.print("</table>");
						%>
					
				

		</table>
		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%if(studentList.size()>0){%> 
				<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%} %>		
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>