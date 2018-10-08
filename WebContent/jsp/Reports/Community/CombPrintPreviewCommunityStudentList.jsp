<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
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
	<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.MasterEntries.Community.CommunityQuery,com.iGrandee.Common.DateTime"%>
	<%@ page language="java" import="com.iGrandee.Report.Reports"%>
	
<%
	Reports reportQuery			= new Reports();
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	CommunityQuery communityQuery			= new CommunityQuery();
	
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	int datacount=0;
	ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
	//ArrayList BoardList				= examQuery.LoadBoardList(instituteid);
	//ArrayList academicList 			= examQuery.loadAcademicYear(instituteid);
	ArrayList CommunityList = communityQuery.loadCommunityList(instituteid);
	String communityid = "";
	String communityname = "";
	String communityidtemp = "";
	String communitynametemp = "";
	
	HashMap	hashmap					= null;
	HashMap	hashmapMark				= null;
	
	ArrayList standardList			= null;
	//String reg_sessionid 			= request.getParameter("sessionname");
	String req_sessionid 			= request.getParameter("req_sessionid");
	String reg_boardid 				= request.getParameter("req_boardid");
	String req_boardname 			= request.getParameter("req_boardname");
	String status 					=request.getParameter("req_sessionstatus");
	
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
		status = "A','D','C";
	
	

	ArrayList StandardList		= null;

	StringBuffer head = new StringBuffer();
	HashMap subname =new HashMap();
	int subjectSize = 0;
	
	if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  )
		if(!req_sessionid.equals("null") && !reg_boardid.equals("null")&& !req_sessionid.equals("0") && !reg_boardid.equals("0"))
		{
			//StandardList=prinicipal.loadstandardwithstatus(reg_boardid,req_sessionid,instituteid,status);   
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

		<table  border=0  width=640 align=center >
		<tr height=50px><td align=left>
		<%@ include file="../../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center><%=bundle.getString("label.reports.communitystudentlist")%>
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
						
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
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

				<% 
			   	 if(CommunityList!=null && CommunityList.size()>0)
					{
			   		 //int percent = 40/CommunityList.size();
					 for (int i = 0; i < CommunityList.size(); i++) {
				%>

		<table   align='center' border='1' id=rounded-corner1 bordercolor=#000000 width="100%" cellpadding=3 cellspacing=0>
						<thead>
						<tr class=tableheading>
							<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
							<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.standardname")%></th>
							<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.reports.totalstudents")%></th>
							
							<!--  <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.exservice")%></th>
							<th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.phychal")%></th>-->
				
				<%						
						HashMap CommunityListMap=(HashMap)CommunityList.get(i);
						communityid      = (String)CommunityListMap.get("communityid");
						communityname      = (String)CommunityListMap.get("communityname");
						//communityidtemp  = communityidtemp+"ÿ"+communityid;
						//communitynametemp  = communitynametemp+"ÿ"+communityname;
						
						out.print("<th scope='col' class='rounded' width='60%' colspan='3'>"+communityname+"</th>");
						
						out.print("<tr class=tableheading><th scope='col' class='rounded' width='20%'>"+bundle.getString("label.reports.exservice")+"</th>");
						out.print("<th scope='col' class='rounded' width='20%'>"+bundle.getString("label.reports.phychal")+"</th>");
						out.print("<th scope='col' class='rounded' width='20%'>Both</th>");
						
						if(!req_sessionid.equals("null") && !reg_boardid.equals("null")&& !req_sessionid.equals("0") && !reg_boardid.equals("0"))
						{
							StandardList=reportQuery.loadcombcommunitystandardwithstatus(reg_boardid,req_sessionid,instituteid,status,communityid);   
						}						

						if(StandardList != null && StandardList.size()>0)
						{
						for(int y=0,j=1;y<StandardList.size();y++,j++){
							hashmap		= (HashMap)StandardList.get(y);
							String standardscheduleid=hashmap.get("standardscheduleid")+"";
							String standardname=hashmap.get("standardname")+"";
							String groupname=hashmap.get("groupname")+"";
							if(!groupname.equals("null"))
							standardname=standardname+" -"+groupname;
							
							String totalcount=hashmap.get("totalcount")+"";
							//String communityId[]=null;
							//String communityName[]=null;
						 
							String exservicecount=hashmap.get("exsercount")+"";		
							String phychalcount=hashmap.get("phycount")+"";
							String bothcount=hashmap.get("bothcount")+"";

							//out.print("<tr align=center  ><td>"+i+"</td><td align=left>"+standardname+"</td><td>");
							out.print("<tr align=center  ><td>"+j+"</td>");
							
							//if(Integer.parseInt(exservicecount) > 0 || Integer.parseInt(phychalcount) > 0 || Integer.parseInt(bothcount) > 0)
								//out.print("<td align=left><a href='#sectionhref' name='sectionhref' standardname='"+standardname+"'  standardscheduleid='"+standardscheduleid+"' communityid='"+communityid+"' communityname='"+communityname+"' onclick='loadSection(this)'>"+standardname+"</a></td><td>");
							//else
								out.print("<td align=left>"+standardname+"</td><td>");

							//if(!totalcount.equals("null") && !totalcount.equals("0"))
								//out.println("<a href='#totalcounthref' name='totalcounthref' sex='T' standardname='"+standardname+"' 	standardscheduleid='"+standardscheduleid+"' onclick='loadStudent(this)'>[ "+totalcount+" ]</a></td>");
							//else
								out.println(totalcount+"</td>");
								out.println("<td>"+exservicecount+"</td>");
								out.println("<td>"+phychalcount+"</td>");							
								out.println("<td>"+bothcount+"</td>");

								
							
							/*if(!exservicecount.equals("null") && !exservicecount.equals("0"))
								out.println("<td><a href='#exservicecounthref' name='exservicecounthref' operation='exserviceman' standardname='"+standardname+"' standardscheduleid='"+standardscheduleid+"' communityid='"+communityid+"' communityname='"+communityname+"' onclick='loadStudent(this)'>[ "+exservicecount+" ]</a></td>");
							else
								out.println("<td>"+exservicecount+"</td>");
							if(!phychalcount.equals("null") && !phychalcount.equals("0"))
								out.println("<td><a href='#phychalcounthref' name='phychalcounthref' operation='phychal' standardname='"+standardname+"' standardscheduleid='"+standardscheduleid+"' communityid='"+communityid+"' communityname='"+communityname+"' onclick='loadStudent(this)'>[ "+phychalcount+" ]</a></td>");
							else
								out.println("<td>"+phychalcount+"</td>");
							if(!bothcount.equals("null") && !bothcount.equals("0"))
								out.println("<td><a href='#bothcounthref' name='bothcounthref' operation='both' standardname='"+standardname+"' standardscheduleid='"+standardscheduleid+"' communityid='"+communityid+"' communityname='"+communityname+"' onclick='loadStudent(this)'>[ "+bothcount+" ]</a></td>");
							else
								out.println("<td>"+bothcount+"</td>");*/							
							out.print("</tr>");
						}
						datacount++;
						}
					else
					{
						out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

					}
					
						out.print("<br>");
						
					 }
					}
					else
					{
						out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

					}				
				%>
				  
				  <!--  <tr class=tableheading>
				  <th scope="col" class="rounded" width="20%" >BC</th>
				<th scope="col" class="rounded" width="20%" >SC</th> -->
			</tr>
			</thead>
		
		<tbody>

					
		</tbody>
		
		</table>
		<br></br>
		<table width="100%">
		<tr align=center><td colspan=6>
		<% 
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr></table>
		</form>		
</body>

</html>