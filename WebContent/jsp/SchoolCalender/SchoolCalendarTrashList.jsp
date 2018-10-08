<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
		
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
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



function editfun(id)
{
	
	document.f1.calendar_typeid.value=id;
	document.f1.action="SchoolCalendarEdit.jsp"
	document.f1.submit();

	
}


function manipulateFun(obj,id)
{
var flage=obj.getAttribute("flage");

if(obj.getAttribute("sessionstatus")!="R")
{
if (flage=="restore")
{

	    if(confirm("Do you want to Restore the Event...?"))
	    {
		document.f1.mode_of_operation.value = "manipulateActive";
		document.f1.calendar_typeid.value=id;
	
		document.f1.action = "calendaractivity.jsp";
		document.f1.submit();
		}
}
else if(flage=="delete")
{

			if(confirm("Do you want to Delete the Event...?"))
			{
			document.f1.mode_of_operation.value = "manipulateDelete";
			document.f1.calendar_typeid.value=id;
		
			document.f1.action = "calendaractivity.jsp";
			document.f1.submit();
			}
}

}
else
{
alert("Current Event is Archival Year so u can't Active");

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

    <h2> <%=bundle.getString("label.schoolcalendar.trashlistrootpath") %></h2>
<form name="f1" action="" method="post">
 <TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
	<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.schoolcalendar.selectedinformation") %> </th>
  	        	<th scope="col" class="rounded" width="10%" align="center"> </th>
       <th scope="col" class="rounded-q4" width="65%"align="center"> </th>
        	
            
        </tr>
         <tr>
				<td class="tablebold"><%=bundle.getString("label.schoolcalendar.academicsession") %></td>
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
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schoolcalendar.eventdate") %></th>
            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schoolcalendar.eventdescription") %></th>
           <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schoolcalendar.dateofcreation") %></th>
                       <th scope="col" class="rounded" width="12%"><%=bundle.getString("label.schoolcalendar.delete") %></th>
                        <th scope="col" class="rounded-q4" width="12%"><%=bundle.getString("label.schoolcalendar.restore") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<%

	ArrayList eventList = query_object.eventListTrashList(instituteBean);
		int inc =1;
		String temp_total  = "";
		String status_ori = null;
		String[] count=null;
		if(eventList.size() > 0)
		{
		for(int s=0;s<eventList.size();s++)
		{
			HashMap map=(HashMap)eventList.get(s);
			String calendarid=(String)map.get("schoolcalendarid");
			String eventdescription=(String)map.get("eventdescription");
			String eventdate=(String)map.get("newdates");
			String newdates1=(String)map.get("newdates1");

			String status=(String)map.get("calendarstatus");
			String sessionstatus=(String)map.get("sessionstatus");

		


			out.println("<tr class=tablelight valign='top'><td>"+(inc++)+"</td>");
			out.println("<td>"+eventdate+"</td>");
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
			out.println("<td>"+newdates1+"</td>");
			if(sessionstatus.equals("R"))
			{
				out.println("<td  class=tablebold>Archival</td>");
			}
			else
			{
			out.println("<td  class=tablebold><font color=blue> <a val='"+eventdescription+"' href=#cld  sessionstatus='"+(String)map.get("sessionstatus")+"' flage='delete' onclick=manipulateFun(this,'"+calendarid+"')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a></font> <input type=hidden name=check"+inc+" content_id='"+calendarid+"' id='"+inc+"' class=tabledivison onclick=checkfun(this.id,this.checked)><input type=hidden name=hide_check>");
			out.println("<td  class=tablebold><font color=blue> <a val='"+eventdescription+"' href=#cld  sessionstatus='"+(String)map.get("sessionstatus")+"' flage='restore' onclick=manipulateFun(this,'"+calendarid+"')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /> <input type=hidden name=check"+inc+" content_id='"+calendarid+"' id='"+inc+"' class=tabledivison onclick=checkfun(this.id,this.checked)><input type=hidden name=hide_check>");
			}
		}
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td colspan=6 align=center class=tablebold>Data not found</td></tr>");
	}

	%>
	</tr>
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
<input type=hidden name=req_sessionname value="<%=req_sessionname%>">
    
    </thead>
</table>


     <a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.schoolcalendar.back")%></strong><span class="bt_blue_r"></span></a>
 
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