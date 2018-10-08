<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	function Studentdetails(obj)
	{
	var standardscheduleid=obj.getAttribute("standardscheduleid");
	var sectionscheduleid=obj.getAttribute("sectionscheduleid");
	var sectionname=obj.getAttribute("sectionname");
	document.wprkallotment.sectionname.value=sectionname;
	document.wprkallotment.standardscheduleid.value=standardscheduleid;
	document.wprkallotment.sectionscheduleid.value=sectionscheduleid;
	document.wprkallotment.attendancestate.value=obj.getAttribute("state");
	
	
	document.wprkallotment.action = "./AbsenteesListView.jsp";
	document.wprkallotment.submit();
	}
	function backfun()
	{
	if(document.wprkallotment.backstatus.value=="Admin")
	{
		document.wprkallotment.action ="./AdminAttendanceView.jsp";
	}
	else
	{
	document.wprkallotment.action ="./YearofsessionAttendanceView.jsp";
	}
	document.wprkallotment.submit();
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

    <h2>Attendance Details / Section Wise</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule,com.iGrandee.Attendance.AttendanceQuery"%>
<%
	///ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	AttendanceQuery attenquery		= new AttendanceQuery();
	HashMap hashmap=null;
	String instituteid			= (String)session.getValue("instituteid");
	String standardid			= request.getParameter("standardscheduleid")+"";
	String standardname			= request.getParameter("standardname")+"";
	String boardid				= request.getParameter("board")+"";
	String boardname			= request.getParameter("boardname")+"";
	String searchdate			= request.getParameter("searchdate")+"";
	String Sessionid			= (String)session.getValue("sessionid");
	String Sessionname			= (String)session.getValue("sessionname");
	String backstatus			= request.getParameter("backstatus")+"";
	ArrayList SectionList	= null;
	if(!standardid.equals("null"))
	{
		SectionList	= attenquery.loadsection(standardid,instituteid);
	}

%>
<jsp:useBean id="common_data_object"  scope="page" class="com.iGrandee.Common.CommonDataAccess"/>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="standardscheduleid" value="">
		<input type="hidden" name="sectionscheduleid" value="">
		<input type="hidden" name="standardname"  value="<%=standardname %>">
		<input type="hidden" name="boardname" 	value="<%=boardname %>">
		<input type="hidden" name="sectionname" 	value="">
		<input type="hidden" name="board" value="<%=boardid %>">
		<input type="hidden" name="searchdate" value="<%=searchdate %>">
		<input type="hidden" name="backstatus" value="<%=backstatus %>">
				<input type="hidden" name="attendancestate" value="<%=backstatus %>">
				
		
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				
						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="90%">Selected Information</th>
									<th scope="col" class="rounded-q4" width="10%"></th>
								</tr>
							</thead>
							<tbody>
							<tr>
							<td colspan=2>
							<table width=100%>
							<tr>
								<td  width='25%' class='tablebold'>Academic Year</td>
								<td class=tablebold>:</td>
								<td  width='25%'><%= Sessionname%></td>
								<td class='tablebold'>Board</td>
								<td class=tablebold>:</td>
								<td><%=boardname%></td >
							</tr>
							<tr>
								<td class='tablebold'>Standard Name</td>
								<td class=tablebold>:</td>
								<td ><%=standardname%></td>
							</tr>
							</table></td></tr>
							</tbody>
								<tfoot>
									<tr>
										<td class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
									</tr>
								</tfoot>
						</table>
						<br></br>
																		</td>

											</tr>
<tr>
				<td align='left' >
				
						
								<table border='0' id=rounded-corner  align="center" width="100%">
								<thead>
									<tr>
										<th scope="col" class="rounded-company" width="15%">Sl.No</th>
										<th scope="col" class="rounded" width="45%">Section</th>
										<th scope="col" class="rounded" width="20%">No of Present</th>
										<th scope="col" class="rounded" width="20%">No of Absent</th>
										<th scope="col" class="rounded-q4" width="20%">Total</th>
									</tr>
									</thead>
											<%
												if(SectionList != null && SectionList.size()>0){
													int totCount=0;
													int totCount1=0;

													for(int y=0;y<SectionList.size();y++){
														int count=0;
														int count1=0;
														hashmap		= (HashMap)SectionList.get(y);
														out.println("<tr>");
														String sectid=hashmap.get("sectionscheduleid")+"";
														String sectionname=hashmap.get("sectionname")+"";
														out.print("<td align=left>"+(y+1)+"</td><td>"+sectionname+"</td>");
														ArrayList absentees = attenquery.loadAbsentesscountforStandard(Sessionid,standardid,sectid,searchdate,"P"); 
														if(absentees!=null && absentees.size()>0)
														{
															for(int i=0;i<absentees.size();i++)
															{
																HashMap innermap=(HashMap)absentees.get(i);
																String noofabsentees=innermap.get("absentees")+"";
																if(noofabsentees.equals("0"))   
																	out.print("<td align=center>"+noofabsentees+"</td>");
																else
																	out.print("<td align=center><a href='#present' name='present' sectionscheduleid='"+sectid+"' standardscheduleid='"+standardid+"' sectionname='"+sectionname+"' state='P' onclick='Studentdetails(this)'>[ "+noofabsentees+" ]</a></td>");
																count +=Integer.parseInt(noofabsentees);
																totCount+=count;
															}
														}
														else
														{
															out.print("<td align=center>0</td>");

														}
														ArrayList absentees1 = attenquery.loadAbsentesscountforStandard(Sessionid,standardid,sectid,searchdate,"A"); 
														
														if(absentees1!=null && absentees1.size()>0)
														{
															for(int i=0;i<absentees1.size();i++)
																{
																	HashMap innermap=(HashMap)absentees1.get(i);
																	String noofabsentees=innermap.get("absentees")+"";
																	if(noofabsentees.equals("0") )
																		out.print("<td align=center>"+noofabsentees+"</td>");
																	else
																		out.print("<td align=center><a href='#absent' name='absent' sectionscheduleid='"+sectid+"' standardscheduleid='"+standardid+"' sectionname='"+sectionname+"' state='A'  onclick='Studentdetails(this)'>[ "+noofabsentees+" ]</a></td>");
																	count1 +=Integer.parseInt(noofabsentees);
																	totCount1+=count1;
																}
														}
														else  
														{
															out.print("<td align=center>0</td>");
	
														}
														out.println("<td align=center>"+(count+count1)+"</td>");
														out.println("</tr>");
														if(y==SectionList.size()-1)
														{
															out.println("<tr><td align=center colspan=5><hr></td></tr>");
															out.println("<tr><td align=right colspan=2 class=tablebold>Total No Of Students:</td><td align=center>"+totCount+"</td><td align=center>"+totCount1+"</td><td align=center>"+(totCount+totCount1)+"</td></tr>");
														}
													}
													 
												}
												else
												{				
													out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
													//out.println("<tr><td align=center colspan=3>Data Not Found<td></tr>");

													
												}
											%>
										</table>
																	</td>

											</tr>

										</table>
										<br>
										<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>Back</strong><span
		class="bt_blue_r"></span></a>
										</td>
										<td></td>
									</tr>
								</table>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>