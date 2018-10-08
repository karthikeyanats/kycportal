<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
</script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">


function goBack()
{
	document.examscheduleviewform.action =	"ExamMarkView.jsp"
	document.examscheduleviewform.submit();
}
function onchangesubmitfun()
{
	//document.examscheduleviewform.examnameid.value =	document.examscheduleviewform.examnameid.options[document.examscheduleviewform.examnameid.options.selectedIndex].value
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
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Exam / Exam Mark / Exam Mark View / Staff Remarks </h2>
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
//ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  exallotQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();


HashMap	hashmap			= null;
String req_sessionids 	= null;
String req_examnameid="";
//String examnameid="";
ArrayList examnameList=null;
ArrayList LoadExamScheduleList = null;
String instituteid		= null;
//String sectionid = null;
//String standardscheduleid	= null;
String studentid	= null;
try{
	instituteid		= (String)session.getValue("instituteid");
	//sectionid				= (String)session.getValue("sectionscheduleid");
	//standardscheduleid				= (String)session.getValue("standardscheduleid");
	//System.out.println("standardscheduleid>>>>>"+standardscheduleid);
	//studentid				= (String)session.getValue("studentid");
	studentid				= request.getParameter("req_studentallocationid");
	
	req_examnameid=request.getParameter("req_examnameid");
	
}catch(Exception e){}


%>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
        	<tr>
        		<th scope="col" class="rounded-company" width="10"></th>
            	<th scope="col" class="rounded" width="100%">Selected Information</th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>

    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
		<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
		<input type=hidden name=req_boardname value="<%=request.getParameter("req_boardname") %>">
		<input type=hidden name=req_examname value="<%=request.getParameter("req_examname") %>">
		<input type=hidden name=req_standardnamegp value="<%=request.getParameter("req_standardnamegp") %>">
		<input type=hidden name=req_sectionname value="<%=request.getParameter("req_sectionname") %>">
		
		<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid") %>">
		<input type=hidden name=req_boardid value="<%=request.getParameter("req_boardid") %>">
		<input type=hidden name=req_examnameid value="<%=request.getParameter("req_examnameid") %>">
		<input type=hidden name=req_standardpubid value="<%=request.getParameter("req_standardpubid") %>">
		<input type=hidden name=req_sectionpubid value="<%=request.getParameter("req_sectionpubid") %>">
				
     <tbody>
	<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%">Academic Year</td><td class=tablelight  width="25%"><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold  width="10%">Board </td><td class=tablelight  width="40%"><%=request.getParameter("req_boardname") %></td>
	</tr>
	<tr>
		<td class=tablebold width="15%">Standard</td><td class=tablelight  width="35%"><%=request.getParameter("req_standardnamegp") %></td>
		<td class=tablebold  width="15%">Section</td><td class=tablelight  width="35%"><%=request.getParameter("req_sectionname") %></td>
	</tr>
	
	<tr>
		<td class=tablebold  width="20%">Student Name</td><td class=tablelight  width="30%"><%=request.getParameter("req_studentname") %></td>
		<td class=tablebold width="15%">Roll No</td><td class=tablelight  width="35%"><%=request.getParameter("req_studentrollno") %></td>
		
	</tr>

	<tr>
		<td class=tablebold width="15%">Exam Name</td><td class=tablelight  width="35%"><%=request.getParameter("req_examname") %></td>
	</tr>
	</table>
	</td><td></td></tr>     
     
     </tbody>
     </table>
          <br>
	

<table id="rounded-corner" border=0 summary="Examschedule List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="8%">Sl.No</th>
        	<th scope="col" class="rounded" width="20%">Subject Name</th>
        	<th scope="col" class="rounded" width="15%">Subject Code</th>
        	<th scope="col" class="rounded" width="8%">Minimum/Maximum</th>
            <th scope="col" class="rounded" width="5%">Mark</th>
            <th scope="col" class="rounded" width="7%">Result</th>
            <th scope="col" class="rounded" width="35%">Staff Remarks</th>
            <th scope="col" class="rounded-q4" width="10%">Status</th>
                               
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
    	String totalMark="";
    	int maxMark = 0;
    	//out.print("LoadExamScheduleList.size()-->"+LoadExamScheduleList.size());
    	 if(LoadExamScheduleList!=null && LoadExamScheduleList.size()>0)
			{
    		
    		 for (int i = 0, j = 1; i < LoadExamScheduleList.size(); i++) {
    			String passStatus 		= "Pass";
    			String fontColor 		= "";
				HashMap ExamScheduleListMap=(HashMap)LoadExamScheduleList.get(i);
				
				String subjectname 		  	= (String)ExamScheduleListMap.get("subjectname");
				String subjectcode  	= (String)ExamScheduleListMap.get("subjectcode");
				String subjectmark      	= (String)ExamScheduleListMap.get("marktaken");
				
				String maxmark      	= (String)ExamScheduleListMap.get("theoryexternalmax");
				String minmark      	= (String)ExamScheduleListMap.get("theoryexternalmin");
				String staffRemark      = (String)ExamScheduleListMap.get("staffremarks");
				String comboRemark      = (String)ExamScheduleListMap.get("comboremarks");

				totalMark = subjectmark;
				//minMark = Integer.parseInt(minmark);
				if(subjectmark == "A" || subjectmark.equals("A"))
				{	
					totalMark	= "0";
					passStatus = "Fail";
					fontColor  = "red";
				}
				else if(Integer.parseInt(subjectmark)<Integer.parseInt(minmark))
				{
					passStatus = "Fail";
					fontColor  = "red";
				}
				if(staffRemark.equals(""))
					staffRemark = "-";
				
				maxMark+=Integer.parseInt(maxmark);
				total+=Integer.parseInt(totalMark);
			%>
	<tr>
			<td valign=top><%=j++ %></td>
            <td valign=top><%=subjectname %></td>
            <td valign=top><%=subjectcode %></td>
            <td valign=top align=center><%=minmark%>/<%=maxmark%></td>
            <td valign=top><font color=<%=fontColor%>><%=subjectmark %></font></td>
            <td valign=top><font color=<%=fontColor%>><%=passStatus %></font></td>
            <td valign=top><%=staffRemark%></td>
            <td valign=top><%=comboRemark%></td>
            
            
                       
        </tr>
        
				<%
    		 }
    		 out.println("<tr><td></td><td class='tablebold' >Total </td><td></td><td  class='tablebold' align=center>"+maxMark+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td class='tablebold' >"+total+"</td><td></td><td></td><td></td></tr>");
			}
    	 
         
         
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");    	 
    	 	}
    	    
     }catch(Exception e){e.printStackTrace();}
          
     %>			
			   	
           

	</tbody>
</table>

      <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<input type=hidden name=req_examnameid value="<%=request.getParameter("req_examnameid") %>">

</form>

	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>