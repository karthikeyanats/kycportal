<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.examscheduleparent.entrytitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
function editExamname(obj)
{

	document.examscheduleviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	document.examscheduleviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examscheduleviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examscheduleviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examscheduleviewform.action="ExamnameUpdate.jsp";
	document.examscheduleviewform.submit();
}
function onchangesubmitfun()
{
	document.examscheduleviewform.examnameid.value =	document.examscheduleviewform.examnameid.options[document.examscheduleviewform.examnameid.options.selectedIndex].value
	document.examscheduleviewform.submit();
}
function loadExam()
{
	document.examscheduleviewform.req_sessionids.value=document.examscheduleviewform.sessionname.options[document.examscheduleviewform.sessionname.options.selectedIndex].value;
	document.examscheduleviewform.submit();

}


</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.examscheduleparent.entryheading")%> </h2>
<form name="examscheduleviewform" action="" method="post">



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamnameEntry"%>
	<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment"%>
	
<%
com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  exallotQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();


HashMap	hashmap			= null;
String req_sessionids 	= null;
String req_examnameid="";
String examnameid="";
ArrayList examnameList=null;
ArrayList LoadExamScheduleList = null;
String instituteid		= null;
String sectionid = null;
String standardscheduleid	= null;
String studentid	= null;
try{
	instituteid		= (String)session.getValue("instituteid");
	sectionid				= (String)session.getValue("sectionscheduleid");
	standardscheduleid				= (String)session.getValue("standardscheduleid");
	//System.out.println("standardscheduleid>>>>>"+standardscheduleid);
	studentid				= (String)session.getValue("studentid");
	req_examnameid=request.getParameter("examnameid");
	
}catch(Exception e){}


%>
<%
try{
	if(session.getValue("usercategory").equals("P")){%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.examscheduleparent.StudentDetails")%></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>Student Name</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.examscheduleparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>	<%} %>
					<br>
					

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
           	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.examscheduleparent.ExamSchedule")%></th>
        	<th scope="col" class="rounded" ></th>
          	<th scope="col" class="rounded-q4"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
		<td width="100%" colspan=3>
		<table border=0 width="100%">
		<tr>
				<td width='20%' class='tablebold'><%=bundle.getString("label.examscheduleparent.ExamName")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='examnameid'  id='examnameid'   validate='Exam Name'  onchange="onchangesubmitfun()">
						<option value='0' >-Select Exam Name-</option>
						<%
							examnameList=exallotQuery.LoadExamnameListforStudent(standardscheduleid);
						//System.out.println("examnameList>>>>"+examnameList);
							if(examnameList != null && examnameList.size()>0)
								for(int y=0;y<examnameList.size();y++)
								{
									HashMap	examnamlistMap	= (HashMap)examnameList.get(y);
									String examname 		  	= (String)examnamlistMap.get("examname");
									examnameid  	= (String)examnamlistMap.get("examnameid");
									
									
									if(examnameid.equals(req_examnameid))
									{
										out.println("<option selected value='"+examnameid+"' class=tablelight >"+examname+"</option>");
									}
									else
									{
										out.println("<option value='"+examnameid+"' class=tablelight >"+examname+"</option>");
									}
								}
						%>
					</select>
				</td>
			</tr>	
				</table>
				</td></tr> 
			
     </tbody>
     </table>
          <br>
	

<table id="rounded-corner" border=0 summary="Examschedule List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examscheduleparent.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.examscheduleparent.SubjectName")%> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.examscheduleparent.ExamDate")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examscheduleparent.StartTime")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examscheduleparent.EndTime")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.exam.duration")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.exam.examtype")%></th>
                     
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     
     try
     {
    	 	
    		LoadExamScheduleList=examnameEntry.LoadScheduledExamStudent(standardscheduleid,request.getParameter("examnameid"));
//out.print("examnameid---->"+request.getParameter("examnameid"));    	    
    	  
    	String temp_standardid = "";
    	if(request.getParameter("examnameid") != null && !(request.getParameter("examnameid")+"").equals("0"))
    	{	
    	 if(LoadExamScheduleList!=null && LoadExamScheduleList.size()>0)
			{
    		
    		 for (int i = 0, j = 1; i < LoadExamScheduleList.size(); i++) {
			
				HashMap ExamScheduleListMap=(HashMap)LoadExamScheduleList.get(i);
				
				String subjectname 		  	= (String)ExamScheduleListMap.get("subjectname");
				String examdate  	= (String)ExamScheduleListMap.get("examdate");
				String examtimein      	= (String)ExamScheduleListMap.get("examtimein");
				String examtimeout=(String)ExamScheduleListMap.get("examtimeout");
				String examtimeinampm      	= (String)ExamScheduleListMap.get("examtimeinampm");
				String examtimeoutampm=(String)ExamScheduleListMap.get("examtimeoutampm");
				String duration=(String)ExamScheduleListMap.get("duration");
				String examtype=(String)ExamScheduleListMap.get("examtype");

				%>
	<tr>
			 <td><%=j++ %></td>
            <td><%=subjectname %></td>
            <td><%=examdate %></td>
            <td><%=examtimeinampm %></td>
            <td><%=examtimeoutampm %></td>
            <td><%=duration %></td>
            <td><%=examtype %></td>           
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");    	 
    	 	}
    	}
    	else
    	{
    		out.println("<tr align='center' ><td colspan='7'>Select Exam Name</td><tr>");
    	}
    	    
     }catch(Exception e){}
          
     %>			
			   	
           

	</tbody>
</table>


<input type=hidden name=req_examnameid value="<%=examnameid %>">
<%
}
catch(Exception e){}
%>
</form>

	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>