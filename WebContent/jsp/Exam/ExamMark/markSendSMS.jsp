<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Send Marks thru SMS | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
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
	
	function publishStandard()
	{
		if(check_ForParticularElements(document.Topper_Form.sessionname,"select",document.Topper_Form.boardname,"select",document.Topper_Form.examname,"select",document.Topper_Form.course,"select")){
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

    <h2>Exam / Exam MarkList / Send SMS </h2>
		<form name="Topper_Form" action="" method="post">
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10"></th>
		            	<th scope="col" class="rounded" width="100%">Select Information</th>
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
		HashMap	hashmapMark				= null;
		
		ArrayList ExamList				= null;
		ArrayList standardList			= null;
		String reg_sessionid 			= request.getParameter("sessionname");
		String reg_boardid 				= request.getParameter("boardname");
		String reg_examid 				= request.getParameter("examname");
		String standardid 				= request.getParameter("course");
		String students					= request.getParameter("students");
		StringBuffer head = new StringBuffer();
		ArrayList studentList			= null;
		ArrayList subjectList			= null;
		int subjectSize = 0;
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  )
			ExamList			= examQuery.LoadAllotedExamnameList(reg_sessionid);

		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null)
			standardList 		= examQuery.listStandard(reg_sessionid,reg_boardid);
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)
		{	
			subjectList			= (ArrayList)examQuery.subjectsScheduled(standardid);
			//studentList			= examQuery.standardTopperWeekerList(standardid,reg_examid,"desc","100");
			studentList			= examQuery.standardMarkListToSMS(standardid,reg_examid);
			//System.out.println(standardid+"----"+reg_examid);
		}
%>
			
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'>Academic Year<font color="red">*</font></td>
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
				</td>
			

				<td class=tablebold width='10%'>Board <font color="red">*</font></td>
				<td>
					<select name=boardname class=tablelight onchange=loadExam()>
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
		
				<td class=tablebold>Standard <font color="red">*</font></td>
				<td><select name=course class=tablelight >
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
		<% 
		try
		{

		if(subjectList!=null)
		if(subjectList.size()>0)
		{
		ArrayList tempList	= new ArrayList();
		int colspancount=0;
		HashMap subname =new HashMap();
		HashMap totalmark =new HashMap();
		
		for(int i=0,s=1;i<subjectList.size();i++)
		{
			HashMap map=(HashMap)subjectList.get(i);
			String subjectname=map.get("subjectname")+"";
			//examallocationid=map.get("examallotmentid")+"";
			 //String markpublishsta=map.get("markpublishstatus")+"";
				//if(markpublishsta.equals("P"))
				//{
					// markpublishstatus=map.get("markpublishstatus")+"";
				//}
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
			subjectSize = subjectList.size();
		
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
	
		<a href="#" class='bt_blue' onclick='publishStandard()'><span class="bt_blue_lft"></span><strong>Load Students</strong><span class="bt_blue_r"></span></a>
		
	<table id="rounded-corner1" border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="8%" rowspan=2>Sl.No</th>
            <th scope="col" class="rounded" width="28%"  rowspan=2 >Student Name</th>
            <th scope="col" class="rounded" width="18%"  rowspan=2>Roll No.</th>
            <th scope="col" class="rounded"  colspan=<%=subjectSize%> width="18%" colspan=3>Marks Obtained</th>
            <th scope="col" class="rounded" width="10%" rowspan=2>Total</th>
            <th scope="col" class="rounded" width="6%" rowspan=2>Rank</th>
            <th scope="col" class="rounded-q4" width="30%" rowspan=2>Send SMS</th>
            <tr  class=tableheading><%=head%>
		     </tr>
		    </thead>
					    <%
					    	ArrayList allocationidList = new ArrayList();
					    	
					    	if(studentList != null && studentList.size()>0){
					    		int count = 0;
					    		int slno  = 0;
					    		int subStu = studentList.size();
					    		String rollNo = null;
					    		String markTaken = null;
					    		String markTaken1 = null;
					    		//for(int y=0;y<studentList.size();y++){
					    			for(int y=(studentList.size()-1);y>=0;y=y-subjectList.size()){
					    				
					    				hashmap		= (HashMap)studentList.get(y);
					    				if(hashmap.get("marktaken")!=null)
					    					markTaken = (String)hashmap.get("marktaken");
					    				else
					    					markTaken = "NE";

					    				if(hashmap.get("rollno")!=null)
					    					rollNo = (String)hashmap.get("rollno");
					    				else
					    					rollNo = "-";
				    				
					    				
					    			if(!allocationidList.contains(hashmap.get("studentallocationid"))){
					    				count = 1;
					    				slno++;
					    				
					    				//out.print("<tr  class=tablebold><td>"+(slno)+".</td><td>"+hashmap.get("studentname")+"</td><td>"+hashmap.get("rollno")+"</td><td align=center>"+markTaken+"</td");
					    				out.print("<tr  class=tablebold><td>"+(slno)+".</td><td>"+hashmap.get("studentname")+"</td><td>"+rollNo+"</td>");
					    			}
					    			else{
					    				count++;
				    					//out.print("<td align=center>"+markTaken+"</td>");
					    			}
					    			subStu = subStu - subjectList.size();
					    			for(int i=0;i<subjectList.size();i++)
					    			{					    				
					    				if((i+subStu)<studentList.size())
					    				{
					    				hashmapMark		= (HashMap)studentList.get(i+subStu);
					    				
					    				//System.out.println("hashmapMark.get(marktaken)-->"+hashmapMark.get("marktaken"));
					    				
					    				if(hashmapMark.get("marktaken")!=null)
					    					markTaken1 = (String)hashmapMark.get("marktaken");
					    				else
					    					markTaken1 = "NE";					    				
					    				
					    				out.print("<td align=center>"+markTaken1+"</td>");
					    				}
					    				else
					    				{
						    				out.print("<td align=center>-</td>");
					    				}
					    			}
					    								    			
					    			//if(count==subjectList.size())
					    			{
						    			if(hashmap.get("totalmark") == null)
					    				out.print("<td class=tablebold align=center>NE</td>");
					    				else
						    			out.print("<td align=center>"+hashmap.get("totalmark")+"</td>");

					    				//out.print("<td align=center>"+((y+1)/subjectList.size())+"</td><td align=center><a href=# >Send</a></td></tr>");
					    				out.print("<td align=center>"+(slno)+"</td><td align=center><a href=# >Send</a></td></tr>");
						    			
					    			}
					    			allocationidList.add(hashmap.get("studentallocationid"));
					    			
					    		}
					    	}
					    	else
				    			out.print("<tr><td colspan='5' align='center'><font color=red>No Students Found</font></td></tr>");
					    		
					    %>		    
      		<tfoot>
		    	<tr>
		        	<td colspan="6" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right" colspan='2'>&nbsp;</td>
		       </tr>
		    </tfoot>
		    

				
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