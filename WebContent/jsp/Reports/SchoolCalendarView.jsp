<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - School Calendar | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">


function backfun()
{
	document.f1.action="ReportIndexView.jsp";
	document.f1.submit();
}
	function printfun()
	{
	window.open("PrintPreviewSchoolcalender.jsp?&req_sessionname="+document.f1.req_sessionname.value+"&req_sessionid="+document.f1.req_sessionid.value+"&req_sessionstatus="+document.f1.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}

function appIssueCalendar(issue){
	Calendar_Fun('../../js/Calendar/CalendarWindow.html','f1.appIssueDate','0',event,'Not_Less_Than_CurrentDate',this)
}

function appLastDates(last){
	Calendar_Fun('../../js/Calendar/CalendarWindow.html','f1.appLastDate','0',event,'Not_Less_Than_CurrentDate',this)
}

function searchFun()
{
	if(document.f1.appIssueDate.value =="")
	{
		alert("From date should not be empty");
		document.f1.appIssueDate.focus();
		return false;
	}

	if(document.f1.appLastDate.value =="")
	{
		alert("To date should not be empty");
		document.f1.appLastDate.focus();
		return false;
	}

	if(document.f1.rado[0].checked)
	{
		document.f1.req_state.value ="DayCollege";
	}
	else if(document.f1.rado[1].checked)
	{
		document.f1.req_state.value ="Evening College";
	}
	else if(document.f1.rado[2].checked)
	{
		document.f1.req_state.value ="both";
	}
	document.f1.action="Applicantsearchresult.jsp";
	document.f1.submit();
}
function getReport()
{
	if(document.f1.appIssueDate.value =="")
	{
		alert("From date should not be empty");
		document.f1.appIssueDate.focus();
		return false;
	}

	if(document.f1.appLastDate.value =="")
	{
		alert("To date should not be empty");
		document.f1.appLastDate.focus();
		return false;
	}

	if(document.f1.rado[0].checked)
	{
		document.f1.req_state.value ="DayCollege";
	}
	else if(document.f1.rado[1].checked)
	{
		document.f1.req_state.value ="Evening College";
	}
	else if(document.f1.rado[2].checked)
	{
		document.f1.req_state.value ="both";
	}
	document.f1.action="ApplicationDatewisereport.jsp";
	document.f1.submit();
}


function editfun(obj,id)
{
	if(obj.getAttribute("sessionstatus")!="R")
{
if(confirm("Do you want to Edit the Event"))
{  
	  document.f1.sessionstatus.value=obj.getAttribute("sessionstatus");
	document.f1.calendar_typeid.value=id;
	document.f1.action="SchoolCalendarEdit.jsp"
	document.f1.submit();

	
} 
else
{}
}
else
{
alert("Current Event is Archival Year so u can't Edit");

}
}


function manipulateFun(obj,id)
{
	
if( obj.getAttribute("sessionstatus")!="R")
{
if(confirm("Do you want to Trash the Event"))
{
	  document.f1.sessionstatus.value=obj.getAttribute("sessionstatus");

	document.f1.mode_of_operation.value = "manipulate";
	document.f1.calendar_typeid.value=id;

	document.f1.action = "calendaractivity.jsp";
	document.f1.submit();
}
else     
{}
} 
else
{
alert("Current Event is Archival Year so u can't trash");

}
}




</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
String req_sessionid = request.getParameter("req_sessionid");
//out.println(req_sessionid);
String req_sessionname = request.getParameter("req_sessionname");
	instituteBean.setSessionid(req_sessionid);
String instituteid=(String)session.getValue("instituteid");
instituteBean.setinstituteid(instituteid);
%>
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

    <h2>Reports / Session wise Report / School Calendar</h2>
    
    
<form name="f1" action="" method="post">
 <input type="hidden" name="sessionstatus" value="">

 
 <table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%">Selected Information</th>
            <th scope="col" class="rounded-q4" width="10%"></th>
            
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
	<table width=100%><tr>
	<td class=tablebold align=center width=40%>
		Academic Year </td>
		<td width=1% class=tablebold>:</td>
		<td  align=left width=60%>
		<%=request.getParameter("req_sessionname") %>
		</td>	
		</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	out.print("<tr><td valign=top class='tablebold' align=center>Archival Details</td><td width=1% class=tablebold>:</td><td valign=top class='tablelight' align=left><h2>This is an Archived Year</h2></td><td></td></tr>");	
	}
	%>
	</table></td></tr>
     	
    </tbody>
</table>
<br>

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>


 

<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="30%">Event Date</th>
            <th scope="col" class="rounded-q4" width="35%">Event Description</th>
             <!-- <th scope="col" class="rounded-q4" width="25%">Date Of Creation</th>
            <th scope="col" class="rounded" width="15%">Edit</th>
            <th scope="col" class="rounded-q4" width="15%" >Trash</th>-->
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
		
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
			
			if(eventdescription=="" || eventdescription.equals(""))
				eventdescription ="-";
			
			out.println("<tr class=tablelight><td>"+(inc++)+"</td>");
			out.println("<td class=tableligh>"+eventdate+"</td>");
			out.println("<td class=tableligh>"+eventdescription+"</td>");
			//out.println("<td class=tableligh>"+newdates1+"</td>");

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
	
	 </tbody>
</table>

</td>
</tr>

	</table>
	<input type="hidden" name="server_date" value="">
	<input type="hidden" name="req_state" value="">
	<input type=hidden name=mode_of_operation>
	<input type=hidden name=flag_state>
	<input type=hidden name=status>
	<input type=hidden name=calendar_typeid>


	<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
	<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
	<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>
    
    </thead>
</table>
     <a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
     
		<%if(eventList.size() > 0){%> 
				<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
		<%} %>     


 
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>