<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Online Exam | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	var winPop 		= null;
	function loadExam(obj)
	{
    	if(winPop && !winPop.closed)
  		{
			alert("Already Online Exam window was opened");
			winPop.focus();
		}
		else
		{
			winPop = window.open("<%=request.getContextPath()%>/OnlineExamServlet?action=examInstructions&qsid="+obj.getAttribute("qsid"),"",'fullscreen=yes,toolbar=no,titlebar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=0,left=0,top=0');
			winPop.focus();
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



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.exam.onlineexam")%></h2>
    
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.OnlineExam"%>

	<%
	
		String sectionid	= (String)session.getValue("sectionscheduleid");
		String standardid	= (String)session.getValue("standardscheduleid");
		String studentid	= (String)session.getValue("studentid");
		OnlineExam exam		= new OnlineExam();
		HashMap	hashmap		= null;
		ArrayList examlist	= exam.onlineExamToday(standardid);

		
	%>    

	<form name='workallotment' method='post'>
	
		<table border='1' width="100%" cellspacing='0' cellpadding='5'>
	    	<tr class='tableheading'>
	        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.department.slno")%></th>
	            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.examdetails.examname")%></th>
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examdetails.starttime")%></th>
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examdetails.endtime")%></th>
	            <th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.staffprofile.status")%></th>
	        </tr>
		    
		    <%

		    	String status		= "";
		    	String qsid			= "";
		    
		    	if(examlist != null && examlist.size()>0){
					
		    		for(int t=0;t<examlist.size();t++){
		    			hashmap		= (HashMap)examlist.get(t);
		    			status		= (String)hashmap.get("status");
		    			qsid		= (String)hashmap.get("qsid");
		    			
		    			out.print("<tr><td>"+(t+1)+".</td>");
		    			out.print("<td>"+hashmap.get("examname")+"</td>");
		    			out.print("<td>"+hashmap.get("examtimein")+"</td>");
		    			out.print("<td>"+hashmap.get("examtimeout")+"</td>");
		    			if(status != null && status.equals("NotYetStarted")){
		    				out.print("<td>Not Yet Started</td>");
		    			}else if(status != null && status.equals("OnTime")){
		    				int answered	= exam.getTotalAnswered(qsid,studentid);
		    				int totalqn		= exam.getTotalQuestion(qsid);
		    				
		    				if(answered >= totalqn)
				    			out.print("<td>Mark Scored = "+exam.getMarkScored(qsid,studentid)+"/"+exam.getTotalMark(qsid)+"</td>");
		    				else
		    					out.print("<td><a href='#' onclick='loadExam(this)' qsid='"+hashmap.get("qsid")+"'>On Time</a></td>");		    					
		    			
		    			}else{
		    				int answered	= exam.getTotalAnswered(qsid,studentid);
		    				
		    				if(answered == 0)
				    			out.print("<td>Not Attended</td>");
		    				else
				    			out.print("<td>Mark Scored = "+exam.getMarkScored(qsid,studentid)+"/"+exam.getTotalMark(qsid)+"</td>");
		    			}
		    			
		    			out.print("</tr>");

		    		}
		    	}
		    	else
		    		out.print("<tr><td align='center' colspan='5'><a class='nodata'>"+bundle.getString("label.diary.datanotfound")+"</td></tr>");
		    %>
		    
		</table>	

	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>