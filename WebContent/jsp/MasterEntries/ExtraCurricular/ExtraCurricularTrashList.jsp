<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularevent.trashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function gotoaction(obj)
{
 document.curricularevententryform.curriculareventid.value= obj.getAttribute("curriculareventid");
	document.curricularevententryform.reqcurriculareventid.value = obj.getAttribute("curriculareventid");
	
	if(obj.getAttribute("reqaction") == "Delete")     
	{
	if(confirm("Do you want to Delete the Curricular Event...?"))
	{
		document.curricularevententryform.eventstatus.value="X";
		document.curricularevententryform.action="CurricularEventSubmit.jsp?eventoperation=eventdelrestore";
		document.curricularevententryform.submit();
		}
		else
		{
		}
		
	}
	else if(obj.getAttribute("reqaction") == "Restore") 
	{
	if(confirm("Do you want to Restore the Curricular Event...?"))
	{
	document.curricularevententryform.eventstatus.value="A";
		document.curricularevententryform.action="CurricularEventSubmit.jsp?eventoperation=eventdelrestore";
		document.curricularevententryform.submit();    
	}
	else
	{}
	}
		
}

function ExtraCurricularTrashList()
{
document.curricularevententryform.action="CurricularEventList.jsp";
document.curricularevententryform.submit();
}
function loadEventdetails(obj)
{	
		if(check_ForParticularElements(document.curricularevententryform.yearofsession_temp,"select"))
		{
			
		var extracurricularcategory_tempid=obj.value;
		document.curricularevententryform.reqsessionid.value = document.curricularevententryform.yearofsession_temp.options[document.curricularevententryform.yearofsession_temp.options.selectedIndex].value;
		document.curricularevententryform.reqcategoryids.value = document.curricularevententryform.curricularcategory_temp.options[document.curricularevententryform.curricularcategory_temp.options.selectedIndex].value;
		document.curricularevententryform.extracurricularcategory_tempid.value =extracurricularcategory_tempid;
	
	
	
		document.curricularevententryform.yearofsession_temp_temp.value = document.curricularevententryform.yearofsession_temp.options[document.curricularevententryform.yearofsession_temp.options.selectedIndex].text;
		document.curricularevententryform.curricularcategory_temp_temp.value = document.curricularevententryform.curricularcategory_temp.options[document.curricularevententryform.curricularcategory_temp.options.selectedIndex].text;
		
		document.curricularevententryform.action="ExtraCurricularTrashList.jsp";
		document.curricularevententryform.submit();
		}
		else
		{
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

    <h2><%=bundle.getString("label.curricularevent.trashlistrootpath") %> </h2>
<form name="curricularevententryform" action="" method="post">

<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>

<%
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry curricularactivity = new com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry(); 

String instituteid= null;
ArrayList eventCategoryList = null;
ArrayList sessionList = null;
String yearofsession_temp=request.getParameter("yearofsession_temp")+"";

String curricularcategory_temp=request.getParameter("curricularcategory_temp")+"";
//String yearofsession_temp=request.getParameter("yearofsession_temp");


		
		String yearofsession_temp_temp="";
		String curricularcategory_temp_temp="";
		String userid= null;
try
{userid = (String)session.getValue("userid");
	 yearofsession_temp_temp=request.getParameter("yearofsession_temp_temp");
	 curricularcategory_temp_temp=request.getParameter("curricularcategory_temp_temp");
instituteid = (String)session.getValue("instituteid");
//eventCategoryList = extraCurricularQuery.listExtraCurricularCategoryList(instituteid,"A");
eventCategoryList = curricularactivity.get_All_Extracurricularactivity("A",userid,instituteid);

}catch(Exception e){}
%>
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="100%">

    

<tr class=tablebold><td> <%=bundle.getString("label.curricularevent.AcademicSession") %> : <select name="yearofsession_temp" validate='Year Of Session' class="tablelight" onchange="loadEventdetails(this)">
<option>-Select Session-</option>
 <%
  		 sessionList =  extraCurricularQuery.listYearofSession(instituteid);
 
        	if(sessionList!=null && sessionList.size()>0)  
			{
   		 	for (int i = 0, j = 1; i < sessionList.size(); i++) {
			
				HashMap sessionListMap=(HashMap)sessionList.get(i);
				String sessionid     = (String)sessionListMap.get("sessionid");
				String sessionname      = (String)sessionListMap.get("sessionname");

				if(yearofsession_temp!= null && yearofsession_temp.equals(""+sessionid) )
				{
       		      out.println("<option value='"+sessionid+"' class=tablelight selected>"+sessionname+"</option>");
				}
				else
				{
		       		 out.println("<option value='"+sessionid+"' class=tablelight >"+sessionname+"</option>");

				}
				}
			}
   		 %>
</select>
</td>
<td>
<%=bundle.getString("label.extracurricularactivity.curricularactivity") %> : <select name="curricularcategory_temp" class="tablelight" validate='Curricular Category' onchange="loadEventdetails(this)">
<option>-Select Activity-</option>
 <%
/* String extracurricularcategoryid ="";	
        	if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++) {
			
				HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
				extracurricularcategoryid     = (String)eventCategoryListMap.get("extracurricularcategoryid");
				String extcurricularcategoryname      = (String)eventCategoryListMap.get("extcurricularcategoryname");
				if(curricularcategory_temp!= null && curricularcategory_temp.equals(""+extracurricularcategoryid))
				{
       		     	
				out.println("<option value='"+extracurricularcategoryid+"' selected class=tablelight >"+extcurricularcategoryname+"</option>");
				}
				else
				{
					out.println("<option value='"+extracurricularcategoryid+"' class=tablelight >"+extcurricularcategoryname+"</option>");

				}
				}
			}*/
			String extracurricularactivityid ="";	
			if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
		 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++) {
			
				HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
				extracurricularactivityid     = (String)eventCategoryListMap.get("extracurricularactivityid");
				String extracurricularname      = (String)eventCategoryListMap.get("extracurricularname");
			
				if(curricularcategory_temp!=null && curricularcategory_temp.equals(""+extracurricularactivityid) )
				{
			     	
				out.println("<option value='"+extracurricularactivityid+"' selected class=tablelight >"+extracurricularname+"</option>");
				}
				else
				{
					out.println("<option value='"+extracurricularactivityid+"' class=tablelight >"+extracurricularname+"</option>");

				}
				}
			}
   		 %>
</select>
</td></tr>
</table></td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.curricularevent.SL.No") %></th>
        	<th scope="col" class="rounded" width="30%" ><%=bundle.getString("label.curricularevent.EventName") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.curricularevent.Venue") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.curricularevent.EventDate") %></th>
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.curricularevent.Delete") %></th>
        	<th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.curricularevent.Restore") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

	<%
	String extracurricularcategory_tempid1="";
	if(request.getParameter("reqsessionid") != null && request.getParameter("reqcategoryids") !=null)
	{
		
	String reqsessionid = request.getParameter("reqsessionid");
	String reqcategoryid = request.getParameter("reqcategoryids");
	 extracurricularcategory_tempid1=request.getParameter("extracurricularcategory_tempid");
	ArrayList eventList = extraCurricularQuery.listExtraCurricularEventList(reqcategoryid,reqsessionid,"T");
	if(eventList!=null && eventList.size()>0)
	{
	 	for (int i = 0, j = 1; i < eventList.size(); i++) {
	
		HashMap eventListMap=(HashMap)eventList.get(i);
		String curriculareventid     = (String)eventListMap.get("curriculareventid");
		String curriculareventname      = (String)eventListMap.get("curriculareventname");
		String venue      = (String)eventListMap.get("venu");
		if(venue == null || venue.equals(""))
			venue = "-";
		String eventdate      = (String)eventListMap.get("eventdate");
		
		out.println("<tr><td>"+(j++)+"</td><td class=tablelight>"+curriculareventname+"</td>");
		out.println("<td class=tablelight>"+venue+"</td>");
		out.println("<td class=tablelight>"+eventdate+"</td>");
		out.println("<td><a href=\"#\" curriculareventid='"+curriculareventid+"' reqaction='Delete' onclick=gotoaction(this)><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a>");
		out.println("<td><a href=\"#\" curriculareventid='"+curriculareventid+"' reqaction='Restore' onclick=gotoaction(this)><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></a></td>");
		
		out.println("</tr>");
	 }
	 }
	else
	{
		out.println("<td colspan='6' align=center><font color='red'><b>Data Not Found</b></font></td>");
		//out.println("<td colspan=6 align=center>Data not found</td>");
	}
	}
	
	
	%>
	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	
	
	           <a href="#" onclick="ExtraCurricularTrashList()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularevent.Back")%></strong><span class="bt_blue_r"></span></a>
	 
     	<input type=hidden name="reqcategoryids"/>
		<input type=hidden name="reqsessionid"/>
			<input type=hidden name="operationstatus"/>
		<input type=hidden name="reqcurriculareventid"/>
		<input type=hidden name="eventstatus"/>
					<input type=hidden name="extracurricularcategory_tempid" value="<%=extracurricularcategory_tempid1 %>">
		
		
							<input type=hidden name="curriculareventid" value="">
		
			<input type=hidden name="yearofsession_temp_temp" value="<%=yearofsession_temp_temp %>">
		<input type=hidden name="curricularcategory_temp_temp" value="<%=curricularcategory_temp_temp %>">
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>