<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Report | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/StyleCalender.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<!--  
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/CalendarControl.js"></script>
-->


<script type="text/javascript">
	
	function loadstudent()
	{
	if(check_ForParticularElements(document.StudentReport_Form.board,"select",document.StudentReport_Form.standardscheduleid,"select",document.StudentReport_Form.sectionscheduleid,"select")){
	//document.StudentReport_Form.req_sessionname.value=document.StudentReport_Form.session.options[document.StudentReport_Form.session.options.selectedIndex].text;
	//document.StudentReport_Form.req_sessionstatus.value=document.StudentReport_Form.session.options[document.StudentReport_Form.session.options.selectedIndex].getAttribute("status")
	document.StudentReport_Form.req_boardname.value=document.StudentReport_Form.board.options[document.StudentReport_Form.board.options.selectedIndex].text;
	document.StudentReport_Form.req_standardnamegp.value=document.StudentReport_Form.standardscheduleid.options[document.StudentReport_Form.standardscheduleid.options.selectedIndex].text;
	document.StudentReport_Form.req_sectionname.value=document.StudentReport_Form.sectionscheduleid.options[document.StudentReport_Form.sectionscheduleid.options.selectedIndex].text;
	document.StudentReport_Form.action="./StudentReportView.jsp"
	document.StudentReport_Form.submit();
	}
	}
function loadcombo(id,id1,flag)
{
//val=id.value;
val=document.StudentReport_Form.req_sessionid.value;
val1=id1.value;
val2=document.StudentReport_Form.sessioninstituteid.value;
var url = "";
	   if(flag=="standard")
	   {
	  	  url = "../Principal/principalinfo.jsp?action=standard&sessionid="+val+"&boardid="+val1+"&instituteid="+val2;
	   }
	 else if(flag=="section")
	   {
		   url = "../Principal/principalinfo.jsp?action=section&standardscheduleid="+val1+"&instituteid="+val2;
	   }
	     else
	   {
		   alert("The Key does not match with any value,URL is Empty, Please contact Administrator/Programmer");
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				  if(flag=="standard")
				  {
					parseMessages(req.responseXML,flag);
				  }
				 else if(flag=="section")
				  {
					 parseMessages(req.responseXML,flag);
				  }
				   			  
			   }
			}
	   };
	   req.open("GET", url, true);
	   req.send(null);
	}
	function parseMessages(parseXML,flag)
	{
		if(flag=="standard")
		{
			optionDelete(document.StudentReport_Form.standardscheduleid,'1');
			var rootObj=parseXML.getElementsByTagName("standard");
			var cNode_1=rootObj[0].childNodes.length;
			if(cNode_1>0)
			{
				for(var i=0,j=1;i<parseInt(cNode_1);i++,j++)
					{
						var standardid=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						var standardname=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("standardscheduleid").options[j] = new Option(standardname,standardid);
					}
			}
		}
		if(flag=="section")
		{
			optionDelete(document.StudentReport_Form.sectionscheduleid,'1');
			var rootObj=parseXML.getElementsByTagName("section");
			var cNode_1=rootObj[0].childNodes.length;
			if(cNode_1>0)
			{
				for(var i=0,j=1;i<parseInt(cNode_1);i++,j++)
					{
						var sectionid=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						var sectionname=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("sectionscheduleid").options[j] = new Option(sectionname,sectionid);
					}
			}
		}
	}
function goBack()
{
	document.StudentReport_Form.action="./ReportIndexView.jsp"
	document.StudentReport_Form.submit();
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


    <div class="center_content">



    <div class="left_content">

    </div>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="right_content">

    <h2> <%=bundle.getString("label.reports.reportsstudentlist")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.MasterEntries.Standard.StandardQuery,com.iGrandee.Common.DateTime,com.iGrandee.Application.ApplicationQuery"%>
<%

		//PrinicipalQuery prinicipal			= new PrinicipalQuery();
		ApplicationQuery applicationQuery	= new ApplicationQuery();
		StandardQuery standardQuery			=	new StandardQuery();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		//ArrayList sessionList		= prinicipal.loadyearofsession(instituteid);
		ArrayList sessionList 		= applicationQuery.listYearofSession(instituteid);
		//ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList BoardList			= standardQuery.listBoard(instituteid);
		//String today				= DateTime.showTime("calendar");
%>
						<form name="StudentReport_Form" action="" method="post">
						<input type="hidden" name="hiddenfromdate" value="">
						<input type="hidden" name="hiddentodate" value="">
						<!--  <input type="hidden" name="todaydate" value="">-->
						<input type='hidden' name='req_sessionname' 			value='<%=request.getParameter("req_sessionname") %>'>
						<input type='hidden' name='req_sessionid' 				value='<%=request.getParameter("req_sessionid") %>'>
						<input type='hidden' name='req_sessionstatus' 			value='<%=request.getParameter("req_sessionstatus") %>'>
						
						<input type="hidden" name="req_boardname" value="">
						<input type="hidden" name="req_standardnamegp" value="">
						<input type="hidden" name="req_sectionname" value="">
					    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="100%" colspan=5><%=bundle.getString("label.reports.studentlistview")%></th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
				<%=request.getParameter("req_sessionname") %>
					
				</td>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
					<select name='board' id='board' validate='Board Name' style="width:150px" onChange="loadcombo(document.getElementById('session'),this,'standard')">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");
								}
							
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class='tablebold' ><%=bundle.getString("label.schedule.standardname")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='standardscheduleid' id='standardscheduleid' style="width:150px"  validate='Standard Name' onChange="loadcombo(document.getElementById('board'),this,'section')">
						<option value='0'>-Select Standard-</option>
					</select>
				</td>
				<td class='tablebold'><%=bundle.getString("label.schedule.section")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='sectionscheduleid' id='sectionscheduleid' style="width:150px"  validate='Section Name' >
						<option value='0'>-Select Section-</option>
					</select>
				</td>
			</tr>
			<%
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
			{
			%>	
			<tr>
				<td class='tablebold' valign=top><%=bundle.getString("label.schedule.archivaldetails")%></td>
				<td class='tablebold' valign=top>:</td>
				<td colspan=4 class='tablelight'>
				<h2><%=bundle.getString("label.schedule.archivalmessage1")%></h2>
				</td>
			</tr>
			<% 
			}
			%>
	
			</tbody>
			</table>
		<a href="#" class="bt_blue" onClick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onClick='loadstudent()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.loadstudent")%></strong><span class="bt_green_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>