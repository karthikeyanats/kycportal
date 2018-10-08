<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%
	ResourceBundle bundle = ResourceBundle
			.getBundle("resources.serversetup");    

ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%= bundle1.getString("label.AbsenteesList.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	
	function sendsms()
	{      	
	var status=false;
			var hiddentext="";
			var clickboxlen=document.wprkallotment.clickname.length;
			var phoneno="";
			var studentnames="";
			if(clickboxlen>1)
				{
				for(var i=0;i<clickboxlen;i++)
				{
					if(document.wprkallotment.clickname[i].checked)
					{
					 phoneno+= document.wprkallotment.hiddenmobileno[i].value+";";
					 studentnames+= document.wprkallotment.studentnames[i].value+";";
					status=true;
					}
					
				}
				
			}
			else
			{
				if(document.wprkallotment.clickname.checked)
				{
					phoneno= document.wprkallotment.hiddenmobileno.value+";";
				   studentnames= document.wprkallotment.studentnames.value+";";
					
					status=true;
				}
				
			}
			if(status)
			{
			requestProcess(phoneno,hiddentext,studentnames);
			}
			else
			{
			alert("Select any one Check Box")
			}
	
	}

function requestProcess(phonenos,hiddentext,studentnames)
{
	
	
	var teleNumbers = phonenos;
	var teleNumber = teleNumbers.split(";");

	 initRequest(teleNumbers,hiddentext,studentnames);
	
}
function initRequest(teleNumbers,hiddentext,studentnames)
{
   var request = false;
   try 
   {
     request = new XMLHttpRequest();
   }
    catch (trymicrosoft)
    {
     try 
     {
       request = new ActiveXObject("Msxml2.XMLHTTP");
     } catch (othermicrosoft)
      {
       try
        {
         request = new ActiveXObject("Microsoft.XMLHTTP");
       } catch (failed)
        {
         request = false;
       }  
     }
   }

   if (!request)
   {
     alert("Error initializing XMLHttpRequest!");
   }
  
    request.onreadystatechange = function() // Callback function
	{
		
		if (request.readyState == 4)
		{
			if (request.status == 200)
			{
			parseSMS(request.responseXML);
				
			}else if (request.status == 404)
			{
         		alert("Request URL does not exist");
       		}else{
		        alert("Error: status code is " + request.status);
		    }
		}
	};
		
		var ipaddress=document.wprkallotment.smsipaddress.value;
		var port=document.wprkallotment.port.value;
		//var url="http://"+ipaddress+":"+port+"/ShortMessage/ShortMessage";
		var url="http://"+ipaddress+"/ShortMessage/ShortMessage";
		var StudentName = studentnames.split(";");
		var MobileNo = teleNumbers.split(";");
		var absenteesdate=document.wprkallotment.absenteesdate.value;
	
		for(var i=0;i<((StudentName.length)-1);i++)
		{
			var temp_msg="INFO : Dear parent  " +StudentName[i]+ "  is on leave today " +absenteesdate;
			var teleNumbers_new=MobileNo[i];
			var params = "to="+encodeURIComponent(teleNumbers_new)+"&message="+encodeURIComponent(temp_msg);
			document.getElementById("fileopener").src=url+"?"+params;
		}
	
	
	
	var ckecklen=document.wprkallotment.clickname.length;
	if(ckecklen>1)
	{
			for(var i=0;i<ckecklen;i++)
			{
				if(document.wprkallotment.clickname[i].checked)
				{
					document.wprkallotment.clickname[i].checked=false
				
				}
			
			}
	}
	else
	{
		document.wprkallotment.clickname.checked=false
	}
		alert("SMS send Successfully"); 	
	
	
			  
}
function parseSMS(parseXml)
{
		if(parseXml!=null) 
		{
			var rootObject=parseXml.getElementsByTagName("ShortMessage");
			var cNode_1=rootObject[0].childNodes.length;
			if(cNode_1>0)
			{
				for(var i=0;i<parseInt(cNode_1);i++)
				{
					var status=rootObject[0].childNodes.item(i).firstChild.nodeValue;
				}
			}				
		}
}


function selectall()
{
	var ckecklen=document.wprkallotment.clickname.length;
	if(ckecklen>1)
	{
		for(var i=0;i<ckecklen;i++)
		{
			if(document.wprkallotment.clickname[i].checked)
			{
			
			}
			else
			{
			document.wprkallotment.clickname[i].checked=true
			}
		}
	}
	else
	{
		document.wprkallotment.clickname.checked=true
	}
}
function deselectall()
{
		var ckecklen=document.wprkallotment.clickname.length;
	if(ckecklen>1)
	{
		for(var i=0;i<ckecklen;i++)
		{
			if(document.wprkallotment.clickname[i].checked)
			{
				document.wprkallotment.clickname[i].checked=false
			
			}
		
		}
	}
	else
	{
	document.wprkallotment.clickname.checked=false
	}
	
}
	


function backfun()
{
	document.wprkallotment.action = "./AdminAttendanceView.jsp";
	document.wprkallotment.submit();
}
function selectallfun()
{
	
	var ckecklen=document.wprkallotment.clickname.length;
	if(ckecklen>1)
	{
		for(var i=0;i<ckecklen;i++)
		{
			document.wprkallotment.clickname[i].checked=true;
		}
	}
	else
	{
	document.wprkallotment.clickname.checked=true
	}
}
	
	
</script>
</head>
<body onload="selectallfun()">
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%= bundle1.getString("label.AbsenteesList.rootpath")%></h2>


<%@ page language="java"
	import="com.iGrandee.Common.DateTime,com.iGrandee.Attendance.AttendanceQuery"%>

<%
	DateTime dateobj = new DateTime();
	AttendanceQuery attenquery = new AttendanceQuery();
	HashMap hashmap = null;
	String sectionid = request.getParameter("section");
	String instituteid = (String) session.getValue("instituteid");
	String userid = (String) session.getValue("userid");
	String Sessionid = (String) session.getValue("sessionid");
	String Sessionname = (String) session.getValue("sessionname");
	String sectionscheduleid = request
			.getParameter("sectionscheduleid")
			+ "";

	String boardname = request.getParameter("boardname") + "";
	String boardid = request.getParameter("boardid") + "";
	String attendancestate = "A";
	String templateid = request.getParameter("templatename") + "";

	ArrayList StandardListID = new ArrayList();
	System.out.println("templateid" + templateid);
	if (templateid != null) {
		StandardListID = attenquery.loadsmstemplateID(templateid);
	}

	String array[] = session.getValueNames();
	for (int i = 0; i < array.length; i++) {
		//out.println("==="+array[i]);
	}
	ArrayList StandardListName = null;
	ArrayList boardList = attenquery.loadboard(instituteid);
	if (!boardid.equals("null")) {
		StandardListName = attenquery.loadstandard(boardid, Sessionid,
				instituteid);
	}
	String searchdate = null;
	String Displaydate[] = null;
	String Displaydate1 = "";
	searchdate = request.getParameter("searchdate") + "";
	Displaydate = searchdate.split("-");
	Displaydate1 = Displaydate[2] + "-" + Displaydate[1] + "-"
			+ Displaydate[0];

	String smstemplateid1 = "";
	smstemplateid1 = request.getParameter("templatename") + "";
	//out.println(searchdate+"============"+attendancestate+"sectionscheduleid"+sectionscheduleid);
	//
%> <jsp:useBean id="common_data_object" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<form name='wprkallotment' method='post' action=""><input
	type="hidden" name="standardscheduleid" value=""><input
	type="hidden" name="standardname" value=""><input type="hidden"
	name="boardname" value="<%=boardname %>"><input type="hidden"
	name="boardid" value="<%=boardid %>"><input type="hidden"
	name="smsipaddress"
	value="<%=bundle.getString("label.smsipaddress.smsipaddress") %>"><input
	type="hidden" name="port"
	value="<%=bundle.getString("label.smsipaddress.port") %>"><input
	type="hidden" name="attendancestate" value=""><input
	type="hidden" name="searchdate" value="<%=searchdate %>"><input
	type="hidden" name="absenteesdate" value="<%=Displaydate1 %>">
<table class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		<table border=0 bordercolor='blue' align="center" width="80%"
			cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>

				<table id="rounded-corner" border=0 summary="Department List"
					width="100%">
					<thead>
						<tr>
							<th scope="col" class="rounded-company" width="20%"><%= bundle1.getString("label.AbsenteesList.SelectedInformation")%></th>
							<th scope="col" class="rounded" width="1%"></th>
							<th scope="col" class="rounded" width="20%"></th>
							<th scope="col" class="rounded" width="20%"></th>
							<th scope="col" class="rounded" width="1%"></th>
							<th scope="col" class="rounded" width="20%"></th>
						</tr>
					</thead>
					<tr>
						<td colspan='6'>
						<table border='0' align="center" width="80%" cellspacing=0
							cellpadding=5>
							<tr>
								<td width='20%' class='tablebold'><%= bundle1.getString("label.AbsenteesList.AcademicYear")%> </td>
								<td width="1%" class="tablebold">:</td>
								<td width='20%'><%=Sessionname%></td>

								<td width='20%' class='tablebold'><%= bundle1.getString("label.AbsenteesList.Board")%></td>
								<td width="1%" class="tablebold">:</td>
								<td width='20%'><%=boardname%></td>
							</tr>
							<tr>
								<td width='20%' class='tablebold'><%= bundle1.getString("label.AbsenteesList.AppsentDate")%> </td>
								<td width="1%" class="tablebold">:</td>
								<td width='20%'><%=Displaydate1%></td>
		
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br></br>

				
			<tr>
				<td colspan="5" align="right"><a href="#" onclick="selectall()">Select
				All &nbsp;&nbsp; <a href="#" onclick="deselectall()">DeSelect
				All</td>
			</tr>
			<tr>
				<td align='left' width='100%' height='100%'>
				<table border='1' id=rounded-corner1 align="center" width="100%"
					cellspacing=0 cellpadding=5>

					<tr class='tableheading'>
						<td><%= bundle1.getString("label.AbsenteesList.Sl.No")%></td>
						<td width='25%'><%= bundle1.getString("label.AbsenteesList.StandardName")%></td>
						<td width='30%'><%= bundle1.getString("label.AbsenteesList.StudentName")%> </td>
						<td width='20%'><%= bundle1.getString("label.AbsenteesList.SectionName")%> </td>
						<td width='20%'><%= bundle1.getString("label.AbsenteesList.SMSContactNo")%></td>
						<td><%= bundle1.getString("label.AbsenteesList.Check")%></td>
					</tr>
					<%
						ArrayList SectionList = new ArrayList();
						ArrayList standarray = new ArrayList();
						ArrayList stuallocationarray = new ArrayList();
						ArrayList stdschedule_temp = new ArrayList();
						int slno=0;
						String studentallocationid = "";
						HashMap SectionListMap = new HashMap();
						try {
						int count_temp=0;
							if (StandardListName != null && StandardListName.size() > 0) {
								for (int y = 0; y < StandardListName.size(); y++) {

									hashmap = (HashMap) StandardListName.get(y);

									String standid = hashmap.get("standardscheduleid") + "";
									String standardname = hashmap.get("standardname") + "";
									String groupname = hashmap.get("groupname") + "";
									
									if (!groupname.equals("null"))
										standardname = standardname + " -" + groupname;
									if (!standarray.contains(standid)) {

										SectionList = attenquery.loadAbsentStudent(Sessionid, standid, searchdate,attendancestate);
										
										if (SectionList != null && SectionList.size() > 0)
										{
											
											//out.print("<tr><td></td><td colspan='5' align='left'>"+ standardname + "</td></tr>");
											for (int k = 0; k < SectionList.size(); k++)
											{
												SectionListMap = (HashMap) SectionList.get(k);
												studentallocationid = SectionListMap.get("studentallocationid")+ "";
												if (!stuallocationarray.contains(studentallocationid))
												{
													String smscontactno = SectionListMap.get("smscontactno")+ "";
													if (smscontactno.equals("null"))
														smscontactno = "-";
													 
													if(!stdschedule_temp.contains(standid))
													{
														out.print("<tr><td>"+ (slno+1)+ "</td><td>"+standardname+"</td>");
														slno++;
														stdschedule_temp.add(standid); 
													}
													else
													{
														out.print("<tr><td></td><td></td>");
													}
													
													out
															.print("<td>"
																	+ SectionListMap
																			.get("uname")
																	+ "</td><td>"
																	+ SectionListMap
																			.get("sectionname")
																	+ "</td><td>"
																	+ smscontactno
																	+ "</td><td><input type='checkbox' name='clickname' ></td><input type='hidden' name='hiddenmobileno' value='"
																	+ smscontactno
																	+ "'><input type='hidden' name='studentnames' value='"
																	+ SectionListMap
																			.get("uname")
																	+ "'></tr>");
													stuallocationarray
															.add(studentallocationid);
												}
											}

											standarray.add(standid);

										} else 
										{
										count_temp++;
										if(StandardListName.size()==count_temp)
										out.print("<tr><td colspan='6' align='center'>No absentees found</td></tr>");

										}
									}

								}
							}
							  
						} 

						catch (Exception e) {
							System.out.print(e);
						}
					%>


				</table>
				</td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
</table>

<iframe src="" width="0" height="0" id="fileopener">
<p>Your browser does not support iframes.</p>
</iframe> <BR>
<a href="#" class="bt_blue" onclick='backfun()'><span
	class="bt_blue_lft"></span><strong><%= bundle1.getString("button.AbsenteesList.Back")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick='sendsms()'><span
	class="bt_green_lft"></span><strong><%= bundle1.getString("button.AbsenteesList.SendSMS")%></strong><span
	class="bt_green_r"></span></a></form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>