<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - PDF Report Index View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel=stylesheet href="<%=request.getContextPath() %>/css/jquerystyle.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenufun.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<script type="text/javascript">

function goBack()
{
		document.ApplicantSearch.action="PDFReportIndex.jsp";
		document.ApplicantSearch.submit();
}
function stdSchd()
{
		document.ApplicantSearch.action="./StandardSchedule.jsp";
		document.ApplicantSearch.submit();
}
function studList()
{
		document.ApplicantSearch.action="./StudentReportPDF.jsp";
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
		document.ApplicantSearch.action="./FeesReportPDF.jsp";
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
		document.ApplicantSearch.action="./ExamReportPDF.jsp";
		document.ApplicantSearch.submit();
}

function schoolSchd()
{
		document.ApplicantSearch.action="./SchoolCalendarView.jsp";
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



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>PDF Reports</h2>
   <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>

  
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
        	<th scope="col" class="rounded-company" width="40%">Selected Information</th>
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
	<tr>
	<td class=tablebold align=center width=40%>
		Academic Year </td>
		<td  align=left width=60%>
		<%=request.getParameter("req_sessionname") %>
		</td>	
		<td></td>
	</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td valign=top class='tablebold' align=center>Archival Details</td><td valign=top class='tablelight' align=left><h2>This is an Archived Year</h2></td><td></td></tr>");	
	}
	%>
    	<% 
	     }catch(Exception e){}
		%>   
    
    	
    </tbody>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="40%">Create PDF For</th>
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
		<!--  <div align="left" id="stdSched"  onclick="stdSchd()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Standard Scheduled </a></p>
		</div>-->
		<div align="left" id="studList"  onclick="studList()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Student List </a></p>
		</div>
		<div align="left" id="studList"  onclick="feeReport()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Fees Report </a></p>
		</div>		
		<div align="left" id="studList"  onclick="examResult()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Mark List </a></p>
		</div>
		<!--<div align="left" id="stdSched"  onclick="staffAllot()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Staff Allotted </a></p>
		</div>
		<div align="left" id="stdSched"  onclick="timeTable()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >Time Table </a></p>
		</div>
				
		<p class="menu_head" align="left"><a href="javascript:void(0)">Fees</a></p>
		<div class="menu_body" style="width:200px" align="left">
			<a href="#" onclick=feeStruct()><font color="#000080">Fees Structure</font></a>
			<br>
         	<a href="#" onclick=feeReport()><font color="#000080">Fees Report</font></a>
		</div>
		<p class="menu_head" align="left"><a href="javascript:void(0)">Exam</a></p>
		<div class="menu_body" style="width:200px"  align="left">
			<a href="#" onclick=examName()><font color="#000080">Exam Name</font></a>
			<br>
         	<a href="#" onclick=onclick=examSchd()><font color="#000080">Exam Schedule</font></a>
         	<br>
         	<a href="#" onclick=onclick=examResult()><font color="#000080">Result</font></a>
		</div>
		<div align="left" id="stdSched"  onclick="schoolSchd()" class="menu_list" style="width:200px">
		<p class="menu_head" ><a href="#" >School Calendar </a></p>
		</div>-->		
  </div>  <!--Code for menu ends here-->
</div>
</td></tr>


</tbody>
	</table>
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>	

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>


</form>


</body>

</html>