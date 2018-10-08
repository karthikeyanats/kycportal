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
	
	int communityCount			= 0;
	
	if(CommunityList!=null && CommunityList.size()>0)
		communityCount			= CommunityList.size();
	
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

		<table  border=0  width=640 >
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

		<br>
		<table   align='center' border='1' id=rounded-corner1 bordercolor=#000000 width="100%" cellpadding=3 cellspacing=0>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.standardname")%></th>
				<th scope="col" class="rounded" width="5%" rowspan=2><%=bundle.getString("label.reports.totalstudents")%></th>
				<th scope="col" class="rounded" width="40%" colspan=<%=communityCount%>><%=bundle.getString("label.reports.community")%></th>
				<%-- <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.exservice")%></th>
				<th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("label.reports.phychal")%></th> --%>
				<% 
			   	 if(CommunityList!=null && CommunityList.size()>0)
					{
			   		 int percent = 40/CommunityList.size();
					 for (int i = 0; i < CommunityList.size(); i++) {
					
						HashMap CommunityListMap=(HashMap)CommunityList.get(i);
						communityid      = (String)CommunityListMap.get("communityid");
						communityname      = (String)CommunityListMap.get("communityname");
						
						if(i==0)
							out.print("<tr class=tableheading><th scope='col' class='rounded' width='"+percent+"%'>"+communityname+"</th>");
						else
							out.print("<th scope='col' class='rounded' width='"+percent+"%'>"+communityname+"</th>");
					 }
					}				
				%>
				  
				  <!--  <tr class=tableheading>
				  <th scope="col" class="rounded" width="20%" >BC</th>
				<th scope="col" class="rounded" width="20%" >SC</th> -->
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
		int Totalmalestudent=0;
		int Totalfemalestudent=0;
		
		
			StandardList=reportQuery.loadcommunitystandard(reg_boardid,req_sessionid,instituteid,status);    
		int count=0;
		HashMap hashMap2= null;

							if(StandardList != null && StandardList.size()>0) 
								{
								
								for(int y=0,i=1;y<StandardList.size();y=y+communityCount){
									hashmap		= (HashMap)StandardList.get(y);
									count++;
									String standardscheduleid=hashmap.get("standardscheduleid")+"";
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									
									String totalcount=hashmap.get("totalcount")+"";
									
								out.print("<tr align=center class=tablelight ><td>"+count+"</td>");
									
									
									for(int k=y;k<y+communityCount;k++){
										
										if(StandardList.size()>k)
										hashMap2	= (HashMap)StandardList.get(k);
										
										if(k==y)
										out.print("<td align=left  class=tablelight>"+standardname+"</td><td>"+hashmap.get("totalcount1")+"</td>");

										
										
										String totalcounts=hashMap2.get("totalcount")+"";
										
										out.println("<td>"+totalcounts+"</td>");
										
									} 
									
									out.print("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='"+(CommunityList.size()+5)+"'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='7' class=tablebold align=center><font color=red>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");

							}
						%>
							
							<!--  <tr >
									<td colspan='7'><hr></td>
							</tr>					
						<tr  class=tablebold>
						
						<td colspan='2'><%=bundle.getString("label.reports.totalnoofstudents")%>:</td><td ></td><td align=center><%=Totalmalestudent %></td><td align=center><%=Totalfemalestudent %></td><td  align=center class=tablebold><%=Totalstudent %></td>
					</tr>-->
					
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