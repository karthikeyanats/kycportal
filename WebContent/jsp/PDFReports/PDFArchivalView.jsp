<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Archival List  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	function backfun()
	{
	document.wprkallotment.action =document.wprkallotment.Backstatus.value;
	document.wprkallotment.submit();
	}
	function changedescription()
	{
	document.wprkallotment.message.value =document.wprkallotment.smstemplate.value;
	}
	
	function submitfun(obj)
	{
	var sessionid=obj.getAttribute("sessionid");
	document.wprkallotment.sessionnamehidden.value=obj.getAttribute("sessionname");
	document.wprkallotment.sessionhiddenid.value=sessionid;
	document.wprkallotment.action ="PDFFolderList.jsp";
	document.wprkallotment.submit();
	}
	function sendfun()
	{
	document.wprkallotment.action ="../SMS/SMSBridge.jsp";
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

	<%
		ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsarchivalreports")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Attendance.AttendanceQuery"%>
<%
	AttendanceQuery attenquery		= new AttendanceQuery();
	HashMap hashmap=null;
	String instituteid			= (String)session.getValue("instituteid");

%>
<jsp:useBean id="obj"  scope="page" class="com.iGrandee.Report.Reports"/>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="sessionhiddenid" value="">
		<input type="hidden" name="sessionnamehidden" value="">
	
	

						<table width='100%' id=rounded-corner align='center' border='0' >
							 <thead>
							    	<tr>
							        	<th scope="col" class="rounded-company" 	      ><%=bundle.getString("label.schedule.slno")%></th>
							            <th scope="col" class="rounded"  width="33%"      ><%=bundle.getString("label.schedule.academicyear")%></th>
							        	<th scope="col" class="rounded"  width="33%"      ><%=bundle.getString("label.schedule.status")%></th>
							        	<th scope="col" class="rounded-q4"    width="33%" ><%=bundle.getString("label.schedule.pdffile")%></th>
							        	
							        </tr>
							    </thead>
							    <tfoot>
									<tr>
										<td colspan=3 class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
									</tr>
								</tfoot>
								<tbody >
									<%
									try
									{
									ArrayList SessionList =obj.ArchivalAcademicYear(instituteid);
									
										if(SessionList!=null && SessionList.size()>0 )
										{
											for(int i=0;i<SessionList.size();i++)
												{
													HashMap hash =(HashMap)SessionList.get(i);
													out.println("<tr>");
													out.println("<td>"+(i+1)+"</td>");
													out.println("<td>"+hash.get("sessionname")+"</td>");
													String sta=hash.get("sessionstatus")+"";
													if(sta.equals("R"))
													{
													out.println("<td>Archival</td>");
													out.println("<td><a href='#pdf' sessionid='"+hash.get("sessionid")+"'  sessionname='"+hash.get("sessionname")+"' onclick='submitfun(this)'>Archival PDF's</a></td>");
													}
													else
													{
														out.println("<td>Current</td>");
														out.println("<td>-</td>");
													}
													out.println("</tr>");
												}

										}
										else
										{
											out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.println("<tr>");
											//out.println("<td colspan=4 align=center>"+bundle.getString("label.schedule.datanotfound")+"</td>");
											//out.println("</tr>");

										}
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
									%>
								</tbody>
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