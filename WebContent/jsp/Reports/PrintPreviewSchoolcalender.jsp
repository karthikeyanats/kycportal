<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - School Calendar Event List | Powered by i-Grandee</title>
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
	alert("Successfully Printed");
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
<%@ page language="java"
	import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
<%
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);

	String req_sessionid = request.getParameter("req_sessionid");
	//out.println(req_sessionid);
	String req_sessionname = request.getParameter("req_sessionname");
		instituteBean.setSessionid(req_sessionid);
	instituteBean.setinstituteid(instituteid);
	int datacount=0;
	%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>School Calendar Event List
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  width='79%' align=left>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							
						</tr>
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' valign=top >Archival Details</td>
													<td  class='tablebold' width='1' valign=top >:</td>
													<td valign=top class='tablelight'  width='20%' align=left><h2>This is an Archived Year</h2></td>
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
					    <thead>
					    	<tr  class='tableheading'>
					        	        	<th align=left width="10%">Sl.No</th>
            <th width="30%" align=left >Event Date</th>
            <th width="35%" align=left >Event Name</th>
           <th width="35%" align=left >Holiday Status</th>
            
					        </tr>
					    </thead>
						<%
	
	
	ArrayList eventList = query_object.eventList(instituteBean);
		int inc =1;
		String temp_total  = "";
		String status_ori = null;
		if(eventList.size() > 0)
		{
			String as=request.getContextPath();	
		for(int s=0;s<eventList.size();s++)
		{
			HashMap map=(HashMap)eventList.get(s);
			String calendarid=(String)map.get("schoolcalendarid");
			String eventdescription=(String)map.get("eventdescription");
			String eventdate=(String)map.get("newdates");
			String newdates1=(String)map.get("newdates1");

			String status=(String)map.get("calendarstatus");
			String holidaystatus=(String)map.get("holidaystatus")+"";
			
			if(eventdescription=="" || eventdescription.equals(""))
				eventdescription ="-";
			if(!holidaystatus.equals("null") && !holidaystatus.equals("N"))
				holidaystatus ="Holiday";
			else if(!holidaystatus.equals("null") && holidaystatus.equals("N"))
				holidaystatus ="-";
			else if(holidaystatus.equals("null"))
				holidaystatus ="-";
			datacount++;
			out.println("<tr class=tablelight><td>"+(inc++)+"</td>");
			out.println("<td class=tableligh>"+eventdate+"</td>");
			out.println("<td class=tableligh>"+eventdescription+"</td>");
			out.println("<td class=tableligh>"+holidaystatus+"</td>");

			//out.println("<td  class=tablebold><a val='"+eventdescription+"' href=#cld sessionstatus='"+(String)map.get("sessionstatus")+"' onclick='editfun(this,\""+calendarid+"\")'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='' border=0 /></a> </td>");
			//out.println("<td class=tablebold><a val='"+eventdescription+"' href=#cld  sessionstatus='"+(String)map.get("sessionstatus")+"' onclick='manipulateFun(this,\""+calendarid+"\")'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='' border=0 /></a></font> <input type=hidden name=check"+inc+" content_id='"+calendarid+"' id='"+inc+"' class=tabledivison onclick=checkfun(this.id,this.checked)><input type=hidden name=hide_check>");

			
		}
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td colspan=3 align=center class=tablebold>Data not found</td></tr>");
	}

	%>
					</table>
				</td></tr>
					
		</table>
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