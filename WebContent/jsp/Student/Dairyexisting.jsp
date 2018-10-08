<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

	function callDairyView(obj){
	
		document.workallotment.dairyid.value 	= obj.getAttribute("dairyid");
		document.workallotment.action			= "DairyProcess.jsp";
		document.workallotment.submit();
	
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

    <h2>Activities / Diary / Existing Diary Details</h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>
<%
	String sectionid		= (String)session.getValue("sectionscheduleid");
	String studentid		= (String)session.getValue("studentid");
	Dairy	dairy			= new Dairy();
	HashMap	hashmap			= null;
	ArrayList diaryList		= dairy.loadDairyStudentExisting(sectionid,studentid);
	
%>    

	<form name='workallotment' method='post'>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
		            <th scope="col" class="rounded" width="30%">Diary Name</th>
		            <th scope="col" class="rounded" width="15%">Diary Status</th>
		            <th scope="col" class="rounded" width="30%">Subject Name</th>
		            <th scope="col" class="rounded-q4" width="15%">Creation Date</th>
		        </tr>
		    </thead>
		    <%
				
		    	if(diaryList != null && diaryList.size()>0){
					
					for(int y=0;y<diaryList.size();y++){
						hashmap				= (HashMap)diaryList.get(y);
						out.print("<tr valign='top'><td>"+(y+1)+"</td><td><a href='#' dairyid='"+hashmap.get("studentdiaryid")+"' onclick='callDairyView(this)'>"+hashmap.get("subject")+"</a></td><td>"+hashmap.get("status")+"</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("creationdate")+"</td></tr>");
					}
		    	}
		    	else{
		    		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
		    		//out.print("<tr><td colspan='6' align='center'>Data Not Found</td></tr>");
		    	}
		 	%>
		 </table>
		
		<input type='hidden' name='dairyid' value=''>
		<input type='hidden' name='status'  value='existing'>
	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>