<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.diary.diaryexistingtitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

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

    <h2><%=bundle.getString("label.diary.entryheading1")%></h2>
    
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
		        	
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.diaryexistingtitle")%>Student Details</th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>					
	
					<%
						out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
						out.print("<tr><td width='17%' class='tablebold'>Student Name</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
						out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
						if(session.getValue("groupname") == null)
							out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
						else
							out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
						out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
						out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
						out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
						out.print("<tr><td class='tablebold'>"+bundle.getString("label.diary.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

						out.print("</table>");
					%>	
				</td>
			</tr>
		</table>	
		<br>	

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.diary.S.No") %></th>
		            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.diary.DiaryName") %></th>
		            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.diary.DiaryStatus") %></th>
		            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.diary.SubjectName") %></th>
		            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.diary.CreationDate") %></th>
		        </tr>
		    </thead>
		    <%
				
		    	if(diaryList != null && diaryList.size()>0){
					
					for(int y=0;y<diaryList.size();y++){
						hashmap				= (HashMap)diaryList.get(y);
						out.print("<tr><td>"+(y+1)+"</td><td><a href='#' dairyid='"+hashmap.get("studentdiaryid")+"' onclick='callDairyView(this)'>"+hashmap.get("subject")+"</a></td><td>"+hashmap.get("status")+"</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("creationdate")+"</td></tr>");
					}
		    	}
		    	else{
		    		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		    		//out.print("<tr><td colspan='5' align='center'>Data Not Found</td></tr>");
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