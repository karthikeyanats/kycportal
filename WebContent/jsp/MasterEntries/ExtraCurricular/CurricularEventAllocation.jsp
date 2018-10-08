<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Event List  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function addeventDetails()
{
	if(check_ForParticularElements(document.curricularevententryform.curicullarcategory,"select"))
	{
		document.curricularevententryform.action="CuricullarEventSubmit.jsp";
		document.curricularevententryform.submit();
		}
}
function onchangesubmitfun()
{
		document.curricularevententryform.sessiononchange.value=document.curricularevententryform.session.value;
		document.curricularevententryform.action="CurricularEventAllocation.jsp";
		document.curricularevententryform.submit();
}
function eventallocationfun(obj)
{
		document.curricularevententryform.yearofhidden.value=document.curricularevententryform.session.options[document.curricularevententryform.session.options.selectedIndex].text;
		document.curricularevententryform.eventhidden.value=obj.getAttribute("eventname");
		document.curricularevententryform.venuehidden.value=obj.getAttribute("venu");
		document.curricularevententryform.eventdatehidden.value=obj.getAttribute("eventdate");
		document.curricularevententryform.categoryhidden.value=obj.getAttribute("categoryname");
		document.curricularevententryform.eventidhidden.value=obj.getAttribute("eventid");
		document.curricularevententryform.action="CurricularEventAllocationList.jsp";
		document.curricularevententryform.submit();
}
function eventawardentryfun(obj)
{
		document.curricularevententryform.eventhidden.value=obj.getAttribute("eventname");
		document.curricularevententryform.eventidhidden.value=obj.getAttribute("eventid");
		document.curricularevententryform.eventdatehidden.value=obj.getAttribute("eventdate");
		document.curricularevententryform.venuehidden.value=obj.getAttribute("venu");
		document.curricularevententryform.action="CurricularEventAwardEntry.jsp";
		document.curricularevententryform.submit();
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>    <div class="right_content">
    <h2><%=bundle.getString("label.schedule.extracurriculareventlist")%></h2>
<form name="curricularevententryform" action="" method="post">
<input type="hidden" name="sessiononchange" value="">

<input type="hidden" name="yearofhidden" value="">
<input type="hidden" name="eventhidden" value="">
<input type="hidden" name="venuehidden" value="">
<input type="hidden" name="categoryhidden" value="">
<input type="hidden" name="eventdatehidden" value="">
<input type="hidden" name="eventidhidden" value="">


<%@ page language="java" import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>
<%
String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList eventCategoryList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
ArrayList sessionList=null;
String sessionid="";
sessionid=request.getParameter("session")+"";
try
{
instituteid = (String)session.getValue("instituteid");
eventCategoryList = extraCurricularQuery.listcurricularEvent(sessionid);
//out.println(eventCategoryList);

 sessionList		= extraCurricularQuery.listYearofSession(instituteid);

}catch(Exception e){}
%>
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" colspan=4><%=bundle.getString("label.schedule.academicyear")%></th>
          	<th scope="col" class="rounded-q4"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
		<td></td>
				<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='session'  id='session'   validate='Academic Year'  onchange="onchangesubmitfun()">
						<option value='0' >-Select Academic Year-</option>
						<%
						HashMap hashmap=null;
							if(sessionList != null && sessionList.size()>0)
								for(int y=0;y<sessionList.size();y++){
									hashmap		= (HashMap)sessionList.get(y);
									if(!sessionid.equals("null") && sessionid.equals(hashmap.get("sessionid")+""))
									{
									out.print("<option value='"+hashmap.get("sessionid")+"' selected>"+hashmap.get("sessionname")+"</option>");
									}
									else
									{
										out.print("<option value='"+hashmap.get("sessionid")+"' >"+hashmap.get("sessionname")+"</option>");

									}
								}
						%>
					</select>
				</td>
				<td></td>
				</tr>
     </tbody>
     </table>
          <br>
     
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
   
    	   	<th scope="col" class="rounded-company" ><%=bundle.getString("label.schedule.slno")%></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.schedule.eventname")%></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.schedule.venue")%></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.schedule.eventdate")%></th>
        	<th scope="col" class="rounded-q4" ><%=bundle.getString("label.schedule.action")%></th>
        	
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
 <%
//out.println("eventCategoryList.size()"+eventCategoryList.size()+"request.getParameter(session)"+request.getParameter("session"));
 if(eventCategoryList.size()>0 && ((!(request.getParameter("session")+"").equals("0")) || (!(request.getParameter("session")+"").equals("null")) ))
 {
	 String category="";
 for(int i=0,x=1;i<eventCategoryList.size();i++,x++)
	{
	 HashMap innermap=(HashMap)eventCategoryList.get(i);
	 if(!category.equals(innermap.get("extracurricularname")+""))
	 {
		 out.println("<tr>");
		// out.println("<td></td>");
		 out.println("<td align=left colspan=5 class=tablebold>"+innermap.get("extracurricularname")+"</td>");
		 //out.println("<td></td>");
		 out.println("<tr>");
		 category=innermap.get("extracurricularname")+"";	
	 }
	 out.println("<tr>");
	 //out.println("<td></td>");
	 out.println("<td>"+x+"</td>");
	 out.println("<td>"+innermap.get("curriculareventname")+"</td>");
	 out.println("<td>"+innermap.get("venu")+"</td>");
	 out.println("<td>"+innermap.get("eventdate")+"</td>");
	// out.println("<td>"+innermap.get("extcurricularcategoryname")+"</td>");
	 out.println("<td><a herf='#' onclick='eventallocationfun(this)' categoryname='"+innermap.get("extracurricularname")+"' eventname='"+innermap.get("curriculareventname")+"' venu='"+innermap.get("venu")+"' eventdate='"+innermap.get("eventdate")+"'  eventid='"+innermap.get("curriculareventid")+"' Style='cursor:pointer'>Allocation</a> &nbsp;|&nbsp; <a herf='#'  eventid='"+innermap.get("curriculareventid")+"' eventname='"+innermap.get("curriculareventname")+"' eventdate='"+innermap.get("eventdate")+"'  venu='"+innermap.get("venu")+"' Style='cursor:pointer' onclick=eventawardentryfun(this)>Award Details</a></td>");
	 //out.println("<td></td>");
	 out.println("</tr>");
	 //extracurricularcategoryid, a.curriculareventid,,, 
	 }
 }
 else
 {
	 out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
	 //out.println("<tr>");
	 //out.println("<td align=center colspan=5><font color=red>"+bundle.getString("label.schedule.datanotfound")+"</font></td>");
	 //out.println("</tr>");

 }%>
	 </tbody>
	 </table>
	 
	</td><td width="30%">&nbsp;</td></tr></table>	 
	
     
     <input type='hidden' name='todaydate' 	value='<%=today %>'/>
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>