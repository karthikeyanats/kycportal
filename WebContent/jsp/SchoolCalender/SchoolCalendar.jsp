<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.schoolcalendar.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function checkfun(idval,flag)
{
	if(flag)
	{
		if(check_ForParticularElements(document.f1.eventdate[idval],"textarea",document.f1.eventdescription[idval],"textarea"))
		{
	
		document.f1.eventdate[idval].disabled=true;
		document.f1.eventdescription[idval].disabled=true;
		
		}
		else
		{
			document.f1.eventdate[idval].focus();
			document.f1.chk[idval].checked=false;
		}
	
	
	}
	else
	{
			document.f1.eventdate[idval].disabled=false;
			document.f1.eventdescription[idval].disabled=false;
	}


}
function checkfunradio(id,aaa)
{
	if(document.f1.radiobut[id].checked)
	{
	document.f1.radiobut_hidden[id].value="Y";
	}
	else
	{
	document.f1.radiobut_hidden[id].value="N";
	}

}


function backfun()
{
	document.f1.action="SchoolCalenderEntry.jsp";
	document.f1.submit();
}

function submitFun()
{
var flage_temp=false;
	for(var v=0;v<document.f1.chk.length;v++)
	{  
		if(document.f1.chk[v].checked==true)
		{
		flage_temp=true;
		}
	}


if(flage_temp)
{
	for(var i=0;i<document.f1.radiobut.length;i++)
	{
	
	if(document.f1.radiobut[i].checked)
	{
	document.f1.radiobut_hidden[i].value="Y";
	}
	else
	{
	document.f1.radiobut_hidden[i].value="N";
	}
	}
	
	
	for(var k=0;k<document.f1.chk.length;k++)
	{
		if(document.f1.chk[k].checked==true)
		{
		document.f1.eventdescription[k].disabled=false;
		document.f1.eventdate[k].disabled=false;
		}
		else
		{
		document.f1.chk[k].disabled=true;
		document.f1.eventdescription[k].disabled=true;
		document.f1.eventdate[k].disabled=true;
		
		
		}
	}
	document.f1.action="SubmitCalendar.jsp";
	document.f1.submit();
}
else
{
alert("Select any one option");
}
	
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

</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap" %>
<%
String date_str="";
	String req_sessionid = "";
	req_sessionid=request.getParameter("req_sessionid");
	String req_sessionname = request.getParameter("req_sessionname");
	 date_str = datebeans.showTime("calendar");
%>
<%@ page import="java.util.*"%>


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

    <h2><%=bundle.getString("label.schoolcalendar.insertrootpath") %></h2>
<form name="f1" action="" method="post">
  <input type="hidden" name="req_sessionname" value="<%=req_sessionname %>"> 
  	<input type="hidden" name="server_date" value="<%=date_str%>">
   
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
            <th scope="col" class="rounded" width="30%"  colspan="2"><%=bundle.getString("label.schoolcalendar.eventdate") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.schoolcalendar.eventdescription") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schoolcalendar.holiday") %></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.schoolcalendar.select") %></th>
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
	int inc =1;
	for(int x=0;x<10;x++)
	{
		out.println("<tr id='tabs"+x+"'><td class=tablelight align=center>"+inc+"</td>");
		%>
		<td >
			<input type=text name=eventdate class=tablelight size="10" onkeydown=this.blur() ></input></td>
					<td >
			<input type="button" class="tablehead" id=<%=x%> value="^" onclick="document.f1.eventdate.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.eventdate[<%=x%>]','0',event,'Not_Less_Than_CurrentDate',document.f1.server_date);">
		</td>
		<td width="40%">
			<input type=text maxlength="100" name=eventdescription size=50 class=tablelight>
		</td>
		<td width="10%">
			<input type=checkbox name=radiobut value="N" id=<%=x%> class=tabledivision  onclick=checkfunradio(this.id,checked);>
			<input type=hidden name=radiobut_hidden value="N">
		</td>
		<td width="10%">
			<input type=checkbox name=chk id=<%=x%> class=tabledivision onclick=checkfun(this.id,checked);>
		</td>
		</tr>
		<%inc++;
	}
	%>
	</tr>
</table>
<br>


		</td>
		</tr>
	</table>
	<input type="hidden" name="req_state" value="">
     
    </thead>
</table>
     <a href="#" class="bt_blue" onclick="backfun()" ><span class="bt_blue_lft" ></span><strong><%=bundle.getString("button.schoolcalendar.back") %></strong><span class="bt_blue_r" ></span></a>

     <a href="#" class="bt_green" value="" onclick="submitFun()" ><span class="bt_green_lft"></span><strong><%=bundle.getString("button.schoolcalendar.submitevent") %></strong><span class="bt_green_r"></span></a>

        <input type=hidden name=standardname value="">
        <input type=hidden name=sectionname value="">
        <input type=hidden name=subjectname value="">
        <input type=hidden name=req_sessionid value="<%=req_sessionid %>">
                
        
    
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