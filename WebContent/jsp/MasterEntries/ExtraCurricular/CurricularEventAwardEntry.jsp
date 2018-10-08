<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Award Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function backfun()
{
document.curricularevententryform.action="./CurricularEventAllocation.jsp";
document.curricularevententryform.submit();
}
function submiteventaward()
{
	var inc=0;
	if(document.curricularevententryform.awarddetails.length==undefined)
	{
	if(document.curricularevententryform.awarddetails.value=="")
	{
	alert("Enter Award Details");
	document.curricularevententryform.awarddetails.focus();
	return false;
	}
	inc++;
	}
	else
	{
		for(var i=0;i<document.curricularevententryform.awarddetails.length;i++)
			{
				if(document.curricularevententryform.awarddetails[i].value=="")
				{
				document.curricularevententryform.awarddetails[i].disabled=true;
				document.curricularevententryform.studentallocationid[i].disabled=true;
				}else
				{
				inc++;
				}
			}
	}
if(inc>0)
	{
	document.curricularevententryform.action="CurricularEventAwardSubmit.jsp";
	document.curricularevententryform.submit();
	}
	else{
		alert("Enter Any One");
		for(var i=0;i<document.curricularevententryform.awarddetails.length;i++)
			{
				document.curricularevententryform.awarddetails[i].disabled=false;
				document.curricularevententryform.studentallocationid[i].disabled=false;
				
			}
	}
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
function editeventaward()
{
		document.curricularevententryform.action="CurricularEventAwardEdit.jsp";
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

    <div class="right_content">

    <h2>Schedule / Extra Curricular Allocation / Extra Curricular Event List / Award Entry</h2>
<form name="curricularevententryform" action="" method="post">


<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>
<%
String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList AllocatedstudentList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
ArrayList sessionList=null;
String eventid="";
String eventname="";
String eventdate="";
String venue="";

int count=0;
int editcount=0;

String sessionid		=request.getParameter("session")+"";
eventid					=request.getParameter("eventidhidden")+"";
eventname				=request.getParameter("eventhidden")+"";
venue					=request.getParameter("venuehidden")+"";
eventdate				=request.getParameter("eventdatehidden")+"";
try
{
	AllocatedstudentList = extraCurricularQuery.loadEventAllocatedstudent(eventid);
//out.println("===========>>>>>"+AllocatedstudentList);
}catch(Exception e){}
%>
<input type="hidden" name="session"  id="session" value="<%=sessionid%>">
<input type="hidden" name="eventid" value="<%=eventid%>">
<input type="hidden" name="eventidhidden" value="<%=eventid%>">
<input type="hidden" name="eventhidden" value="<%=eventname%>">
<input type="hidden" name="venuehidden" value="<%=venue%>">
<input type="hidden" name="eventdatehidden" value="<%=eventdate%>">

<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='90%' >Selected Information</th>
          	<th scope="col" class="rounded-q4" width='10%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr><td colspan=2><table width=100%>
     <tr>
		<td  class='tablebold'>Event Name</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight' >
		<%=eventname %></td>
		<td  class='tablebold'>Event Date</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight' >
		<%=eventdate %></td>
		</tr>
		<tr>
		<td class='tablebold'>Venue</td>
		<td width='1%' class='tablebold'>:</td>
		<td class='tablelight'>
		<%=venue %></td>
		</tr>
		</table></td></tr>
     </tbody>
     </table>
          <br>
     
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded" >Sl. No</th>
        	<th scope="col" class="rounded" >Student Name</th>
        	<th scope="col" class="rounded" >Roll No</th>
        	<th scope="col" class="rounded" >Award Details</th>
        	<th scope="col" class="rounded-q4" width="1%"></th>
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
//out.println("eventCategoryList.size()"+eventCategoryList.size()+"request.getParameter(session)"+request.getParameter("session"));
 if(AllocatedstudentList.size()>0 )
 {
 String category="";
 for(int i=0,x=1;i<AllocatedstudentList.size();i++,x++)
	{
	 HashMap innermap=(HashMap)AllocatedstudentList.get(i);
	// rollno=12A1001, uname=Mr. Barani dharan, studentallocationid=3
	 out.println("<tr>");
	 out.println("<td></td>");
	 out.println("<td>"+x+"</td>");
	 out.println("<td>"+innermap.get("uname")+"</td>");
	 out.println("<td>"+innermap.get("rollno")+"</td>");
	 if((innermap.get("awarddetails")+"").equals("-"))
	 {
	count++;
	 out.println("<td><input type='text' name='awarddetails' id='awarddetails' value='' size='30' maxlength='44'><input type='hidden' name='studentallocationid' id='studentallocationid' value='"+innermap.get("studentallocationid")+"'></td>");
	 }
	 else
	 {
		 editcount++;
		 out.println("<td>"+innermap.get("awarddetails")+"</td>");
	 }
	 out.println("<td></td>");
	 out.println("</tr>");
	 //extracurricularcategoryid, a.curriculareventid,,, 
	 }
 
 }
 else
 {
	 out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	 //out.println("<tr>");
	 //out.println("<td align=center colspan=6><font color=red>Data Not Found</font></td>");
	 //out.println("</tr>");

 }%>
	 </tbody>
	 </table>
	 <a href="#edit" name="back" id="back" onclick='backfun()' class="bt_blue" align=center><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 <a href="#edit" name="edit" id="edit" onclick='editeventaward()' class="bt_green" align=center><span class="bt_green_lft"></span><strong>Edit</strong><span class="bt_green_r"></span></a>
	 <a href="#bbb" name="bbb" id="bbb" onclick='submiteventaward()' class="bt_green" align=center><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
	</td><td width="30%">&nbsp;</td></tr></table>	 
	
     <%
     if(count>0)
     {
    	 out.println("<script>document.getElementById('bbb').style.display='block';</script>");
     }
     else
     {
    	 out.println("<script>document.getElementById('bbb').style.display='none';</script>");
     }
     if(editcount>0)
     {
    	 out.println("<script>document.getElementById('edit').style.display='block';</script>");
     }
     else
     {
    	 out.println("<script>document.getElementById('edit').style.display='none';</script>");
     }
     %>
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