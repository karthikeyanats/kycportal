<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exam.topperlisttitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	

	function changeSession(){
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select")){
			document.Topper_Form.boardname.selectedIndex 	= 0;
			document.Topper_Form.examname.selectedIndex 	= 0;
			document.Topper_Form.course.selectedIndex 		= 0;
			document.Topper_Form.subject.selectedIndex 		= 0;
			document.Topper_Form.submit();
		}	
	}	
	
	function loadExam(){

		//if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select")){
		if(check_ForParticularElements(document.Topper_Form.boardname,"select")){
			document.Topper_Form.examname.selectedIndex 	= 0;
			document.Topper_Form.course.selectedIndex 		= 0;
			document.Topper_Form.subject.selectedIndex 		= 0;
			document.Topper_Form.submit();
		}	
	}

	function loadStandard()
	{
		//if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
		if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
			document.Topper_Form.course.selectedIndex 		= 0;
			document.Topper_Form.subject.selectedIndex 		= 0;
			document.Topper_Form.submit();
		}	
	}
	
	function changeStandard(){
	
		//if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
		if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
			document.Topper_Form.subject.selectedIndex 		= 0;
			document.Topper_Form.submit();
		}	
	}
	
	function publishStandard()
	{
		//if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select",document.Topper_Form.subject,"select")){
		if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select",document.Topper_Form.subject,"select")){
			document.Topper_Form.submit();
		}	
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

    <h2><%=bundle.getString("label.exam.topperlistrootpath")%> </h2>
		<form name="Topper_Form" action="" method="post">
	 
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		            	<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.exam.SubjectwiseToppersList")%></th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
       
		<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
		<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
		
		<%
				String instituteid				= (String)session.getValue("instituteid");
				ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
				ArrayList BoardList				= null;
				//ArrayList academicList 			= examQuery.loadAcademicYearMarkPublished(instituteid);
				HashMap	hashmap					= null;
				ArrayList ExamList				= null;
				ArrayList standardList			= null;
				//String reg_sessionid 			= request.getParameter("sessionname");
				String reg_sessionid 			= (String)session.getValue("sessionid");
				String reg_boardid 				= request.getParameter("boardname");
				String reg_examid 				= request.getParameter("examname");
				String standardid 				= request.getParameter("course");
				String subjectid 				= request.getParameter("subject");
				String students					= request.getParameter("students");
				ArrayList studentList			= null;
				ArrayList subjecttList			= null;
				String studentcount				= "0";
				
				
				//if(request.getParameter("sessionname") != null )
				{
					BoardList				= examQuery.loadBoardListMarkPublished(instituteid,reg_sessionid);
				}
				//if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  )
				if(request.getParameter("boardname") != null  )	
					ExamList			= examQuery.loadExamNameMarkPublished(reg_sessionid,reg_boardid);
		
				//if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null)
				if(request.getParameter("boardname") != null  && request.getParameter("examname") != null)	
					standardList 		= examQuery.listStandardMarkPublished(reg_sessionid,reg_boardid,reg_examid);
				
				//if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null && request.getParameter("subject") != null){
				if(request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null && request.getParameter("subject") != null){	
					studentList			= examQuery.subjectTopperWeekerList(standardid,reg_examid,"desc",students,subjectid);
					//studentcount		= examQuery.studentsCount(standardid);
					studentcount		= examQuery.studentsCount(standardid,reg_examid);
				}
				
				//if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)
				if(request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)	
					subjecttList			= examQuery.subjectsScheduled(standardid);
		%>
			
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'><%=bundle.getString("label.exam.AcademicYear")%></td>
				<td width=1px class=tablebold>:</td><td>
				<%=session.getValue("sessionname") %>	
					<!--  <select name=sessionname class=tablelight onchange='changeSession()'>
						<option value="00">-Select Academic-</option>
						<%
							//if(academicList != null && academicList.size()>0)
							//for(int s=0;s<academicList.size();s++)
							//{
								//hashmap		= (HashMap)academicList.get(s);
								//if(reg_sessionid != null && reg_sessionid.equals((String)hashmap.get("sessionid")))
									//out.println("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								//else
									//out.println("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								
							//}
						%>
					</select>-->
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.exam.Board")%> <font color="red">*</font></td>
				<td width=1px class=tablebold>:</td><td>
					<select name=boardname class=tablelight validate='Board' onchange=loadExam()>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
		  		 			for (int i = 0;i < BoardList.size(); i++) 
		  		 			{
		  		 				hashmap				=(HashMap)BoardList.get(i);
								if(reg_boardid != null && reg_boardid.equals((String)hashmap.get("boardid")))
									out.println("<option selected value='"+hashmap.get("boardid")+"' class=tablelight >"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("boardid")+"' class=tablelight >"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
					  		 }
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.exam.ExamName")%> <font color="red">*</font></td>
				<td width=1px class=tablebold>:</td><td>
					<select name=examname class=tablelight validate='Exam Name'  onchange=loadStandard() >
						<option value="00">-Select Exam Name-</option>
						<%
							
					      	if(ExamList!=null && ExamList.size()>0)
		  		 			for (int i = 0; i < ExamList.size(); i++) 
		  		 			{
		  		 				hashmap				=(HashMap)ExamList.get(i);
								if(reg_examid != null && reg_examid.equals((String)hashmap.get("examnameid")))
									out.println("<option selected value='"+hashmap.get("examnameid")+"' class=tablelight >"+hashmap.get("examname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("examnameid")+"' class=tablelight >"+hashmap.get("examname")+"</option>");
					  		 }

						%>
					</select>
				</td>
		
				<td class=tablebold><%=bundle.getString("label.exam.Standard")%> <font color="red">*</font></td>
				<td width=1px class=tablebold>:</td><td><select name=course class=tablelight  validate=Standard onchange='changeStandard()' >
					<option value="00">-Select Standard-</option>
					<%
						if(standardList !=null && standardList.size() >0)
						for(int s1=0;s1<standardList.size();s1++)
						{
							hashmap			=(HashMap)standardList.get(s1);
							if(standardid != null && standardid.equals((String)hashmap.get("standardscheduleid")))
								out.print("<option selected value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+hashmap.get("standardname")+"</option>");
							else
								out.print("<option value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+hashmap.get("standardname")+"</option>");
						}
					%>
					</select>
				</td>
			</tr>
			<tr >
				<td class=tablebold><%=bundle.getString("label.exam.Subject")%> <font color="red">*</font></td>
				<td width=1px class=tablebold>:</td><td><select name=subject class=tablelight  validate=Subject >
					<option value="00">-Select Subject-</option>
					<%
						if(subjecttList !=null && subjecttList.size() >0)
							for(int s1=0;s1<subjecttList.size();s1++)
							{
								hashmap			=(HashMap)subjecttList.get(s1);
								if(subjectid != null && subjectid.equals((String)hashmap.get("subjectscheduleid")))
									out.println("<option selected value='"+hashmap.get("subjectscheduleid")+"' class=tablelight >"+hashmap.get("subjectname")+"</option>");
								
								else
									out.println("<option value='"+hashmap.get("subjectscheduleid")+"' class=tablelight >"+hashmap.get("subjectname")+"</option>");
							}
					%>
					</select>
				</td>
			
				<td class=tablebold><%=bundle.getString("label.exam.Top")%></td>
				<td width=1px class=tablebold>:</td><td>
					<select name=students class=tablelight >
					<%
						if(students != null && students.equals("1"))
							out.print("<option selected value='1'>1</option>");
						else
							out.print("<option value='1'>1</option>");


						if(students != null && students.equals("3"))
							out.print("<option selected value='3'>3</option>");
						else
							out.print("<option value='3'>3</option>");

						if(students != null && students.equals("5"))
							out.print("<option selected value='5'>5</option>");
						else
							out.print("<option value='5'>5</option>");
						
						if(students != null && students.equals("10"))
							out.print("<option selected value='10'>10</option>");
						else
							out.print("<option value='10'>10</option>");

						if(students != null && students.equals("15"))
							out.print("<option selected value='15'>15</option>");
						else
							out.print("<option value='15'>15</option>");
					%>
					</select>
					<a class='tablebold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Students</a>
				</td>
			</tr>			
		</table>
 		<tfoot>
	    	<tr>
	        	<td colspan="2" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot>
	<br>
	
		<a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exam.LoadStudents")%></strong><span class="bt_blue_r"></span></a>
		

		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>	
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examlist.SL.No")%></th>
					            <th scope="col" class="rounded" 		width="45%"><%=bundle.getString("label.exammark.StudentName")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exammark.RollNo")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.Mark")%></th>
					            <th scope="col" class="rounded-q4" 		width="15%"><%=bundle.getString("label.exammark.position")%></th>
					        </tr>
					    </thead>
					    <%
					    	int mark		= 0;
					    	int markt		= 0;
					    	String total	= "";
					    	int position	= 0;
					    
					    
					    
					    	if(studentList != null && studentList.size()>0){
					    		for(int y=0;y<studentList.size();y++){
					    			hashmap		= (HashMap)studentList.get(y);
					    			
					    			total		= (String)hashmap.get("totalmark");
					    			
					    			if(total == null || total.equals("") || total.equalsIgnoreCase("null"))
					    				total = "0";
					    			
					    			mark		= Integer.parseInt(total);
					    			
					    			if(mark != markt){
					    				position++;
					    				markt	= mark;
					    			}
					    			
									if(students != null && Integer.parseInt(students) < position)
										break;
  
									out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("studentname")+"</td><td>"+hashmap.get("rollno")+"</td>");
					    			
					    			
					    			
					    			if(hashmap.get("totalmark") == null)
					    				out.print("<td>Not Given</td><td>"+position+" / "+studentcount+"</td></tr>");
					    			else
						    			out.print("<td>"+hashmap.get("totalmark")+"</td><td>"+position+" / "+studentcount+"</td></tr>");
					    		

					    		}
					    	}
					    	else
					    		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					    		
					    %>
					</table>
				</td>
			</tr>
		</table>
	</table>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>