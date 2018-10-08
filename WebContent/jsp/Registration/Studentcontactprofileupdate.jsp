<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Profile Update | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
	<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function backfun()
{
document.applicationform.action="./Studentprofileview.jsp";
document.applicationform.submit();
}
function Submitfun()   
{
	//if(check_ForParticularElements(document.applicationform.AddressForCommunication,'text',document.applicationform.communicationcountry,'select',document.applicationform.communicationstate,'select',document.applicationform.permanentstate,'select',document.applicationform.permanent,'text',document.applicationform.permanentcountry,'select',document.applicationform.communicationcity,'text',document.applicationform.communicationpin,'text',document.applicationform.permanentcity,'text',document.applicationform.permanentpin,'text',document.applicationform.email,'text',document.applicationform.mobileno,'text'))
	if(check_ForParticularElements(document.applicationform.AddressForCommunication,'text',document.applicationform.communicationcountry,'select',document.applicationform.communicationstate,'select',document.applicationform.permanentcountry,'select',document.applicationform.permanentstate,'select',document.applicationform.permanent,'text',document.applicationform.permanentcountry,'select',document.applicationform.communicationcity,'text',document.applicationform.communicationpin,'text',document.applicationform.permanentcity,'text',document.applicationform.permanentpin,'text',document.applicationform.mobileno,'text',document.applicationform.smscontactno,"text"))
	{
			
		if(document.applicationform.permanentstate.length==1)
		{ 		
			document.applicationform.hiddenpermanentstate.value=document.applicationform.othercommunicationstate1.value;
		}
		else
		{
			document.applicationform.hiddenpermanentstate.value=document.applicationform.permanentstate.value;
		}
		
		document.applicationform.hiddencommunicationcountry.value=document.applicationform.communicationcountry.value;
		document.applicationform.hiddenpermanentcountry.value=document.applicationform.permanentcountry.value;
		if(document.applicationform.communicationstate.length==1)
		{
			document.applicationform.hiddencommunicationstate.value=document.applicationform.othercommunicationstate.value;
		}
		else
		{
			document.applicationform.hiddencommunicationstate.value=document.applicationform.communicationstate.value;
		}
				 
		if(document.applicationform.hiddencommunicationstate.value=="")
		{
			 alert("State Not Selected");
			 document.applicationform.communicationstate.focus();
			 return false;
		}
		if(document.applicationform.hiddenpermanentstate.value=="")
		{
			 alert("State Not Selected");
			 document.applicationform.permanentstate.focus();
	 		 return false;
		}
		if(confirm("Are You Sure You Want Update"))
		{ 
			document.applicationform.action="./Studentcontactprofilesubmit.jsp";
			document.applicationform.submit();
		}
	}
}
var xmlDoc=null;
	function loadFirst()
	{
		/*if (window.ActiveXObject)
		{
			// code for IE
			xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		}
		else if(document.implementation.createDocument)
		{
			// code for Mozilla, Firefox, Opera, etc.
			xmlDoc=document.implementation.createDocument("","",null);
		}
		else
		{
			alert('Your browser cannot handle this script');
		}
		if (xmlDoc!=null)
		{
			xmlDoc.async=false;
			xmlDoc.load("../xml/Region.xml");
		}*/
		if (window.XMLHttpRequest)
		   		xhttp=new XMLHttpRequest();
		  	else
		   		xhttp=new ActiveXObject("Microsoft.XMLHTTP");
			xhttp.open("GET","../../xml/Region.xml",false);
			xhttp.send(null);
			xmlDoc=xhttp.responseXML;


		country_fun_1();
		//country_fun_2();
 	}

	function country_fun_1()
	{
		var obj=document.applicationform.communicationcountry;
   		var country_xml = xmlDoc.getElementsByTagName("location");
   		//alert("country_xml[0] ==>"+country_xml[0]);

 		if(country_xml[0] != null)
		{
			var states = country_xml[0].getElementsByTagName("country");
 			for(var i=0;i<states.length;i++)
			{
				var val=states[i].attributes.getNamedItem("name").nodeValue;
				//alert("==="+document.applicationform.hiddencommunicationcountry.value);
				obj.options[obj.options.length] = new Option(val,val);
				//alert(val+"==="+document.applicationform.hiddencommunicationcountry.value);
				if(val.toLowerCase()==document.applicationform.hiddencommunicationcountry.value.toLowerCase())
				{
				obj[i+1].selected=true;
				
				}
				else if(val=="India") 
				{
					obj[i+1].selected=true;
				}

			}
		}
		document.applicationform.othercommunicationstate1.style.visibility="hidden";
		document.applicationform.othercommunicationstate.style.visibility="hidden";
		state_fun(document.getElementById('communicationstate'),obj,document.getElementById('othercommunicationstate'),document.getElementById('hiddencommunicationstate'));
		
		country_fun_2();
	}

	function country_fun_2()
	{
//alert(document.applicationform.hiddenpermanentcountry.value);
		var obj=document.applicationform.permanentcountry;

		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var states = country_xml[0].getElementsByTagName("country");
			for(var i=0;i<states.length;i++)
			{
				var val=states[i].attributes.getNamedItem("name").nodeValue;
				obj.options[obj.options.length] = new Option(val,val);
				//alert(document.applicationform.hiddenpermanentcountry.value);
				if(val.toLowerCase()==document.applicationform.hiddenpermanentcountry.value.toLowerCase())
				{
				obj[i+1].selected=true;
				}
				else if(val=="India") 
				{
					obj[i+1].selected=true;
				}
			}
		}
		state_fun(document.getElementById('permanentstate'),obj,document.getElementById('othercommunicationstate1'),document.getElementById('hiddenpermanentstate'));
	}

	function state_fun(name,source,hiddenelement,hiddenstateobj)
	{
	optionDelete(name,1);
		var tmp_text=source.value;
		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var country = country_xml[0].getElementsByTagName("country");

			for(var i=0;i<country.length;i++)
			{
  				//alert(country[i].attributes.getNamedItem("name").nodeValue);

  				if(country[i].attributes.getNamedItem("name").nodeValue==tmp_text)
				{
					var states = country[i].getElementsByTagName("state");

					if(states.length>0)
					{
						for(var i=0 ,j=1;i<states.length;i++)
						{
						var val=states[i].attributes.getNamedItem("name").nodeValue;
							name.options[j] = new Option(states[i].attributes.getNamedItem("name").nodeValue,states[i].attributes.getNamedItem("name").nodeValue);
								if(val.toLowerCase()==hiddenstateobj.value.toLowerCase())
								{
									name[i+1].selected=true;
									
								}
								 else if(val=="Tamil Nadu") 
									{
									name[i+1].selected=true;
									} 
							
																								
						j++;
						}
						hiddenelement.style.visibility="hidden";
					}
					else
					{
					//alert("==>>");
					//alert("======>>");
					hiddenelement.style.visibility="visible";
					hiddenelement.value=hiddenstateobj.value
					//alert("======>>");
					}
					break;
    		   }

			}
		}
	}
function checkNumber(e)
 {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8 && code!=43 && code!=45 && code!=118 && code!=99 && code!=44)   
{
	if(code!=44)
	{
		if (code==47||code<46||code>57)
		{
			code=0;
			alert("Enter  Number only")
		
			if(window.event != null)
			{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;
			}
			else
			{
				e.preventDefault();
			}
			 return false;
		}
	}
}
}
function smsmobilecontactcheck(e)
 {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8 && code!=43 && code!=45 )   
{
	if (code==47||code<46||code>57)
		{
			code=0;
			alert("Enter  Number only")
		
			if(window.event != null)
			{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;
			}
			else
			{
				e.preventDefault();
			}
			 return false;
		}
}
}
	
</script>
</head>
<body onload='loadFirst()'>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<%-- <h2><%=bundle.getString("label.studentcontactprofileupdate.rootpath")%></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.studentcontactprofileupdate.rootpath")%></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>

<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
	String date_str = "";
	StudentRegistrationQuery studentquery = new StudentRegistrationQuery(); 	
		String communicationstreet1 = "";
		String communicationstreet2 = "";

		String communicationstate = "-";
		String communicationcountry = "-";
		String communicationcity = "-";
		String communicationpin = "-";
		String permanentstreet1 = "-";
		String permanentstreet2 = "-";

		String permanentstate = "-";
		String permanentcountry = "-";
		String permanentcity = "-";
		String permanentpin = "-";
		String phoneno = "-";
		String emailid = "-";
		String mobilenumber = "-";
		String smscontactno = "";

		
		
	String userid = request.getParameter("personid");
	String instituteid = null;
	try {
		instituteid = (String) session.getValue("instituteid");
 		ArrayList contact_list = studentquery.Studentcontactwithemaildetails(userid);
		HashMap map = null;
 		
		if (contact_list != null && contact_list.size() > 0) {
 			map = (HashMap) contact_list.get(0);
 			communicationstreet1 = (String) map	.get("communicationstreet1");
 			communicationstreet2 = (String) map	.get("communicationstreet2");

 			communicationcity = (String) map.get("communicationcity");
 			communicationstate = (String) map.get("communicationstate");
 			communicationcountry = (String) map	.get("communicationcountry");
 			communicationpin = (String) map.get("communicationpin");
 			permanentstreet1 = (String) map.get("permanentstreet1");
 			permanentstreet2 = (String) map.get("permanentstreet2");

 			permanentcity = (String) map.get("permanentcity");
 			permanentstate = (String) map.get("permanentstate");
 			permanentcountry = (String) map.get("permanentcountry");
 			permanentpin = (String) map.get("permanentpin");
 			 phoneno = (String) map.get("landlinenumber");
 			 emailid = (String) map.get("emailid");
 			 mobilenumber = (String) map.get("mobilenumber");
 			smscontactno = (String) map.get("smscontactno")+"";
 			if(smscontactno.equalsIgnoreCase("null") || smscontactno.equalsIgnoreCase(" ") || smscontactno.equalsIgnoreCase(""))
 				smscontactno="-";

 			
 		}

	} catch (Exception e) {
	}
%>

	<form name="applicationform" method="post" action=""><%@ page
		import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"	+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));
 	StudentRegistrationQuery Staffquery = new StudentRegistrationQuery();
 	ArrayList communityList = Staffquery.loadcommunity(instituteid);
 	ArrayList religionList = Staffquery.loadreligion(instituteid);
	
	// out.println("detaillist=========>>>>>"+detaillist);
 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
<input type="hidden" name="personid" value="<%=userid%>">
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
<input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">
<input type=hidden  name="hiddencommunicationcountry"	value="<%=communicationcountry %>">
<input type=hidden  name="hiddenpermanentcountry"	id="hiddenpermanentcountry" value="<%=permanentcountry%>">
<input type="hidden" name="hiddentext3" id="hiddentext3" value="" />
<input type="hidden" name="hiddentext" id="hiddentext" value="<%=communicationstate%>" />
<input type=hidden  name="hiddencommunicationstate"	id="hiddencommunicationstate" value="<%=communicationstate%>">
<input type="hidden" name="hiddentext2" id="hiddentext2" value="" />
<input type="hidden" name="hiddentext1" id="hiddentext1" value="<%=permanentstate%>" />
<input type=hidden  name="hiddenpermanentstate" id="hiddenpermanentstate"	value="<%=permanentstate%>">

<table border=0 id="rounded-corner" width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company"  width="90%" ><%=bundle.getString("label.schedule.selectedinfo")%></th>
					<th scope="col" class="rounded-q4" width="10%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
						<tr>
						<td colspan=2><table width="100%"><tr>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.AcademicYear")%>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%= request.getParameter("req_sessionname")%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Standard")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_standardnamegp")%>
						</td>
						</tr>
						<tr style="height: 20">
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Board")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_boardname")%>
						</td>
						<td class="tablebold" ><%=bundle.getString("label.studentprofile.Section")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_sessionname")%>
						</td>
						</tr>
						<tr>
							<td class="tablebold" ><%=bundle.getString("label.studentprofile.Name")%>
						</td>
						<td class="tablebold">:</td>
						<td class="tablelight" ><%=request.getParameter("req_studentname")%>
						</td>
						
						</tr>
						</table></td></tr>
				</tbody>
			</table><br></br>
 	<table id="rounded-corner" border=0 
		width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="100%" colspan=5 align=left><%=bundle.getString("label.studentcontactprofileupdate.StudentContactProfileAddressUpdate")%></th>
				<th scope="col" class="rounded-q4" width="1"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>
					<tr align=left>
						<td></td><td  class=tablebold colspan=2><u><%=bundle.getString("label.studentcontactprofileupdate.CommunicationAddress")%></u></td><td  class=tablebold colspan=2><u><%=bundle.getString("label.studentcontactprofileupdate.PermanentAddress")%></u></td></td><td>
					</tr>
					<tr valign=top>
							<td></td>
								<td  class=tablebold width=25%><%=bundle.getString("label.studentcontactprofileupdate.Street1")%>&nbsp;<font	color=red>*</font></td>
								<td class="tablelight"  align=left width=25%>
									<input type=text  	size=30 maxlength=100 validate="Communication Street 1"	name="AddressForCommunication" value="<%=communicationstreet1 %>">
								</td>
								<td class=tablebold  align="left" width=25%><%=bundle.getString("label.studentcontactprofileupdate.Street1")%>&nbsp;<font	color=red>*</font></td>
								<td  align="left" width=25%>
									<input type=text  	size=30 maxlength=100 validate="Permanent Street 1"	name="permanent"  value="<%=permanentstreet1 %>">
								</td>
								<td></td>
							</tr>
							<tr align=left>
								<td></td>
								<td   class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.Street2")%></td>
								<td class="tablelight"  align=left>	<input type=text  	size=30 maxlength=100 validate="Communication Street2"	name="Communicationstreet2"  value="<%=communicationstreet2 %>"></td>
								<td class=tablebold  align="left"><%=bundle.getString("label.studentcontactprofileupdate.Street2")%></td>
								<td  align="left">
								<input type=text  	size=30 maxlength=100 validate="Permanent Street2"	name="permanentstreet2"   value="<%=permanentstreet2%>"></td>
								<td></td>
								
							</tr>
							<tr height=30 align="left">
															<td></td>
							
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.country")%>&nbsp;<font	color=red>*</font></td>
								<td >
									<select size=1 cols=10	name="communicationcountry" validate="Communication Country" class=tablelight style="width:250px"			onchange="state_fun(document.getElementById('communicationstate'),this,document.getElementById('othercommunicationstate'),document.getElementById('hiddentext3'));">
											<option value="0">&nbsp;&nbsp; -- Select Country --	&nbsp;&nbsp;</option>
									</select>
								</td>
								<td class=tablebold  align="left"><%=bundle.getString("label.studentcontactprofileupdate.country")%>&nbsp;<font	color=red>*</font></td>
								<td  align="left"><select size=1 id="permanentcountry"  style="width:250px"
									name="permanentcountry" validate="Permanent Country" class=tablelight
									onchange="state_fun(document.getElementById('permanentstate'),this,document.getElementById('othercommunicationstate1'),document.getElementById('hiddentext2'));">
									<option value="0">&nbsp;&nbsp; -- Select Country --
									&nbsp;&nbsp;</option>
								</select>
								</td>
								<td></td>
								
							</tr>
							<tr height=30 valign=top align=left>
							<td></td>
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.state")%>&nbsp;<font	color=red>*</font> 
								</td>
								<td>
									<select name="communicationstate" style="width:250px" id="communicationstate" style="width:150"  validate="Communication State">
										<option>-- Select State --</option>
									</select><br>
									<input type="text" validate="Communication State" name="othercommunicationstate" id="othercommunicationstate" value="" size=25 maxlength=40/>
								</td>
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.state")%>&nbsp;<font	color=red>*</font></td>
								<td ><select name="permanentstate"  style="width:250px" id="permanentstate"	validate="Permanent State" class=tablelight maxlength=40>
									<option value="0">&nbsp;&nbsp; -- Select State --
									&nbsp;&nbsp;</option>
								</select>
								
								<input type="text" name="othercommunicationstate1" id="othercommunicationstate1" value="" size=25/></td>
								<td></td>
							</tr>
							<tr height=30 align=left>
							<td></td>
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.city")%>&nbsp;<font	color=red>*</font>
								</td>
								<td>
								 <input type=text name="communicationcity" validate="Communication City" maxlength=50 size=15	class=tablelight value="<%=communicationcity %>"></td>
								 <td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.city")%>&nbsp;<font	color=red>*</font></td>
								<td > <input type=text name="permanentcity" validate="Permanent City" id="citycity1" maxlength=50 size=15
									class=tablelight value="<%=permanentcity %>"></td><td></td>
							</tr>
							<tr align=left>
															<td></td>
							
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.Pin")%>&nbsp;<font	color=red>*</font></td>
								<td><input type="text" class="labeltextbox" class="tablelight" Validate="Communication Pin Code" name="communicationpin" size="6"		maxlength="6" maxlength="15"	onblur="address_Validation(this,this.name)" value="<%=communicationpin %>"></td>
								<td class=tablebold><%=bundle.getString("label.studentcontactprofileupdate.Pin")%>&nbsp;<font	color=red>*</font></td>
								<td><input type="text" class="labeltextbox"
									class="tablelight" name="permanentpin" validate="Permanent Pin Code" value="<%=permanentpin %>"size="6" maxlength="6"
									onblur="address_Validation(this,this.name)"></td><td></td>
							</tr>
						</table>
						</td>
						
					</tr>
					</tbody>
					</table>
					<br>
					<table id="rounded-corner" border=0 
		width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="100%" colspan=2><%=bundle.getString("label.studentcontactprofileupdate.StudentContactProfileUpdate")%></th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=2 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>
					<tr>
					
					
				<td colspan=3 align="center"><br>
				<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="5"
					cellspacing="0" align=left>
					<tr align=left>
						<td class=tablebold width="10%"><%=bundle.getString("label.studentcontactprofileupdate.HomePhoneNo.")%></td><td width="30%"><input type="text" class="labeltextbox"
							 name="telephone" value="<%=phoneno%>" size="25"
							maxlength="50" onkeypress="checkNumber(event)" ></td>
						<td class=tablebold width="10%" align=left><%=bundle.getString("label.studentcontactprofileupdate.Email")%>&nbsp;</td><td width="40%"><input
							type="text" class="tablelight" maxlength="50" name="email"	validate='Email'  size="38" value="<%=emailid %>" ></td>
					</tr>
					<tr align=left>
						<td class=tablebold width="20%"><%=bundle.getString("label.studentcontactprofileupdate.MobileNo.")%>&nbsp;<font	color=red>*</font> </td><td width="30%" ><input type="text" class="labeltextbox"
							class="tablelight" name="mobileno" validate="Mobile Number" value="<%=mobilenumber%>" size="25"  onkeypress="checkNumber(event)"		maxlength="44"></td><td class=tablebold width="20%"><%=bundle.getString("label.studentcontactprofileupdate.smscontact.")%>&nbsp;<font	color=red>*</font> </td><td width="30%" ><input type="text" class="labeltextbox"
							class="tablelight" name="smscontactno" validate="SMS Contact Number" value="<%=smscontactno%>" size="25"		onkeypress="smsmobilecontactcheck(event)"	maxlength="44"></td>
					</tr>
				</table> 
				</td>
			</tr>
		</tbody>
	</table>
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentcontactprofileupdate.Back")%></strong><span
		class="bt_blue_r"></span></a>
	 <a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentcontactprofileupdate.Submit")%></strong><span
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