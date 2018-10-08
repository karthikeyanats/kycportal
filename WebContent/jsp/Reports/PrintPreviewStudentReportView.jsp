<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student List | Powered by i-Grandee</title>
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
<body>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D','A','C";
			}
		%>

<form name="StudentReport_Form" action="" method="post">
<%
int datacount=0;
InstitutionQurey insquery=new InstitutionQurey();

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
		String boardname			= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
		String sectionschedulename	= request.getParameter("req_sectionname");

		String condition	= request.getParameter("attendanceradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		ArrayList insdetails=insquery.getInstituteDetails(instituteid);

		/*out.println(standardscheduleid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);
		out.println(boardid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);*/

		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			studentList			= prinicipalquery.loadSectionwiseStudent(sectionscheduleid,status);
			//studentList			= prinicipalquery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid); 
		}
		
%>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width="640" align=center >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Student List</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr align='left'>
				<td width='25%' class='tablebold' align='left'>Academic Year</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' align='left'>
				<%=sessionname%>
				</td>
				<td width='5%' class='tablebold' align='left'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' align='left'>
					<%=boardname%>
				</td>
			</tr>
			<tr align='left'>
				<td width='20%' class='tablebold'  align='left'>Standard</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' align='left'>
					<%=standardschedulename%>
				</td>
				<td  class='tablebold' align='left'>Section</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' align='left'>
					<%=sectionschedulename%>
				</td>
			</tr>
					<%
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		%>
		<tr>
			<td width='20%'  align=left class='tablebold'>Archival Details</td>
			<td width='1%' class='tablebold'>:</td>
			<td align=left class='tablelight' colspan=4>
				<h2>This is an Archived Year</h2>
			</td>
		</tr>
		<%		
			}
		%>					
				</table>
			    	
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr  class='tableheading'>
					        	<th align=left  width="10%">SL No.</th>
					            <th align=left  width="30%">Student Name</th>
					            <th align=left  width="20%">Roll No</th>
					            <th align=left  width="20%">Father Name</th>
					            <th align=left  width="20%">Mobile No</th>
					            <th align=left  width="20%">Email</th>
					      		<th align=left  width="20%">Image</th>
					            
					        </tr>
					    </thead>
						<%
						try{
							if(studentList != null && studentList.size()>0){
								for(int y=0,j=1;y<studentList.size();y++,j++){
									hashmap			= (HashMap)studentList.get(y);
									String Studname		= (String)hashmap.get("uname");
									

String firstname		= (String)hashmap.get("firstname");
String 	 middlename		= (String)hashmap.get("middlename");
String  lastname		= (String)hashmap.get("lastname");
								 
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
									String image		= hashmap.get("imagepath")+"";

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
									out.print("<tr class='tablelight' >");
									out.print("<td>"+j+".</td>");
									out.print("<td>"+Studname+"</td>");
									out.print("<td>"+rollno+"</td>");
									out.print("<td>"+fathername+"</td>");
									out.print("<td>"+mobilenumber+"</td>");
									out.print("<td>"+emailid+"</td>");
						        	out.println("<td  valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+image+"' width=60 height=47></td>");

									out.print("</tr>");
								}
								datacount=1;
							}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
							}
						}
						catch(Exception e)
						{
							e.printStackTrace();
						}
							%>
					        
					</table>
				</td></tr>
					
		</table>
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
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