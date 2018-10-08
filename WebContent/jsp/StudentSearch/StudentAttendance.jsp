<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.StudanceAttandancetitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
			document.f1.submit();

}

</script>
</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.studentsearch.StudanceAttandancerootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			
 			
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList NoofAlloteddiaryArray=new ArrayList();

 	 		HashMap map = null;

 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String studentid="";
 			String sessionname="";
 			String standardscheduleid="";
 			String groupname = null;
 			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			 //Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 		
				 
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) 
 			 {
 					
 				map = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map.get("uname");
 				standardid = (String) map.get("standardid");
 				sectionid = (String) map.get("sectionid");
 				
 				standardname = (String) map.get("standardname");
 				sectionname = (String) map.get("sectionname");
 				standardscheduleid = (String) map.get("standardscheduleid");
 				sessionname = (String) map.get("sessionname");groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;
 			 }
 			 
 			
 			
  		
 			 
  			
 
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %>	</td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>
				
			</thead>
		</table>
		</td>
	</tr>
	</table>
	
<br>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="15%"><%=bundle.getString("label.studentsearch.StudanceAttandanceDetails") %></th>
					<th scope="col" class="rounded" width="1%"></th>   
					<th scope="col" class="rounded" width="15%"></th> 
					<th scope="col" class="rounded" width="15%"></th>  
					<th scope="col" class="rounded" width="1%"></th> 
					<th scope="col" class="rounded-q4" width="15%"></th> 
					
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				
				<%
				String startdate="";
				String enddate="";
				String sdate="";
				String edate="";
				String sessionid="";
				String totalnodays="";
				String calendarstatus="";
				String instituteid="";
				instituteid=(String)session.getValue("instituteid");
				int pcount=0;
				int odcount=0;
				int oppcount=0;
				int holidays=0;
				int dd=0;
				int finalworkindays=0;
				ArrayList getsedate=new ArrayList();
				HashMap getsedatemap=null;
				HashMap getattstatemap=null;
				HashMap TotalHolidaysmap=null;
				ArrayList getattstate=new ArrayList();
				ArrayList TotalHolidays=new ArrayList();
				getsedate=studentquery.getseendate(standardscheduleid);
				if(getsedate.size()>0 && getsedate!=null)
				{
					for(int i=0,j=1;i<getsedate.size();i++,j++)
					{     
						getsedatemap=(HashMap)getsedate.get(i);	
						startdate=(String)getsedatemap.get("startdate");
						 enddate=(String)getsedatemap.get("enddate");
						 sessionid=(String)getsedatemap.get("sessionid");
						 sdate=(String)getsedatemap.get("sdate");
						 edate=(String)getsedatemap.get("edate");
					}
				}
				getattstate= studentquery.getAttendance(startdate,enddate,rollnumber);
				 if(getattstate.size()>0 && getattstate!=null)
					{				
						for(int k=0;k<getattstate.size();k++)
						{     
							getattstatemap=(HashMap)getattstate.get(k);	
							String presentcoun=(String)getattstatemap.get("studentstate");
							
							if(presentcoun.equals("P"))
							{
								pcount++;
							}
							else if(presentcoun.equals("OD"))
							{
								odcount++;
							}
							else if(presentcoun.equals("A"))
							{
								oppcount++;
							}
												}
					} 
				  totalnodays=studentquery.TotalNoofDaysForStudent(startdate,enddate);
				  dd=Integer.parseInt(totalnodays)+1;
				 //TotalHolidays= studentquery.getTotalHolidays(sessionid,startdate,enddate,instituteid);
				 //TotalHolidays= studentquery.getTotalHolidays(sessionid,startdate,enddate,instituteid,standardscheduleid);
				 TotalHolidays= studentquery.getTotalHolidaysnew(sessionid,startdate,enddate,instituteid,standardscheduleid);
				 
				 if(TotalHolidays.size()>0 && TotalHolidays!=null)
					{
					 for(int l=0;l<TotalHolidays.size();l++)
						{
						 TotalHolidaysmap=(HashMap)TotalHolidays.get(l);
						 calendarstatus=(String)TotalHolidaysmap.get("holidaystatus");
						 if(calendarstatus.equals("Y"))
						 {
							 holidays++;
						 }
					}
					}
				 finalworkindays=dd-holidays;
				%>
				
			
				<tr>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.StartDate") %> </td>
					<td width="1%" class="tablebold">:</td>
					<td class="tablelight"><%=sdate%></td>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.EndDate") %> </td>
					<td width="1%" class="tablebold">:</td>
					<td class="tablelight" ><%=edate%></td>
				</tr>
				<tr>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.NoOfWorkingDays") %> </td>
					<td width="1%" class="tablebold">:</td>
					<td class="tablelight" colspan=4><%=finalworkindays%></td>
					
				</tr>
				<tr>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.NoOfPresent") %> </td>
					<td width="1%" class="tablebold">:</td>
					<td class="tablelight" colspan=4><%=pcount%></td>
					
				</tr>
				<tr>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.NoOfAbsentist") %> </td>
					<td width="1%" class="tablebold">:</td>
					<td class="tablelight" colspan=4><%=oppcount%></td>
					
				</tr>
				<tr>
					<td class="tablebold" width="15%"><%=bundle.getString("label.studentsearch.NoOfOnDuty") %> </td>
				    <td width="1%" class="tablebold">:</td>
					<td class="tablelight" colspan=4><%=odcount%></td>
					
				</tr>
			</thead>
		</table>
		</td>
	</tr>
	</table>
	
		</td>
	</tr>
	</table>
	
	
						</table>
				</tbody>
			</table>
			</td>
	</tr>
	</table>
		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>

	
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->
<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>