<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Event List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function onchangesubmitfun()
{
		document.curriculareventlistform.sessiononchange.value=document.curriculareventlistform.session.value;
		document.curriculareventlistform.action="CurricularEventList.jsp";
		document.curriculareventlistform.submit();
}
function eventview(obj)
{
		document.curriculareventlistform.eventhidden.value=obj.getAttribute("eventname");
		document.curriculareventlistform.eventidhidden.value=obj.getAttribute("eventid");
		document.curriculareventlistform.eventdatehidden.value=obj.getAttribute("eventdate");
		document.curriculareventlistform.venuehidden.value=obj.getAttribute("venu");
		document.curriculareventlistform.action="CurricularEventParticipantsList.jsp";
		document.curriculareventlistform.submit();
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.curriculareventlist.rootpath") %> </h2>
<form name="curriculareventlistform" action="" method="post">
<input type="hidden" name="sessiononchange" value="">

<input type="hidden" name="yearofhidden" value="">
<input type="hidden" name="eventhidden" value="">
<input type="hidden" name="venuehidden" value="">
<input type="hidden" name="categoryhidden" value="">
<input type="hidden" name="eventdatehidden" value="">
<input type="hidden" name="eventidhidden" value="">


<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>
<%
String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList eventCategoryList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
ArrayList sessionList=null;
String sessionid="";
sessionid=session.getValue("sessionid")+"";
try
{
instituteid = (String)session.getValue("instituteid");
eventCategoryList = extraCurricularQuery.listcurricularEvent(sessionid);
//out.println(eventCategoryList);

 sessionList		= extraCurricularQuery.listYearofSession(instituteid);

}catch(Exception e){}
%>

<table id="rounded-corner" border=0  align=center width=100%>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" ><%=bundle.getString("hmlabel.curriculareventlist.selecteddetails") %></th>
        	<th scope="col" class="rounded-q4" ></th>
        	
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr><td colspan=2>
     <table width=100% border=0>
     <tr>
		<td class='tablebold' width='25%' ><%=bundle.getString("hmlabel.curriculareventlist.academicyear") %></td>
		<td class=tablebold width='1%'>:</td>
		<td class=tablelight><%=session.getValue("sessionname") %></td>
	</tr></table></td></tr>
     </tbody>
     </table>
          <br>
     
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("hmlabel.curriculareventlist.slno") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("hmlabel.curriculareventlist.eventname") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("hmlabel.curriculareventlist.venue") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("hmlabel.curriculareventlist.eventdate") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("hmlabel.curriculareventlist.action") %></th>
        	<th scope="col" class="rounded-q4" width="1%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6 class="rounded-foot-left"><em></em></td>
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
	 if(!category.equals(innermap.get("extcurricularcategoryname")+""))
	 {
		 out.println("<tr>");
		 out.println("<td></td>");
		 out.println("<td align=left colspan=5 class=tablebold>"+innermap.get("curriculareventname")+"</td>");
		 out.println("<td></td>");
		 out.println("<tr>");
		 category=innermap.get("curriculareventname")+"";
	 }
	 out.println("<tr>");
	 out.println("<td></td>");
	 out.println("<td>"+x+"</td>");
	 out.println("<td>"+innermap.get("curriculareventname")+"</td>");
	 out.println("<td>"+innermap.get("venu")+"</td>");
	 out.println("<td>"+innermap.get("eventdate")+"</td>");
	// out.println("<td>"+innermap.get("extcurricularcategoryname")+"</td>");
	 out.println("<td><a herf='#'  eventid='"+innermap.get("curriculareventid")+"' eventname='"+innermap.get("curriculareventname")+"' eventdate='"+innermap.get("eventdate")+"'  venu='"+innermap.get("venu")+"' Style='cursor:pointer' onclick=eventview(this)><u>Participant Details</u></a></td>");
	 out.println("<td></td>");
	 out.println("</tr>");
	 //extracurricularcategoryid, a.curriculareventid,,, 
	 }
 }
 else
 {
	 out.println("<tr>");
	 out.println("<td align=center colspan=7 class=tablebold ><font color=red>Data Not Found</font></td>");
	 out.println("</tr>");

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

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>