<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularevent.trashpreviewtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function updatefun()
{
if(confirm("Do you want to Trash the Curricular Event...?"))
	{
	document.curricularevententryform.action="CurricularEventSubmit.jsp";
	document.curricularevententryform.submit();
	}
	else
	{}
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

    <h2><%=bundle.getString("label.curricularevent.trashpreviewrootpath") %></h2>
<form name="curricularevententryform" action="" method="post">
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>

<%
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

String instituteid= null;
ArrayList eventCategoryList = null;
ArrayList eventtrackList = null;
String reqeventid = "";
String yearofsession_temp ="";
String curricularcategory_temp ="";
try
{
	 yearofsession_temp = request.getParameter("yearofsession_temp");
	 curricularcategory_temp = request.getParameter("curricularcategory_temp");
instituteid = (String)session.getValue("instituteid");
reqeventid = request.getParameter("reqcurriculareventid");
eventCategoryList = extraCurricularQuery.evenListforEventid(reqeventid,"EventView");
eventtrackList = extraCurricularQuery.evenListforEventid(reqeventid,"eventrack");
}catch(Exception e){}
%>

 <table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr>
<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.curricularevent.SelectedInformation") %></th>
  	        	<th scope="col" class="rounded" width="20%" align="center"> </th>
  	        	  	        	<th scope="col" class="rounded" width="20%" align="center"> </th>
  	        	
       <th scope="col" class="rounded-q4" width="40%"align="center"> </th>
        	
            
        </tr>
         <tr> 
				<td class="tablebold"><%=bundle.getString("label.curricularevent.AcademicSession") %> :</td>
				<td class="tablelight" colspan=1><%= yearofsession_temp%></td>
				<td class="tablebold"><%=bundle.getString("label.curricularevent.CurricularCategory") %> :</td>
				<td class="tablelight" colspan=1><%= curricularcategory_temp%></td>
			</tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
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

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="60%"><%=bundle.getString("label.curricularevent.EventDetails") %> </th>
        	<th scope="col" class="rounded" width="40%"></th>
        	<th scope="col" class="rounded-q4" width="40%"></th>
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
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.EventName") %></td><td><%=eventname %></td></tr>
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.Venue") %></td><td><%=eventvenue %></td></tr>
		<tr><td class=tablebold><%=bundle.getString("label.curricularevent.EventDate") %></td><td><%=eventdate %></td></tr>
		<% }%>
			
		</table>
		
	</td>
	</tr>

	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	 
	 
	  
    <br>
    
 

<%
	if(eventtrackList != null && eventtrackList.size() > 0)
	{
		%>
		<div class="warning_box">
               <%=bundle.getString("label.curricularevent.Trashmessage") %>
     	</div>
		<%
	}
%>
	 <a href="./CurricularEventList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularevent.BacktoEventList") %></strong><span class="bt_blue_r"></span></a>

<%if(eventtrackList == null || eventtrackList.size() == 0)
{ %>
	<a href="#" onclick="updatefun()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularevent.Trash") %></strong><span class="bt_green_r"></span></a>
	<%} %>
	 
     	<input type=hidden name=reqcategoryid/>
		<input type=hidden name=reqsessionid>
			<input type=hidden name="eventstatus" value="T">
		<input type=hidden name="curriculareventid" value="<%=reqeventid %>"/>
		 
		 <input type=hidden name=eventoperation value="UpdateEventStatus"/>
		 
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>