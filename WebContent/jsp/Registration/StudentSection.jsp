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
	if(check_ForParticularElements(document.StudentReport_Form.session,"select",document.StudentReport_Form.board,"select",document.StudentReport_Form.standardscheduleid,"select",document.StudentReport_Form.sectionscheduleid,"select")){
	document.StudentReport_Form.req_sessionname.value=document.StudentReport_Form.session.options[document.StudentReport_Form.session.options.selectedIndex].text;
	document.StudentReport_Form.req_sessionstatus.value=document.StudentReport_Form.session.options[document.StudentReport_Form.session.options.selectedIndex].getAttribute("status")
	document.StudentReport_Form.req_boardname.value=document.StudentReport_Form.board.options[document.StudentReport_Form.board.options.selectedIndex].text;
	document.StudentReport_Form.req_standardnamegp.value=document.StudentReport_Form.standardscheduleid.options[document.StudentReport_Form.standardscheduleid.options.selectedIndex].text;
	document.StudentReport_Form.req_sectionname.value=document.StudentReport_Form.sectionscheduleid.options[document.StudentReport_Form.sectionscheduleid.options.selectedIndex].text;
	document.StudentReport_Form.action="./StudentSectionChange.jsp"
	document.StudentReport_Form.submit();
	}
	}
function loadcombo(id,id1,flag)
{
val=id.value;
val1=id1.value;
val2=document.StudentReport_Form.sessioninstituteid.value;
var url = "";
	   if(flag=="standard")
	   {
	  	  url = "./Registrationinfo.jsp?action=standard&sessionid="+val+"&boardid="+val1+"&instituteid="+val2;
	   }
	 else if(flag=="section")
	   {
		   url = "./Registrationinfo.jsp?action=section&standardscheduleid="+val1+"&instituteid="+val2;
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

    <div class="right_content">

    <h2> Enrollment / Student Enrollment / Student Section Transfer</h2>
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
						<input type="hidden" name="req_sessionname" value="">
						<input type="hidden" name="req_sessionstatus" value="">
						
						<input type="hidden" name="req_boardname" value="">
						<input type="hidden" name="req_standardnamegp" value="">
						<input type="hidden" name="req_sectionname" value="">
					    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="100%" colspan=5>Student List View</th>
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

				<td width='20%' class='tablebold'>Academic Year</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='session'  id='session'   validate='Session Name' style="width:150px">
						<option value='0'>-Select Session-</option>
						<%
							if(sessionList != null && sessionList.size()>0)
								for(int y=0;y<sessionList.size();y++){
									hashmap		= (HashMap)sessionList.get(y);
									out.print("<option value='"+hashmap.get("sessionid")+"' status='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
								}
							
						%>
					</select>
				</td>
				<td width='5%' class='tablebold'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
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
			
				<td width='20%' class='tablebold' >Standard</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='standardscheduleid' id='standardscheduleid' style="width:150px"  validate='Standard Name' onChange="loadcombo(document.getElementById('board'),this,'section')">
						<option value='0'>-Select Standard-</option>
						
					</select>
				</td>
				<td  class='tablebold'>Section</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='sectionscheduleid' id='sectionscheduleid' style="width:150px"  validate='Section Name' >
						<option value='0'>-Select Section-</option>
					</select>
				</td>
			</tr>
			</tbody>
			</table>
		<a href="#" class="bt_blue" onClick='loadstudent()'><span class="bt_blue_lft"></span><strong>Load Student</strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>