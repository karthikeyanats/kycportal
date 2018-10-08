<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Topper List | Powered by i-Grandee</title>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>        

<script type="text/javascript">
	

	function changeSession(){
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select")){
		}	
	}	
	
	function loadExam(){

		if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select")){
			document.Topper_Form.submit();
		}	
	}

	function loadStandard()
	{
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
			document.Topper_Form.submit();
		}	
	}
	
	function changeStandard(){
	
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
			document.Topper_Form.submit();
		}	
	}
	
	function publishStandard()
	{
		/*if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select",document.Topper_Form.subject,"select")){
			document.Topper_Form.submit();
		}	*/
		
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select",document.Topper_Form.subject,"select"))
		{
		
		
		document.Topper_Form.req_sessionname.value=document.Topper_Form.sessionname.options[document.Topper_Form.sessionname.options.selectedIndex].text;
		document.Topper_Form.req_sessionvalue.value=document.Topper_Form.sessionname.options[document.Topper_Form.sessionname.options.selectedIndex].value;
		document.Topper_Form.req_boardname.value=document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].text;
		document.Topper_Form.req_boardvalue.value=document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].value;
		document.Topper_Form.req_examname.value=document.Topper_Form.examname.options[document.Topper_Form.examname.options.selectedIndex].text;
		document.Topper_Form.req_examvalue.value=document.Topper_Form.examname.options[document.Topper_Form.examname.options.selectedIndex].value;
		document.Topper_Form.req_coursename.value=document.Topper_Form.course.options[document.Topper_Form.course.options.selectedIndex].text;
		document.Topper_Form.req_coursevalue.value=document.Topper_Form.course.options[document.Topper_Form.course.options.selectedIndex].value;
		//document.Topper_Form.req_subjectname.value=document.Topper_Form.subject.options[document.Topper_Form.subject.options.selectedIndex].text;
		//document.Topper_Form.req_subjectvalue.value=document.Topper_Form.subject.options[document.Topper_Form.subject.options.selectedIndex].value;
		document.Topper_Form.req_students.value=document.Topper_Form.students.options[document.Topper_Form.students.options.selectedIndex].value;
		//alert(document.Topper_Form.subject.options[document.Topper_Form.subject.options.selectedIndex].text);
		
		document.Topper_Form.action="MultisubjectWeakerlists.jsp";
	    document.Topper_Form.submit();
	
	}
	}
	function goBack()
	{
	document.Topper_Form.action="subjectmarktopperlist.jsp";
	document.Topper_Form.submit();
	
	}
	function newclick(obj)
	{
	document.Topper_Form.action="SingleStudentMarks.jsp";
	document.Topper_Form.submit();
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

    <h2>Exam / Exam MarkList / Subjectwise Weaker List </h2>
		<form name="Topper_Form" action="" method="post">
		
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10"></th>
		            	<th scope="col" class="rounded" width="100%">Subjectwise Weaker List</th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%

		String instituteid				= (String)session.getValue("instituteid");
		ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
		ArrayList BoardList				= examQuery.LoadBoardList(instituteid);
		ArrayList academicList 			= examQuery.loadAcademicYear(instituteid);
		HashMap	hashmap					= null;
		ArrayList ExamList				= null;
		ArrayList standardList			= null;
		String reg_sessionid 			= request.getParameter("sessionname");
		String reg_boardid 				= request.getParameter("boardname");
		String reg_examid 				= request.getParameter("examname");
		String standardid 				= request.getParameter("course");
		//String subjectid 				= request.getParameter("subject")+"";
		String[] subjectidnew 				= request.getParameterValues("subject");
		String[] subjectidnew1 				= request.getParameterValues("subject");

		String subjectid_temp="";
		int colspancount=0;

		if(subjectidnew!=null) 
		{
			for(int i=0;i<subjectidnew.length;i++)
			{
				subjectid_temp +=subjectidnew[i];
				if(i!=(subjectidnew.length)-1)
				{
					subjectid_temp +="','";
				}
			
			} 
		}



		String students					= request.getParameter("students");
		ArrayList studentList			= null;
		ArrayList subjecttList			= null;

		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  )
			ExamList			= examQuery.LoadAllotedExamnameList(reg_sessionid);

		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null)
			standardList 		= examQuery.listStandard(reg_sessionid,reg_boardid);
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null && request.getParameter("subject") != null)
			studentList			= examQuery.subjectTopperWeekerListMultisubject(standardid,reg_examid,"desc",students,subjectid_temp);
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)
			subjecttList			= examQuery.subjectsScheduled(standardid);
	//	out.println(studentList);
%>
			<%
	int count=0;
	boolean flag 	= false;
	ArrayList tempList	= new ArrayList();
	HashMap subname =new HashMap();	
	HashMap subname_ID =new HashMap();

	String examallocationid="0";
	String markpublishstatus="P";
	StringBuffer head=new StringBuffer();
	StringBuffer head1=new StringBuffer();
	String subjectscheduleID="";
	try
	{
	if(studentList.size()!=0)
	{
		for(int i=0,s=1;i<studentList.size();i++)
		{
			HashMap map=(HashMap)studentList.get(i);
			String subjectname=map.get("subjectname")+"";
			String subjectscheduleid=map.get("subjectscheduleid")+"";

			examallocationid=map.get("examallotmentid")+"";
			 String markpublishsta=map.get("markpublishstatus")+"";
				if(markpublishsta.equalsIgnoreCase("P"))   
				{
					markpublishstatus="yes";
				}
				
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				subjectscheduleID=subjectscheduleid.trim();

				head.append("<th>S"+s+"</th>");
				head1.append("<th>T"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				subname_ID.put("S"+s,subjectscheduleID);
				tempList.add(subjectname);
				s++;
			}
		}
		for(int i=0,s=1;i<studentList.size();i++)
		{
			HashMap map=(HashMap)studentList.get(i);
			String subjectname=map.get("subjectname")+"";
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				head.append("<th>S"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				tempList.add(subjectname);
				s++;
			}
		}
	}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	%>	
		
	<input type="hidden" name="req_sessionname" value="">
	<input type="hidden" name="req_sessionvalue" value="">
	<input type="hidden" name="req_boardname" value="">
	<input type="hidden" name="req_boardvalue" value="">
	<input type="hidden" name="req_examname" value="">
	<input type="hidden" name="req_examvalue" value="">
	<input type="hidden" name="req_coursename" value="">
	<input type="hidden" name="req_coursevalue" value="">
	<input type="hidden" name="req_subjectname" value="">
	<input type="hidden" name="req_subjectvalue" value="">
	<input type="hidden" name="req_students" value="">  
	
		
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'>Academic Year<font color="red">*</font></td>
				<td>
					<select name=sessionname validate="Academic Year" class=tablelight onchange='changeSession()'>
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
				</td>
			

				<td class=tablebold width='10%'>Board <font color="red">*</font></td>
				<td>
					<select name=boardname validate="Board " class=tablelight onchange=loadExam()>
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
				<td class=tablebold>Exam <font color="red">*</font></td>
				<td>
					<select name=examname validate="Exam "class=tablelight onchange=loadStandard() >
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
		
				<td class=tablebold>Standard <font color="red">*</font></td>
				<td><select name=course validate="Standard " class=tablelight onchange='changeStandard()' >
					<option value="00">-Select Standard-</option>
					<%
						if(standardList !=null && standardList.size() >0)
							for(int s1=0;s1<standardList.size();s1++)
							{
								hashmap			=(HashMap)standardList.get(s1);
								String standardname=(String)hashmap.get("standardname");
								String groupname=(String)hashmap.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								if(standardid != null && standardid.equals((String)hashmap.get("standardscheduleid")))
									out.println("<option selected value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+standardname+"</option>");
								
								else
									out.println("<option value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+standardname+"</option>");
							}
					%>
					</select>
				</td>
			</tr>
			<tr >
				<td class=tablebold>Subject <font color="red">*</font></td>
				<td><select name=subject validate="Subject " class=tablelight multiple>
					<option value="00">-Select Subject-</option>
					<%
						if(subjecttList !=null && subjecttList.size() >0)
							for(int s1=0;s1<subjecttList.size();s1++)
							{
								hashmap			=(HashMap)subjecttList.get(s1);
								//if(subjectid != null && subjectid.equals((String)hashmap.get("subjectscheduleid")))
									//out.println("<option selected value='"+hashmap.get("subjectscheduleid")+"' class=tablelight >"+hashmap.get("subjectname")+"</option>");
								
								//else
									out.println("<option value='"+hashmap.get("subjectscheduleid")+"' class=tablelight >"+hashmap.get("subjectname")+"</option>");
							}
					%>
					</select>
				</td>
				<td class=tablebold>Top</td>
				<td>
					<select name=students validate="Students " class=tablelight >
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
				<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back </strong><span class="bt_blue_r"></span></a>
	
				<a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong>Load Students</strong><span class="bt_blue_r"></span></a>

		
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