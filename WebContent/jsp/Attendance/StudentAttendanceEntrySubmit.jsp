<html>
<head>
<script language="javascript">
function loadResult()
{

	if(document.submitlessonform.resultids.value!="")
		document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Attendance/StudentAttendanceAlreadyEntered.jsp";
	else
		document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	
	document.submitlessonform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitlessonform" action="" method="post">
<%@ page language="java" %>
<%@ page import="com.iGrandee.Attendance.AttendanceBean" %> 
<%@ page import="com.iGrandee.Attendance.AttendanceQuery" %>

<%@ page import="com.iGrandee.Common.DateTime" %>

<% 

String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
String sessionusercategory = (String)session.getValue("usercategory");
DateTime dateobj=new DateTime();
AttendanceBean gen_qu=new AttendanceBean(); 

AttendanceQuery gen_query=new AttendanceQuery();
%>
		<%
		String finaleditstatus			= request.getParameter("finaleditstatus");

		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standard");
		String sectionscheduleid	= request.getParameter("section");
		String sessionname			= request.getParameter("sessionname");
		String boardname				= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("standardname");
		String sectionschedulename	= request.getParameter("sectionname"); 
		String dateofattendance = null;
		String studentallocationid []= null;
	    String Studentattendancestatus []= null;
	    String Editstatus []= null;
	    String Editstatus1 []= {"delete","delete2"};
	    String resultids = "";
	      String studentattendanceid []= null;
	      studentattendanceid		= request.getParameterValues("studentattendanceid");
	      Editstatus				= request.getParameterValues("editstatus");
	      dateofattendance 			= request.getParameter("dateofattendance");
	      String dateofattendance1	= dateofattendance;
	      		
	      
	      dateofattendance			=dateobj.getMySQLFormat(dateofattendance)+"";
	      studentallocationid		= request.getParameterValues("studallocationid");
	      Studentattendancestatus 	= request.getParameterValues("attendanceoutput");
		  gen_qu.setCreatedby(sessionuserid);
		  gen_qu.setUsercategory(sessionusercategory);
		  
		  gen_qu.setDateofattendance(dateofattendance);
		  for(int i=0;i<Editstatus.length;i++)
		  {
		  //System.out.println("Editstatus========>>>>>"+Editstatus[i]);
		  }
		  if(!finaleditstatus.equals("delete"))
		  {
			  gen_qu.setEditstatus(Editstatus); 
			  gen_qu.setStudentallocationid(studentallocationid);
			  gen_qu.setStudentattendancestatus(Studentattendancestatus);
			  gen_qu.setAttendanceid(studentattendanceid);
		  }
		  else if(finaleditstatus.equals("delete"))
		  {
			  for(int i=0;i<Editstatus.length;i++)
			  {
				  if(Editstatus[i].equals("delete"))
				  {
					  /*System.out.println("studentallocationid[i]========>>>>>"+studentallocationid[i]);
					  System.out.println("studentattendanceid[i]========>>>>>"+studentattendanceid[i]);
					  System.out.println("Studentattendancestatus[i]========>>>>>"+Studentattendancestatus[i]);*/

					  String studentallocationidnew []={studentallocationid[i],""};
					  String studentattendanceidnew []={studentattendanceid[i],""};
					  String Studentattendancestatusnew []={Studentattendancestatus[i],""};
					  gen_qu.setStudentallocationid(studentallocationidnew);
					  gen_qu.setStudentattendancestatus(Studentattendancestatusnew);
					  gen_qu.setEditstatus(Editstatus1); 
					  gen_qu.setAttendanceid(studentattendanceidnew);
				  }

			  }
			  
		  }
		  String ipaddress  = request.getRemoteHost();
		  gen_qu.setIpaddress(ipaddress); 
		  String word="";
		/*if(Editstatus.equals("new"))
				word="Inserted";
		else if(Editstatus.equals("update"))
			word="Updated";
		else if(Editstatus.equals("delete"))
			word="Deleted";*/
		%>
		<input type=hidden name=session value="<%=sessionid%>">
		<input type=hidden name=board value="<%=boardid%>">
		<input type=hidden name=standard value="<%=standardscheduleid%>">
		<input type=hidden name=section value="<%=sectionscheduleid%>">
		<input type="hidden" name="sessionname" value="<%=sessionname%>">
		<input type="hidden" name="boardname" value="<%=boardname%>">
		<input type="hidden" name="standardname" value="<%=standardschedulename%>">
		<input type="hidden" name="sectionname" value="<%=sectionschedulename%>">
		<input type=hidden name="attendancedate" value="<%=dateofattendance1%>">
		<input type=hidden name="Editstatuss" value="<%=Studentattendancestatus[0]%>">
		<input type="hidden" name="op" value="Completed">
				<%
				
		//int result=gen_query.Studentattendanceinsert(gen_qu);
		int result=gen_query.Studentattendanceinsertser(gen_qu);
						
				
		//System.out.println("result===========>>>>"+Studentattendancestatus[0]);
		String return_file = "./Attendance/StudentAttendanceEntry.jsp";
		//if(session.getValue("usercategory").equals("SA") || session.getValue("usercategory").equals("MA")){
			// return_file = "./Attendance/StudentAttendanceEntry.jsp";
		//}
		//else
			return_file = "./Attendance/StudentAttendanceEntryForStaff.jsp";
		
		String resultword = "";
		if(result >0){
			if(finaleditstatus.equals("delete"))
				resultword="Attendance Successfully Deleted";
			else
				resultword="Attendance Successfully Entered";
		}
		else
		{
			resultword="Operation Failed";
		}
System.out.print("gen_qu.getResultnames().length()-->"+gen_qu.getResultnames().length());
		//if(gen_qu.getResultnames() != null && gen_qu.getResultnames().length() >0){
			if(gen_qu.getResultids() != null && gen_qu.getResultids().length() >0){
			String resultnames = (String)gen_qu.getResultnames();
			 resultids = (String)gen_qu.getResultids();
			return_file = "./Attendance/StudentAttendanceAlreadyEntered.jsp";
			resultword	+= "<br>Attendance already entered for the following Students <br>"+resultnames.substring(0,resultnames.length()-1);
		}
		%>

		<input type=hidden name=resultids value="<%=resultids%>">

<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">  			
			</form>
	</body>
</html>

