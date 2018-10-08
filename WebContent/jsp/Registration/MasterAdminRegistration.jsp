<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<LINK rel=stylesheet href="../css/vlearn_sty.css">
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="NetObjects Fusion 4.0 Trial for Windows">
<LINK rel=stylesheet href="<%=request.getContextPath() %>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../kycpanel/style.css" />

<SCRIPT language="JavaScript" src='../../js/Calendar/Calendar.js'></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>

<script language="JavaScript">
var is_ie 		= (/msie/i.test(navigator.userAgent));
function calcAge(args)
{
	//alert(args);
	var ages = 0;
		var birthDate = new Date(args);
		var currentDate = new Date();
		var birthYear = "0";
		if(2000<=birthDate.getYear())
		{
		   birthYear = birthDate.getYear();
		}
		else
		if(is_ie)
		{
		   birthYear = birthDate.getYear()+1900;
	   }
	   else
	   {
		   birthYear = birthDate.getYear();
	   }

		var currentYear = currentDate.getYear();
		ages = currentYear -  birthYear;
		var birthMonth = birthDate.getMonth()+1;
		var currentMonth = currentDate.getMonth()+1;
		if(currentMonth<birthMonth)
			ages = ages - 1;

	return ages;
}
function calcagefun()
{
var dob=document.University.txt_dob.value.split("-");
mon="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
mon=mon.split(",");
for(var i=0;i<mon.length;i++)
{
if(dob[1]==mon[i])
{
var age=calcAge(i+1+"/"+dob[0]+"/"+dob[2]);
document.University.age.value=age;
document.getElementById("displayage").innerHTML=age;
}
}
}
function checkNnmerickey(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8)
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
function submission()
	{
		var pasword  = document.University.txt_passward.value;
		var paswordconfirm  = document.University.txt_confirm.value;
 
		 if(check_ForParticularElements(document.University.txt_school_name,"text",document.University.txt_street1,"text",document.University.txt_city,"text",document.University.slt_country,"select",document.University.slt_state,"text",document.University.txt_zip,"text",document.University.txt_contact,"text",document.University.txt_mail,"text",document.University.txt_mobile,"text",document.University.txt_fax,"text",document.University.currencytype,"text",document.University.txt_fname,"text",document.University.txt_lname,"text",document.University.txt_dob,"text",document.University.slt_sex,"select",document.University.age,"text",document.University.txt_qualification,"text",document.University.txt_street2,"text",document.University.txt_street_admin,"text",document.University.txt_city_admin,"text",document.University.slt_country_admin,"select",document.University.slt_state_admin,"text",document.University.txt_zip_admin,"text",document.University.txt_contact_admin,"text",document.University.txt_mail_admin,"text",document.University.txt_mobile_admin,"text",document.University.txt_username,"text",document.University.txt_passward,"password", document.University.slt_hint,"select", document.University.txt_answer,"text",document.University.txt_confirm,"password",document.University.txt_answer,"text"))
 		{
			if(!email_Validation(document.University.txt_mail,"Mail Id",true))
			 {
 				return false;
			 }
			 if(!email_Validation(document.University.txt_mail_admin,"Mail Id",true))
			 {
				return false;
			 }
			 if(!numeric_Validation(document.University.txt_zip,"Zip Code",true))
			 {

				return false;
			 }
			 if(!numeric_Validation(document.University.txt_zip_admin,"Zip Code",true))
			 {
				
				return false;
			 }
			 
 			 if(!stringValidate(document.University.txt_fname,"First Name"))
			 {
				
				document.University.txt_fname.focus();
				return false;
			 }
			 if(!stringValidate(document.University.txt_mname,"Middle Name"))
			 {
				
				document.University.txt_mname.focus();
				return false;
			 }
			 if(!stringValidate(document.University.txt_lname,"Last Name"))
			 {
				
				document.University.txt_lname.focus();
				return false;
			 }
			 if(document.University.txt_username.value.length<3)
			 {
				 
				 alert("Username must be grater than 3 charectors");
				 return false;
			 }
			 if(document.University.txt_passward.value.length<3)
			 {
				 
				 alert("Password must be grater than 3 charectors");
				 return false;
			 }

			 if(!checkUserAndPassword(document.University.txt_username)){
				 
				 return false;
			 };
			 if(!checkUserAndPassword(document.University.txt_passward)){
				 
				 return false;
			 };
			 if(pasword!=paswordconfirm){
			 alert("Password and Confirm password Should Be Same")
				 return false;
			 };
			  doCompletion(document.University.txt_school_name.value,"schoolname");
			}

	}
	function loadFirst()
	{
		if (window.XMLHttpRequest)
		xhttp=new XMLHttpRequest();
	  	else
	   		xhttp=new ActiveXObject("Microsoft.XMLHTTP");
		xhttp.open("GET","../../xml/Region.xml",false);
		xhttp.send(null);
		xmlDoc=xhttp.responseXML;
		country_fun_1();
		country_fun_2();
	}
	function country_fun_1()
	{
		var obj=document.University.slt_country;
   		var country_xml = xmlDoc.getElementsByTagName("location");
 		if(country_xml[0] != null)
		{
			var states = country_xml[0].getElementsByTagName("country");
 			for(var i=0;i<states.length;i++)
			{
				var val=states[i].attributes.getNamedItem("name").nodeValue;
				obj.options[obj.options.length] = new Option(val,val);

			}
		}
	}
	function country_fun_2()
	{
		var obj=document.University.slt_country_admin;

		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var states = country_xml[0].getElementsByTagName("country");
			for(var i=0;i<states.length;i++)
			{
				var val=states[i].attributes.getNamedItem("name").nodeValue;
				obj.options[obj.options.length] = new Option(val,val);

			}
		}
	}
	
	function state_fun(name,dest,source)
	{
		var tmp_text=source.value;
		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var country = country_xml[0].getElementsByTagName("country");

			for(var i=0;i<country.length;i++)
			{

				//alert(country[i].attributes.getNamedItem("name").nodeValue);
				//alert(tmp_text);

 				if(country[i].attributes.getNamedItem("name").nodeValue==tmp_text)
				{
					var states = country[i].getElementsByTagName("state");

					for(var i=dest.rows.length-1;i>-1;i--)
					{
						dest.deleteRow(i);
					}


					if(states.length>0)
					{

						var code="<select name='"+name+"' style='width:150px' >\n";


						for(var i=0;i<states.length;i++)
						{
							code+="<option value="+states[i].attributes.getNamedItem("name").nodeValue+">"+states[i].attributes.getNamedItem("name").nodeValue+"</option>\n";
						}
						code+="</select>\n";

						tBody = document.createElement("tbody");

							tr=document.createElement("tr");
							tr.height=30;

							tBody.appendChild(tr);

							td=document.createElement("td");
							td.className='tablelight';
							td.width=20;
							td.align='center';
							td.innerHTML=code;
							tr.appendChild(td);

							dest.appendChild(tBody);
					}
					else
					{
						tBody = document.createElement("tbody");

							tr=document.createElement("tr");
							tr.height=30;

							tBody.appendChild(tr);

							td=document.createElement("td");
							td.className='tablelight';
							td.width=20;
							td.align='center';
							td.innerHTML="<input type='text' name="+name+">";
							tr.appendChild(td);

							dest.appendChild(tBody);
					}
					break;
				}
			}
		}
	}
	function doCompletion(id,flag)
	{
	   var url = "";
	   if(flag=="schoolname")
	   {
		   url = "../getLoginInfo.jsp?action=schoolname&name="+id;
	   }
	 else if(flag=="username")
	   {
		   url = "../getLoginInfo.jsp?action=username&name="+id;
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
			   	   	   
			   
				  if(flag=="schoolname")
				  {
					 parseMessages(req.responseXML,flag);

				  }
				 else if(flag=="username")
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

		if(flag=="schoolname")
		{
		var temp="";
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				 temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
			if(temp=="true")
			{
				alert("School Name already exists");
				return false;
			}
			else
			{
				doCompletion(document.University.txt_username.value,"username");
			}
			
		}
		if(flag=="username")
		{
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						
			}
			if(temp=="true")
				{
					alert("User Name already exists");
					return false;
				}
				else
				{
				document.University.Schoolusername.value=document.University.txt_username.value;
					document.University.action="./SchoolRegistrationPreview.jsp";
					document.University.submit();
			}
		}
	}
</script>
</HEAD>
<BODY  LINK="#0000FF" VLINK="#800080" TEXT="#000000" TOPMARGIN=0 LEFTMARGIN=0 MARGINwidth=0 MARGINheight=0 onload="loadFirst()">
<div id="main_container">

	<div class="header">
   
    </div>

    <div class="main_content">



    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
        <TABLE class=tableBody_border  align=center width=100% height=95%  cellspacing=0 cellpadding=8>
        <TR><TH class=tableBody_BG height=45 align=left valign=bottom>
        <font class=tableBody>Master Admin  Registration</font>
        </TH></TR>
        <TR><TD valign=top><br>
<form name="University" method="post" enctype="multipart/form-data">
<input type="hidden" name="Schoolusername" value="">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center height=485 cellpadding=0>
  <TR valign="TOP" style="height:190">
      <TD>
 		<table border=0 bordercolor='#EFEFE7' align=center class=tablehead cellpadding=0 cellspacing=0 width="95%" rules="groups">
				<tr>
					<td width="100%" >
					<fieldset >
					<legend class="heading1">Master Admin Information</legend>  
					<br >
							<table width="100%" border=0 bgcolor="#ffffff" cellspacing="2">
								<tr style="height:25">
									<td class="tablebold" width="18%">
										 Name of School <font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="82%" colspan="3">
										<input type"text" size="50" name="txt_school_name" maxlength="50" validate="Name of School" value="" >
									</td>
								</tr>
 								
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 Street <font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="23%">
										<input type="text" name="txt_street1" maxlength="25" validate="Street"  value="">
									</td>
									<td class="tablebold" width="10%">
										City<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="55%">
										<input type="text" name="txt_city" maxlength="25" validate="City" value="">
									</td>
		
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 Country<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
										<select name="slt_country" style="width:150px"  onchange="state_fun('slt_state',document.getElementById('univ_state_tab'),this)"  validate="Country">
											<option>Select</option>
										</select>
 									</td>
									<td class="tablebold" width="10%">
										State<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="70%">
										<table id="univ_state_tab">
											<tr>
												<td>
													<select name="slt_state" style="width:150px"   validate="State">
														<option>Select</option>
													</select>

												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 Zipcode<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
										<input type="text" name="txt_zip" maxlength="6" value="" validate="Zipcode" onkeypress="return checkNnmerickey(event)">
									</td>
									<td class="tablebold" width="10%">
										Contact No<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_contact" maxlength="50" value="" validate="ContactNo" onkeypress="return checkNnmerickey(event)">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 Email<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
										<input type="text" name="txt_mail" maxlength="50" value="" validate="email">
									</td>
									<td class="tablebold"width="18%">
										Web
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_web" maxlength="30" value="" validate="web">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" width="10%">
										 Mobile<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="10%">
										<input type="text" name="txt_mobile" maxlength="50" value="" validate="Mobile" onkeypress="return checkNnmerickey(event)">
									</td>
									<td class="tablebold"width="10%">
										Fax<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" width="70%">
										<input type="text" name="txt_fax" maxlength="30" value="" validate="Fax" onkeypress="return checkNnmerickey(event)">
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Institute Logo<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%" colspan=2>
										<input type ="file" name="logo" validate="photo"  maxlength=500  style="width:220" class=tablelight>
									</td>
									
									<td class="tablebold" style="width:17%">
									</td>
									<td class="tablebold" style="width:34%">
									</td>

								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Currency Type <font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%" colspan=2>
										<input type ="text" name="currencytype" validate="Currency Type" value="">
									</td>
									
									<td class="tablebold" style="width:17%">
									</td>
									<td class="tablebold" style="width:34%">
									</td>

								</tr>
								
							</table>
												</fieldset>
							

					</td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
									<td><br></td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
					<td><br></td>
				</tr>
				<tr >
					<td width="100%">
					<fieldset >
					<legend class="heading1">Admin Information</legend>
					<br >
						<table width="100%" border=0 bgcolor="#ffffff" cellspacing="2">
							<tr   height=10 bgcolor="#ffffff">
								<td class="tablebold">
									<font color="red">Personal :</font>
								</td>
							</tr>

 							<tr style="height:25">
								<td class="tablebold" style="width:20%">
									 Prefix<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" style="width:15%">
									<select name="slt_prefix"  maxlength=6  class=tablelight validate="prefix">
										 <option value="Mr.">Mr.</option>
										 <option value="Mrs.">Mrs.</option>
										 <option value="Ms.">Ms.</option>
										 <option value="Dr.">Dr.</option>
										 <option value="Sir.">Sir.</option>
									 </select>
									 								</td>
								<td class="tablebold" style="width:17%"></td>
								<td class="tablebold" style="width:17%"></td>
								<td class="tablebold" style="width:34%"></td>
							</tr>

 							<tr style="height:25" class="tablebold" >
								<td class="tablebold"  >
									 Firstname<font color=red>&nbsp;&nbsp;*</font>
									</td><td>
									<input type="text" name="txt_fname" maxlength="20"  value="" validate="firstname">
								        </td><td >
									Middle
									</td>
									<td>
									<input type="text" name="txt_mname" maxlength="20"  value="" validate="middle">
									</td>
									<td>
									Last<font color=red>&nbsp;*</font><input type="text" name="txt_lname" size=17 maxlength="20"  value="" validate="last">
								 	 	
								</td>
							</tr>
							<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Date Of Birth<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_dob" validate="dob"  value="" size=10 readonly>&nbsp;<input type="button" class="tablehead" value="^" onclick="document.University.txt_dob.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','University.txt_dob','0',event,'Not_Less_Than_CurrentDate',document.University.server_date);">
									</td>
									<td class="tablebold" style="width:17%">
										Sex<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" style="width:17%">
 										 <select name="slt_sex"  maxlength=6  class=tablelight validate="sex">
											 <option>Select</option>
											 <option value="Male">Male</option>
											 <option value="Female">Female</option>
	   									 </select>
									</td>
									<td class="tablebold" style="width:34%">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Age<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" readonly name=age size=3 value="" validate="Age" onblur='calcagefun()' onclick='calcagefun()'>
									</td>
									<td class="tablebold" style="width:17%">

									</td>
									<td class="tablebold" style="width:17%">

									</td>
									<td class="tablebold" style="width:34%">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Qualification<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_qualification" maxlength="" value="" validate="qualification">
									</td>
									<td class="tablebold" style="width:17%">

									</td>
									<td class="tablebold" style="width:17%">

									</td>
									<td class="tablebold" style="width:34%">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Photo<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%" colspan=4>
										<input type ="file" name="photo" validate="photo"  size = 50 maxlength=500  style="width:220" class=tablelight>
									</td>
								</tr>



								<tr   height=10 bgcolor="#ffffff">
									<td class="tablebold">
										<font color="red">Contact :</font>
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" width="12%" >
										 Street 1<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" width="88%" colspan="3">
										<input type="text" name="txt_street2" maxlength="25" validate="street"  value="" >
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Street 2<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_street_admin" maxlength="40" value="" validate="street">
									</td>
									<td class="tablebold" style="width:17%">
										City<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" style="width:17%">
										<input type="text" name="txt_city_admin" maxlength="30" validate="city" value="">
									</td>

											<td class="tablebold" style="width:34%" rowspan=4 align="center">
											</td>
										</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Country<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<!--<select name="slt_country_admin" style="width:150" validate="country"  onchange="loadStatesAdmin(this)">
											<option>Select</select>
										</select>
										<script>
 											loadCountry(document.University.slt_country_admin);
										</script>-->

										<select name="slt_country_admin" style="width:150px" onchange="state_fun('slt_state_admin',document.getElementById('admin_state_tab'),this)"   validate="country">
											<option>Select</option>
										</select>
 									</td>
									<td class="tablebold" style="width:17%">
										State<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" style="width:17%">
										<table id="admin_state_tab">
											<tr>
												<td>
													<select name="slt_state_admin"  validate="" style="width:150px" >
														<option>Select</option>
													</select>
												</td>
											</tr>
										</table>
									</td>


								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Zipcode<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_zip_admin" maxlength="6" validate="zipcode" value="" onkeypress="return checkNnmerickey(event)">
									</td>
									<td class="tablebold" style="width:17%">
										Contact No<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablebold" style="width:17%">
										<input type="text" name="txt_contact_admin" maxlength="50" validate="contactno" value="" onkeypress="return checkNnmerickey(event)">
									</td>
								</tr>
								<tr style="height:25">
									<td class="tablebold" style="width:20%">
										 Email<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_mail_admin" maxlength="50" validate="email" value="">
									</td>
									<td class="tablebold" style="width:20%">
										 Mobile No<font color=red>&nbsp;&nbsp;*</font>
									</td>
									<td class="tablelight" style="width:15%">
										<input type="text" name="txt_mobile_admin" maxlength="50" validate="Mobile" value="" onkeypress="return checkNnmerickey(event)">
									</td>
									<!--<td class="tablebold" style="width:17%">
										web
									</td>
									<td class="tablebold" style="width:17%">
										<input type="text" name="txt_web_admin" maxlength="40" validate="web">
									</td>-->


								</tr>


						</table>
		</fieldset>
					</td>
				</tr>
				<tr   height=10 bgcolor="#ffffff">
					<td><br></td>
				</tr>
				<tr   height=25>
				</tr>
				<tr>
					<td width="100%">
					<fieldset >
					<legend class="heading1">Account Information</legend>
					<br>
					<table width="100%" border=0 bgcolor="#ffffff" cellspacing="2">
							<tr style="height:25">
								<td class="tablebold" width="16%">
									 Username<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" >
									<input type="text" name="txt_username" validate="username" value="" maxlength="50" onkeyup='javascript:this.value=this.value.toLowerCase()'>
								</td>
								<td class="tablebold" >
 								</td>
								<td class="tablebold" >
 								</td>
								<td class="tablebold" >
 								</td>
								<td class="tablebold" >
 								</td>
							</tr>
							<tr style="height:25">
								<td class="tablebold" width="15%">
									 Password<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" >
									<input type="password" name="txt_passward" validate="password" value="" maxlength="50" onkeyup='javascript:this.value=this.value.toLowerCase()'>
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
							</tr>
							<tr style="height:25">
								<td class="tablebold" width="15%">
									 Confirm<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" >
									<input type="password" name="txt_confirm" value="" validate="Confirm Password" maxlength="50" onkeyup='javascript:this.value=this.value.toLowerCase()'>
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
															</td>
							</tr>
							<tr style="height:25">
								<td class="tablebold" width="15%">
									 Hint<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" >
									 <select name="slt_hint"  maxlength=12 value="" class=tablelight validate="PasswordHint" >
									 		 <option value="0">--Select Hint--</option>
									 		 <option value="What is ur pet name">What is ur pet name</option>
									 		 <option value="What is ur favorite color">What is ur favorite color</option>
									 		 <option value="What is ur friend name">What is ur friend name</option>
	   								 </select>
	   								 
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
							</tr>
							<tr style="height:25">
								<td class="tablebold" width="15%">
									 Answer<font color=red>&nbsp;&nbsp;*</font>
								</td>
								<td class="tablelight" >
									 <input type"text" maxlength="10" name="txt_answer" value="">
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
								<td class="tablebold" >
								</td>
							</tr>
						</table>
						</fieldset >
					</td>
				</tr>

			</table>


		</td>
	</tr>

			<tr valign="TOP">
					<td align="center">
					<br>
					<a href="#bbb" name="bbb" onclick='submission()' class="bt_green" align=center><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
					</td>
		</tr>


</table>



	<input type=hidden name=server_date value="">
	<input type=hidden name="hid_photo" value="hid_photo">
	<input type=hidden name="institutionmode" value="MA">
	
	
</form>

</td>
</tr>
</table>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
</div>

 </BODY>
</HTML>


