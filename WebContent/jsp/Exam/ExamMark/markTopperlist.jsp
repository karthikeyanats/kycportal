<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exam.topperlisttitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	

	function changeSession(){
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select")){
			document.Topper_Form.boardname.selectedIndex 	= 0;
			document.Topper_Form.examname.selectedIndex 	= 0;
			document.Topper_Form.course.selectedIndex 		= 0;
			document.Topper_Form.submit();
		}	
	}	
	
	function loadExam(){
		
		if(document.Topper_Form.req_usercategory.value=="NA"){
			if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select")){
				document.Topper_Form.examname.selectedIndex 	= 0;
				document.Topper_Form.course.selectedIndex 		= 0;
				document.Topper_Form.submit();
			}
		}
		else{
			if(check_ForParticularElements(document.Topper_Form.boardname,"select")){
				document.Topper_Form.examname.selectedIndex 	= 0;
				document.Topper_Form.course.selectedIndex 		= 0;
				document.Topper_Form.submit();		
			}
		}	
	}

	function loadStandard()
	{
		if(document.Topper_Form.req_usercategory.value=="NA"){
			if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
				document.Topper_Form.course.selectedIndex 	= 0;
				document.Topper_Form.submit();
			}
		}
		else{
			if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
				document.Topper_Form.course.selectedIndex 	= 0;
				document.Topper_Form.submit();
			}		
		}	
	}
	
	function publishStandard()
	{
		if(document.Topper_Form.req_usercategory.value=="NA"){
			if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
				document.Topper_Form.submit();
			}
		}
		else{
			if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
				document.Topper_Form.submit();
			}		
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

    <h2>
  
    <% 
   /* String [] arry=session.getValueNames();
    for(int i=0;i<arry.length;i++)
    {
    out.println(arry[i]+"<br>"+session.getValue(arry[i]));
    }*/
    if(usercategory.equals("HM"))
    {%><%=bundle.getString("label.exammark.Rootpath")%><%}else{ %>
    <%=bundle.getString("label.exammark.Rootpath_admin")%><%} %> </h2>
		<form name="Topper_Form" action="" method="post">
		    <table id="rounded-corner" border=0 width="100%">
		    	<thead>
  				<tr>
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.exammark.topperlist")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th> 
        </tr>
    </thead>
    
    
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime,com.iGrandee.GradeSetting.GradeScaleQuery"%>

<%
//out.print("USER-->"+session.getValue("usercategory"));
		String instituteid				= (String)session.getValue("instituteid");
		ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
		GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();
		ArrayList BoardList				= null;
		ArrayList academicList 			= examQuery.loadAcademicYearMarkPublished(instituteid);
		HashMap	hashmap					= null;
		ArrayList ExamList				= null;
		ArrayList standardList			= null;
		String reg_sessionid 			= null;

		String reg_boardid 				= request.getParameter("boardname");
		String reg_examid 				= request.getParameter("examname");
		String standardid 				= request.getParameter("course");
		String students					= request.getParameter("students");
		ArrayList studentList			= null;
		String studentcount				= "0";
		

		if(session.getValue("usercategory").equals("NA")){
			 reg_sessionid 			= request.getParameter("sessionname");
				if(request.getParameter("sessionname") != null ){
					BoardList				= examQuery.loadBoardListMarkPublished(instituteid,reg_sessionid);		
				}
				
				if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  )
					ExamList			= examQuery.loadExamNameMarkPublished(reg_sessionid,reg_boardid);

				if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null)
					standardList 		= examQuery.listStandardMarkPublished(reg_sessionid,reg_boardid,reg_examid);
				
				if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null){
					studentList			= examQuery.standardTopperWeekerList(standardid,reg_examid,"desc",students);
					//studentcount		= examQuery.studentsCount(standardid);
					studentcount		= examQuery.studentsCount(standardid,reg_examid);
				}
		}
			else{
				reg_sessionid 			= (String)session.getValue("sessionid");	
				//if(request.getParameter("sessionname") != null )
				{
					BoardList				= examQuery.loadBoardListMarkPublished(instituteid,reg_sessionid);		
				}
				
				if(request.getParameter("boardname") != null  )
					ExamList			= examQuery.loadExamNameMarkPublished(reg_sessionid,reg_boardid);

				if(request.getParameter("boardname") != null  && request.getParameter("examname") != null)
					standardList 		= examQuery.listStandardMarkPublished(reg_sessionid,reg_boardid,reg_examid);
				
				if(request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null){
					studentList			= examQuery.standardTopperWeekerList(standardid,reg_examid,"desc",students);
					//studentcount		= examQuery.studentsCount(standardid);
					studentcount		= examQuery.studentsCount(standardid,reg_examid);
				}
			}		


			
%>
	
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'><%=bundle.getString("label.exam.AcademicYear")%>
				<%if(session.getValue("usercategory").equals("NA")){%>
				<font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=sessionname class=tablelight onchange='changeSession()'>
						<option value="00">-Select Academic-</option>
						<%
							if(academicList != null && academicList.size()>0)
							for(int s=0;s<academicList.size();s++)
							{
								hashmap		= (HashMap)academicList.get(s);
								if(reg_sessionid != null && reg_sessionid.equals((String)hashmap.get("sessionid")))
									out.println("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								
							}
						%>
					</select>
					<%}
					else{%>
					<td class=tablebold width="2%">:</td>
					<td><%=session.getValue("sessionname") %>
					
					<%}%>
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.exam.Board")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=boardname class=tablelight onchange=loadExam() validate=Board>
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
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard()  validate='Exam Name'>
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
				<td class=tablebold width="2%">:</td>
				<td><select name=course class=tablelight  validate=Standard>
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
				<td class=tablebold><%=bundle.getString("label.exam.Top")%></td>
				<td class=tablebold width="2%">:</td>
				<td colspan='3'>
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
	        	<td class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot>
	<br>
	
		<a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exammark.loadstudents")%></strong><span class="bt_blue_r"></span></a>
		

		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examlist.SL.No")%></th>
					            <th scope="col" class="rounded" 		width="30%"><%=bundle.getString("label.exammark.StudentName")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exammark.RollNo")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exammark.Total")%></th>
					            <th scope="col" class="rounded-q4" 		width="15%"><%=bundle.getString("label.exammark.position")%></th>
					            <%--<th scope="col" class="rounded-q4" 		width="15%"><%=bundle.getString("label.exammark.Grade")%></th> --%>
					            


					        </tr>
					    </thead>
					    
					    <%
					    	String grade	= "";
					    	int mark		= 0;
					    	int markt		= 0;
					    	String total	= "";
					    	int position	= 0;
					    	
					    	
					    	if(studentList != null && studentList.size()>0){
					    		for(int y=0;y<studentList.size();y++){
					    			
					    			hashmap		= (HashMap)studentList.get(y);
					    			total		= (String)hashmap.get("totalmark");
					    			//grade		= examQuery.getGradeSystem(reg_sessionid,total);
					    			grade		= gradescaleQuery.getGradeScaleSystem(standardid,total);
					    			
					    			if(total == null || total.equals("") || total.equalsIgnoreCase("null"))
					    				total = "0";
					    			
					    			mark		= Integer.parseInt(total);
					    			
					    			if(mark != markt){
					    				position++;
					    				markt	= mark;
					    			}
					    			
									if(students != null && Integer.parseInt(students) < position)
										break;

					    			
					    			if(grade == null || grade.equals("-")  || grade.equals("") || grade.equalsIgnoreCase("null"))
					    				grade = "No Grade";
					    			
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
	<input type=hidden name=req_usercategory value="<%=session.getValue("usercategory")%>">

</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>