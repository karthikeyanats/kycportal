<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - My Diary | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	function callDairyView(obj){
	
		document.workallotment.dairyid.value 	= obj.getAttribute("dairyid");
		document.workallotment.action			= "DairyProcess.jsp";
		document.workallotment.submit();
	
	}
	
	function callPrevious(){
	
		document.workallotment.action	= "DiaryMonth.jsp";
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

    <h2><%=bundle.getString("label.diary.studentroot")%></h2>
    
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>

	<%
	
		String sectionid		= (String)session.getValue("sectionscheduleid");
		String studentid		= (String)session.getValue("studentid");
		Dairy	dairy			= new Dairy();
		HashMap	hashmap			= null;
		ArrayList diaryList		= dairy.loadDairyStudentSubject(sectionid,studentid);
		
		String dayname			= null;
		String date				= null;
		ArrayList dayDetails	= dairy.toDayDetails();
		
		if(dayDetails != null && dayDetails.size()>0){
			hashmap				= (HashMap)dayDetails.get(0);
			dayname				= (String)hashmap.get("dayname");
			date				= (String)hashmap.get("date");
		}
		
	%>    

	<form name='workallotment' method='post'>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.diary.dateandday")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>
					<table  border=0 bordercolor='blue' align="center" width="100%" >
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diary.date")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=date%>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diary.day")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=dayname%>
							</td>
						</tr>	
					</table>
		    	</td>
		    </tr>
		</table>	

		<a href="#" class="bt_blue" onclick='callPrevious()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.diary.monthwisediary")%></strong><span class="bt_blue_r"></span></a>

		<br>
		
		
		<table border='1' width="100%" cellspacing='0' cellpadding='5'>
	    	<tr class='tableheading'>
	        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.diary.SubjectName")%> - Code <br> [ <%=bundle.getString("label.diary.StaffName")%> ] </th>
	            <th scope="col" class="rounded" width="46%"><%=bundle.getString("label.diary.DairyName")%></th>
	            <th scope="col" class="rounded" width="12%"><%=bundle.getString("label.diary.EndDate")%></th>
	            <th scope="col" class="rounded-q4" width="17%"><%=bundle.getString("label.diary.StaffRemarks")%></th>
	        </tr>
		    
		    <%
		    
				String userid		= "";
				String userid1		= "";
				String subjectid	= "";
				String subjectid1	= "";
			
		    	if(diaryList != null && diaryList.size()>0){
					
					for(int y=0;y<diaryList.size();y++){
						hashmap		= (HashMap)diaryList.get(y);
						subjectid	= (String)hashmap.get("subjectscheduleid");
						userid		= (String)hashmap.get("userid");
						
						
						if((userid1.equals("") && subjectid1.equals("")) || !userid.equals(userid1) || !subjectid.equals(subjectid1)){
							
							%>
							    <tr><td rowspan='<%=hashmap.get("diarycount")%>' class='tablebold' valign='top'><%=hashmap.get("subjectname")%><br>[ <%=hashmap.get("staffname")%> ]</td>					
							<%
							
							subjectid1	= subjectid;
							userid1		= userid;
							
						}
						
						%>
						
						
						<%
						
						out.print("<td><a href='#' dairyid='"+hashmap.get("studentdiaryid")+"' onclick='callDairyView(this)'>"+hashmap.get("subject")+"</td><td>"+hashmap.get("dairysubmissiondate")+"</td><td>"+hashmap.get("remarkdate")+"</td></tr>");
					}
		    	}
		    	else
		    		out.print("<tr><td align='center' colspan='4'><a class='nodata'>"+bundle.getString("label.diary.datanotfound")+"</td></tr>");
		    %>
		    
		</table>	
		
		<input type='hidden' name='dairyid' value=''>
		
	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>