<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Search View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.StudentReport_Form.action="./StudentSearchNameDob.jsp";
	document.StudentReport_Form.submit();
	}
	
function studentprofileview(obj)
{
document.StudentReport_Form.StudentPersonid.value=obj.getAttribute("personid");
document.StudentReport_Form.req_rollno.value=obj.getAttribute("rollno");
document.StudentReport_Form.req_sessionname.value = obj.getAttribute("sessionname");
document.StudentReport_Form.req_boardname.value = obj.getAttribute("boardname");
document.StudentReport_Form.req_standardnamegp.value = obj.getAttribute("standardname");
document.StudentReport_Form.req_sectionname.value = obj.getAttribute("sectionname");
document.StudentReport_Form.condition.value = "studentsearch";

document.StudentReport_Form.action="../StudentSearch/SearchStudentView.jsp";
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

    <div class="right_content">

    <h2> Search / Student Search / Student Search View / Student Profile</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>

<form name="StudentReport_Form" action="" method="post">

		
		<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D";
		%>
		<table>		
		<tr>
			<td width='20%' valign=top class='tablebold'>Archival Details</td>
			<td width='1%' valign=top class='tablebold'>:</td>
			<td valign=top class='tablelight' width='79%'>
				<h2>This is an Archived Year</h2>
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
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		//out.println("standardscheduleid===>>>"+standardscheduleid);
		String sectionscheduleid	= request.getParameter("sectionscheduleid");
		//out.println("sectionscheduleid===>>>"+sectionscheduleid);
		String sessionname			= request.getParameter("req_sessionname");
		String boardname			= request.getParameter("req_boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
		String sectionschedulename	= request.getParameter("req_sectionname");

		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		//out.println(standardscheduleid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);
		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			//studentList			= prinicipalquery.loadSectionwiseStudent(sectionscheduleid,status);
			//studentList			= prinicipalquery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid); 
		}
		studentList			= prinicipalquery.searchStudentNameDob(request.getParameter("studentname"),request.getParameter("fathername"),request.getParameter("dateOfBirth"));
		//out.print("studentList-->"+studentList);
%>
		<input type=hidden name=hiddensession value="<%=sessionid%>">
		<input type=hidden name=hiddenboard value="<%=boardid%>">
		
		<input type=hidden name=sectionscheduleid value="<%=sectionscheduleid%>">
		
		<input type="hidden" name="req_sessionname">
		<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
		<input type="hidden" name="req_boardname" value="<%=boardname%>">
		<input type="hidden" name="req_standardnamegp">
		<input type="hidden" name="req_sectionname">
		<input type="hidden" name="req_rollno" >
		<input type="hidden" name="condition" >
		<input type="hidden" name="studentname" value="<%=request.getParameter("studentname") %>">
		<input type="hidden" name="fathername"  value="<%=request.getParameter("fathername") %>">
		<input type="hidden" name="dateOfBirth"  value="<%=request.getParameter("dateOfBirth") %>">
		
		<input type="hidden" name="StudentPersonid" value="">
		
		
		<table width='80%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" ></th>
		            <th scope="col" class="rounded" colspan=6 width="100%">Selected Information</th>
		        	<th scope="col" class="rounded-q4"   ></th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td colspan="7" class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>		    
			<tr>
			<td></td>
				<td width='20%' class='tablebold'>Student Name</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='29%'>
				<%=request.getParameter("studentname")%>
				</td>
				<td width='20%' class='tablebold'>Father Name</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='29%'>
					<%=request.getParameter("fathername")%>
				</td>
				<td></td>
			</tr>
			<tr>
			<td></td>
				<td width='20%' class='tablebold' >Date of Birth</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=request.getParameter("dateOfBirth")%>
				</td>
				<td  class='tablebold'></td>
				<td width='1%' class='tablebold'></td>
				<td class='tablelight'>
				</td>
				<td></td>
			</tr>
			</table>
		<br>
					<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%">SL No.</th>
					            <th scope="col" class="rounded" width="30%">Student Name</th>
					            <th scope="col" class="rounded"	width="20%">Roll No</th>	            
					            <th scope="col" class="rounded" width="20%">Email</th>
					            <th scope="col" class="rounded-q4"	width="20%">Image</th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="4" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
							<%
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("uname");
								String rollno		= hashmap.get("rollno")+"";
								if(rollno.equals("null"))
									rollno="-";

								String emailid		= hashmap.get("emailid")+"";
								if(emailid.equals("null"))
									emailid="-";								

								String imagepath	= hashmap.get("imagepath")+"";
								if(imagepath.equals("null"))
									imagepath="-";
								
								String studallocationid	= (String)hashmap.get("studentallocationid");
								String personid	= (String)hashmap.get("personid");
								standardscheduleid = (String)hashmap.get("standardscheduleid");
								//out.println("standardscheduleid===>>>"+standardscheduleid);

								out.print("<tr>");
								out.print("<td>"+j+".</td>");
								out.print("<td><a href='#studentprofile' name='studentprofile' sessionname='"+hashmap.get("sessionname")+"' boardname='"+hashmap.get("boardname")+"'  standardname='"+hashmap.get("standardname")+"' sectionname='"+hashmap.get("sectionname")+"' personid='"+personid+"' rollno='"+rollno+"' onclick='studentprofileview(this)' >"+Studname+"</a></td>");
								out.print("<td>"+rollno+"</td>");
								out.print("<td><a href=mailto:"+emailid+">"+emailid+"</a></td>");
								
								out.println("<td  valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+imagepath+"' width=60 height=47></td>");
								//out.print("<td>"+imagepath+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
						}
							out.print("</table>");
						%>
					
				

		</table>
		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<input type=hidden name=standardscheduleid value="<%=standardscheduleid%>" />
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>