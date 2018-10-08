<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.examlist.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>

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

    <h2><%=bundle.getString("label.examlist.entryheading") %> </h2>
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

HashMap	hashmap			= null;
String req_sessionids 	= null;
String instituteid		= (String)session.getValue("instituteid");
String sectionid				= (String)session.getValue("sectionscheduleid");
String standardscheduleid				= (String)session.getValue("standardscheduleid");
String studentid				= (String)session.getValue("studentid");
String usercategory_temp				= (String)session.getValue("usercategory");
ArrayList LoadExamScheduleList = null;
 

%>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    	<tbody>
	

<table id="rounded-corner" border=0 summary="Examschedule List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examlist.SL.No") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.examlist.SubjectName") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.examlist.ExamDate") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examlist.StartTime") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examlist.EndTime") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.exam.duration") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.exam.examtype") %></th>
                     
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
    	 String examnameid=request.getParameter("examnameid");
    	 
        		LoadExamScheduleList=examnameEntry.LoadScheduledForHomepageExamStudent(standardscheduleid,examnameid);
	
    	 	
    	  
    	String temp_standardid = "";
    	 if(LoadExamScheduleList!=null && LoadExamScheduleList.size()>0)
			{
    		
    		 for (int i = 0, j = 1; i < LoadExamScheduleList.size(); i++) {
			
				HashMap ExamScheduleListMap=(HashMap)LoadExamScheduleList.get(i);
				
				String subjectname 		  	= (String)ExamScheduleListMap.get("subjectname");
				String examdate  	= (String)ExamScheduleListMap.get("examdate");
				//String examtimein      	= (String)ExamScheduleListMap.get("examtimein");
				//String examtimeout=(String)ExamScheduleListMap.get("examtimeout");
				String examtimeinampm=(String)ExamScheduleListMap.get("examtimeinampm");
				String examtimeoutampm=(String)ExamScheduleListMap.get("examtimeoutampm");
				String duration=(String)ExamScheduleListMap.get("duration");
				String examtype=(String)ExamScheduleListMap.get("examtype");
				
				
			%>
	<tr>
			 <td><%=j++ %></td>
            <td><%=subjectname %></td>
            <td><%=examdate %></td>
            <td><%=examtimeinampm %></td>
            <td><%=examtimeoutampm%></td>
            <td><%=duration%></td>
            <td><%=examtype%></td>
            
                       
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='11'><font color='red'>Data Not Found</font></td></tr>");
    	 		//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");    	 
    	 	}
    	    
     }catch(Exception e){}
          
     %>			
			   	
           

	</tbody>
</table>


</table>
 <% 
 if(usercategory_temp.equals("P"))
 {
            out.print("<a href='../../Parent/TimeTable.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.examlist.Back")+"</strong><span class='bt_blue_r'></span></a>");
 }
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