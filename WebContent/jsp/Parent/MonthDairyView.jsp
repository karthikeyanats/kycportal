<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.diary.entrytitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

	function callDairyView(obj){
	
		document.workallotment.dairyid.value 	= obj.getAttribute("dairyid");
		document.workallotment.action			= "MonthDairyProcess.jsp";
		document.workallotment.submit();
	
	}
	
	function goBack(){
	
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

    <h2><%=bundle.getString("label.diary.parentroot3")%></h2>
    
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>
	
	<%
	
		String sectionid		= (String)session.getValue("sectionscheduleid");
		String studentid		= (String)session.getValue("studentid");
		Dairy	dairy			= new Dairy();
		HashMap	hashmap			= null;
		String dayname			= request.getParameter("dayname");
		String date				= request.getParameter("dairydate");
		String cdate			= request.getParameter("cdairydate");
		String index			= request.getParameter("index");
		
		ArrayList diaryList		= dairy.loadDairyStudentSubjectDay(sectionid,studentid,cdate);
		
	%>    
    
    
	<form name='workallotment' method='post'>
				
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.StudentDetails")%></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    
		    <tr>	
		    	<td colspan='2'>					
					<table border=0 width=100%>	
						<%
							out.print("<tr ><td width='17%' align='left' class='tablebold'>Student Name</td><td width='1%' class='tablebold'>:</td><td align='left'>"+session.getValue("studentname")+"</td></tr>");
							out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.AcademicYear")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("sessionname")+"</td></tr>");
							if(session.getValue("groupname") == null)
								out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.StandardName")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("standardname")+"</td></tr>");
							else
								out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.StandardName")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
							out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.SectionName")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("sectionname")+"</td></tr>");
							out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.BoardName")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("boardname")+"</td></tr>");
							out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.MediumName")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("mediumname")+"</td></tr>");
							out.print("<tr><td class='tablebold' align='left'>"+bundle.getString("label.diary.RollNo.")+"</td><td class='tablebold'>:</td><td align='left'>"+session.getValue("rollno") + "</td></tr>");

							
						%>	
					</table>
				</td>
		    </tr>
		</table>	
		<br>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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

		<br>
		
		<table border='1' width="100%" cellspacing='0' cellpadding='5'>
	    	<tr class='tableheading'>
	        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.diary.SubjectName")%> - Code <br> [ <%=bundle.getString("label.diary.StaffName")%> ] </th>
	            <th scope="col" class="rounded" width="46%"><%=bundle.getString("label.diary.DiaryName")%></th>
	            <th scope="col" class="rounded" width="12%"><%=bundle.getString("label.diary.EndDate")%></th>
	            <th scope="col" class="rounded-q4" width="17%"><%=bundle.getString("label.diary.StaffRemarkedOn")%></th>
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
		    		out.print("<tr><td align='center' colspan='4'><a class='nodata'>Data Not Found</td></tr>");
		    %>
		    
		</table>	
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='dairyid' 	value=''>
		<input type='hidden' name='dairydate' 	value='<%=date%>'>
		<input type='hidden' name='cdairydate' 	value='<%=cdate%>'>
		<input type='hidden' name='dayname' 	value='<%=dayname%>'>
		<input type='hidden' name='index' 		value='<%=index%>'>	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>