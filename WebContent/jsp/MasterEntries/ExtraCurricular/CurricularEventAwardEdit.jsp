<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Award Edit | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function submiteventaward()
{
		if(document.curricularevententryform.awarddetails.length==undefined)
		{
		document.curricularevententryform.awarddetails.type="text";
		}
		else
		{
		for(var no=0;no<document.curricularevententryform.awarddetails.length;no++)
		{
		document.curricularevententryform.awarddetails[no].type="text";
		}
		}
	var inc=0;
	if(document.curricularevententryform.awarddetails.length==undefined)
	{
			if(document.curricularevententryform.awarddetails.value=="")
				{
				alert("Empty Award Details Not Allowed");
				document.curricularevententryform.awarddetails.focus();
				return false;
				}
				else
				{
				inc++;
				}
	}
	else
	{
		for(var i=0;i<document.curricularevententryform.awarddetails.length;i++)
			{
				if(document.curricularevententryform.awarddetails[i].value=="")
				{
				alert("Empty Award Details Not Allowed");
				document.curricularevententryform.awarddetails[i].focus();
				return false;
				}
				else
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
function backfun()
{
		document.curricularevententryform.action="CurricularEventAwardEntry.jsp";
		document.curricularevententryform.submit();
}
function resetfun()
{
		document.location.reload();
}

function removedetails(obj)
{
if(confirm("Are you sure want to Remove the Award Details...?"))
{
		var no =obj.getAttribute("no");
		if(document.curricularevententryform.awarddetails.length==undefined)
		{
			document.curricularevententryform.awarddetails.value="-";
			//document.curricularevententryform.awarddetails.type="hidden";
			document.curricularevententryform.awarddetails.style.visibility="hidden";
			eval("document.getElementById('awarddetaildiv"+no+"').innerHTML='<br>-'");
		}
		else
		{
			document.curricularevententryform.awarddetails[no].value="-";
			//document.curricularevententryform.awarddetails[no].type="hidden";
			document.curricularevententryform.awarddetails[no].style.visibility="hidden";
			//document.curricularevententryform.awarddetails[no].type="text";
			eval("document.getElementById('awarddetaildiv"+no+"').innerHTML='<br>-'");
		}
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

    <h2>Schedule / Extra Curricular Allocation / Extra Curricular Event List / Award Edit</h2>
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

String sessionid		=request.getParameter("session")+"";

eventid		=request.getParameter("eventidhidden")+"";
eventname	=request.getParameter("eventhidden")+"";
venue		=request.getParameter("venuehidden")+"";
eventdate	=request.getParameter("eventdatehidden")+"";

try
{
	AllocatedstudentList = extraCurricularQuery.loadEventAllocatedstudent(eventid);
//out.println("===========>>>>>"+AllocatedstudentList);
}catch(Exception e){}
%>
<input type="hidden" name="update" value="update">
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
        	<th scope="col" class="rounded-company">Event Details</th>
          	<th scope="col" class="rounded-q4"></th>
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
        	<th scope="col" class="rounded" >Remove</th>
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
 if(AllocatedstudentList.size()>0 )
 {
 String category="";
 for(int i=0,x=1;i<AllocatedstudentList.size();i++)
	{
	 HashMap innermap=(HashMap)AllocatedstudentList.get(i);
	// rollno=12A1001, uname=Mr. Barani dharan, studentallocationid=3
	String award=innermap.get("awarddetails")+"";
	if(!award.equals("-"))
	{
	 out.println("<tr>");
	 out.println("<td></td>");
	 out.println("<td>"+x+"</td>");
	 out.println("<td>"+innermap.get("uname")+"</td>");
	 out.println("<td>"+innermap.get("rollno")+"</td>");
	 out.println("<td><div id='awarddetaildiv"+(x-1)+"'></div><input type='text' name='awarddetails' id='awarddetails' value='"+innermap.get("awarddetails")+"' size='30' maxlength='44'><input type='hidden' name='studentallocationid' id='studentallocationid' value='"+innermap.get("studentallocationid")+"'></td>");
	 out.println("<td><a href='#remove' name='remove' no='"+(x-1)+"' onclick='removedetails(this)'> Remove </a> </td>");
	 out.println("<td></td>");
	 out.println("</tr>");
	 x++;
	}
	 //extracurricularcategoryid, a.curriculareventid,,, 
	 }
 }
 else
 {
	 out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
	 //out.println("<tr>");
	 //out.println("<td align=center colspan=7><font color=red>Data Not Found</font></td>");
	 //out.println("</tr>");

 }%>
	 </tbody>
	 </table>
	 <a href="#resets" name="resets" onclick='resetfun()' class="bt_red" align=center><span class="bt_red_lft"></span><strong>Cancel</strong><span class="bt_red_r"></span></a>
	 <a href="#back" name="back" onclick='backfun()' class="bt_blue" align=center><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 <a href="#bbb" name="bbb" onclick='submiteventaward()' class="bt_green" align=center><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
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