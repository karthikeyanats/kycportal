<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Mark List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript">
	function goBack()
	{
	window.close();
	}
	
	function printfun()
	{	
	document.getElementById("printbutt").style.visibility='hidden';
	document.getElementById("backbutt").style.visibility='hidden';
	window.print();
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body>
	<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.InstitutionQurey"%>
	<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime,com.iGrandee.GradeSetting.GradeScaleQuery"%>
	
<%
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	int datacount=0;
	ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
	GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();
	ArrayList BoardList				= examQuery.LoadBoardList(instituteid);
	ArrayList academicList 			= examQuery.loadAcademicYear(instituteid);
	HashMap	hashmap					= null;
	HashMap	hashmapMark				= null;
	
	ArrayList ExamList				= null;
	ArrayList standardList			= null;
	//String reg_sessionid 			= request.getParameter("sessionname");
	String req_sessionid 			= request.getParameter("req_sessionid");
	//String reg_boardid 			= request.getParameter("boardname");
	String req_boardid 				= request.getParameter("req_boardid");
	String reg_examid 				= request.getParameter("examname");
	//String standardid 			= request.getParameter("course");
	String standardschedId			= request.getParameter("standardschedid");
	String sectionschedId			= request.getParameter("sectionscheduleId");
	String sectionname			= request.getParameter("req_sectionname");
	String students					= request.getParameter("students");
	StringBuffer head = new StringBuffer();
	ArrayList studentList			= null;
	ArrayList subjectList			= null;
	HashMap subname =new HashMap();
	int subjectSize = 0;
	
	if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  )
		ExamList			= examQuery.LoadAllotedExamnameList(req_sessionid);

	if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  && request.getParameter("examname") != null)
		standardList 		= examQuery.listStandard(req_sessionid,req_boardid);
	
	if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  && request.getParameter("examname") != null)
	{	
		subjectList			= (ArrayList)examQuery.subjectExamScheduled(standardschedId);
		//studentList			= examQuery.standardMarkListToSMS(standardschedId,reg_examid);
		studentList			= examQuery.standardMarkListToSMSNew(standardschedId,reg_examid,sectionschedId);
		
	}
/*	out.println("req_sessionid"+req_sessionid);
	out.println("req_boardid"+req_boardid);
	out.println("reg_examid"+reg_examid);
	out.println("standardschedId==[ "+standardschedId+" ]");
	out.println(ExamList);
	out.println(standardList);
	out.println(subjectList);
	out.println(studentList);*/

%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=left>
		<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Exam Mark List
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td  class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'   align=left>
							<%=request.getParameter("req_sessionname") %>
							</td>
							<td  class='tablebold' align='left'>Board</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'   align=left>
							
							<%=request.getParameter("req_boardname") %>
								
							</td>
							
						</tr>
						<tr>
							<td  class='tablebold' align='left'>Exam</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  align=left>
							
							<%=request.getParameter("req_examname") %>
								
							</td>
							<td  class='tablebold' align='left'>Standard</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  align=left>
							
							<%=request.getParameter("req_standardname") %>
								
							</td>
							
						</tr>
						<tr>
							<td  class='tablebold' align='left'>Section</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  align=left>
							
							<%=request.getParameter("req_sectionname") %>
								
							</td>
							
							
						</tr>					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' valign=top >Archival Details</td>
													<td  class='tablebold' width='1' valign=top >:</td>
													<td valign=top class='tablelight'  align=left valign=top colspan=4><h2>This is an Archived Year</h2></td>
											</tr>
											<%
											} 
											%>		
					</table>					    	
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
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
							subjectSize = tempList.size();
						
						}
						else{}
						}
						catch(Exception e)
						{							
							e.printStackTrace();
						}
						%>
						<thead>
						 <tr class=tableheading  >
        	<th align=left width="8%" rowspan=2>Sl.No</th>
            <th  align=left  width="28%"  rowspan=2 >Student Name</th>
            <th  align=left  width="18%"  rowspan=2>Roll No.</th>
            <th  align=center   colspan=<%=subjectSize%> width="18%">Marks Obtained</th> 
            <th  align=left  width="10%" rowspan=2>Total</th>
            <!--  <th  align=left  width="6%" rowspan=2>Rank</th>-->
            <th  align=left  width="14%" rowspan=2>Grade</th>
            <tr  class=tableheading><%=head%>
		     </tr>
		    </thead>
					   <%
					    try
					    {
					    	ArrayList allocationidList = new ArrayList();
					    	System.out.print("studentList.size()-->"+studentList);
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
      				</table>
				</td></tr>
					
		</table><br><br>
		<a class=tablebold>Note :<br>
		<%
		if(subname.size()>0)
		{
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" :"+subname.get("S"+sub)+"<br>");
		}
		out.println("NE :Not Entered<br>");out.println("NYG :Not Yet Generated<br>");

		}
		%>
		</a>	
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		//out.print("datacount-->"+datacount);
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>