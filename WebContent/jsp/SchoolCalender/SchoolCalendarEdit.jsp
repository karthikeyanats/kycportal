<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.schoolcalendar.entrytitle") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">     
    

function backfun()
{
	document.f1.action="SchoolCalendarView.jsp";
	document.f1.submit();
}


function callDate(obj)
{
 	if(document.f1.eventdate.length>0)
	 {
 		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html',"f1.eventdate["+obj.id+"]",'0','Not_Less_Than_CurrentDate',document.f1.server_date);
	 }
	 else
	 {
		 Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html',"f1.eventdate",'0','Not_Less_Than_CurrentDate',document.f1.server_date);
	 }
}

function updatefun()
{
if(document.f1.radiobut.checked)
{
	document.f1.holiday_status.value = "Y";

}
else
{
	document.f1.holiday_status.value = "N";

}
	document.f1.mode_of_operation.value = "update";



	document.f1.action = "calendaractivity.jsp";
	document.f1.submit();


}
</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
String date_str="";
String req_sessionname = "";
String req_sessionid = request.getParameter("req_sessionid");
 req_sessionname = request.getParameter("req_sessionname");
String calenderidvalue = request.getParameter("calendar_typeid");
date_str = datebeans.showTime("calendar");

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


    <h2><%=bundle.getString("label.schoolcalendar.editrootpath") %></h2>
<form name="f1" action="" method="post">
 <input type="hidden" name="holiday_status" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
<tr>
	<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.schoolcalendar.selectedinformation") %></th>
  	        	<th scope="col" class="rounded" width="10%" align="center"> </th>
       <th scope="col" class="rounded-q4" width="65%"align="center"> </th>
        	
            
        </tr>
         <tr>
				<td class="tablebold"><%=bundle.getString("label.schoolcalendar.academicsession") %> </td>
				<td class="tablebold">:</td>
				<td class="tablelight" ><%= req_sessionname%></td>             
			</tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
    </td>
    </tr>
   </table>
    <br><br>
    	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.schoolcalendar.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">
 <thead>   
     <tbody>
     	<%
	instituteBean.setSchoolcalendarid(calenderidvalue);
	ArrayList calederlist = (ArrayList)query_object.getCalendarListForEdit(instituteBean);

		String temp_total  = "";
		String status_ori = null;
		String calendarid="";
		String holidaystatus="";
		String sessionstatus="";
		sessionstatus=request.getParameter("sessionstatus");
		if(calederlist.size() > 0)
		{     
		for(int s=0;s<calederlist.size();s++)
		{
			HashMap map=(HashMap)calederlist.get(s);
			 calendarid=(String)map.get("schoolcalendarid");
			String eventdescription=(String)map.get("eventdescription");
			String eventdate=(String)map.get("newdates");

			String status=(String)map.get("calendarstatus");
			 holidaystatus=(String)map.get("holidaystatus");
		
	
	%>
     
				<tr>
					<td colspan=3 class="tablebold"><%=bundle.getString("label.schoolcalendar.eventdate") %></td>
						<td width="1%" class="tablebold">:</td>
						<td>
						<input type=text name="eventdate" value="<%=eventdate%>" onkeydown=this.blur()>&nbsp;&nbsp;
						<input type="button" class="tablehead"  value="^" onclick="document.f1.eventdate.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.eventdate','0',event,'Not_Less_Than_CurrentDate',document.f1.server_date);">
						
						</input></td>
						</tr>
						<tr>
					<td colspan=3 class="tablebold"><%=bundle.getString("label.schoolcalendar.description") %></td>
					<td width="1%" class="tablebold">:</td>
						<td class=tablelight><input type=text name="eventdescription" maxlength=100 size=75 value="<%=eventdescription%>" size="40">
					
					</td>
					</tr>
					<tr>
					<td  class="tablebold" colspan=3><%=bundle.getString("label.schoolcalendar.holiday") %>
					</td>
					<td width="1%" class="tablebold">:</td>
					<td >
					<%
					if(holidaystatus.equals("Y"))
					{
					out.println("<input type=checkbox name=radiobut value=''  checked >");
					
					}
					else if(holidaystatus.equals("N"))
					{ 
					out.println("<input type=checkbox name=radiobut value='' >");
					
					} %>       
		</td>
		</tr>
					
					
					
			<%

		}
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td colspan=5 class=tablebold>Data not found</td></tr>");
	}

	%>
	
	 </tbody>
</table>
     <a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.schoolcalendar.backtoschoolcalandarview") %> </strong><span class="bt_blue_r"></span></a>

 <a href="#" class="bt_green" id='check'  tablename='maintab' class'=tablelight' onclick=updatefun()><span class="bt_green_lft"></span><strong><%=bundle.getString("button.schoolcalendar.update") %></strong><span class="bt_green_r"></span></a>
	
</table>



	<input type="hidden" name="server_date" value="<%=date_str%>">
	<input type="hidden" name="req_state" value="">
	<input type=hidden name=mode_of_operation>
	<input type=hidden name=flag_state>
	<input type=hidden name=status>
	<input type=hidden name=calendar_typeid value="<%= calenderidvalue%>">



	<input type=hidden name=req_sessionid value="<%=req_sessionid%>">
    	<input type=hidden name=req_sessionname value="<%=req_sessionname %>">
    
    </thead>
</table>


 
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