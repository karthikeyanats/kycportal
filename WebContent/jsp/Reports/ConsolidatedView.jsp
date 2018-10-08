<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Consolidated List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="Consolidated_pre.jsp";
	document.approvalForm.submit();
}

function pendingView(obj)
{

	document.approvalForm.standardpublishid.value 	= obj.getAttribute("standardscheduleid");
	document.approvalForm.standardnamegp.value 		= obj.getAttribute("standardname");
	document.approvalForm.req_termfeesid.value 		= obj.getAttribute("termfeesid");
	document.approvalForm.req_termfeesname.value 	= obj.getAttribute("termname");
	document.approvalForm.req_termfeesamount.value 	= obj.getAttribute("termfeesamount");
	document.approvalForm.req_duedate.value 		= obj.getAttribute("duedate");
	
	document.approvalForm.action="FeesPendingDetailView.jsp";
	document.approvalForm.submit();
}
function viewProfile(id)
{
	document.approvalForm.id.value=id
	document.approvalForm.action="ProfileView.jsp";
	document.approvalForm.submit();
}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="approvalForm" action="" method="post">
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

    <h2><%=bundle.getString("label.reports.reportsconsolidatedreportview")%></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" colspan='2' width="100%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 	//com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
	 	com.iGrandee.Report.Reports  reportQuery = new com.iGrandee.Report.Reports();
	 	
		
		//String dateofallocation=null;

		String instituteid=(String)session.getValue("instituteid");
		String sessionid=(String)session.getValue("sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		//String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		//String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList consoReportList= null;
		
		consoReportList =	(ArrayList)reportQuery.consolidatedReport(sessionid,request.getParameter("req_boardid"),instituteid);
		//pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesDetails(sessionid,request.getParameter("req_boardid"),instituteid);
       //out.print(consoReportList);
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.schedule.academicyear")%> :</td><td class=tablelight ><%=session.getValue("sessionname") %></td>
	<td class=tablebold><%=bundle.getString("label.schedule.board")%> :</td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
</table>
</td><td></td></tr>
</table>
<br>

	<table align=center width=100% border=1 cellpadding=0 cellspacing=0 bordercolor=black>
		<tr bgcolor="#B6DDE8">
			<td align=center class=tablebold colspan=7>
			<font size=5><%=bundle.getString("label.schedule.standardstructure")%></font>
			</td>
		</tr>
		<tr>
			<td bgcolor="#95B3D7" rowspan=2 class=tablebold align=center>
				<%=bundle.getString("label.schedule.standardname")%>
			</td>
			<td bgcolor="#DBE5F1" colspan=3 class=tablebold align=center>
				<%=bundle.getString("label.schedule.schedule")%>
			</td>
			<td bgcolor="#95B3D7" rowspan=2 class=tablebold align=center>
			<%=bundle.getString("label.schedule.fees")%>
			</td>
			<td bgcolor="#DBE5F1" colspan=2 class=tablebold align=center>
			<%=bundle.getString("label.schedule.timetable1")%>
			</td>
		</tr>
		<tr>
			<td bgcolor="#95B3D7" class=tablebold align=center>
				<%=bundle.getString("label.schedule.standard1")%>
			</td>
			<td bgcolor="#95B3D7" class=tablebold align=center>
				<%=bundle.getString("label.schedule.subject1")%>
			</td>
			<td bgcolor="#95B3D7" class=tablebold align=center>
			<%=bundle.getString("label.schedule.lesson1")%>
			</td>	
			<td bgcolor="#95B3D7" class=tablebold align=center>
			<%=bundle.getString("label.schedule.subjectallotment")%>
			</td>
			<td bgcolor="#95B3D7" class=tablebold align=center>
			<%=bundle.getString("label.schedule.timetable1")%>
			</td>
		</tr>
		
		
		<%
		if(consoReportList.size()!=0)
		{
			for(int i=0;i<consoReportList.size();i++)
			{
				String stdfontColor = "#FDE9D9";
				String subfontColor = "#FDE9D9";
				String lesfontColor = "#FDE9D9";
				String feefontColor = "#FDE9D9";
				String suballfontColor = "#FDE9D9";
				String timefontColor = "#FDE9D9";
				
				HashMap consoMap = (HashMap)consoReportList.get(i);

				String stdSchedStatus = (String)consoMap.get("stdstatus");
				String subSchedStatus = (String)consoMap.get("substatus");
				String lesonSchedStatus = (String)consoMap.get("lesstatus");
				String feeSchedStatus = (String)consoMap.get("feestatus");
				//String subAllotStatus = (String)consoMap.get("suballstatus");
				//String timeSchedStatus = (String)consoMap.get("timestatus");
				
				String subAllotStatus = "";
				String timeSchedStatus = "No";
				subAllotStatus = reportQuery.getSubjectAllotStatus((String)consoMap.get("standardscheduleid"));
				
				if(lesonSchedStatus=="Get" || lesonSchedStatus.equals("Get"))
					lesonSchedStatus = reportQuery.getLessonSchedule((String)consoMap.get("standardscheduleid"));
				
				//if(timeSchedStatus=="Get" || timeSchedStatus.equals("Get"))
				if(subAllotStatus=="Yes" || subAllotStatus.equals("Yes"))
					timeSchedStatus = reportQuery.getTimetableSchedule((String)consoMap.get("standardscheduleid"));

				if(stdSchedStatus == "Yes" || stdSchedStatus.equals("Yes"))
					stdfontColor = "#D7E4BC";
				
				if(subSchedStatus == "Yes" || subSchedStatus.equals("Yes"))
					subfontColor = "#D7E4BC";
				
				if(lesonSchedStatus == "Yes" || lesonSchedStatus.equals("Yes"))
					lesfontColor = "#D7E4BC";
				
				if(feeSchedStatus == "Yes" || feeSchedStatus.equals("Yes"))
					feefontColor = "#D7E4BC";
				
				if(subAllotStatus == "Yes" || subAllotStatus.equals("Yes"))
					suballfontColor = "#D7E4BC";
				
				if(timeSchedStatus == "Yes" || timeSchedStatus.equals("Yes"))
					timefontColor = "#D7E4BC";
				
				if(consoMap.get("groupname")==null)
					out.print("<tr><td>&nbsp;&nbsp;"+consoMap.get("standardname")+"</td><td bgcolor='"+stdfontColor+"' align=center>"+consoMap.get("stdstatus")+"</td><td bgcolor='"+subfontColor+"' align=center>"+consoMap.get("substatus")+"</td><td bgcolor='"+lesfontColor+"' align=center>"+lesonSchedStatus+"</td><td  bgcolor='"+feefontColor+"' align=center>"+consoMap.get("feestatus")+"</td><td  bgcolor='"+suballfontColor+"' align=center>"+subAllotStatus+"</td><td bgcolor='"+timefontColor+"' align=center>"+timeSchedStatus+"</td></tr>");
				else
					out.print("<tr><td>&nbsp;&nbsp;"+consoMap.get("standardname")+" - "+consoMap.get("groupname")+"</td><td bgcolor='"+stdfontColor+"' align=center>"+consoMap.get("stdstatus")+"</td><td bgcolor='"+subfontColor+"' align=center>"+consoMap.get("substatus")+"</td><td bgcolor='"+lesfontColor+"' align=center>"+lesonSchedStatus+"</td><td  bgcolor='"+feefontColor+"' align=center>"+consoMap.get("feestatus")+"</td><td  bgcolor='"+suballfontColor+"' align=center>"+subAllotStatus+"</td><td bgcolor='"+timefontColor+"' align=center>"+timeSchedStatus+"</td></tr>");
			}
		}
		else
		{
			out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
		}
		%>
	</table>
			<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
<input type='hidden' name='standardpublishid'>
<input type='hidden' name='req_termfeesid'>
<input type='hidden' name='req_termfeesname'>
<input type='hidden' name='req_termfeesamount'>
<input type='hidden' name='req_duedate'>
<input type='hidden' name='standardnamegp'>

<input type='hidden' name='req_boardname' value='<%=boardName%>'>
<input type='hidden' name='req_sessionid' value='<%=sessionid%>'>
<input type='hidden' name='req_boardid' value='<%=boardid%>'>






  	</td>
 						</table></td><td></td></tr>

						</table>

	<!-- <a href="#" class="bt_green" onclick="navAction()"><span class="bt_green_lft"></span><strong>Admit</strong><span class="bt_green_r"></span></a> 
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>-->
     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>