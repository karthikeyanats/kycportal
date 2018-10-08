<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Time Table | Powered by i-Grandee</title>
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
<body><%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	<%
	//ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	//ArrayList staffList		= wallot.loadStaffForSection(sectionid);
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();	
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);

	ArrayList periodList	= wallot.loadPeriods(instituteid); 
	ArrayList scheduleList	= wallot.loadScheduless(instituteid,sectionid); 
	int datacount=0;
%>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Time Table
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							<td width='20%' class='tablebold' align='left'>Standard</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
								<%=standardname %>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold' align='left'>Section</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=sectionname %>
								
							</td>
							
						</tr>
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'  >Archival Details</td>
													<td  class='tablebold' width='1' >:</td>
													<td valign=top class='tablelight' align=left colspan=4><h2>This is an Archived Year</h2></td>
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
			<tr class='tablelight' >
				<td width='20%' >
					<table  border='1' align="center" width="80%" cellspacing=0 cellpadding=5>
																<tr>
																	<td class=tablebold>Periods</td>
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
																	<td class=tablebold>Day</td>	
																</tr>
																<%
																	int innerloop			= 0;
																	int getcount			= 0;
																	int idcount				= 1;
																	
																	StringBuffer buffer		= new StringBuffer();
																	
																	if(scheduleList != null && scheduleList.size()>0){
																		for(int y=0;y<scheduleList.size();){
																			datacount++;
																			for(innerloop=0;innerloop<periodList.size() && (y+innerloop)<scheduleList.size();innerloop++){
																				hashmap		= (HashMap)scheduleList.get((y+innerloop));
																				
																				if(innerloop == 0)
																					buffer.append("<tr><td class='tablebold'>"+hashmap.get("dayname")+"</td>");
																				
																				if(hashmap.get("sectionpublishid") == null){
																					//buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"'></span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid='' onclick='checkScheduleAjax(this)'><br><span id='subject"+idcount+"'></span></td>");
																					buffer.append("<td align='center' class='tablelight'>-</td>");
																				}
																				else{
																					//buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"' title='"+hashmap.get("staffname")+"'>"+hashmap.get("shortstaff")+"</span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid=''  disabled checked><br><span id='subject"+idcount+"' title='"+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span></td>");
																					buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"' title='"+hashmap.get("staffname")+"'>"+hashmap.get("shortstaff")+"</span><br><br><span id='subject"+idcount+"' title='"+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span></td>");
																				}
																				
					
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