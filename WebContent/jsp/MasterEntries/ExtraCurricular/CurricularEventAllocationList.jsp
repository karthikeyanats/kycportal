<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Extra Curricular Event Allocation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function loadstudent()
{
document.curricularevententryform.submit();
}
function back()
{
document.curricularevententryform.action="CurricularEventAllocation.jsp";
document.curricularevententryform.submit();
}
function inserteventallocation()
{
	if(check_ForParticularElements(document.curricularevententryform.board,"select",document.curricularevententryform.standard,"select",document.curricularevententryform.section,"select"))
	{
		if(allocatecheck>0)
		{
		document.curricularevententryform.action="CurricularEventAllocationSubmit.jsp";
		document.curricularevententryform.submit();
		}
		else
		{
		alert("Check Any One Student");
		}
	}
}
var allocatecheck=0;
function allocationcheck(obj)
{
if(obj.checked)
{
allocatecheck++;
}
else
{
allocatecheck--;

}
}

function deallocateevent(obj)
{
	var award=obj.getAttribute("awarddetails");
	if(award!="-")
	{
		alert("Award allotted for this Student ,so you cannot Deallocate");
		return false;
	}
	if(confirm("Do You Want to Deallocate the Student"))
	{
		document.curricularevententryform.action="./CurricularEventDeallocationSubmit.jsp?eventparticipantsid="+obj.getAttribute("eventparticipantsid");
		document.curricularevententryform.submit();
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

    <h2>Schedule / Extra Curricular Allocation / Extra Curricular Event List / Allocation </h2>
<form name="curricularevententryform" action="" method="post">
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>

<%

String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList eventCategoryList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
String yearofsession="";
String category="";
String venue="";
String eventname="";
String eventdate="";
String eventid="";


ArrayList sessionList=null;
String sessionid="";
sessionid=request.getParameter("session")+"";
String boardid="";
String standardscheduleid="";
String sectionscheduleid="";





ArrayList boardList = null;
ArrayList StandardList = new ArrayList();
ArrayList SectionList =  new ArrayList();
ArrayList StudentList =  new ArrayList();

HashMap hashmap=null;
try
{
boardid=request.getParameter("board")+"";
standardscheduleid=request.getParameter("standard")+"";
instituteid = (String)session.getValue("instituteid");
yearofsession=request.getParameter("yearofhidden");
category=request.getParameter("categoryhidden");
venue=request.getParameter("venuehidden");
eventname=request.getParameter("eventhidden");
eventdate=request.getParameter("eventdatehidden");
instituteid = (String)session.getValue("instituteid");
eventid=request.getParameter("eventidhidden");
sectionscheduleid=request.getParameter("section");


String parameter = "";
for(java.util.Enumeration e = request.getParameterNames();e.hasMoreElements(); ){
	parameter = (String)e.nextElement();
	if(parameter != null && !(parameter.equals("eventid") || parameter.equals("sessionid") || parameter.equals("session") || parameter.equals("sessioninstituteid") || parameter.equals("board") || parameter.equals("standard") || parameter.equals("section") ))
	out.print("<input type='hidden' name='"+parameter+"'  id='"+parameter+"' value='"+request.getParameter(parameter)+"'>");
}
if(!sessionid.equals("null") )
{
boardList = extraCurricularQuery.loadboard(instituteid);
}
if(!sessionid.equals("null") && !boardid.equals("null") && !boardid.equals("0"))
{
	StandardList=extraCurricularQuery.loadstandard(boardid,sessionid,instituteid);
}
if(!sessionid.equals("null") && !boardid.equals("null") && !boardid.equals("0") && !standardscheduleid.equals("null") && !standardscheduleid.equals("0") && StandardList.size()>0 )
{
	SectionList=extraCurricularQuery.loadsection(standardscheduleid,instituteid);
}
if(!sessionid.equals("null") && !boardid.equals("null") && !boardid.equals("0") && !standardscheduleid.equals("null") && !standardscheduleid.equals("0") && StandardList.size()>0 && !sectionscheduleid.equals("null") && !sectionscheduleid.equals("0") && SectionList.size()>0 )
{
	StudentList=extraCurricularQuery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid,eventid);
}
}catch(Exception e){}

%>
<input type="hidden" name="eventid"  id="eventid" value="<%=eventid%>">
<input type="hidden" name="sessionid"  id="sessionid" value="<%=sessionid%>">
<input type="hidden" name="session"  id="session" value="<%=sessionid%>">
<input type="hidden" name="sessioninstituteid"  id="sessioninstituteid" value="<%=instituteid%>">

<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.photogallery.selectedinformation") %></th>
          	<th scope="col" class="rounded-q4" width="10%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
     
     <td colspan=2>
		     <table border=0 cellpadding=0 width="100%">
		     <tr>
	
				<td ' class='tablebold'><%=bundle.getString("label.photogallery.academicsession") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
					<%=yearofsession %>
				</td>
				<td  class='tablebold'><%=bundle.getString("label.extracurricularactivity.curricularactivity") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=category %>
				</td>
			
			</tr>
			<tr>
			
				<td  class='tablebold'><%=bundle.getString("label.photogallery.eventname") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=eventname %>
				</td>
				<td  class='tablebold'><%=bundle.getString("label.photogallery.eventdate") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
					<%=eventdate %>
				</td>
				
			</tr>
			<tr>
			
					<td  class='tablebold'>Venue</td>
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight' >
						<%=venue %>
					</td>
			
			</tr>
		</table>
		</td>
		</tr>
		
		
     </tbody>
     </table>
          <br>
          <table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>

        	<th scope="col" class="rounded-company" ><%=bundle.getString("label.schedule.extracurriculareventlist.standarddetails") %>
</th>
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
     
     <tr>
		<td colspan=2><table width=100%><tr>
				<td width='20%' class='tablebold'><%=bundle.getString("label.studentprofileentry.Board") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='board'  id='board'   validate='Borad Name'  style="width:150px" onchange="loadstudent()">
						<option value='0' selected>-Select Board-</option>
						<%
							if(boardList != null && boardList.size()>0)
							{
								for(int y=0;y<boardList.size();y++){
									hashmap		= (HashMap)boardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
					if(!mediumname.equals("null"))
						boardname=boardname+" -"+mediumname;
									if(boardid.equals(hashmap.get("boardid")))
										out.print("<option value='"+hashmap.get("boardid")+"' selected=true>"+boardname+"</option>");
									else
										out.print("<option value='"+hashmap.get("boardid")+"' >"+boardname+"</option>");
									}
								}
						%>
					</select>
				</td>
				<td width='20%' class='tablebold'><%=bundle.getString("label.studentprofileentry.Standard") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='standard'  id='standard'   validate='Standard Name'  style="width:150px" onchange="loadstudent()">
						<option value='0' >-Select Standard-</option>
						<%
							if(StandardList != null && StandardList.size()>0)
							{
								for(int y=0;y<StandardList.size();y++){
									hashmap		= (HashMap)StandardList.get(y);
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
										standardname=standardname+" -"+groupname;
									if(standardscheduleid.equals(hashmap.get("standardscheduleid")))
										out.print("<option value='"+hashmap.get("standardscheduleid")+"' selected=true>"+standardname+"</option>");
									else
										out.print("<option value='"+hashmap.get("standardscheduleid")+"' >"+standardname+"</option>");									}
								}
						%>
					</select>
				</td>
				
				</tr>
				<tr>
				
				<td width='20%' class='tablebold'><%=bundle.getString("label.studentprofileentry.Section") %></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' colspan=4>
				<select name='section'  id='section'   validate='Section Name'  style="width:150px" onchange="loadstudent()">
						<option value='0' >-Select Section-</option>
						<%
							if(SectionList != null && SectionList.size()>0)
							{
								for(int y=0;y<SectionList.size();y++){
									hashmap		= (HashMap)SectionList.get(y);
									if(sectionscheduleid.equals(hashmap.get("sectionscheduleid")))
										out.print("<option value='"+hashmap.get("sectionscheduleid")+"' selected=true>"+hashmap.get("sectionname")+"</option>");
									else
										out.print("<option value='"+hashmap.get("sectionscheduleid")+"' >"+hashmap.get("sectionname")+"</option>");
									}
								}
						%>
					</select>
				</td>
				</tr>
				</table></td></tr>
				
     </tbody>
     </table>
          <br>
     
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("hmlabel.sectionwiselist.slno") %></th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.feesprintpreview.NameofStudent") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.studentprofileentry.RollNo") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.standard.Action") %></th>
        	<th scope="col" class="rounded-q4" width="1%"></th>
        </tr>
    </thead>
     <tbody>
  	 
	 <%
	 try{
	 if(StudentList!=null && StudentList.size()>0)
	 {
		 for(int y=0,sno=1;y<StudentList.size();y++,sno++){
			HashMap hashmapinner = (HashMap)StudentList.get(y);
			String curriculareventid=(String)hashmapinner.get("curriculareventid")+"";
			String studentallocationid=(String)hashmapinner.get("studentallocationid");
			String rollno=(String)hashmapinner.get("rollno");
			String applicantname=(String)hashmapinner.get("applicantname");
			String eventparticipantsid=(String)hashmapinner.get("eventparticipantsid");
			String awarddetails=(String)hashmapinner.get("awarddetails");
			if(awarddetails==null || awarddetails.equalsIgnoreCase("null") || awarddetails.equalsIgnoreCase("") || awarddetails.equalsIgnoreCase(" ")) 
				awarddetails="-";
			
			
			out.println("<tr>");
			out.println("<td></td>");  
			out.println("<td width='10%' align=center>"+sno+"</td>");  
			out.println("<td width='30%'>"+applicantname+"</td>");  
			out.println("<td width='20%'>"+rollno+"</td>"); 
			if(curriculareventid.equals(eventid))
			{
				out.println("<td width='40%'>Allocated&nbsp;|&nbsp;<a href='#' eventparticipantsid='"+eventparticipantsid+"'  awarddetails='"+awarddetails+"'   onclick='deallocateevent(this)' >Deallocate</td>");
			}
			else
			{
				out.println("<td width='40%'><input type='checkbox'  name=allocatecheck value='"+studentallocationid+"' onclick='allocationcheck(this)'></td>");
			}
			out.println("<td></td>");
			out.println("</tr>");
			}
	 }
	 else
	 {
		 out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	 	//out.println("<tr><td  width='100%' colspan=6 align=center>Data Not Found</td></tr>");
	 }
	 }
	 catch(Exception e)
	 {}
	 %></tbody>
	 </table>
     <table id="rounded-corner" border=0 summary="selectd Information" align=center width=100%>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     </tbody>
     </table>
     
	</td><td width="30%">&nbsp;</td></tr></table>	 
	 <a href="#" class="bt_blue" onclick="back()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.registeredstudentlist.Back") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="inserteventallocation()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.registeredstudentlist.Allocate") %></strong><span class="bt_green_r"></span></a>
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