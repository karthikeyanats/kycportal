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
<title>Know Your Child - <%=bundle.getString("label.schoolcalendar.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>    
<script type="text/javascript">


function backfun()
{
	document.f1.action="SchoolCalenderEntry.jsp";
	document.f1.submit();
}


function editfun(obj,id)
{
	if(obj.getAttribute("sessionstatus")!="R")
{
if(confirm("Do you want to Update the Event...?"))
{  
	  document.f1.sessionstatus.value=obj.getAttribute("sessionstatus");
	document.f1.calendar_typeid.value=id;
	document.f1.action="SchoolCalendarEdit.jsp"
	document.f1.submit();

	
} 

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
if(confirm("Do you want to Trash the Event...?"))
{
	  document.f1.sessionstatus.value=obj.getAttribute("sessionstatus");

	document.f1.mode_of_operation.value = "manipulate";
	document.f1.calendar_typeid.value=id;

	document.f1.action = "calendaractivity.jsp";
	document.f1.submit();
}

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

    <h2><%=bundle.getString("label.schoolcalendar.viewrootpath") %></h2>
<form name="f1" action="" method="post">
 <input type="hidden" name="sessionstatus" value="">
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
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schoolcalendar.slno") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schoolcalendar.eventdate") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.schoolcalendar.eventdescription") %></th>
             <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.schoolcalendar.dateofcreation") %></th>
              <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schoolcalendar.holidaystatus") %></th>
              <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schoolcalendar.edit") %></th>
              <th scope="col" class="rounded-q4" width="15%" ><%=bundle.getString("label.schoolcalendar.trash")%></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
		
	<%
	
	
	ArrayList eventList = query_object.eventList(instituteBean);
		int inc =1;
		String[] count=null;
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
			String holidaystatus=(String)map.get("holidaystatus");
			String status=(String)map.get("calendarstatus");
			String sessionstatus=(String)map.get("sessionstatus");
			out.print("<tr class=tablelight valign='top'><td>"+(inc++)+"</td>");
			out.print("<td class=tableligh>"+eventdate+"</td>");
			
			if(eventdescription == null || eventdescription.equals("") || eventdescription.equals("-") || eventdescription.equalsIgnoreCase("null"))
			{
			
			out.print("<td class='tablelight'>-</td>");
			}
			else{
				
				   count=eventdescription.split(" ");
					if((count.length-1)>15)
					{
						out.print("<td class='tablelight' ");
						String des_tempnew="";
						for(int k=0;k<15;k++)
						{
							des_tempnew+=count[k]+" ";
						}%>
						<div>
						<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
					[<font color="red">More..</font>]
				</a>  
				<div class="highslide-maincontent">
					<h3></h3>
					<%=(eventdescription).replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
				</div>
					</div>
					<% }
					else
					{
						out.print("<td class='tablelight'>"+eventdescription+"</td>");

					}
					}
			out.print("<td class=tableligh>"+newdates1+"</td>");
			if(holidaystatus.equals("Y"))
			{
			out.print("<td class=tableligh>Holiday</td>");
			}
			else
			{
				out.print("<td class=tableligh>-</td>");

			}
      
			if(sessionstatus.equals("R"))
			{
				out.print("<td  class=tablebold colspan=2 >Archival</td>");
			}
			else
			{
			out.print("<td  class=tablebold><a val='"+eventdescription+"' href=#cld sessionstatus='"+(String)map.get("sessionstatus")+"' onclick='editfun(this,\""+calendarid+"\")'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.schoolcalendar.edit")+"' border=0 /></a> </td>");
			out.print("<td class=tablebold><a val='"+eventdescription+"' href=#cld  sessionstatus='"+(String)map.get("sessionstatus")+"' onclick='manipulateFun(this,\""+calendarid+"\")'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.schoolcalendar.trash")+"'' border=0 /></a></font> <input type=hidden name=check"+inc+" content_id='"+calendarid+"' id='"+inc+"' class=tabledivison onclick=checkfun(this.id,this.checked)><input type=hidden name=hide_check>");
		    }
			
		}
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
		//out.print("<tr><td colspan=7 align=center class=tablebold>Data not found</td></tr>");
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



	<input type=hidden name=req_sessionid value="<%=req_sessionid%>">
	<input type=hidden name=req_sessionname value="<%=req_sessionname %>">
    
    </thead>
</table>
     <a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.schoolcalendar.backtocreatecalender") %> </strong><span class="bt_blue_r"></span></a>


 
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