<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Mark Result | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	

	function changeSession(){
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select")){
		}	
	}	
	
	function loadExam(){

		if(check_ForParticularElements(document.Topper_Form.boardname,"select")){
			document.Topper_Form.req_boardid.value = document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].value;
			document.Topper_Form.submit();
		}	
	}

	function loadStandard()
	{
		if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select")){
			document.Topper_Form.req_boardid.value = document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].value;
			document.Topper_Form.submit();
		}	
	}
	
	function loadSections()
	{
		if(check_ForParticularElements(document.Topper_Form.course,"select",document.Topper_Form.examname,"select")){
			document.Topper_Form.req_boardid.value = document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].value;
			document.Topper_Form.standardschedid.value = document.Topper_Form.course.options[document.Topper_Form.course.options.selectedIndex].value;

			document.Topper_Form.submit();
		}	
	}
	
	
	
	function loadStudents()
	{
		if(check_ForParticularElements(document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
			document.Topper_Form.req_boardid.value = document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].value;
			document.Topper_Form.standardschedid.value = document.Topper_Form.course.options[document.Topper_Form.course.options.selectedIndex].value;
			document.Topper_Form.req_sectionname.value = document.Topper_Form.section.options[document.Topper_Form.section.options.selectedIndex].text;
			
			//document.Topper_Form.section.value = document.Topper_Form.course.options[document.Topper_Form.section.options.selectedIndex].value;
			document.Topper_Form.submit();
		}	
	}
	
	function goBack()
	{
		document.Topper_Form.action = "ReportIndexView.jsp";
		document.Topper_Form.submit();	
	}

	function printfun()
	{
		sectionname = document.Topper_Form.section.options[document.Topper_Form.section.options.selectedIndex].text;
	window.open("PrintPreviewExamMarkResult.jsp?&req_sessionname="+document.Topper_Form.req_sessionname.value+"&req_sessionid="+document.Topper_Form.req_sessionid.value+"&standardschedid="+document.Topper_Form.course.value+"&req_boardid="+document.Topper_Form.req_boardid.value+"&examname="+document.Topper_Form.examname.value+"&req_boardname="+document.Topper_Form.boardname.options[document.Topper_Form.boardname.options.selectedIndex].text+"&req_examname="+document.Topper_Form.examname.options[document.Topper_Form.examname.options.selectedIndex].text+"&req_standardname="+document.Topper_Form.course.options[document.Topper_Form.course.options.selectedIndex].text+"&req_sessionstatus="+document.Topper_Form.req_sessionstatus.value+"&req_sectionname="+sectionname+"&sectionscheduleId="+document.Topper_Form.section.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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

    <h2>Reports / Session wise Report / Result </h2>
		<form name="Topper_Form" action="" method="post">
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="80%">Select Information</th>
		            	<th scope="col" class="rounded-q4" width="20%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>        
		        	</tr>
		    	</thead>
		    	<tfoot>
	    			<tr>
	        			<td class="rounded-foot-left"><em></em></td>
	        			<td class="rounded-foot-right">&nbsp;</td>
	       			</tr>
    			</tfoot>
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime,com.iGrandee.GradeSetting.GradeScaleQuery"%>

<%

		String instituteid				= (String)session.getValue("instituteid");
		ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
		GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();
		ArrayList BoardList				= examQuery.LoadBoardList(instituteid);
		ArrayList academicList 			= examQuery.loadAcademicYear(instituteid);
		HashMap	hashmap					= null;
		HashMap	hashmapMark				= null;
		
		ArrayList ExamList				= null;
		ArrayList standardList			= null;
		ArrayList sectionList			= null;
		String section = null;
		//String reg_sessionid 			= request.getParameter("sessionname");
		String req_sessionid 			= request.getParameter("req_sessionid");
		//String reg_boardid 			= request.getParameter("boardname");
		String req_boardid 				= request.getParameter("req_boardid");
		String reg_examid 				= request.getParameter("examname");
		//String standardid 			= request.getParameter("course");
		String standardschedId			= request.getParameter("standardschedid");
		String sectionschedId			= request.getParameter("section");
		
		
		if(request.getParameter("section") != null)
		 section			= request.getParameter("section");
		
		String students					= request.getParameter("students");
		StringBuffer head = new StringBuffer();
		ArrayList studentList			= new ArrayList();
		ArrayList subjectList			= null;
		HashMap subname =new HashMap();
		int subjectSize = 0;
		
		if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  )
			ExamList			= examQuery.LoadAllotedExamnameList(req_sessionid);

		if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  && request.getParameter("examname") != null)
			standardList 		= examQuery.listStandard(req_sessionid,req_boardid);
		
		if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)
		{	
			//subjectList			= (ArrayList)examQuery.subjectsScheduled(standardschedId);
		
			//studentList			= examQuery.standardTopperWeekerList(standardschedId,reg_examid,"desc","100");
			//studentList			= examQuery.standardMarkListToSMS(standardschedId,reg_examid);
			sectionList			= examQuery.listSections(standardschedId);
			//System.out.println(standardschedId+"----"+reg_examid);
		}
		
		if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  && request.getParameter("examname") != null && request.getParameter("course") != null && request.getParameter("section") != null)
		{	
			subjectList			= (ArrayList)examQuery.subjectExamScheduled(standardschedId);
			studentList			= examQuery.standardMarkListToSMSNew(standardschedId,reg_examid,section);
		}
		
%>
		<tbody>
		<tr>
		<td colspan=2>	
		<table width='100%' >
			<tr>
				<td class=tablebold width='15%'>Academic Year</td>
				<td class=tablebold>:</td>
				<td>
					<%=request.getParameter("req_sessionname") %>
				</td>
			

				<td class=tablebold width='10%'>Board <font color="red">*</font></td>
				<td class=tablebold>:</td>
				<td>
					<select name=boardname class=tablelight onchange=loadExam()>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
		  		 			for (int i = 0;i < BoardList.size(); i++) 
		  		 			{
		  		 				hashmap				=(HashMap)BoardList.get(i);
								if(req_boardid != null && req_boardid.equals((String)hashmap.get("boardid")))
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
				<td class=tablebold>:</td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard() >
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
		
				<td class=tablebold width=20%>Standard <font color="red">*</font></td>
				<td class=tablebold>:</td>
<!-- 				<td><select name=course class=tablelight onchange=loadStudents()>
 -->
 <td><select name=course class=tablelight onchange=loadSections()>					<option value="00">-Select Standard-</option>
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
								if(standardschedId != null && standardschedId.equals((String)hashmap.get("standardscheduleid")))
									out.println("<option selected value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+standardname+"</option>");
								else
									out.println("<option value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+standardname+"</option>");
							}
					%>
					</select>
				</td>
			</tr>
			<tr>
			<td class=tablebold width=20%>Section <font color="red">*</font></td>
			<td class=tablebold>:</td>
			<td colspan=3><select name="section" class=tablelight  onchange=loadStudents()>
			<option value="00">-Select Section-</option>
					<%
						if(sectionList !=null && sectionList.size() >0)
							for(int s1=0;s1<sectionList.size();s1++)
							{
								hashmap			=(HashMap)sectionList.get(s1);
								String sectionname=(String)hashmap.get("sectionname");
								String sectionscheduleid=(String)hashmap.get("sectionscheduleid");
								
								if(sectionschedId != null && sectionschedId.equals((String)hashmap.get("sectionscheduleid")))
									out.println("<option selected value='"+hashmap.get("sectionscheduleid")+"' class=tablelight >"+sectionname+"</option>");
								else
									out.println("<option value='"+hashmap.get("sectionscheduleid")+"' class=tablelight >"+sectionname+"</option>");
							}
					%>
			</select></td>
			</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td valign=top class='tablebold' align=left>Archival Details</td><td valign=top class=tablebold>:</td><td colspan=2 valign=top class='tablelight' align=left><h2>This is an Archived Year</h2></td><td></td></tr>");	
	}
	%>			
	
	</table></td></tr></tbody>
	
		<% 
		try
		{

		if(subjectList!=null)
		if(subjectList.size()>0)
		{
		ArrayList tempList	= new ArrayList();
		int colspancount=0;
		//HashMap subname =new HashMap();
		HashMap totalmark =new HashMap();
		
		for(int i=0,s=1;i<subjectList.size();i++)
		{
			HashMap map=(HashMap)subjectList.get(i);
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
		if(subjectList!=null)
			subjectSize = tempList.size();
		
		}
		else{}
		}
		catch(Exception e)
		{							
			e.printStackTrace();
		}
		%>
		</table>
 		<tfoot>
	    	<tr>
	        	<td colspan="2" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot>
	<br>
		
	<table id=rounded-corner1 border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="8%" rowspan=2>Sl.No</th>
            <th scope="col" class="rounded" width="25%"  rowspan=2 >Student Name</th>
            <th scope="col" class="rounded" width="10%"  rowspan=2>Roll No.</th>
            <th scope="col" class="rounded"  colspan=<%=subjectSize%> width="40%" >Marks Obtained</th>
            <th scope="col" class="rounded" width="5%" rowspan=2>Total</th>
            <!--  <th scope="col" class="rounded" width="5%" rowspan=2>Rank</th>-->
            <th scope="col" class="rounded-q4" width="15%" rowspan=2>Grade</th></tr>
            <!--  <th scope="col" class="rounded-q4" width="30%" rowspan=2>Send SMS</th>-->
            <tr  class=tableheading><%=head%>
		    </thead>
		    <tbody>
					    <%
					    try
					    {
					    	ArrayList allocationidList = new ArrayList();
					    	//System.out.print("studentList.size()-->"+studentList.size());
					    	String grade = "";
					    	if(studentList != null && studentList.size()>0){
					    		int count = 0;
					    		int slno  = 1;
					    		String rollNo = null;
					    		String markTaken = null;
					    		String markTaken1 = null;
					    		String passmark =null;
					    		
					    		String studentallocationid =null;
					    		for(int y=0;y<studentList.size();y++){
					    			hashmap=null;
				    				hashmap		= (HashMap)studentList.get(y);
					    			
				    				if(!allocationidList.contains(hashmap.get("studentallocationid")+"")){
				    				studentallocationid=hashmap.get("studentallocationid")+"";
					    			allocationidList.add(studentallocationid);grade="yes";
					    			if(hashmap.get("rollno") != null)
					    				rollNo = (String)hashmap.get("rollno");
					    			else
					    				rollNo ="NYG";
				    				out.print("<tr  class=tablebold><td>"+(slno)+".</td><td>"+hashmap.get("studentname")+"</td><td align=center>"+rollNo+"</td>");
				    				for(int i=0;i<studentList.size();i++){
						    			 HashMap hashmapmark		= (HashMap)studentList.get(i);
						    			 String studentallocationid1=hashmapmark.get("studentallocationid")+"";
						    			 if(studentallocationid.equals(studentallocationid1))
						    			 {
						    				 
						    				 if(hashmapmark.get("marktaken")!=null){
							    					markTaken1 = (String)hashmapmark.get("marktaken");
							    					passmark = (String)hashmapmark.get("theoryexternalmin");
							    					if(markTaken1 == "A" || markTaken1.equals("A")){
							    						grade = "No"; markTaken1= "<font color=red>"+markTaken1+"</font>";}
							    					
							    					 if(Integer.parseInt((String)hashmapmark.get("marktaken"))<Integer.parseInt((String)hashmapmark.get("theoryexternalmin")))
							    					 {
							    						grade = "No";
							    						markTaken1= "<font color=red>"+markTaken1+"</font>";
							    					 }
							    					
							    				}
							    				else
							    					markTaken1 = "<font color=red>NE</font>";	
						    				 out.print("<td align=center>"+markTaken1+"</td>");
						    			 }
				    				}
				    				if(hashmap.get("totalmark") == null){
					    				out.print("<td class=tablebold align=center><font color=red>NE</font></td>");
						    			}
					    				else{
						    			out.print("<td align=center>"+hashmap.get("totalmark")+"</td>");
						    			if(grade=="yes" || grade.equals("yes")){
						    				//grade		= examQuery.getGradeSystem(req_sessionid,(String)hashmap.get("totalmark"));
						    				grade		= gradescaleQuery.getGradeScaleSystem(standardschedId,(String)hashmap.get("totalmark"));
						    				
						    			}
						    			else
						    				grade 		= "<i><font color=red>-No Grade-</font></i>"; 
						    			
					    				}
										
						    			if(grade == null || grade.equals("-") || grade.equalsIgnoreCase("null"))
						    				grade = "<i><font color=red>- NYG -</font></i>";
						    			if(grade.equals("yes"))	
				    						out.print("<td align=center >-</td>");
						    			else
						    				out.print("<td align=center >"+grade+"</td>");
				    				out.print("</tr>");
					    			slno++;

					    		}

					    	}
					    	}
					    	else
					    		out.println("<tr align=center><td colspan='"+(6+subjectSize)+"'> <font color=red><b>No Student Found</b></font></td></tr>");
					        }
							catch(Exception e)
							{							
								e.printStackTrace();
							}
					    %>	
					    		    </tbody>
		</table>

<br><br>
		<%
		if(subname.size()>0)
		{
			%>
		<a class=tablebold>Note :<br>
			<%
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" :"+subname.get("S"+sub)+"<br>");
		}
			out.println("NE :Not Entered<br>");
			out.println("NYG :Not Yet Generated<br>");
		}
		%>
		</a>				

				
		<a href="#" class='bt_blue' onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>		
		<%
		if(studentList!=null){
			if(studentList.size()>0){%> 
					<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
			<%
			}
		}
			%>
	</table>
<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname") %>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>
<input type=hidden name=req_boardid >
<input type='hidden' name='standardschedid'>
<input type='hidden' name='sectionschedId' value="<%=sectionschedId %>">
<input type='hidden' name='req_sectionname'>

	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>