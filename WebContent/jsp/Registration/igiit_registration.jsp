<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<XML id=location_xml src="../../xml/Region.xml"></XML>
<title>Know Your Child -<%=bundle1.getString("label.staffregisteration.staffregisterationtitle") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="../kycpanel/style.css" />
<style>
#passwordStrength

{

	height:10px;

	display:block;

	float:left;

}

.strength0

{

	width:150px;

	background:#ccceee;

}

.strength1

{

	width:25px;

	background:#cccccc;

}



.strength2

{

	width:50px;

	background:#ff0000;

}



.strength3

{

	width:75px;	

	background:#ff5f5f;

}



.strength4

{

	width:100px;

	background:#56e500;

}



.strength5

{

	background:#4dcd00;

	width:125px;

}



.strength6

{

	background:#399800;

	width:150px;

}

</style>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/ServerPath.js"></SCRIPT>
<script language="javascript" src="<%=request.getContextPath()%>/js/Elements.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="javascript">
function passwordStrength(password)

{

	var desc = new Array();
	
	desc[0] = "Password Not Entered";

	desc[1] = "Very Weak";

	desc[2] = "Weak";

	desc[3] = "Better";

	desc[4] = "Medium";

	desc[5] = "Strong";

	desc[6] = "Strongest";



	var score   = 0;

	if (password.length > 1) score++;

	//if password bigger than 6 give 1 point

	if (password.length > 6) score++;



	//if password has both lower and uppercase characters give 1 point	

	if ( ( password.match(/[a-z]/) ) && ( password.match(/[A-Z]/) ) ) score++;



	//if password has at least one number give 1 point

	if (password.match(/\d+/)) score++;



	//if password has at least one special caracther give 1 point

	if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) )	score++;



	//if password bigger than 12 give another 1 point

	if (password.length > 12) score++;
	
	
	 document.getElementById("passwordDescription").innerHTML = desc[score];
	 document.getElementById("passwordStrength").className = "strength" + score;
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
			alert("Enter  Number only");
		
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
var is_ie 		= (/msie/i.test(navigator.userAgent));
function calcAge(args)
{
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
var dob=document.f1.user_bday.value.split("-");
mon="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
mon=mon.split(",");
	for(var i=0;i<mon.length;i++)
	{
		if(dob[1]==mon[i])
			{
				var age=calcAge(i+1+"/"+dob[0]+"/"+dob[2]);
				if(age<10)
					{
						alert("Age Must Be Greater than 10 Years");
						document.f1.user_bday.value="";
						document.f1.user_bday.focus();
						return false;
					}
				document.f1.user_age.value=age;
				document.getElementById("displayage").innerHTML=age+"&nbsp;Years";
		}
	}
}
var ag_document=new Array();
var ag_document_int = 0;

function CalendarFun(calName)
{
	window.scroll(0,0);
	curr = calName;
	fieldName = "form1."+curr
	Load_Fun(fieldName);
	document.all.CALENDAR.style.visibility='visible';
	ParentField=calName;
}
function document_information()
{
	if(check_ForParticularElements(document.f1.user_docname,"text",document.f1.user_institution,"text",f1.user_finishing_date,"text"))
	{
		ag_document[ag_document_int] = new AgentDocument(f1.user_docname.value,f1.user_institution.value,f1.user_finishing_date.value);
		ag_document_int++;

		//If entered then only the field should be ready to get next data
		document.f1.user_docname.value="";
		document.f1.user_institution.value="";
		document.f1.user_finishing_date.value="";
		//document.f1.user_merit.value="";
	}
}

function AgentDocument(docname,institution,findate,merit)
{
	this.docname=docname;
	this.institution=institution;
	this.findate=findate;
	this.merit=merit;
}

function country_fun(name,source,hiddenelement)
	{
		var tmp_text=source.value;
	
		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
		
			var country = country_xml[0].getElementsByTagName("country");

			for(var i=0;i<country.length;i++)
			{
			
  				if(country[i].attributes.getNamedItem("name").nodeValue==tmp_text)
				{
					var states = country[i].getElementsByTagName("state");
					if(states.length>0)
					{
						for(var i=0 ,j=1;i<states.length;i++)
						{
							name.options[j] = new Option(states[i].attributes.getNamedItem("name").nodeValue,states[i].attributes.getNamedItem("name").nodeValue);
						j++;
						}
						hiddenelement.style.visibility="hidden";
					}
					else
					{
					optionDelete(name,1);
					hiddenelement.style.visibility="visible";
					}
					break;
    		   }

			}
		}
	}
function country_fun11(coun,elementobj,hiddenelement)
{

	optionDelete(elementobj);
		var country_xml = xmlDoc.getElementsByTagName("location");
		if(country_xml[0] != null)
		{
			var country = country_xml[0].getElementsByTagName("country");

			for(var i=0;i<country.length;i++)
			{
  				//alert(country[i].attributes.getNamedItem("name").nodeValue);

  				if(country[i].attributes.getNamedItem("name").nodeValue==coun)
			{
					var states = country[i].getElementsByTagName("state");
		//alert(states[0].attributes.getNamedItem("name").nodeValue);
		if (states.length > 0)
		{
		elementobj.style.visibility="visible";
		elementobj.disabled=false;
		hiddenelement.style.visibility="hidden";
		//alert("states.length-->"+states.length);
			for(var j=1,i=0;i<states.length;i++)
			{
				elementobj.options[j] = new Option(states[i].attributes.getNamedItem("name").nodeValue,states[i].attributes.getNamedItem("name").nodeValue);
				j++;
			}
		}
		else
		{
		//alert("else")
	//	permanentuser_state1
			//alert("else"+hiddenelement.name)
	
				elementobj.style.visibility="visible";;
				hiddenelement.style.visibility="visible";
		}
	}
}
}
}
function password_v()
{
	if(document.f1.user_passwd1.value == "")
	{
		alert("Empty Password not Allowed");
		document.f1.user_passwd1.focus();
		return false;
	}

	if(document.f1.user_passwd2.value == "")
	{
		alert("Empty Verify Password  not Allowed");
		document.f1.user_passwd2.focus();
		return false;
	}
  	if(document.f1.user_passwd1.value==document.f1.user_passwd2.value)
	{
  		return true;
  	}
  	else
  	{
  		alert("Password and Confirm Password Must Be Same");
  		document.f1.user_passwd1.focus();
  		return false;
	}
}
function validation_all()
{
if(check_ForParticularElements(document.f1.user_first_name,"text",document.f1.user_last_name,"text",document.f1.user_final_qualification,"text", document.f1.user_id,"text",document.f1.user_passwd1,"text",document.f1.user_passwd2,"text",document.f1.user_fathername,"text",document.f1.user_mothername,"text",document.f1.user_bday,"text",document.f1.user_age,"text",document.f1.user_street1,"text",document.f1.user_street2,"text",document.f1.user_city,"text",document.f1.country,"select",document.f1.user_zipcode,"text",document.f1.permanentuser_street1,"text",document.f1.permanentuser_street2,"text",document.f1.permanentuser_city,"text",document.f1.permanentcountry,"select",document.f1.permanentuser_zipcode,"text",document.f1.user_phone,"text",document.f1.smscontactno,"text",document.f1.user_private_mail_id,"text",document.f1.user_department,"select",document.f1.user_role,"select",document.f1.user_joining_date,"text"))
{
		
		 if(!stringValidate(document.f1.user_first_name,"First Name"))
			 {
				document.f1.user_first_name.focus();
				return false;
			 }
			 if( document.f1.user_fathername.value.charAt(0)==" ")
			 {
			 	alert("Father Name should not start with Empty Character");
			    document.f1.user_fathername.focus();
				return false;
			 }
			 if(!stringValidateincludesigquots(document.f1.user_fathername,"Father Name"))
			 {
				
				document.f1.user_fathername.focus();
				return false;
			 }
			 if( document.f1.user_mothername.value.charAt(0)==" ")
			 {
			 	alert("Mother Name should not start with Empty Character");
			    document.f1.user_mothername.focus();
				return false;
			 }
			 if(!stringValidateincludesigquots(document.f1.user_mothername,"Mother Name"))
			 {
				  
				document.f1.user_mothername.focus();
				return false;
			 }
				 
			 if(!password_v())
				return false;
			
			//alert("2====>>>>");
			if(!stringValidate(document.f1.user_middle_name,"Middle Name"))
			 {
				document.f1.user_middle_name.focus();
				return false;
			 }
			 //alert("3====>>>>");
			 
			 if(!stringValidate(document.f1.user_last_name,"Last Name"))
			 {
				
				document.f1.user_last_name.focus();
				return false;
			 }
			 //alert("=======>>>>"+document.f1.user_photo.disabled);
			 if(document.f1.user_photo.disabled==false)
				 {
					if(document.f1.user_photo.value =="")
						{
							alert("Empty Photo not allowed");
							document.f1.user_photo.focus();
							return false;
						}
					if(document.f1.user_photo.value !="")
					{
						var pho_val=getExtension(document.f1.user_photo.value);
						pho_val = pho_val.toLowerCase();
						if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg") & (pho_val != "png") & (pho_val != "bmp"))
						{
						alert("*.jpeg,*.jpg,*.gif,*.png,*.bmp Image type only allowed")
						document.f1.user_photo.select();
						return false;
						}
					}
				 }
		//alert("7====>>>>"); 
		
		if(document.f1.user_state.length==1)
{
if(document.f1.user_state1.value=="")
{
alert("Enter the State");
document.f1.user_state1.style.visibility="visible";
document.f1.user_state1.focus();
return false;
}
}
//if(document.f1.permanentuser_state.length==1)
//{
//if(document.f1.permanentuser_state1.value=="")
//{
//alert("Enter the State");
//document.f1.permanentuser_state1.style.visibility="visible";
//document.f1.permanentuser_state1.focus();
//return false;
//}
//}
		if(!qualificationcheckcount>0)
		{
		alert("Select Any One Qualification Details");
		document.f1.chk[0].focus();
		return false;
		}
		if(!email_Validation(document.f1.user_private_mail_id,"Mail Id",true))
			 {
 				return false;
			 }
		for(var i=1;i<=3;i++)
		{
			if(eval("document.f1.certificatename"+i+".value!=''") || eval("document.f1.certificatefile"+i+".value!=''"))
				{
				
				if(check_ForParticularElements(eval("document.f1.certificatename"+i),"text"))
					{
						if(eval("document.f1.certificatefile"+i+".value==''"))
							{
							alert("Select Any File To upload ");
							return false;
							}
					}
				else
					{
					return false;
					}
				
				}
		}
		submitAction();
}

}

function submitAction()
{


if(document.f1.user_state.selectedIndex == 0){
		//document.f1.user_state.options[0].value = "-";
		if(document.f1.user_state1.value =="")
		{
			document.f1.user_state.options[0].value = "-";
		}
		else
		{
		document.f1.user_state.options[0].value = document.f1.user_state1.value;
		//alert("document.f1.user_state.options[0].value-->"+document.f1.user_state.options[0].value)
		}
	}
		//if(document.f1.permanentuser_state.selectedIndex == 0){
		//document.f1.user_state.options[0].value = "-";
		//if(document.f1.permanentuser_state1.value =="")
		//{
			
			//document.f1.permanentuser_state1.value = "-";
		//}
		//else
		//{
		//document.f1.permanentuser_state.options[0].value = document.f1.permanentuser_state1.value;
		//alert("document.f1.user_state.options[0].value-->"+document.f1.user_state.options[0].value)
		//}
		//}
		
for(var i=0;i<document.f1.chk.length;i++)
{
   if(!document.f1.chk[i].checked)
   {
   document.f1.major[i].disabled=true;
   document.f1.user_qualification[i].disabled=true;
   document.f1.Yearofgrad[i].disabled=true;
   document.f1.marks[i].disabled=true;
   document.f1.institutename[i].disabled=true;
   }
   else
   {
   document.f1.major[i].disabled=false;
   document.f1.user_qualification[i].disabled=false;
   document.f1.Yearofgrad[i].disabled=false;
   document.f1.marks[i].disabled=false;
   document.f1.institutename[i].disabled=false;
   }
}
			for(var i=0;i<document.f1.experiencecheck.length;i++)
			{
			   if(!document.f1.experiencecheck[i].checked)
			   {
				   document.f1.instituteName[i].disabled=true;
				   document.f1.instituteRole[i].disabled=true;
				   document.f1.institutePeriod[i].disabled=true;
			   }
			   else
			   {
				   document.f1.instituteName[i].disabled=false;
				   document.f1.instituteRole[i].disabled=false;
				   document.f1.institutePeriod[i].disabled=false;
			   }
			 }
	Submit();
	
}


function Submit()
{
		if(confirm("Do you want to proceed...?"))
					{
					doCompletion(document.f1.user_id.value,"username");
					}
		}
function getExtension(file_value)
{
	if(file_value.lastIndexOf(".") != -1)
	{
		var ext_of_file = file_value.substring(file_value.lastIndexOf(".")+1);
		return ext_of_file.toLowerCase();
	}
	else
	{
		return 0;
	}
}


var experiencefield=2;
function nextRows()
{
	table = document.getElementById("tabids").getElementsByTagName("tbody")[0];
	row = document.createElement("tr");
	row.align="center";
		cell = document.createElement("td");
	cell.innerHTML = "<input type=\"text\" name=\"instituteName\" size=\"25\" class=\"tablelight\" maxlength=\"100\" >";
	row.appendChild(cell);
	
	cell = document.createElement("td");
	cell.innerHTML = "<input type=\"text\" name=\"instituteRole\" size=\"25\" class=\"tablelight\" maxlength=\"100\" >";
	row.appendChild(cell);
	
	cell = document.createElement("td");
	cell.innerHTML = "<input type=\"text\" name=\"institutePeriod\" size=\"10\"  class=\"tablelight\" maxlength=\"50\">";
	row.appendChild(cell);
	
//alert(document.getElementById("tabids").rows.length)
	cell = document.createElement("td");
	cell.innerHTML = "<input type=\"checkbox\" name=\"experiencecheck\"  class=\"tablelight\" onclick=experiencevalidation(this,'"+experiencefield+"')>";
	row.appendChild(cell);

	table.appendChild(row);
	experiencefield++;
}
function removeRows(tabname)
{
	if(document.getElementById(tabname).rows.length==3)
	{
	alert("Minimum Two  Row Required");
	}
	else
	{
       if(document.getElementById(tabname).rows.length > 3)
       {
       		experiencefield--;
            document.getElementById(tabname).deleteRow(document.getElementById(tabname).rows.length-1);
  	}
  	}
}
var xmlDoc=null;

function loadOption()
{
    //document.f1.permanentuser_state1.style.visibility='hidden';
   	document.f1.user_state1.style.visibility='hidden';
    if (window.XMLHttpRequest)
   		xhttp=new XMLHttpRequest();
  	else
   		xhttp=new ActiveXObject("Microsoft.XMLHTTP");

	xhttp.open("GET","../../xml/Region.xml",false);
	xhttp.send(null);
	xmlDoc=xhttp.responseXML;
   	getCountry();
 }

function getCountry()
{
var obj			= document.forms["f1"].country;
//var obj1			= document.forms["f1"].permanentcountry;

	var country_xml = xmlDoc.getElementsByTagName("location");
	if(country_xml[0] != null)
	{
		var states = country_xml[0].getElementsByTagName("country");
		for(var i=0;i<states.length;i++)
		{
			var val 	= states[i].attributes.getNamedItem("name").nodeValue;
			obj.options[obj.options.length] = new Option(val,val);
			//obj1.options[obj1.options.length] = new Option(val,val);
			
		}
	}/* var opt=new Array();
 var totCountry=Coun.length;
 for(n=1;n<totCountry;n++)
 {
  document.f1.country.options[n]=new Option(Coun[n]);
  document.f1.permanentcountry.options[n]=new Option(Coun[n]);
  
 }*/
}

function ff()
{
	var s1=document.f1.user_id.value.length;

	if(s1 == 0)
	{
		alert("UserName Empty !");
		document.f1.user_id.focus();
		return false;

	}


	if(s1 < 4)
	{

		alert("UserName minmum 4 Characters Must !");
		document.f1.user_id.focus();
		return false;
	}

}
var experiencecheckcount=0;
function experiencevalidation(obj,elementno)
{
if(obj.checked)
{
	if(!check_ForParticularElements(document.f1.instituteName[elementno],"text",document.f1.instituteRole[elementno],"text",document.f1.institutePeriod[elementno],"text"))
	{
	   obj.checked=false;
	   return false;
	}
	else
	{
		document.f1.instituteName[elementno].disabled=true;
		document.f1.instituteRole[elementno].disabled=true;
		document.f1.institutePeriod[elementno].disabled=true;
	}
	experiencecheckcount++;
}
else
{
   document.f1.instituteName[elementno].disabled=false;
   document.f1.instituteRole[elementno].disabled=false;
   document.f1.institutePeriod[elementno].disabled=false;
   experiencecheckcount--;
}
}
var qualificationcheckcount=0;
function qualificationvalidation(obj,elementno)
{
  if(obj.checked)
{
	if(!check_ForParticularElements(document.f1.major[elementno],"text",document.f1.user_qualification[elementno],"text",document.f1.Yearofgrad[elementno],"text",document.f1.marks[elementno],"text",document.f1.institutename[elementno],"text"))
	{
	   obj.checked=false;
	   return false;
	}
	else
	{
				var year_of_graduration=document.f1.Yearofgrad[elementno].value;
				var split_year_of_graduration	= year_of_graduration.split(" ");
					if(split_year_of_graduration.length > 2){
						alert("Invalid year of graduation.");
				  		obj.checked=false;
						document.f1.Yearofgrad[elementno].focus();
						return false;
					}
					else{
						var month_array = new Array("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec");
						var valid_month	= false;
						for(var a=0;a<month_array.length;a++){
							if(split_year_of_graduration[0].toLowerCase() == month_array[a].toLowerCase()){
								valid_month	= true;
							}
						}
						if(!valid_month){
							alert("Invalid year of graduation.");
							obj.checked=false;
							document.f1.Yearofgrad[elementno].focus();
							return false;
						}
						if(isNaN(split_year_of_graduration[1])){
							alert("Invalid year of graduation.");
							obj.checked=false;
							document.f1.Yearofgrad[elementno].focus();
							return false;
						}
					}
				if(isNaN(document.f1.marks[elementno].value))
				{
						alert("Invalid GPA.");
						obj.checked=false;
						document.f1.marks[elementno].value="";
						document.f1.marks[elementno].focus();
						return false;
		}
		
   document.f1.major[elementno].disabled=true;
   document.f1.user_qualification[elementno].disabled=true;
   document.f1.Yearofgrad[elementno].disabled=true;
   document.f1.marks[elementno].disabled=true;
   document.f1.institutename[elementno].disabled=true;
	}
	qualificationcheckcount++;
	
}
else
{
   document.f1.major[elementno].disabled=false;
   document.f1.user_qualification[elementno].disabled=false;
   document.f1.Yearofgrad[elementno].disabled=false;
   document.f1.marks[elementno].disabled=false;
   document.f1.institutename[elementno].disabled=false;
   qualificationcheckcount--;
   
}
}
function ff1()
{
	var s2=document.f1.user_passwd1.value.length;

	if(s2 == 0)
	{
		alert("Password Empty !");
		document.f1.user_passwd1.focus();
		return false;
	}
	if(s2 < 4)
	{

		alert("Password minmum 4 Characters Must !");
		document.f1.user_passwd1.focus();
		return false;
	}
}


function allowNumber()
{

	if(event.keyCode < 48 || event.keyCode > 57)
	{
		alert("Enter number only")
		event.keyCode = 0
	}
}
var filednumber=3;
function createNextQualification()
{
	rowlen = document.getElementById("qualtab").rows.length;
	table=document.getElementById("qualtab").getElementsByTagName("tbody")[0];
	row = document.createElement("tr");
	row.align="Left";
	
	cell = document.createElement("td");
	cell.innerHTML = "<a class=tabletd><input type=text name=major size=16 class=tablelight validate='Major' ></a>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<a class=tabletd><input type=text name=user_qualification size=16 validate='Qualification' class=tablelight></a>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<a class=tabletd><input type=text name=Yearofgrad size=10 validate='Year of Graduation' class=tablelight></a>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<a class=tabletd><input type=text name=marks size=10 validate='Percentage' class=tablelight></a>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<a class=tabletd><input type=text name=institutename size=20 validate='Institute Name' class=tablelight></a>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<a class=tabletd><td class=tabletd align=center><input type=checkbox class=tablelight name='chk' onclick=qualificationvalidation(this,'"+filednumber+"')></a>";
	row.appendChild(cell);
	
	table.appendChild(row);

	/*cell = row.insertCell();
	cell.align = "Center";
	cell.innerHTML = "<a class=tabletd><input type=text name='user_merit' maxlength=50 size=20 class=tablelight></a>";*/
	//len = document.f1.insname2.length;
	filednumber++;
}

function removeQualification(tabname)
{
	if(document.getElementById(tabname).rows.length==4)
	{
	alert("Cant delete further rows");
	}
	else
	{
       if(document.getElementById(tabname).rows.length > 1)
       	{
            document.getElementById(tabname).deleteRow(document.getElementById(tabname).rows.length-1);
            filednumber--;
        }
  	}
}
function doCompletion(id,flag)
	{
	   var url = "";
	   if(flag=="username")
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
				   if(flag=="username")
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
		if(flag=="username") 
		{
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			
			if(cNode_1>0)
			{
			
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				if(temp=="true")
				{
					alert("User Name already exists");
					return false;
				}
			
			}
				document.f1.hiddenuser_id.value=document.f1.user_id.value;
				document.f1.rolename.value=document.f1.user_role.options[document.f1.user_role.selectedIndex].text;
				document.f1.departname.value=document.f1.user_department.options[document.f1.user_department.selectedIndex].text;
				document.f1.action= "./StaffProfilePreView.jsp";
				document.f1.submit(); 

			}
		}
	}

	function loadphototype(type)
	{
		if(type=="local")
		{
			document.getElementById('webcamspan').style.display='none';
			document.getElementById('localphoto').style.display='';
			document.f1.user_photo.disabled=false;

		}
		else
		{
			document.getElementById('webcamspan').style.display='';
			document.getElementById('localphoto').style.display='none';
			document.f1.user_photo.disabled=true;

		}
	}
</script>
</head>
<body onload="loadOption()">
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

    <h2><%=bundle1.getString("label.staffregisteration.staffregisterationrootpath") %></h2>
    <%@ page import="java.util.*"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>

<%


%>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%
	String date_str="";
	ArrayList deptList = null;
	ArrayList roleList = null;
	ArrayList jobList = null;
	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
	String userid=null;
	String instituid=null;
	userid=(String)session.getValue("userid");  
	
	if(userid!=null)
	{
	try
	{

		
			String instituteid="";
			instituid=(String)session.getValue("instituteid");

				//schedule_query_bean.getInstituteInfo();
		//out.println("SSSSS"+instituteid);

			deptList =staffquery.departmentload(instituid);
			//out.println("SSSSS deptList"+deptList);
			roleList = staffquery.roleload(instituid);
			//deptobj.getRoles(instituteid);
			//out.println("SSSSS roleList"+roleList);
 			jobList = staffquery.jobcategoryload(instituid);
			 date_str = datebeans.showTime("calendar");


		
	}
	catch(NullPointerException e){}
	java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
	String shapshotpath=rb.getString("shapshot");
	//out.println("shapshotpath********* "+shapshotpath);
	String imagePath=rb.getString("storagepath")+"/imagestorage/";
	String imageName="StaffPersonalImage.jpg";  
%>
<form name="f1" method="post" action="" enctype="multipart/form-data">
<input type=hidden name=server_date value="<%= date_str %>">
<input type=hidden name=rolename value="">
<input type=hidden name=departname value="">
<input type=hidden name=hiddenuser_id value="">  



   <table border="0"  bgcolor="#ECF8FD"   cellpadding=0 cellspacing=0 width="100%" rules="groups" height=450 align=center>
	<tr>
	<td valign=top >
	<table   cellpadding=3 cellspacing=0  border=0 width="100%" align=center>
	<tr  height="30" class=tableheading><td  colspan=3 scope="col" class="rounded-company">&nbsp;<%= bundle1.getString("label.staffregisteration.PersonalInformation")%>&nbsp;</td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td></tr>
	<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Prefix") %>&nbsp;</td>
	<td class=tablelight><select name="slt_prefix"  maxlength=6  class=tablelight validate="prefix">
											 <option value="Mr.">Mr.</option>
											 <option value="Mrs.">Mrs.</option>
											 <option value="Ms.">Ms.</option>
											 <option value="Dr.">Dr.</option>
											 <option value="Sir.">Sir.</option>
										 </select> </td>
	</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;Person Name&nbsp;</td>
<td class=tablelight><input type = text name = "user_first_name" size=21 maxlength=50  validate="First Name" class=tablelight></td>
</tr>
<!-- 
<tr height=30>
<td class=tablebold>&nbsp;&nbsp;<%=bundle1.getString("label.staffregisteration.MiddleName") %>&nbsp;</td>
<td class=tablelight><input type = text name = "user_middle_name" size=5 maxlength=50   class=tablelight></td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.LastName") %>&nbsp;</td>
<td class=tablelight><input type = text name = "user_last_name" size=21 maxlength=50  validate="Last Name" class=tablelight></td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Qualification") %>&nbsp;</td>
<td class=tablelight><input type = text name = "user_final_qualification" size=21 maxlength=50  validate="Qualification" class=tablelight></td>
</tr> -->
<!-- **************LOGIN LOGIN******************************************************************-->

<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Gender") %>&nbsp;</td>
<td class=tablelight><input type = radio name="user_gender" value="M" ><%= bundle1.getString("label.staffregisteration.Male")%>
    <input type = radio name="user_gender" value="F" checked=true><%= bundle1.getString("label.staffregisteration.Female")%> </td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.DateofBirth") %>&nbsp;</td>
<td class=tablelight><input type = text name="user_bday" class=tablelight value="" maxlength=50 size=20 validate="Date of Birth" onkeydown='this.blur();' onchange="calcagefun()" ><input type="button" class="tablehead" value="^" onclick="document.f1.user_bday.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.user_bday','1000',event,'Not_Greater_Than_CurrentDate',document.f1.server_date);">          
</td>
</tr>
<!-- 
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Age") %>&nbsp;</td>
<td class=tablelight><label id='displayage'></label>&nbsp;<input type =hidden  name="user_age" class=tablelight value="" validate="Age" maxlength=3 size=3 > 
</td>
</tr>
<tr align="left">
					<td colspan=2>
					<input type="radio" name="phototype" value='local' onclick="loadphototype('local')" checked/><%=bundle1.getString("label.studentprofileentry.UploadImage")%><input type="radio" name="phototype" value='snapshot' onclick="loadphototype('webcam')"/><%=bundle1.getString("label.studentprofileentry.CaptureImage")%>
					</td>
					</tr>
					<tr align="left">
					<td colspan=2>
					<table border='0' bordercolor='yellow' id="localphoto" style="display:block;" >  
						<tr>  
						<td width="35%" align="left" class=tablebold><font color=red class=tablebold>*</font>&nbsp;<%=bundle1.getString("label.studentprofileentry.Photo")%></td>
						<td align="left" valign="bottom" width="65%"><input size='30' type=file class="browses" name="user_photo"	></td>
					</tr>
					</table>
					</td>
					</tr>  
				<tr>
					<td colspan=2>
					
					<table border='0' bordercolor='yellow' id="webcamspan" style="display: none" >  
									<tr>      
										<td>  
										<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
												id="Snapshot"  width="320" height="180"
												codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
												<param name="movie" value="<%=shapshotpath %>/Snapshot.swf" />
												<param name="quality" value="high" />   
												<param name="bgcolor" value="#869ca7" />
												<param name="allowScriptAccess" value="sameDomain" />  
												<param name="FlashVars" value="imagePath=<%=imagePath%>&imageName=<%=imageName%>" />
												<embed src="<%=shapshotpath %>/Snapshot.swf" FlashVars="imagePath=<%=imagePath%>&imageName=<%=imageName%>" quality="high" bgcolor="#869ca7"
													name="Snapshot" align="middle" width="320" height="180"
													play="true"
													loop="false"
													quality="high"
													allowScriptAccess="sameDomain"
													type="application/x-shockwave-flash"
													pluginspage="http://www.adobe.com/go/getflashplayer">
												</embed>
										</object>
										</td>
									</tr>
								</table>		
					</td>
					</tr>
<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.MaritalStatus") %>&nbsp;</td>
	<td class=tablelight><input type = radio name = "user_mar_status" validate="Marital Status" value="Married"><%=bundle1.getString("label.staffregisteration.Married") %>
		<input type = radio name = "user_mar_status" value="Single" checked><%=bundle1.getString("label.staffregisteration.Single") %>
	</td>
</tr>
<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.FatherName") %></td>
	<td><input type = text name = user_fathername maxlength=50 size=30 value="" validate="Father Name" class=tablelight></td>
</tr>
   
<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.MotherName") %></td>
	<td><input type = text name = user_mothername maxlength=50 size=30 value="" validate=" Mother Name" class=tablelight></td>
</tr>
<tr height=30 class=tableheading >
<td  colspan=3 ><%=bundle1.getString("label.staffregisteration.CommunicationAddress") %></td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td>
</tr>   -->
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Street1") %>&nbsp;</td>
<td><input type=text name = "user_street1" maxlength=50 size=35  validate="Street" value="" class=tablelight></td>
</tr>

<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Street2") %>&nbsp;</td>
<td><input type=text name = "user_street2" maxlength=50 size=35 value="" class=tablelight></td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Country") %>&nbsp;</td>
<!--<td><input type=text size=12 name='country' validate="Country" class=tablelight value="" value=""></td>-->
<td><select size=1 cols=20 id=country name="country" validate="Country" style="width:250px" class=tablelight onchange="country_fun(document.getElementById('user_state'),this,document.getElementById('user_state1'));">
<option value="">Select Country</option>
</select></td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.State") %>&nbsp;</td>
<td>
<select id = "user_state"  name = "user_state" validate="User State" style="width:250px" class=tablelight><option>Select State</option></select>
<input type="text" name='user_state1' id='user_state1' maxlength=50>
</td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.City") %>&nbsp;</td>
<td><input type = text name = "user_city" validate="City" maxlength=50 size=15 value="" class=tablelight></td>
</tr>


<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.PostalCode") %>&nbsp;</td>
<td><input type = text name = "user_zipcode" maxlength=6 size=15 validate="Postal Code" value="" onkeypress="checkNumber(event)" class=tablelight></td>
</tr>
<!-- 
<tr height=30  class=tableheading>
<td   colspan=3><%=bundle1.getString("label.staffregisteration.PermanentAddress") %></td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td>
</tr>  
<tr height=30>  
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Street1") %>&nbsp;</td>
<td><input type=text name = "permanentuser_street1" maxlength=50 size=35  validate="Street" value="" class=tablelight></td>
</tr>

<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Street2")%>&nbsp;</td>
<td><input type=text name = "permanentuser_street2" maxlength=50  validate="Permanent Street" size=35 value="" class=tablelight></td>
</tr>

 
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Country") %>&nbsp;</td>
<td><select size=1 cols=20 name="permanentcountry" validate="Country" style="width:250px" class=tablelight onchange='country_fun(document.f1.permanentuser_state,this,document.f1.permanentuser_state1);'>
<option value="0">Select Country</option>
</select></td>
</tr>



<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.State") %>&nbsp;</td>
<td>
<select name = "permanentuser_state" validate="User state" style="width:250px" class=tablelight><option>Select State</option></select>
<input type="text" name='permanentuser_state1' maxlength=50>
</td>
</tr>

<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.City") %>&nbsp;</td>
<td><input type = text name = "permanentuser_city" validate="City" maxlength=50 size=15 value="" class=tablelight></td>
</tr>


<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.PostalCode") %>&nbsp;</td>
<td><input type = text name = "permanentuser_zipcode" maxlength=6 size=15 validate="Postal Code" value="" onkeypress="checkNumber(event)" class=tablelight></td>
</tr>
-->
	<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.MobileNo") %><br></td>
	<td><span id=phone></span><input type = text name="user_phone" validate='Telephone No' size=35 value="" onkeypress="checkNumber(event)" maxlength=25 class=tablelight value="" ></td>
	</tr>
	<!-- 
	<tr>
	<td class=tablebold width="20%"><font color=red class=tablebold>*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.SMSContactNo.")%></td>
	<td class=tablebold width="30%"><input type="text" class="tablelight" name="smscontactno" value="" size=35 validate='SMS Contact Number' maxlength="20" onkeypress="smsmobilecontactcheck(event)"></td>
	</tr>
	<tr height=30>
	<td class=tablebold><font color="ff0000">&nbsp;</font>&nbsp;<%=bundle1.getString("label.staffregisteration.HomePhoneNo") %><br></td>
	<td><span id=phone></span><input type = text name="user_phone_ll" validate='Telephone No' size=35 value="" onkeypress="checkNumber(event)" maxlength=25 class=tablelight value=""></td>
	</tr> -->
<tr height=30>
<td valign="top" height="60" class=tablebold><font color="red">*</font>&nbsp;<%=bundle1.getString("label.staffregisteration.Email") %></td>
<td valign="top" height="60"><input type=text name="user_private_mail_id" size=35 validate="Email Address" value="" class=tablelight maxlength=40></td>
</tr>
<tr  class=tableheading height="30">
		<td colspan=3> <%=bundle1.getString("label.staffregisteration.QualificationDetails") %><input type=hidden name=usr_post ></td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td>
		</tr>

	<tr><td colspan=6>
		<table id='qualtab' border=0 bordercolor="#cfcfcf" cellspacing=0 cellpadding=3 width="100%">
		<tr bgcolor='#AED7FF' class=tablehead align=center>
			<td>Course</td>
			<td><%=bundle1.getString("label.staffregisteration.AreaofSpecialization") %></td>
			<td><%= bundle1.getString("label.staffregisteration.YearofGraduation")%><br><font color=red><%= bundle1.getString("label.staffregisteration.(Eg.Jan2006)")%></font></td>
			<td><%= bundle1.getString("label.staffregisteration.Percentage")%><br><font color=red><%= bundle1.getString("label.staffregisteration.(Eg.80or8.0)")%></font></td>
			<td><%= bundle1.getString("label.staffregisteration.College/University")%></td>
			<td><%= bundle1.getString("label.staffregisteration.Check")%></td>
		</tr>

		<tr  class=tablelight align=left>
			<td>
				<span id=isnameid></span><input type=text name=major validate="Major" size=16 class=tablelight maxlength=40 >
			</td>

			<td>
				<span id=snoid></span><input type=text validate="Qualification" class=tablelight name=user_qualification size=16 maxlength=40 >
			</td>
			<td>
				<span id=majorid></span><input type=text name='Yearofgrad' validate="Year of Graduation" size=10 class=tablelight maxlength=40 >
			</td>
			<td>
				<span id=marksid></span><input type=text name="marks" validate="Percentage" size=10 class=tablelight  maxlength=3>
			</td>
			<td>
				<span id=percentageid></span><input type=text name=institutename validate="Institute Name" size=20 class=tablelight maxlength=40 >
			</td>
			<td>
				<span id=durationid></span><input type=hidden name=duration size=10>
				<input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'0')>
			</td>
		</tr>
		<tr  align=left>
			<td>
				<span id=isnameid1></span><input type=text name=major size=16 validate=" Major" class=tablelight></td>

			<td>
				<span id=snoid1></span><input type=text validate="Qualification" class=tablelight name=user_qualification size=16 maxlength=40 ></td>
			<td>
				<span id=majorid1></span><input type=text name=Yearofgrad  validate="Year of Graduation" size=10 class=tablelight  maxlength=40 ></td>
			<td>
				<span id=marksid1></span><input type=text name=marks  validate="Percentage" size=10 class=tablelight  maxlength=3></td>
			<td>
				<span id=percentageid1></span><input type=text name=institutename validate="Institute Name" size=20 class=tablelight maxlength=40 ></td>
			<td>
				<span id=durationid1></span><input type=hidden name=duration   size=10><input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'1')>
			</td>
	</tr>
	<tr class=tablelight align=left>
			<td>
				<span id=isnameid2></span><input type=text name=major size=16 class=tablelight validate="Major"  maxlength=50 ></td>
			<td>
				<span id=snoid2></span><input type=text name=user_qualification size=16 validate="Qualification" class=tablelight  maxlength=40 ></td>
			<td>
				<span id=majorid2></span><input type=text name=Yearofgrad validate="Year of Graduation" size=10 class=tablelight  maxlength=40 ></td>
			<td>
				<span id=marksid2></span><input type=text name=marks validate="Percentage" size=10 class=tablelight maxlength=3></td>
			<td>
				<span id=percentageid2></span><input type=text name=institutename  validate="Institute Name" size=20  maxlength=40 class=tablelight></td>
			<td>
				<span id=durationid2></span><input type=hidden name=duration2 size=10><input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'2')>
			</td>
	</tr>
	</table>

	<tr>
		<td colspan="6" valign=bottom align="right">
			<!--  <input type=button name=next_but class=buttons value="Add New Row" >
			<input type=button name=next_but class=buttons value=Remove onclick="removeQualification('qualtab')">-->
     	<a href="#ck" name='ck' onclick="removeQualification('qualtab')" class="bt_red"><span class="bt_red_lft"></span><strong><%= bundle1.getString("button.staffregisteration.Remove")%></strong><span class="bt_red_r"></span></a>
		 <a href='#bb' name="bb" onclick="createNextQualification()" class="bt_green"><span class="bt_green_lft"></span><strong><%= bundle1.getString("button.staffregisteration.AddNewRow")%></strong><span class="bt_green_r"></span></a>

		</td>
   </tr>
   
<tr>
	<td colspan=2>&nbsp;</td>
</tr>
<tr height="30" class=tableheading>
<td colspan="3" class=tablebold>&nbsp;<b> <%= bundle1.getString("label.staffregisteration.ExperienceDetails")%></b></td><td align=right> ( <font color=red><%= bundle1.getString("button.staffregisteration.optional")%></font> )</td>
</tr>
	<tr height=25>
		<td class=tablebold colspan=5>
			<table id='tabids' border=0  cellpadding=0 cellspacing=0 width=100%>
				<tbody>
					<tr height=25 class="tablehead"  bgcolor='#AED7FF'>
						<td class=tablehead align=center width='15%'><%= bundle1.getString("label.staffregisteration.Institution")%></td>
						<td class=tablehead align=center width='15%'><%= bundle1.getString("label.staffregisteration.role")%></td>
						<td class=tablehead align=right width='15%'><%= bundle1.getString("label.staffregisteration.Period")%>&nbsp;<font color='red'><%= bundle1.getString("label.staffregisteration.[InYear(s)orMonth(s)]")%></font></td>
						<td class=tablehead align=center width='5%'><%= bundle1.getString("label.staffregisteration.Check")%></td>
					</tr>
					<tr height=30>
						<td class=tabletd align=center><input type=text name="instituteName" maxlength=40 size=25 class=tablelight></td>
						<td class=tabletd align=center><input type=text name="instituteRole" maxlength=40 size=25 class=tablelight></td>
						<td class=tabletd align=center><input type = text name = "institutePeriod" class=tablelight maxlength=40 size=10 value=""></td>
						<td class=tabletd align=center><input type=checkbox name="experiencecheck" onclick=experiencevalidation(this,'0')></td>
					</tr>
					<tr height=30>
						<td class=tabletd align=center><input type=text name="instituteName" maxlength=40 size=25 class=tablelight></td>
						<td class=tabletd align=center><input type=text name="instituteRole" maxlength=40 size=25 class=tablelight></td>
						<td class=tabletd align=center><input type = text name = "institutePeriod" class=tablelight maxlength=40 size=10 value=""></td>
						<td class=tabletd align=center><input type=checkbox name="experiencecheck" onclick=experiencevalidation(this,'1')></td>
					</tr>
				</tbody>
			</table>
			<table border=0 bordercolor='red' cellpadding=5 cellspacing=0 width=100%>
				<tr>
					<td colspan='4' align='right' >
					<a href="#ss"  name="ss" onclick="removeRows('tabids')" class="bt_red"><span class="bt_red_lft"></span><strong><%= bundle1.getString("button.staffregisteration.Remove")%></strong><span class="bt_red_r"></span></a>
		 			<a href="#fgf" name="fgf" onclick="nextRows()" class="bt_green"><span class="bt_green_lft"></span><strong><%= bundle1.getString("button.staffregisteration.AddNewRow")%></strong><span class="bt_green_r"></span></a>
					</td>
				</tr>
			</table>
</tr>   
   <tr  class=tableheading  height="30">
		<td colspan=3> Upload Resume </td><td align=right>(<font color=red> <%= bundle1.getString("button.staffregisteration.optional")%></font> )</td>  
		</tr>
		 <tr  class=tablebold  height="30">  
		<td colspan=4>
		<table width=100%>
		<% for(int i=1;i<2;i++) {%>
			<tr height=30>
					<td width="5%"><%=(i) %></td><td class=tablelight  width="30%"><input type=text name="certificatename<%=(i) %>" value="" size="30"/> 
					</td>
					<td class=tablelight width="65%"><input type="file" name="certificatefile<%=i %>" />   
					</td>
			</tr>
		<%} %>   
		</table>
		<br>
		</td>
		</tr>
	
	<!-- 	
	<tr  class=tableheading height="30" >
	<td colspan="3"><%= bundle1.getString("label.staffregisteration.JobInformation")%></td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td>
	</tr>
	<input type=hidden name=exp_spl_flag value=1>


		<tr class=tablebold height=30>
		<td><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.JobCategory")%>&nbsp;</td>

		<td width=60%>
		<%
		try
		{
	 		HashMap deptMap = null;
	 		for(int i=0;i<jobList.size()-1;i++) {
	 			deptMap = (HashMap)jobList.get(i);
	 			String categoryid = (String)deptMap.get("staffcategoryid");
	    		String categoryname = (String)deptMap.get("categoryname");
	    		if(i==0)
	    		{
	 		   	out.println("<input type = radio name='user_post' value='"+categoryid+"' checked >"+categoryname+"&nbsp;&nbsp;");
	 			}
	    		else
	    		{
		 		   	out.println("<input type = radio name='user_post' value='"+categoryid+"' >"+categoryname+"&nbsp;&nbsp;");

	    		}
	    		}
		}
		catch(NullPointerException npe)
		{
			//System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
			npe.printStackTrace();
			}
		
		%>
		</td>
		</tr>

	<tr height=40 >
	<td valign="top" height="40" class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.Department")%> </td>
	<td valign="top" height="40"><select name="user_department" class=tablelight validate="Department" style="width:250px">
	  <option selected>&nbsp;&nbsp;-- Select Department --&nbsp;&nbsp;</option>
	  <%
		try
		{
	 		HashMap deptMap = null;
	 		for(int i=0;i<deptList.size();i++) {
	 			deptMap = (HashMap)deptList.get(i);
	 			String deptid = (String)deptMap.get("departmentid");
	    		String deptname = (String)deptMap.get("departmentname");
	 		   	out.println("<option value='"+deptid+"'>"+deptname+"</option>");
	 		}
		}
		catch(NullPointerException npe)
		{
			System.out.println("IGST-ERROR : in Staff_Registration.jsp in deptMap"+npe);
			npe.printStackTrace();
			}
	%>
	</select>
	</td>
	</tr>

	<tr height=40 >
	<td valign="top" height="40" class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.role")%> </td>
	<td valign="top" height="40"><select name="user_role" class=tablelight validate="Role" style="width:250px">
	  <option selected>&nbsp;&nbsp;-- Select Position --&nbsp;&nbsp;</option>
	  <%
	  try
		{
			
			HashMap roleMap = null;
			for(int i=0;i<roleList.size();i++) {
				roleMap = (HashMap)roleList.get(i);
				String roleid = (String)roleMap.get("roleid");
				String rolename = (String)roleMap.get("rolename");
				out.println("<option value='"+roleid+"'>"+rolename+"</option>");
	 		}
		}
		catch(NullPointerException npe)
		{
			System.out.println("IGST-ERROR : in Staff_Registration.jsp in roleMap"+npe);
			npe.printStackTrace();
		}
	%>
	</select>
	</td>
	</tr>



	<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.JoiningDate")%>&nbsp;</td>
	<td class=tablelight><input type = text name="user_joining_date" maxlength=40 size=20 validate="Joining Date" value="" class=tablelight onkeydown='this.blur();'><input type="button" value="^" onclick="document.f1.user_gender.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.user_joining_date','0',event,'Not_Greater_Than_CurrentDate',document.f1.server_date);">
</tr>


<tr height=20>
<td  class=tablebold valign=top><b><%= bundle1.getString("label.staffregisteration.AreaofInterest")%> </td>
	<td  ><textarea	name="areaOfInterest" rows=5 cols=40 	validate="Area of Interest"  onkeydown="textCounter_label(document.f1.areaOfInterest,document.getElementById('remLen2'),2000)"
							onkeypress="textCounter_label(document.f1.areaOfInterest,document.getElementById('remLen2'),2000)"></textarea>
						<br>
						<i><font color="red"><label name="remLen2" id="remLen2"><%= bundle1.getString("label.staffregisteration.2000")%></label>
						<%= bundle1.getString("label.staffregisteration.charactersRemaining")%></font></i></td>
</tr>

<tr height=40>
<td class=tablebold valign=top><b><%= bundle1.getString("label.staffregisteration.Publications")%> </td>
	<td  ><textarea	name="publiCations" rows=5 cols=40 	validate="Publications"  onkeydown="textCounter_label(document.f1.publiCations,document.getElementById('remLen22'),2000)"
							onkeypress="textCounter_label(document.f1.publiCations,document.getElementById('remLen22'),2000)"></textarea>
						<br>
						<i><font color="red"><label name="remLen22" id="remLen22"><%= bundle1.getString("label.staffregisteration.2000")%></label>
						<%= bundle1.getString("label.staffregisteration.charactersRemaining")%></font></i><br><br><br><br></td></tr>   
						<tr class=tableheading height="30" >
<td colspan="3">&nbsp;<b> <%= bundle1.getString("label.staffregisteration.LoginInformation")%></td><td align=right scope="col" class="rounded-q4"><font color=red>*</font>&nbsp;<font color=#000000><%= bundle1.getString("label.staffregisteration.MandatoryFields")%></font></td>
</tr>
<tr height=30>
	<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.UserName")%>&nbsp;

	</td>
	<td class=tablelight><input type=text name = "user_id"  size=20 maxlength=12 validate="User Name"    class=tablelight><a class=tablelight> &nbsp; &nbsp;<font color=red><%= bundle1.getString("label.staffregisteration.(4to12Characters)")%></font></a>
		</td>
</tr>
<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.Password")%>&nbsp;</td>

<td><input type = password name = "user_passwd1" id="pass"  size=20 maxlength=25  validate="Password" class=tablelight onfocus="ff()" onkeyup="passwordStrength(this.value)" onchange="passwordStrength(this.value)" value=""><a class=tablelight> &nbsp; &nbsp;<font color=red><%= bundle1.getString("label.staffregisteration.(4to25Characters)")%></font></a>
</td>
</tr>
<tr>
<td class="tablebold">&nbsp;&nbsp;<%= bundle1.getString("label.staffregisteration.PasswordStrength")%>
</td>  
<td>
<div id="passwordDescription"><%= bundle1.getString("label.staffregisteration.Passwordnotentered")%></div>
<div id="passwordStrength" class="strength0"></div>
</td>
</tr>

<tr height=30>
<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle1.getString("label.staffregisteration.ConfirmPassword")%>&nbsp;</td>
<td><input type=password name="user_passwd2"  size=20 maxlength=25  class=tablelight validate="Confirm Password" onfocus="ff1()"value=""></td>
</tr>
 -->
<!-- **************LOGIN LOGIN******************************************************************-->
			</table>
		</td>
	</tr>
	
<tr  align="center" height=10>
<td colspan=5>
<input type =hidden name='session_userid' value="<%=userid%>">


</td>
</tr>
<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
</table>
<!--</div>-->   
<br>
<a href="#bbb" name="bbb" onclick='javascript:validation_all()' class="bt_green" align=center><span class="bt_green_lft"></span><strong><%= bundle1.getString("button.staffregisteration.Register")%></strong><span class="bt_green_r"></span></a>
</form>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%
}
%>
<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>