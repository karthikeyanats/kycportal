<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Report Index | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css"  href="<%=request.getContextPath() %>/css/jquerystyle.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenufun.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<script type="text/javascript">

function goBack()
{
		document.ApplicantSearch.action="FinanciarReportIndex.jsp";
		document.ApplicantSearch.submit();
}
function stdSchd()
{
		document.ApplicantSearch.action="./StandardSchedule.jsp";
		document.ApplicantSearch.submit();
}
function Consolidatedstudlist()
{
		document.ApplicantSearch.action="../../jsp/Principal/StandardView.jsp";
		document.ApplicantSearch.submit();
}
function studList()
{
		document.ApplicantSearch.action="./StudentReport.jsp";
		document.ApplicantSearch.submit();
}
function staffAllot()
{
		document.ApplicantSearch.action="./SubjectAllotment.jsp";
		document.ApplicantSearch.submit();
}

function timeTable()
{
		document.ApplicantSearch.action="./ScheduleSelect.jsp";
		document.ApplicantSearch.submit();
}

function feeStruct()
{
		document.ApplicantSearch.action="./FeesStructureSelect.jsp";
		document.ApplicantSearch.submit();
}

function feeReport()
{
		document.ApplicantSearch.action="./PendingList_pre.jsp";
		document.ApplicantSearch.submit();
}

function examName()
{
		document.ApplicantSearch.action="./ExamnameView.jsp";
		document.ApplicantSearch.submit();
}

function examSchd()
{
		document.ApplicantSearch.action="./ExamView.jsp";
		document.ApplicantSearch.submit();
}

function examResult()
{
		document.ApplicantSearch.action="./ExamMarkResult.jsp";
		document.ApplicantSearch.submit();
}

function schoolSchd()
{
		document.ApplicantSearch.action="./SchoolCalendarView.jsp";
		document.ApplicantSearch.submit();
}

function commReprt()
{
		document.ApplicantSearch.action="./Community/CommunityStdView.jsp";
		document.ApplicantSearch.submit();
}

function relReprt()
{
		document.ApplicantSearch.action="./Religion/ReligionStdView.jsp";
		document.ApplicantSearch.submit();
}



</script>

</head>
<body>
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid")%>">
<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">


<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reports")%></h2>
   <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>

  
	<%
    try
    {	
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
	
	    String instituteid = null;
	    ArrayList BoardList = null;

	 		
			//String temp=applicationQuery.receiptNo();

	    	  instituteid = (String)session.getValue("instituteid");
	    	  ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	    	  BoardList = standardQuery.listBoard(instituteid);
	    
		//out.println("temp-->"+temp);
	%>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
            <th scope="col" class="rounded-q4" width="20%"></th>
            
        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td colspan=2>
	<table width=100%>
	<tr>
	<td class=tablebold align=center width=40%>
		<%=bundle.getString("label.schedule.academicyear")%></td>
		<td width=1% class=tablebold>:</td>
		<td  align=left >
		<%=request.getParameter("req_sessionname") %>
		</td>	
		</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td class='tablebold' align=center>"+bundle.getString("label.schedule.archivaldetails")+"</td><td width=1% class=tablebold>:</td><td valign=top><h3>"+bundle.getString("label.schedule.archivalmessage1")+"</h3></td></tr>");	
	}
	%>
    	<% 
	     }catch(Exception e){}
		%>   
    </table></td></tr>
    	
    </tbody>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="40%"><%=bundle.getString("label.reports.reportsfor")%></th>
            <th scope="col" class="rounded" width="40%">&nbsp;</th>
            <th scope="col" class="rounded-q4" width="10%"></th>
            
        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>


<tr><td colspan=3 class=tablebold align=center>	
<div style="float:left" > <!--This is the first division of left-->
  <div id="firstpane"  class="menu_list"> <!--Code for menu starts here-->
	<%-- 	<div align="left" id="stdSched"  onclick="Consolidatedstudlist()" class="menu_list" style="width:200px">
		
		<p class="menu_head" ><a href="#" onclick="Consolidatedstudlist()"><%=bundle.getString("label.reports.consolidatedstudentlist")%></a></p>
		</div>
		
		<div align="left" id="stdSched"  onclick="stdSchd()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.standardscheduled")%></a></p>
		</div>
		<div align="left" id="stdSched"  onclick="studList()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.studentlist")%></a></p>
		</div>
		<div align="left" id="stdSched"  onclick="staffAllot()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.staffallotmentlist")%></a></p>
		</div>
		<div align="left" id="stdSched"  onclick="timeTable()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.timetable")%></a></p>
		</div> --%>
				
		
		<div style="width:200px" align="left">
			<a href="#" onclick=feeStruct()><font color="#000080"><%=bundle.getString("label.reports.feesstructure")%></font></a>
			<br><br>
         	<a href="#" onclick=feeReport()><font color="#000080"><%=bundle.getString("label.reports.feesreport")%></font></a>
		</div>
		<%-- <p class="menu_head" align="left"><a href="javascript:void(0)"><%=bundle.getString("label.reports.exam")%></a></p>
		<div class="menu_body" style="width:200px"  align="left">
			<a href="#" onclick=examName()><font color="#000080"><%=bundle.getString("label.reports.examname")%></font></a>
			<br>
         	<a href="#" onclick=examSchd()><font color="#000080"><%=bundle.getString("label.reports.examschedule")%></font></a>
         	<br>
         	<a href="#" onclick=examResult()><font color="#000080"><%=bundle.getString("label.reports.result")%></font></a>
		</div>
		<div align="left" id="stdSched"  onclick="schoolSchd()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.schoolcalendar")%></a></p>
		</div>
		<!-- for ATA customization hidden the community and religion links by rams dated on Aug 27, 2012 -->
		 <div align="left" id="commReprt"  onclick="commReprt()" class="menu_list" style="width:300px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.communitystudentlist")%></a></p>
		</div>
		<div align="left" id="relReprt"  onclick="relReprt()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" ><%=bundle.getString("label.reports.religionstudentlist")%></a></p>
		</div> --%>
				
  </div>  <!--Code for menu ends here-->
</div>
</td></tr>


</tbody>
	</table>
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>	

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>


</form>


</body>

</html>