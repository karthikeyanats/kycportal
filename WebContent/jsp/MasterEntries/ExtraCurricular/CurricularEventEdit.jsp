<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularevent.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function updatefun()
{
	document.curricularevententryform.action="CurricularEventSubmit.jsp";
	document.curricularevententryform.submit();
}

function checkNames(obj)
{
var date = new Date();
  	 var url = "checkDuplicate.jsp?tabname=extracuriculaereventupdateupdate&fieldname1="+document.curricularevententryform.eventname.value+"&reqcurricularcategoryid="+document.curricularevententryform.curriculareventid.value+"&reqcategoryids="+document.curricularevententryform.reqcategoryids.value+"&date="+date;
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var)
{
	   var fromarray=new Array();
       var toarray=new Array();
		
			var rootObj=parseXML.getElementsByTagName("complaintdetails");
			var cNode_1=rootObj.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
				
				
					if(temp=="true")
						{
							alert("Event Name already exists");
							document.curricularevententryform.eventname.focus();
							return false;
						}
					else
						{
							updatefun();
						}
				
	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.curricularevent.updaterootpath") %></h2>
<form name="curricularevententryform" action="" method="post">


<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>

<%
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

String instituteid= null;
ArrayList eventCategoryList = null;
ArrayList sessionList = null;
String today				= DateTime.showTime("calendar");
String reqeventid = "";
String reqcategoryids="";
String yearofsession_temp ="";
String curricularcategory_temp ="";
try
{
	
	
	 yearofsession_temp = request.getParameter("yearofsession_temp");
	 curricularcategory_temp = request.getParameter("curricularcategory_temp");

instituteid = (String)session.getValue("instituteid");
reqeventid = request.getParameter("reqcurriculareventid");
reqcategoryids= request.getParameter("extracurricularcategoryid");
eventCategoryList = extraCurricularQuery.evenListforEventid(reqeventid,"EventView");
}catch(Exception e){}
%>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.curricularevent.SelectedInformation") %></th>
	       <th scope="col" class="rounded-q4" width="20%" > </th>
        </tr>
        <table width=100% border=0 id="rounded-corner">
        
         <tr> 
				<td class="tablebold" width=35%><%=bundle.getString("label.curricularevent.AcademicSession") %> </td>
				<td class=tablebold>:</td>
				<td class="tablelight" ><%= yearofsession_temp%></td>
		</tr>
				<tr>
				<td class="tablebold"><%=bundle.getString("label.curricularevent.CurricularCategory") %></td>
				<td class=tablebold>:</td>
				<td class="tablelight" ><%= curricularcategory_temp%></td>
			</tr>
    
    
    </table>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
  
    <br><br>
    
    
    

<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="30%"><%=bundle.getString("label.curricularevent.EventDetails") %></th>
        	<th scope="col" class="rounded" width="20%"></th>
        	<th scope="col" class="rounded-q4" width="20%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td> 
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td colspan=3>
		<table border=0 cellpadding=0 cellspacing=0 width="100%">
		<%
		 if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
 		 			HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(0);
					String eventname      = (String)eventCategoryListMap.get("curriculareventname");
					String eventdate      = (String)eventCategoryListMap.get("eventdate");
					String eventvenue      = (String)eventCategoryListMap.get("venu");
				
		%>
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.EventName") %></td>
		<td class=tablebold>:</td>
		<td><input type=text name="eventname" value="<%=eventname %>" size="50"  maxlength="150"/></td></tr>
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.Venue") %></td>
		<td class=tablebold>:</td>
		<td><input type=text name="eventvenue" value="<%=eventvenue %>"  size="50"  maxlength="150"/></td></tr>
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.EventDate") %></td>
		<td class=tablebold>:</td>
		<td><input type=text name="eventdate" value="<%=eventdate %>" onfocus='this.blur()'/><input type='button' value='^' onclick=Calendar_Fun('<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html','curricularevententryform.eventdate','0',event,'Not_Less_Than_CurrentDate',curricularevententryform.todaydate)></td></tr>
		<% }%>
			
		</table>
		
	</td>
	</tr>

	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	 
		 <a href="./CurricularEventList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularevent.BacktoEventList") %></strong><span class="bt_blue_r"></span></a>
	
		 	 <a href="#" onclick="checkNames(this)" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularevent.UpdateEventDetails") %></strong><span class="bt_green_r"></span></a>
	
	 
     	<input type=hidden name=reqcategoryid/>
		<input type=hidden name=reqsessionid>
			<input type=hidden name="reqstatus">
		<input type=hidden name="curriculareventid" value="<%=reqeventid %>">
		 <input type='hidden' name='todaydate' 	value='<%=today %>'/>
		 <input type=hidden name=eventoperation value="UpdateEvent">
		 <input type=hidden name="reqcategoryids" value="<%=reqcategoryids %>">
		 
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>