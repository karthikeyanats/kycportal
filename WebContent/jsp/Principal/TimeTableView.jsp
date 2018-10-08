<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TimeTable  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/xmlhttpobject.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/clearselects.js"></SCRIPT>

<script language='javascript'>

	function backfun(){
		document.wprkallotment.action = "TimeTableSearch.jsp";
		document.wprkallotment.submit();
	}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.stafftimetablestandardview")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	
<%
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;
	String sessionid		= session.getValue("sessionid")+"";
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String boardname		= request.getParameter("boardname");
	
	ArrayList staffList		= wallot.loadStaffForSection(sectionid);
	String instituteid		= (String)session.getValue("instituteid");
	ArrayList periodList	= wallot.loadPeriods(instituteid); 
	ArrayList scheduleList	= wallot.loadScheduless(instituteid,sectionid); 

%>
	<form name='wprkallotment' method='post'>

								<table  border=0 bordercolor='blue' id=rounded-corner align="center" width="80%" cellspacing=0 cellpadding=5>
									<thead>
								    	<tr bordercolor='blue'>
								            <th scope="col" class="rounded-company" width="98%" colspan=4 ><%=bundle.getString("label.schedule.selectedinfo")%></th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
									</thead>
								    <tfoot>
										<tr>
											<td colspan=4 class="rounded-foot-left"><em></em></td>
											<td class="rounded-foot-right">&nbsp;</td>
										</tr>
									</tfoot>
									<tbody>
									<tr height='23'>
									<td></td>
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=session.getValue("sessionname") %>
										</td>
										<td></td>
									</tr>
									<tr height='23'>
									<td></td>
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=boardname%>
										</td>
										<td></td>
									</tr>									
									<tr height='23'>
										<td></td>
									
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=standardname %>
										</td>
																			<td></td>
										
									</tr>
									<tr height='23'>
																		<td></td>
									
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=sectionname %>
										</td>
																			<td></td>
										
									</tr>
									</tbody>
								</table>
							<br>
						
								
					
				
				<%
				//out.println("<tr><td align=center><iframe id='iframeid' src='./TimeTableIfrm.jsp' width=826px height=400px frameborder=0></iframe></td></tr>"); 
				if(periodList.size()>7)
				{
				%>				
					<div class="myScrollingDiv">
				<%
				} 
				%>
								<table  border='0' id=rounded-corner align="center" width="80%"  cellpadding=0>
									<thead>
								    	<tr bordercolor='blue'>
								            <th scope="col" class="rounded-company" width="98%" colspan='2'><%=bundle.getString("label.schedule.timetableview")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tfoot>
										<tr>
										<td colspan=2 class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
								</tr>
								</tfoot>
								<tbody>
									<%
									if(periodList.size()>0)
									{
									%>				
									<tr class='tablebold' height='25'>
									<td></td>
										<td>
											<table  border='1' align="center"  cellspacing=0 cellpadding=0>
											<tr>
												<td>Periods</td>
											<%
												if(periodList != null && periodList.size()>0){
													for(int y=0;y<periodList.size();y++){
														hashmap		= (HashMap)periodList.get(y);
														out.print("<td class='tablebold' rowspan='2' nowrap>"+hashmap.get("periodname")+" <br>"+hashmap.get("periodtime")+"</td>");
													}
												}
											%>
											</tr>
											<tr>
												<td>Day</td>	
											</tr>
											<%
												int innerloop			= 0;
												int getcount			= 0;
												int idcount				= 1;
												
												StringBuffer buffer		= new StringBuffer();
												if(scheduleList != null && scheduleList.size()>0){
													for(int y=0;y<scheduleList.size();){
						
														for(innerloop=0;innerloop<periodList.size() && (y+innerloop)<scheduleList.size();innerloop++){
															hashmap		= (HashMap)scheduleList.get((y+innerloop));
															
															if(innerloop == 0)
																buffer.append("<tr><td class='tablebold'>"+hashmap.get("dayname")+"</td>");
															if(hashmap.get("sectionpublishid") == null)
																buffer.append("<td align='center' class='tablelight'>-</td>");
															else
																buffer.append("<td align='center' class='tablelight'>"+hashmap.get("staffname")+"<br>("+hashmap.get("subjectname")+" )</td>");
															

															idcount++;
															
														
														}
														y += innerloop;
														innerloop = 0;
														buffer.append("</tr>");
													}
												}
												
												out.print(buffer.toString());
												idcount--;
											%>
											</table>
										</td><td></td>
										</tr>
										<%
										}
										else
										{
											out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
										//out.print("<tr><td align=center colspan=3>"+bundle.getString("label.schedule.datanotfound")+"</td</tr>");	
										}
										%>
											
										
										</table>								
											<%
				if(periodList.size()>7)
				{
				%>				
				</div>	
				<%
				} 
				%>	
					<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>