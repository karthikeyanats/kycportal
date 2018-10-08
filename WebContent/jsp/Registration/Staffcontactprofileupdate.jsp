<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffcontactprofileupdate.title") %> | Powered by i-Grandee</title>
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
<SCRIPT language="JavaScript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript"
	src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>

<script type="text/javascript">
function checkNumber(e) {
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
function backfun()
{
document.applicationform.action="./StaffProviewView.jsp";
document.applicationform.submit();
}
function Submitfun()
{

	if(check_ForParticularElements(document.applicationform.AddressForCommunication,'text',document.applicationform.street2,'text',document.applicationform.communicationcountry,'select',document.applicationform.communicationstate,'select',document.applicationform.communicationcity,'text',document.applicationform.communicationpin,'text',document.applicationform.permanent,'text',document.applicationform.permanentstreet2,'text',document.applicationform.permanentcountry,'select',document.applicationform.permanentstate,'select',document.applicationform.permanentcity,'text',document.applicationform.permanentpin,'text',document.applicationform.mobileno,'text',document.applicationform.smscontactno,'text',document.applicationform.email,'text'))
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
			if(!email_Validation(document.applicationform.email,"Mail Id",true))
				 {
						return false;
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
	
		 if(confirm("Do you want to Update the Staff Profile...?"))
		 {		 
			document.applicationform.action="./Staffcontactprofilesubmit.jsp";
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

<%-- <h2><%=bundle.getString("label.staffcontactprofileupdate.rootpath") %></h2> --%>

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.staffcontactprofileupdate.rootpath") %></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>

<%@ page
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StaffRegistrationQuery"%>

<%
	String date_str = "";
	StaffRegistrationQuery staffquery = new StaffRegistrationQuery();
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
	String mobileno = "-";
	String personid = "-";
	String smscontactno = "-";

	
	String emailid = "-";

	String Staffid = request.getParameter("Staffid");
	String departid=request.getParameter("departmentid");

	String instituteid = null;
	try {
		instituteid = (String) session.getValue("instituteid");
		ArrayList contact_list = staffquery
				.staffaddressprofiledetail(Staffid);
		HashMap map = null;
		if (contact_list != null && contact_list.size() > 0) {
			map = (HashMap) contact_list.get(0);
			communicationstreet1 = (String) map
					.get("communicationstreet1");
			communicationstreet2 = (String) map
					.get("communicationstreet2");

			communicationcity = (String) map.get("communicationcity");
			communicationstate = (String) map.get("communicationstate");
			communicationcountry = (String) map
					.get("communicationcountry");
			communicationpin = (String) map.get("communicationpin");
			permanentstreet1 = (String) map.get("permanentstreet1");
			permanentstreet2 = (String) map.get("permanentstreet2");

			permanentcity = (String) map.get("permanentcity");
			permanentstate = (String) map.get("permanentstate");
			permanentcountry = (String) map.get("permanentcountry");
			permanentpin = (String) map.get("permanentpin");
			phoneno = (String) map.get("landlinenumber");
			mobileno = (String) map.get("mobilenumber");

			emailid = (String) map.get("emailid");
			personid = (String) map.get("personid");
			smscontactno = (String) map.get("smscontactno");
			if(smscontactno==null)
				smscontactno="";

			
		}

	} catch (Exception e) {
	}
%>

<form name="applicationform" method="post" action=""><%@ page
	import="java.io.*,java.util.*"%> <%
 	StringBuffer currentDate = new StringBuffer();
 	Date dateObj = new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"
 			+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));

 	// out.println("detaillist=========>>>>>"+detaillist);
 %> <input type="hidden" name="currentDate" value="<%=currentDate%>">
 <input	type="hidden" name="Staffid" value="<%=Staffid %>">
 <input type="hidden" name="departmentid" value="<%=departid%>"/>
 
 <input	type="hidden" name="personid" value="<%=personid %>">
 <input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>
 
<table id="rounded-corner" border=0 width="100%">
	<thead>
		<tr>
			<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffcontactprofileupdate.title") %></th>
			<th scope="col" class="rounded-q4" width="1%"></th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td colspan=1 class="rounded-foot-left"><em></em></td>
			<td class="rounded-foot-right">&nbsp;</td>
		</tr>
	</tfoot>
	<tbody>
<tr><td align=left  colspan=2><h3><%=bundle.getString("label.staffprofileupdate.CommunicationAddress")%></h3></td></tr>
		<tr>
			<td valign="top" align=left  colspan=2>
			<table border="0" width="100%"  cellpadding="0" cellspacing="0" >
				<tr height=30 align="left">
					<td align=left class=tablebold><%=bundle.getString("label.staffprofileupdate.Street1") %>&nbsp;<font color=red>*</font></td>
					<td width="70%" ><input type="text" name="AddressForCommunication" Validate="Communication Street1"
						value="<%=communicationstreet1%>" size=45 /></td>
				</tr>
				<tr height=30 align="left">
					<td  align=left class=tablebold><%=bundle.getString("label.staffprofileupdate.Street2") %>&nbsp;<font color=red>*</font></td>
					<td><input type="text" name="street2"
						value="<%=communicationstreet2%>" Validate="Communication Street2" size=45 /></td>
				</tr>
				<tr height=30 align="left">
					<td class=tablebold><%=bundle.getString("label.staffprofileupdate.Country") %>&nbsp;<font color=red>*</font></td>
					<td ><select size=1 cols=10
						name="communicationcountry" validate="Communication Country" class=tablelight  style='width:250px'
						onchange="state_fun(document.getElementById('communicationstate'),this,document.getElementById('othercommunicationstate'),document.getElementById('hiddentext3'));">
						<option value="0">&nbsp;&nbsp; -- Select Country --
						&nbsp;&nbsp;</option>
					</select> <input type=hidden name="hiddencommunicationcountry"
						value="<%=communicationcountry %>" /></td>
				</tr>
				<tr height=30 valign=top align="left">
					<td class=tablebold><%=bundle.getString("label.staffprofileupdate.State") %>&nbsp;<font color=red>*</font></td>
					<td ><select validate="Communication State" name="communicationstate" style='width:250px'
						id="communicationstate" validate="State">
						<option>-- Select State --</option>
					</select><br>
					<input type="hidden" name="hiddentext3" id="hiddentext3" value="" />
					<input type="hidden" name="hiddentext" id="hiddentext"
						value="<%=communicationstate%>" /> <input type=hidden
						name="hiddencommunicationstate" id="hiddencommunicationstate"
						value="<%=communicationstate%>" /><input type="text"
						name="othercommunicationstate" id="othercommunicationstate"
						value="" /></td>
				</tr>




				<tr height=30 align="left">
					<td class=tablebold><%=bundle.getString("label.staffprofileupdate.City") %>&nbsp;<font color=red>*</font> <%
 	//out.println(request.getParameter("communicationcity")+"#");
 %>
					</td>
					<td ><input type=text name="communicationcity"
						maxlength=50 size=15 class=tablelight Validate="Communication City"
						value="<%=communicationcity %>" /></td>
				</tr>
				<tr align="left">
					<td class="tablebold"><%=bundle.getString("label.staffprofileupdate.Pin") %>&nbsp;<font color=red>*</font></td>
					<td><input type="text"
						name="communicationpin" size="6" maxlength="6" maxlength="15" Validate="Communication Pin"
						 onkeypress="checkNumber(event)"
						value="<%=communicationpin %>" /></td>
				</tr>
				
			</table>
			</td>
			</tr>
			<tr>
			<td align=left colspan=2><h3><%=bundle.getString("label.staffprofileupdate.PermanentAddress")%></h3></td></tr>
			<tr>
			<td valign="top"  align=left colspan=2>
			<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="5"
				cellspacing="0">
				<tr height=30 align="left">
					<td  align=left class=tablebold><%=bundle.getString("label.staffprofileupdate.Street1") %>&nbsp;<font color=red>*</font></td>
					<td width="70%"><input type="text" name="permanent"
						value="<%=permanentstreet1%>" Validate="Permanent Street1" size=45 /></td>
				</tr>
				<tr height=30 align="left">
					<td  align=left class=tablebold><%=bundle.getString("label.staffprofileupdate.Street2") %>&nbsp;<font color=red>*</font></td>
					<td><input type="text" name="permanentstreet2" Validate="Permanent Street2"
						value="<%=permanentstreet2%>" size=45 /></td>
				</tr>
				<tr height=30>
					<td class=tablebold  align="left"><%=bundle.getString("label.staffprofileupdate.Country") %>&nbsp;<font color=red>*</font></td>
					<td  align="left"><select size=1
						id="permanentcountry" name="permanentcountry" validate="Permanent Country"
						class=tablelight  style='width:250px'
						onchange="state_fun(document.getElementById('permanentstate'),this,document.getElementById('othercommunicationstate1'),document.getElementById('hiddentext2'));">
						<option value="0">&nbsp;&nbsp; -- Select Country --
						&nbsp;&nbsp;</option>
					</select> <input type=hidden name="hiddenpermanentcountry"
						id="hiddenpermanentcountry" value="<%=permanentcountry%>" /></td>
				</tr>
				<tr height=30 valign=top>
					<td class=tablebold><%=bundle.getString("label.staffprofileupdate.State") %>&nbsp;<font color=red>*</font></td>
					<td><select name="permanentstate" validate="Permanent State" id="permanentstate" style='width:250px'
						validate="user_state" class=tablelight>
						<option value="0">&nbsp;&nbsp; -- Select State --
						&nbsp;&nbsp;</option>
					</select> <input type="hidden" name="hiddentext2" id="hiddentext2" value="" />
					<input type="hidden" name="hiddentext1" id="hiddentext1"
						value="<%=permanentstate%>" /> <input type=hidden
						name="hiddenpermanentstate" id="hiddenpermanentstate"
						value="<%=permanentstate%>" /><input type="text"
						name="othercommunicationstate1" id="othercommunicationstate1"
						value="" /></td>
				</tr>
				<tr height=30>
					<td class=tablebold><%=bundle.getString("label.staffprofileupdate.City") %>&nbsp;<font color=red>*</font></td>
					<td><input type=text name="permanentcity" id="citycity1"
						maxlength=50 size=15 class=tablelight value="<%=permanentcity %>" Validate="Permanent City" /></td>
				</tr>
				<tr>
					<td class="tablebold"><%=bundle.getString("label.staffprofileupdate.Pin") %>&nbsp;<font color=red>*</font></td>
					<td><input type="text" class="labeltextbox" class="labelfont" Validate="Permanent Pin"
						name="permanentpin" value="<%=permanentpin %>" size="6"
						maxlength="6" onkeypress="checkNumber(event)" /></td>
				</tr>
				<tr>
					<td colspan=3></td>
				</tr>

			</table>
			
			
			
			</td>
		</tr>
			<tr>
			<td align=left colspan=2><h3><%=bundle.getString("label.staffprofileupdate.ContactAddress")%></h3></td></tr>
			<tr>
		<tr>
		<td  colspan=2>
		<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="5" 	cellspacing="0">
			<tr align="left">
					<td class="tablebold" ><%=bundle.getString("label.staffprofileupdate.MobileNo") %>&nbsp;<font color=red>*</font></td><td width=70%> <input type="text" class="labeltextbox"
					class="labelfont" name="mobileno" value="<%=mobileno%>" size="25" Validate="Mobile Number"
					maxlength="50"  onkeypress="checkNumber(event)" /></td>
				</tr>
				<tr align="left">
					<td class="tablebold"  align=left ><%=bundle.getString("label.staffprofileupdate.LandLineNo") %></td><td> <input
					type="text" class="labelfont" maxlength="50" name="landline" Validate="LandLine No"
					size="38" value="<%=phoneno %>"  onkeypress="checkNumber(event)" /></td>
				</tr>
				<tr><td class=tablebold  align=left><%=bundle.getString("label.staffprofileupdate.SMSContactNo") %>&nbsp;<font color=red>*</font></td>
					<td class=tablebold align=left ><input type="text" class="labeltextbox"
					class="labelfont" class="tablelight" name="smscontactno" value="<%=smscontactno%>" size=38 validate='SMS Contact Number' maxlength="50" onkeypress="checkNumber(event)" /></td>
				</tr><tr align="left">
					<td class="tablebold"  align=left ><%=bundle.getString("label.staffprofileupdate.Email") %>&nbsp;<font color=red>*</font></td><td> <input
					type="text" class="labelfont" maxlength="50" name="email"
					size="38" value="<%=emailid %>"  /></td>
				</tr>
			</table>
		</td>
		</tr>
	</tbody>
</table>
<a href="#" onclick="backfun()" class="bt_blue"><span
	class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffprofileupdate.Back") %></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="Submitfun()"><span
	class="bt_green_lft"></span><strong><%=bundle.getString("button.staffprofileupdate.Submit") %></strong><span
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