<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.exammarkparent.entrytitle")%> | Powered by i-Grandee</title>
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

    <h2><%=bundle.getString("label.exammarkparent.entryheading")%> </h2>
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
try
{
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
<%if(session.getValue("usercategory").equals("P")){%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.exammarkparent.StudentDetails")%></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.exammarkparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.exammarkparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table><%} %>	
					<br>
					

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" colspan=3><%=bundle.getString("label.exammarkparent.ExamMark") %></th>
          	<th scope="col" class="rounded-q4"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
				<td colspan=2 width='20%' class='tablebold'><%=bundle.getString("label.exammarkparent.ExamName") %></td>
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
     </tbody>
     </table>
          <br>
	

<table id="rounded-corner" border=0 summary="Examschedule List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="8%"><%=bundle.getString("label.exammarkparent.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.exammarkparent.SubjectName") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.exammarkparent.SubjectCode") %></th>
        	<th scope="col" class="rounded" width="8%"><%=bundle.getString("label.exammarkparent.Minimum/Maximum") %></th>
            <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.exammarkparent.Mark") %></th>
            <th scope="col" class="rounded" width="7%"><%=bundle.getString("label.exammarkparent.Result") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.exammarkparent.StaffRemarks") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.exammarkparent.Status") %></th>
                               
        </tr>
    </thead>

    <tfoot>
    	<tr>
        	<td colspan=7 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>    
    <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     
     try
     {
    	 	
    		LoadExamScheduleList=exallotQuery.LoadStudentMarkList(studentid,req_examnameid);
    	    
    	  
    	String temp_standardid 	= "";
    	
    	int total=0;
    	int maxMark = 0;
    	if(request.getParameter("examnameid") != null && !(request.getParameter("examnameid")+"").equals("0"))
    	{
    	 if(LoadExamScheduleList!=null && LoadExamScheduleList.size()>0)
			{
    		
    		 for (int i = 0, j = 1; i < LoadExamScheduleList.size(); i++) {
    			String passStatus 		= "Pass";
				HashMap ExamScheduleListMap=(HashMap)LoadExamScheduleList.get(i);
				
				String subjectname 		  	= (String)ExamScheduleListMap.get("subjectname");
				String subjectcode  	= (String)ExamScheduleListMap.get("subjectcode");
				String subjectmark      	= (String)ExamScheduleListMap.get("marktaken");
				
				String maxmark      	= (String)ExamScheduleListMap.get("theoryexternalmax");
				String minmark      	= (String)ExamScheduleListMap.get("theoryexternalmin");
				String staffRemark      = (String)ExamScheduleListMap.get("staffremarks");
				String comboRemark      = (String)ExamScheduleListMap.get("comboremarks");
				
				//minMark = Integer.parseInt(minmark);
				if(Integer.parseInt(subjectmark)<Integer.parseInt(minmark))
					passStatus = "Fail";
				if(staffRemark.equals(""))
					staffRemark = "-";
				
				maxMark+=Integer.parseInt(maxmark);
				total+=Integer.parseInt(subjectmark);
			%>
	<tr>
			<td valign=top><%=j++ %></td>
            <td valign=top><%=subjectname %></td>
            <td valign=top><%=subjectcode %></td>
            <td valign=top align=center><%=minmark%>/<%=maxmark%></td>
            <td valign=top><%=subjectmark %></td>
            <td valign=top><%=passStatus%></td>
            <td valign=top><%=staffRemark%></td>
            <td valign=top><%=comboRemark%></td>
            
            
                       
        </tr>
        
				<%
    		 }
    		 out.println("<tr><td></td><td class='tablebold' >"+bundle.getString("label.exammarkparent.Total")+" </td><td></td><td  class='tablebold' align=center>"+maxMark+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td class='tablebold' >"+total+"</td><td></td><td></td><td></td></tr>");
			}
    	 
         
         
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");    	 
    	 	}
    	}
    	else
    	{
    		out.println("<tr align='center' ><td colspan='9'>Select Exam Name</td><tr>");
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