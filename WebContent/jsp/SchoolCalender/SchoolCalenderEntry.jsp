<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
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
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function Insert()
{


			  if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="0")
			  {
				  alert("Select Session");
				  document.ApplicantSearch.sessionname.focus();
				  return false;
			  }

			  document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;

			  document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
			  
				  document.ApplicantSearch.action="SchoolCalendar.jsp";
				document.ApplicantSearch.submit();

}
function LoadDiary()
{

			  if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="0")
			  {
				  alert("Select Year Of Session");
				  document.ApplicantSearch.sessionname.focus();
				  return false;
			  }
  document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;

			  document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
 document.ApplicantSearch.action="SchoolCalendarView.jsp";
				document.ApplicantSearch.submit();

}
function trashfun()
{
  if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="0")
			  {
				  alert("Select Year of Session");
				  document.ApplicantSearch.sessionname.focus();
				  return false;
			  }
			  	  document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;

			  document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
	document.ApplicantSearch.action="SchoolCalendarTrashList.jsp";
	document.ApplicantSearch.submit();

}
function  loadsession(obj)
{
 document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
document.ApplicantSearch.req_sessionstatus.value=document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("sessionstatus");
	document.ApplicantSearch.submit();

}
</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
String sessionname=request.getParameter("sessionname")+"";
String req_sessionname=request.getParameter("req_sessionname")+"";

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

    <h2><%=bundle.getString("label.schoolcalendar.entryrootpath") %></h2>
<form name="ApplicantSearch" action="" method="post">
 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.schoolcalendar.entrytableheading") %></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>   
    <tr>
    <td class="tablebold"><%=bundle.getString("label.schoolcalendar.academicsession") %> </td>
    <td width="1%" class="tablebold">:</td>
    <td class="tablelight"><select name="sessionname" id="year" onchange="loadsession(this)">
    <option value="0" class="tablelight">--Select Academic Session--</option>
    <%
    String req_sessionstatus="";
    req_sessionstatus=  request.getParameter("req_sessionstatus");
    String createdby = (String)session.getValue("userid");
    String instituteid = (String)session.getValue("instituteid");
	ArrayList yearList = query_object.listYearofSession(instituteid);


											for(int s=0;s<yearList.size();s++)
											{
												HashMap map=(HashMap)yearList.get(s);
												String sessionid=(String)map.get("sessionid");
												String yearofsession=(String)map.get("sessionname");
												String session_status=(String)map.get("sessionstatus");
												if(!sessionname.equals("null") && sessionname.equals(sessionid))
												{
												out.println("<option value='"+sessionid+"' sessionstatus='"+session_status+"' selected=true class='tablelight'>"+yearofsession+"</option>");
											}
												else
												{
													out.println("<option value='"+sessionid+"' sessionstatus='"+session_status+"' class='tablelight'>"+yearofsession+"</option>");

												}
											}

	%>
    </select>
    </td>
    </tr>
  
     <tr class="tablehead">
										<td colspan="3" align="center">
										<input value="Cancel" type="hidden" class="buttons" onclick="samePage()" >
										</td>
	</tr>
        <input type=hidden name=req_sessionid value="">
<input type=hidden name=req_sessionname value="<%=req_sessionname %>">  
<input type=hidden name=req_sessionstatus value="">  

        
    
    </thead>
</table>
     <a href="#" class="bt_red" onclick="trashfun()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.schoolcalendar.trashlist") %></strong><span class="bt_red_r"></span></a>

     <a href="#" class="bt_blue" onclick="LoadDiary()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.schoolcalendar.loadexistingcalendar") %></strong><span class="bt_blue_r"></span></a>
    <%
    if(req_sessionstatus!=null && !req_sessionstatus.equalsIgnoreCase("null") && !req_sessionstatus.equals(""))
    {
    if(req_sessionstatus.equals("A"))
    {
    	%>
      <a href="#" class="bt_green" onclick="Insert()" id="createbutton" ><span class="bt_green_lft"></span><strong><%=bundle.getString("button.schoolcalendar.createnewcalendar")%></strong><span class="bt_green_r"></span></a>
 <%
    }
 else
 {
 }
    }
 %>
 
 <%
 if(req_sessionstatus != null && req_sessionstatus.equals("R"))
				{
					out.println("<div class='warning_box'>");
					out.println(bundle.getString("label.schoolcalendar.errormessagedetails"));
					out.println("</div>");		
				}%>
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