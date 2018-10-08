<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffpreviewedit.staffregisterationtitle") %>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/ServerPath.js"></SCRIPT>
<script language="javascript" src="<%=request.getContextPath()%>/js/Elements.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<style>
#passwordStrength

{

	height:10px;

	display:block;

	float:left;

}

.strengthnot

{

	width:150px;

	background:#ccceee;

}

.strength0

{

	width:25px;

	background:#cccccc;

}



.strength1

{

	width:50px;

	background:#ff0000;

}



.strength2

{

	width:75px;	

	background:#ff5f5f;

}



.strength3

{

	width:100px;

	background:#56e500;

}



.strength4

{

	background:#4dcd00;

	width:125px;

}



.strength5

{

	background:#399800;

	width:150px;

}

</style>

<script type="text/javascript">
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
var dob=document.f1.user_bday.value.split("-");
//var dob=date.split("-");
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
function passwordStrength(password)

{

	var desc = new Array();

	desc[0] = "Very Weak";

	desc[1] = "Weak";

	desc[2] = "Better";

	desc[3] = "Medium";

	desc[4] = "Strong";

	desc[5] = "Strongest";



	var score   = 0;



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
function editfun()
	{
				window.history.go(-1);
	}
function Submitfun()
{
document.f1.action= "./StaffRegistrationSubmit.jsp";
document.f1.submit();
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
function backfun()
{
document.f1.action= "./Staff_registration.jsp";
document.f1.submit();
}
function contactprofileupdate()
{
document.f1.action= "./Staffcontactprofileupdate.jsp";
document.f1.submit();
}
function updatestaffstatus()
{
var Status=document.f1.status.value;
var fieldname="";
if(Status=="D")
{
fieldname="Deactivate"
}
else if(Status=="A")
{
fieldname="Activate"
}
else if(Status=="T")
{
fieldname="Trash"
}
if(confirm("Are You Sure You Want to "+fieldname+" the Staff ...?"))
{
document.f1.action= "./StaffupdateSubmit.jsp";
document.f1.submit();
}
}
function win(obj)
{
var attachment=obj.getAttribute("atta");
window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
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
	if(check_ForParticularElements(document.f1.user_first_name,"text",document.f1.user_last_name,"text",document.f1.user_final_qualification,"text", document.f1.user_id,"text",document.f1.user_passwd1,"text",document.f1.user_passwd2,"text",document.f1.user_fathername,"text",document.f1.user_mothername,"text",document.f1.user_bday,"text",document.f1.user_age,"text",document.f1.user_street1,"text",document.f1.user_street2,"text",document.f1.user_city,"text",document.f1.country,"select",document.f1.user_zipcode,"text",document.f1.permanentuser_street1,"text",document.f1.permanentuser_street2,"text",document.f1.permanentuser_city,"text",document.f1.permanentcountry,"select",document.f1.permanentuser_zipcode,"text",document.f1.user_phone,"text",document.f1.user_private_mail_id,"text",document.f1.user_department,"select",document.f1.user_role,"select",document.f1.user_joining_date,"text"))
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
				
				if(!stringValidate(document.f1.user_middle_name,"Father Name"))
				 {
					document.f1.user_middle_name.focus();
					return false;
				 }
				 
				 if(!stringValidate(document.f1.user_last_name,"Mother Name"))
				 {
					
					document.f1.user_last_name.focus();
					return false;
				 }
				if(document.f1.hiddenphoto.value=="")
					{
					if(document.f1.user_photo.value =="")
						{
							alert("Empty Photo not allowed");
							document.f1.user_photo.focus();
							return false;
						}			
					}
					if(document.f1.user_photo.value !="")
						{
							var pho_val=getExtension(document.f1.user_photo.value);
							if((pho_val != "jpg") & (pho_val != "gif"))
							{
								alert("Please give photo file(ex:gif,jpg.....");
								document.f1.user_photo.select();
								return false;
							}
							if(document.f1.user_photo.value !="")
							{
								var pho_val=getExtension(document.f1.user_photo.value);
								pho_val = pho_val.toLowerCase();
								if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg"))
								{
								alert("*.jpeg,*.jpg,*.gif Image type only allowed")
								document.f1.user_photo.select();
								return false;
								}
							}
						}
				
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
			
			if(document.f1.permanentuser_state.length==1)
			{
				if(document.f1.permanentuser_state1.value=="")
				{
					alert("Enter the State");
					document.f1.permanentuser_state1.style.visibility="visible";
					document.f1.permanentuser_state1.focus();
					return false;
				}
			}
			var qualificationcheckcount=0;
			if(document.f1.chk.length==undefined)
			{
				if(document.f1.chk.checked==true)
					qualificationcheckcount++;
			}
			else
			{
				for(var i=0;i<document.f1.chk.length;i++)
					{
						if(document.f1.chk[i].checked==true)
							qualificationcheckcount++;
					}
			}
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
			
			submitAction();
	}

}

function submitAction()
{
		if(document.f1.user_state.selectedIndex == 0)
		{
			if(document.f1.user_state1.value =="")
				{
					document.f1.user_state.options[0].value = "-";
				}
			else
				{
					document.f1.user_state.options[0].value = document.f1.user_state1.value;
				}
		}
		if(document.f1.permanentuser_state.selectedIndex == 0)
		{
			if(document.f1.permanentuser_state1.value =="")
			{
				document.f1.permanentuser_state1.value = "-";
			}
			else
			{
				document.f1.permanentuser_state.options[0].value = document.f1.permanentuser_state1.value;
			}
		}
		if(document.f1.chk.length==undefined)
		{
			if(!document.f1.chk.checked)
			   {
			   document.f1.major.disabled=true;
			   document.f1.user_qualification.disabled=true;
			   document.f1.Yearofgrad.disabled=true;
			   document.f1.marks.disabled=true;
			   document.f1.institutename.disabled=true;
			   }
			   else
			   {
			   document.f1.major.disabled=false;
			   document.f1.user_qualification.disabled=false;
			   document.f1.Yearofgrad.disabled=false;
			   document.f1.marks.disabled=false;
			   document.f1.institutename.disabled=false;
			   }
		}
		else
		{
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
		 }
		 if(document.f1.experiencecheck!=undefined) 
			 {
			 if(document.f1.experiencecheck.length==undefined) 
			 {
			 	if(!document.f1.experiencecheck.checked)
				   {
					   document.f1.instituteRole.disabled=true;
					   document.f1.institutePeriod.disabled=true;
				   }
				   else
				   {
					   document.f1.instituteRole.disabled=false;
					   document.f1.institutePeriod.disabled=false;    
				   }
			 }
			 else
			 {
				for(var i=0;i<document.f1.experiencecheck.length;i++)
				{
				   if(!document.f1.experiencecheck[i].checked)
				   {
					   document.f1.instituteRole[i].disabled=true;
					   document.f1.institutePeriod[i].disabled=true;
				   }
				   else
				   {
					   document.f1.instituteRole[i].disabled=false;
					   document.f1.institutePeriod[i].disabled=false;
				   }
				}
			 }
			 }
	Submit();
	
}
function experiencevalidation(obj,elementno)
{
	if(document.f1.experiencecheck.length==undefined)
	{
		if(obj.checked)
		{
			if(!check_ForParticularElements(document.f1.instituteRole,"text",document.f1.institutePeriod,"text"))
				{
				   obj.checked=false;
				   return false;
				}
			else
				{
					document.f1.instituteRole.disabled=true;
					document.f1.institutePeriod.disabled=true;
				}
		}
		else
		{
		   document.f1.instituteRole.disabled=false;
		   document.f1.institutePeriod.disabled=false;
		}
	}
	else
	{
		if(obj.checked)
		{
			if(!check_ForParticularElements(document.f1.instituteRole[elementno],"text",document.f1.institutePeriod[elementno],"text"))
				{
				   obj.checked=false;
				   return false;
				}
			else
				{
					document.f1.instituteRole[elementno].disabled=true;
					document.f1.institutePeriod[elementno].disabled=true;
				}
		}
		else
		{
		   document.f1.instituteRole[elementno].disabled=false;
		   document.f1.institutePeriod[elementno].disabled=false;
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

function qualificationvalidation(obj,elementno)
{
		if(document.f1.experiencecheck.length==undefined)
		{
			if(obj.checked)
				{
					if(!check_ForParticularElements(document.f1.major,"text",document.f1.user_qualification,"text",document.f1.Yearofgrad,"text",document.f1.marks,"text",document.f1.institutename,"text"))
					{
					   obj.checked=false;
					   return false;
					}
					else
					{
								var year_of_graduration=document.f1.Yearofgrad.value;
								var split_year_of_graduration	= year_of_graduration.split(" ");
									if(split_year_of_graduration.length > 2){
										alert("Invalid year of graduation.");
								  		obj.checked=false;
										document.f1.Yearofgrad.focus();
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
											document.f1.Yearofgrad.focus();
											return false;
										}
										if(isNaN(split_year_of_graduration[1])){
											alert("Invalid year of graduation.");
											obj.checked=false;
											document.f1.Yearofgrad.focus();
											return false;
										}
									}
								if(isNaN(document.f1.marks.value))
								{
										alert("Invalid GPA.");
										obj.checked=false;
										document.f1.marks.value="";
										document.f1.marks.focus();
										return false;
						}
						
				   document.f1.major.disabled=true;
				   document.f1.user_qualification.disabled=true;
				   document.f1.Yearofgrad.disabled=true;
				   document.f1.marks.disabled=true;
				   document.f1.institutename.disabled=true;
					}
					
				}
				else
						{
						   document.f1.major.disabled=false;
						   document.f1.user_qualification.disabled=false;
						   document.f1.Yearofgrad.disabled=false;
						   document.f1.marks.disabled=false;
						   document.f1.institutename.disabled=false;
						   
						}
					
		}
		else
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
					}
					else
						{
						   document.f1.major[elementno].disabled=false;
						   document.f1.user_qualification[elementno].disabled=false;
						   document.f1.Yearofgrad[elementno].disabled=false;
						   document.f1.marks[elementno].disabled=false;
						   document.f1.institutename[elementno].disabled=false;
						}
				}
		
	
	
}
function Submit()
	{
		if(confirm("Do you want to continue?"))
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
	var xmlDoc=null;

function loadOption()
{
    document.f1.permanentuser_state1.style.visibility='hidden';
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
var obj1			= document.forms["f1"].permanentcountry;

	var country_xml = xmlDoc.getElementsByTagName("location");
	if(country_xml[0] != null)
	{
		var states = country_xml[0].getElementsByTagName("country");
		for(var i=0;i<states.length;i++)
		{
			var val 	= states[i].attributes.getNamedItem("name").nodeValue;
			obj.options[obj.options.length] = new Option(val,val);
			obj1.options[obj1.options.length] = new Option(val,val);
			
		}
	}
	for(var i=0;i<document.f1.country.length;i++)  
 	{
 		if(document.f1.country.options[i].value==document.f1.hiddencoun.value)
 		document.f1.country.options[i].selected=true;
 	}
 	country_fun(document.getElementById('user_state'),document.f1.country,document.getElementById('user_state1'));
 	for(var i=0;i<document.f1.user_state.length;i++)  
 	{
 		if(document.f1.user_state.options[i].value==document.f1.hiddenstate.value)
 		document.f1.user_state.options[i].selected=true;
 	}
	for(var i=0;i<document.f1.permanentcountry.length;i++)  
 	{
 		if(document.f1.permanentcountry.options[i].value==document.f1.hiddenpercoun.value)
 		document.f1.permanentcountry.options[i].selected=true;
 	}
 	country_fun(document.f1.permanentuser_state,document.f1.permanentcountry,document.f1.permanentuser_state1);
 	for(var i=0;i<document.f1.permanentuser_state.length;i++)  
 	{
 		if(document.f1.permanentuser_state.options[i].value==document.f1.hiddenperstate.value)
 		document.f1.permanentuser_state.options[i].selected=true;
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

<script language="javascript" type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />

</head>
<body  onload="loadOption()">
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.staffpreviewedit.staffregisterationrootpath") %></h2>
<form name="f1" method="post" action=""  enctype="multipart/form-data"><%@ page
	import="java.util.*"%> <%

 %> <%@ page
	import="com.iGrandee.Registration.StaffRegistrationQuery,com.iGrandee.Common.DateTime,com.iGrandee.Registration.StaffRegistrationBean,com.iGrandee.Registration.StaffRegistrationUpload"%>
 <%
	String certificatename[] =null;
	String certificatepath[] =null;
	StaffRegistrationBean gen_qu=new StaffRegistrationBean();
	DateTime dateobj=new DateTime();
	String date_str = "";
	ArrayList deptList = null;
	StaffRegistrationQuery staffquery = new StaffRegistrationQuery();
	String userid = null;
	String instituid = null;
	String Staffid = null;
	String departid = null;
	String roleid = null;
	String Status = null;
	String Staffname = null;

	instituid=(String)session.getValue("instituteid");

	String sessionInstituteName = "";
	sessionInstituteName=(String)session.getValue("institutename");
	
		userid=(String)session.getValue("userid");

	if (userid != null) {
		try {
			departid = request.getParameter("departmentid");
			Staffid = request.getParameter("Staffid");
			roleid = request.getParameter("roleid");
			Status = request.getParameter("status");
			Staffname = request.getParameter("Staffname");

			deptList = staffquery.staffdetails(Staffid);
			//out.println("=====>>>"+Staffid);
			String instituteid = "";

		}

		catch (NullPointerException e) {
		}
		ArrayList deptListnew = null;
		ArrayList roleList = null;
		ArrayList jobList = null;
		
 		String name = "-";
 		String fname = "-";
 		String mname = "-";
 		String lname = "-";
 		String age = "-";
 		String dob = "-";
 		String gender = "-";
 		String m_status = "-";

 		//contact
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

 		String mail_id = "-";

 		//job
 		String department = "-";
 		String occupation = "-";
 		String landline = "-";
 		String mobile = "-";
 		String email = "-";

 		String join_date = "-";
 		HashMap map = null;
 		String area = "-";
 		String publication = "-";
 		String sessionuserid = "";
 		String[] major =null;
 		String[] user_qualification =null;
 		String[] Yearofgrad =null;
 		String[] marks =null;
 		String[] institute_name =null;
 		String[] instName =null;
 		String[] instRole =null;
 		String[] instPeriod =null;
 		String fathername = null;
 		String mothername = null;
 		String username = null;
 		String rolenname =null;
 		String departmentname =null;
 		String prefixname="";
 		String qualification=null;
 		String photo=null;
 		String password=null;
 		String smsmobile=null;

 		
 		try{
 			
		deptListnew =staffquery.departmentload(instituid);
		roleList = staffquery.roleload(instituid);
		jobList = staffquery.jobcategoryload(instituid);
		
		StaffRegistrationBean	gen_qu2=new StaffRegistrationBean();
		gen_qu2=(StaffRegistrationBean)session.getAttribute("detailobj");
 		age = gen_qu2.getAge();
 		prefixname = gen_qu2.getprefix();
 		fname = gen_qu2.getFirstName();
 		mname = gen_qu2.getMidName();
 		lname = gen_qu2.getLastName();
 		qualification = gen_qu2.getQualification();
 		fathername = gen_qu2.getFatherName();
 		mothername = gen_qu2.getMotherName();
 		gender = gen_qu2.getGender();
 		m_status = gen_qu2.getMStatus();
 		username = gen_qu2.getUserName();
 		password = gen_qu2.getPassWd();
 		dob = gen_qu2.getEditdob();
 		communicationstreet1 = gen_qu2.getStreet1();
 		communicationstreet2 = gen_qu2.getStreet2();
 		communicationstate = gen_qu2.getState();
 		communicationcity = gen_qu2.getCity();
 		communicationcountry = gen_qu2.getCountry();
 		communicationpin = gen_qu2.getZipCode();
 		if (communicationpin.equals(""))
 			communicationpin = "-";
 		permanentstreet1 = gen_qu2.getpermanentStreet1();
 		permanentstreet2 = gen_qu2.getpermanentStreet2();
 		permanentstate = gen_qu2.getpermanentState();
 		permanentcity = gen_qu2.getpermanentCity();
 		permanentcountry = gen_qu2.getpermanentCountry();
 		permanentpin = gen_qu2.getpermanentZipCode();
 		if (permanentpin.equals(""))
 			permanentpin = "-";
 		mobile = gen_qu2.getMobile();
 		if (mobile == null || mobile.equals("")
 				|| mobile.equals("null"))
 			mobile = "-";

 		landline = gen_qu2.getLandLine();
 		if (landline == null || landline.equals("")
 				|| landline.equals("null"))
 			landline = "-";
 		email = gen_qu2.getEMail();
 		if (email.equals(""))
 			email = "-";

 		 major = gen_qu2.getmajor();
 		 user_qualification = gen_qu2.getuser_qualification();
 		 Yearofgrad = gen_qu2.getYearofgrad();
 		 marks = gen_qu2.getmarks();
 		 institute_name = gen_qu2.getinstitutename();
 		 instName = gen_qu2.getinstName();
 		 instRole = gen_qu2.getinstRole();
 		 instPeriod = gen_qu2.getinstPeriod();
 		 occupation = gen_qu2.getPost();
 		 department = gen_qu2.getDepartment();
 		 roleid = gen_qu2.getRole();
 		 smsmobile=gen_qu2.getSmsmobile();

 		/* rolenname 	  = gen_qu2.getParameter("rolename");
 		 departmentname = gen_qu2.getParameter("departname");*/

 		 join_date = gen_qu2.getEditjoindate();

 		 area = gen_qu2.getAreaOfInterest();
 		 publication = gen_qu2.getPubliCations();
 		 
 		 certificatename = gen_qu2.getVerficertificatename();
 		 certificatepath = gen_qu2.getVerficertificatepath();
 		 photo=gen_qu2.getPhoto();
 		 session.setAttribute("detailobj",gen_qu2);    
		 }
 		 catch(Exception e)
 		 {
 			e.printStackTrace();
 		 }
 		java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
 		String shapshotpath=rb.getString("shapshot");
 		//out.println("shapshotpath********* "+shapshotpath);
 		String imagePath=rb.getString("storagepath")+"/imagestorage/";
 		String imageName="StaffPersonalImage.jpg";  
  %>
<form name="f1" method="post" action=""><input type="hidden"
	name="Staffid" value="<%=Staffid%>" /> <input type="hidden"
	name="roleid" value="<%=roleid%>" /> <input type="hidden"
	name="status" value="<%=Status%>" /> <input type="hidden"
	name="departmentid" value="<%=departid%>" />
	<input type=hidden name=hiddenuser_id value="">
	<input type=hidden name=rolename value="">
	<input type=hidden name=departname value="">
	<input type=hidden name=editstatus value="Edit">
	
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height=485 cellpadding=0>
	<tr valign="top" style="height: 190">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"	width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.subcontent")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>
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
					<td width="100%" colspan=2>
					<table width="100%" border=0 bgcolor="#ffffff" cellspacing=0 cellpadding=0 >
					<tr height=30>
						<td class=tablebold width='20%' ><font color="red" >*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Prefix") %>&nbsp;</td>
						<td class=tablelight width='80%' >
							<select name="slt_prefix"  maxlength=6  class=tablelight validate="prefix">
								 <option value="Mr.">Mr.</option>
								 <option value="Mrs.">Mrs.</option>
								 <option value="Ms.">Ms.</option>
						 		 <option value="Dr.">Dr.</option>
						 		 <option value="Sir.">Sir.</option>
						 	</select> 
						 	<script>
						 	for(var i=0;i<document.f1.slt_prefix.length;i++)
						 	{
						 		if(document.f1.slt_prefix.options[i].value=="<%=prefixname%>")
						 		document.f1.slt_prefix.options[i].selected=true;
						 		
						 	}
						 	</script>
						 </td>
					</tr>
					<tr height=30>
						<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.FirstName") %>&nbsp;</td>
						<td class=tablelight><input type = text name = "user_first_name" size=21 maxlength=50 value="<%=fname %>" validate="First Name" class=tablelight>
						<input type ="hidden" name = "hiddenphoto"  value="<%=photo%>" ><div style="position:absolute;left:75%;"><img src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>" name='stphoto_img1' id=stphoto_img width=120 height=130></img></div></td>
					</tr>
									
					<tr height=30>
							<td class=tablebold>&nbsp;&nbsp;<%=bundle.getString("label.staffpreviewedit.MiddleName") %>&nbsp;</td>
							<td class=tablelight><input type = text name = "user_middle_name" size=5 maxlength=50  value="<%=mname %>" class=tablelight></td>
					</tr>
					<tr height=30>
							<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.LastName") %>&nbsp;</td>
							<td class=tablelight><input type = text name = "user_last_name" size=21 maxlength=50  validate="Last Name" class=tablelight value="<%=lname%>" ></td>
					</tr>
					<tr height=30>
						<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Qualification") %>&nbsp;</td>
						<td class=tablelight><input type = text name = "user_final_qualification" size=21 maxlength=50  validate="Qualification" value="<%=qualification %>" class=tablelight></td>
					</tr>
					
					<tr height=30>
							<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Gender") %>&nbsp;</td>
							<td class=tablelight>
								<input type = radio name="user_gender" value="M" ><%= bundle.getString("label.staffpreviewedit.Male")%>
							    <input type = radio name="user_gender" value="F" ><%= bundle.getString("label.staffpreviewedit.Female")%>
						    <script>
							 	for(var i=0;i<document.f1.user_gender.length;i++)
							 	{
							 		if(document.f1.user_gender[i].value=="<%=gender%>")  
							 		document.f1.user_gender[i].checked=true;  
							 	}
						 	</script> 
							</td>
					</tr>
					<tr height=30>
							<td class=tablebold>
								<font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.DateofBirth") %>&nbsp;
							</td>
							<td class=tablelight>
								<input type = text name="user_bday" class="tablelight"  value="<%=dob %>"  maxlength=50 size=20 validate="Date of Birth" ><input type="button" class="tablehead" value="^" onclick="document.f1.user_bday.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.user_bday','1000',event,'Not_Greater_Than_CurrentDate',document.f1.server_date);">          
							</td> 
					</tr>
					<tr style="height: 25">
							<td class="tablebold" style="width: 15%"><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Age")%>
							</td>
							<td class="tablelight" style="width: 35%"><label id='displayage'><%=age%> <%=bundle.getString("label.staffpreviewedit.years")%></label> <input type =hidden  name="user_age" class=tablelight value="<%=age%>" validate="Age" maxlength=3 size=3 ></td>
			<tr align="left">
					<td colspan=2>
					<input type="radio" name="phototype" value='local' onclick="loadphototype('local')" checked/><%=bundle.getString("label.studentprofileentry.UploadImage")%><input type="radio" name="phototype" value='snapshot' onclick="loadphototype('webcam')"/><%=bundle.getString("label.studentprofileentry.CaptureImage")%>
					</td>
					</tr>
					<tr align="left">
					<td colspan=2>
					<table border='0' bordercolor='yellow' id="localphoto" style="display:block;" >  
						<tr>  
						<td width="34%" align="left" class=tablebold><%=bundle.getString("label.studentprofileentry.Photo")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td align="left" valign="bottom" width="66%"><input size='30' type=file class="browses" name="user_photo"	></td>
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
							<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.MaritalStatus") %>&nbsp;</td>
							<td class=tablelight>
								<input type = radio name = "user_mar_status" validate="Marital Status" value="Married"><%=bundle.getString("label.staffpreviewedit.Married") %>
								<input type = radio name = "user_mar_status" value="Single"><%=bundle.getString("label.staffpreviewedit.Single") %>
							 <script>
							 	for(var i=0;i<document.f1.user_mar_status.length;i++)
							 	{
							 		if(document.f1.user_mar_status[i].value=="<%=m_status%>")  
							 		document.f1.user_mar_status[i].checked=true;  
							 	}
						 	</script> 
							</td>
					</tr>
					
					<tr height=30>
							<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.FatherName") %></td>
							<td><input type = text name = user_fathername maxlength=50 size=30 value="<%=fathername%>" validate="Father Name" class=tablelight></td>
					</tr>

					<tr height=30>
						<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.MotherName") %></td>
						<td><input type = text name = user_mothername maxlength=50 size=30 value="<%=mothername%>" validate=" Mother Name" class=tablelight></td>
					</tr>
										
					</table>
					</td>
				</tr>
			</tbody>

		</table>
		<br>
		</td>
	</tr>


	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.continform")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr height=25>
					<td align=left colspan=2>
					<h3 align=left><%=bundle.getString("label.staffprofile.CommunicationAddress")%></h3>
					</td>
				</tr>
				<tr>
				<td width="100%" colspan=2>
				<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
					cellpadding=0 cellspacing=0 width="95%" >

					<tr>
						<td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Street1") %>&nbsp;</td>
								<td><input type=text name = "user_street1" maxlength=50 size=35  validate="Street" value="<%=communicationstreet1%>" class=tablelight></td>
							</tr>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Street2") %>&nbsp;</td>
								<td><input type=text name = "user_street2" maxlength=50 size=35 value="<%=communicationstreet2%>" class=tablelight></td>
							</tr>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Country") %>&nbsp;</td>
								<!--<td><input type=text size=12 name='country' validate="Country" class=tablelight value="" value=""></td>-->
								<td><select size=1 cols=20 id=country name="country" validate="Country" style="width:250px" class=tablelight onchange="country_fun(document.getElementById('user_state'),this,document.getElementById('user_state1'));">
								<option value="">Select Country</option>
								</select>
								<input type=hidden name="hiddencoun" value="<%=communicationcountry%>" /> 
								
							</td>
							</tr>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.State") %>&nbsp;</td>
								<td>
								<select id = "user_state"  name = "user_state" validate="User State" style="width:250px" class=tablelight><option>Select State</option></select>
								<input type="text" name='user_state1' id='user_state1' maxlength=50>
								<input type=hidden name="hiddenstate" value="<%=communicationstate%>" /> 
								
								</td>
							</tr>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.City") %>&nbsp;</td>
								<td><input type = text name = "user_city" validate="City" maxlength=50 size=15 value="<%=communicationcity%>" class=tablelight></td>
							</tr>
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.PostalCode") %>&nbsp;</td>
								<td><input type = text name = "user_zipcode" maxlength=6 size=15 validate="Postal Code" value="<%=communicationpin%>" onkeypress="checkNumber(event)" class=tablelight></td>
							</tr>
							<tr height=30 style="background-color:red;">
								<td align=left colspan=2>
									<h3><div style="position:relative;left:-38px">Permanent Address</div></h3>
								</td>	
							</tr>
							<tr height=30>
							<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Street1") %>&nbsp;</td>
							<td><input type=text name = "permanentuser_street1" maxlength=50 size=35  validate="Street" value="<%=permanentstreet1%>" class=tablelight></td>
							</tr>

							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Street2")%>&nbsp;</td>
								<td><input type=text name = "permanentuser_street2" maxlength=50  validate="Permanent Street" size=35 value="<%=permanentstreet2%>" class=tablelight></td>
							</tr>

							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Country") %>&nbsp;</td>
								<!--<td><input type=text size=12 name='country' validate="Country" class=tablelight value="" value=""></td>-->
								<td><select size=1 cols=20 name="permanentcountry" validate="Country" style="width:250px" class=tablelight onchange='country_fun(document.f1.permanentuser_state,this,document.f1.permanentuser_state1);'>
								<option value="0">Select Country</option>
								</select>
								<input type=hidden name="hiddenpercoun" value="<%=permanentcountry%>" /> 
								</td>
							</tr>

							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.State") %>&nbsp;</td>
								<td>
								<select name = "permanentuser_state" validate="User state" style="width:250px" class=tablelight><option>Select State</option></select>
								<input type="text" name='permanentuser_state1' maxlength=50>
								<input type=hidden name="hiddenperstate" value="<%=permanentstate%>" /> 
								
								</td>
							</tr>
							
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.City") %>&nbsp;</td>
								<td><input type = text name = "permanentuser_city" validate="City" maxlength=50 size=15 value="<%=permanentcity%>" class=tablelight></td>
							</tr>

							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.PostalCode") %>&nbsp;</td>
								<td><input type = text name = "permanentuser_zipcode" maxlength=6 size=15 validate="Postal Code" value="<%=permanentpin%>" onkeypress="checkNumber(event)" class=tablelight></td>
							</tr>
							
							<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.MobileNo") %><br></td>
								<td><span id=phone></span><input type = text name="user_phone" validate='Telephone No' size=35  onkeypress="checkNumber(event)" maxlength=25 class=tablelight value="<%=mobile%>" ></td>
							</tr>
							<tr height=30>
								<td class=tablebold width="20%"><font color=red class=tablebold>*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.smscontact") %></td>
								<td class=tablebold width="30%"><input type="text" class="tablelight" name="smscontactno" size=35 validate='SMS Contact Number' maxlength="50" onkeypress="smsmobilecontactcheck(event)" value="<%=smsmobile%>"></td>							</tr>
							<tr height=30>
								<td class=tablebold><font color="ff0000">&nbsp;</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.HomePhoneNo") %><br></td>
								<td><span id=phone></span><input type = text name="user_phone_ll" validate='Telephone No' size=35 value="<%=landline%>" onkeypress="checkNumber(event)" maxlength=25 class=tablelight ></td>
							</tr>
							<tr height=30>
								<td valign="top" height="60" class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.Email") %></td>
								<td valign="top" height="60"><input type=text name="user_private_mail_id" size=35 validate="Email Address"  class=tablelight maxlength=40 value="<%=email%>"></td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
						</td>
					</tr>
				</table>
				
		<br>
		</td>
	</tr>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffprofile.qualification")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<tr style="height: 25">
								<td class="tablebold" style="width: 5%"><%=bundle.getString("label.staffpreviewedit.SL.No")%></td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffpreviewedit.Major")%></td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffpreviewedit.University")%>
								</td>
								<td class="tablebold" style="width: 35%"><%=bundle.getString("label.staffpreviewedit.Program")%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffpreviewedit.years")%>
								</td>
								<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffpreviewedit.%OfMarks")%></td>
								<td class="tablebold" style="width: 15%"><%= bundle.getString("label.staffpreviewedit.Check")%></td>
							</tr>
							<%
								if (major != null && major.length > 0) {
										for (int i = 0; i < major.length; i++) {
											out.println("<tr>");
											out.println("<td class='tablelight'>");  
											out.println((i + 1));
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=text name=major validate='Major' size=16 class=tablelight  disabled value='");

											out.println(major[i]);
											out.println("' >");

											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=text name=institutename validate='Institute Name' size=20 class=tablelight  disabled value='");

											out.println(institute_name[i]);
											out.println("' >");

											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=text validate='Qualification' class=tablelight name=user_qualification size=16  disabled value='");
											out.println(user_qualification[i]);
											out.println("' >");
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=text name='Yearofgrad' validate='Year of Graduation' size=10 class=tablelight  disabled value='");

											out.println(Yearofgrad[i]);
											out.println("' >");

											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=text name='marks' validate='Percentage' size=10 class=tablelight  maxlength=3  disabled value='");

											out.println(marks[i]);
											out.println("' >");
											out.println("</td>");
											out.println("<td class='tablelight'>");
											out.println("<input type=checkbox class=tablelight name=chk onclick=qualificationvalidation(this,'"+i+"') checked>");
											out.println("</td>");
											out.println("</tr>");

										}
									}
							%>
						</table>
						</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
<%
if (certificatepath != null && certificatepath.length > 0 && certificatename != null && certificatename.length > 0) {
%>
		<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffpreviewedit.Certificate")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr><td width="100%">
						<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
							cellspacing=0>
							<%
										for (int i = 0; i<certificatepath.length; i++) {
											out.println("<tr>");
											out.println("<td class='tablelight' width='10%' >");
											out.println((i + 1));
											out.println("</td  width='10%' >");
											out.println("<td class='tablelight'>");
											out.println(certificatename[i]);
											out.println("[ <a href='#' atta='"+certificatepath[i]+"' onclick=win(this)>View</a> ]");
											out.println("</td>");
											out.println("</tr>");

										}
							%>
						</table>
						</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
	<%} %>
	<tr valign="top" >
		<td colspan=4>
		<table id="rounded-corner" border=0 summary="Department List"  
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="40%"><%=bundle
										.getString("label.staffprofile.jobinform")%></th>
					<th scope="col" class="rounded-q4" ></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr class=tablebold height=30>
				<td width=20%><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.Position")%>&nbsp;</td>
				<td>
				<%
				
				try
				{
			 		HashMap deptMap = null;
			 		for(int i=0;i<jobList.size()-1;i++) 
			 		{
			 			deptMap = (HashMap)jobList.get(i);
			 			

			 			String categoryid = (String)deptMap.get("staffcategoryid");
			    		String categoryname = (String)deptMap.get("categoryname");
			    		if(categoryid.equals(occupation))
			    			out.print("<input type='radio' name='user_post' value='"+categoryid+"' checked>"+categoryname);
			 			else
			    			out.print("<input type='radio' name='user_post' value='"+categoryid+"'>"+categoryname);
			    		
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
				<td valign="top" height="40" class=tablebold><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.Department")%> </td>
				<td valign="top" height="40"><select name="user_department" class=tablelight validate="Department" style="width:250px">
				  <option >&nbsp;&nbsp;-- Select Department --&nbsp;&nbsp;</option>
				  <%
					try
					{
				 		HashMap deptMap = null;
				 		for(int i=0;i<deptListnew.size();i++) {
				 			deptMap = (HashMap)deptListnew.get(i);
				 			String deptid = (String)deptMap.get("departmentid");
				    		String deptname = (String)deptMap.get("departmentname");
				    		if(deptid.equals(department))
				    			out.println("<option value='"+deptid+"' selected>"+deptname+"</option>");
				    		else
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
				<td valign="top" height="40" class=tablebold><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.role")%> </td>
				<td valign="top" height="40"><select name="user_role" class=tablelight validate="Role" style="width:250px">
				  <option >&nbsp;&nbsp;-- Select Position --&nbsp;&nbsp;</option>
				  <%
				  try
					{
						
						HashMap roleMap = null;
						for(int i=0;i<roleList.size();i++) {
							roleMap = (HashMap)roleList.get(i);
							String roleidin = (String)roleMap.get("roleid");
							String rolename = (String)roleMap.get("rolename");
							if(roleidin.equals(roleid)) 
							out.println("<option value='"+roleidin+"' selected>"+rolename+"</option>");
							else
								out.println("<option value='"+roleidin+"'>"+rolename+"</option>");

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
					<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.JoiningDate")%>&nbsp;</td>
					<td class=tablelight><input type = text name="user_joining_date" maxlength=50 size=20 validate="Joining Date" value="<%=join_date%>" class=tablelight onkeydown='this.blur();'><input type="button" value="^" onclick="document.f1.user_gender.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','f1.user_joining_date','0',event,'Not_Greater_Than_CurrentDate',document.f1.server_date);">
				</tr>
				
					</table>
					</td>
					</tr>
		</table>
		<br>
		</td>
	</tr>
	<%
	if (instRole != null && instRole.length > 0) 
	{
		%>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffpreviewedit.ExperienceDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="100%">
							<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
								cellspacing=0>
								<tr style="height: 25">
									<td class="tablebold" style="width: 15%"><%=bundle.getString("label.staffpreviewedit.SL.No")%></td>
									<td class="tablebold" style="width: 40%"><%=bundle.getString("label.staffpreviewedit.Position")%></td>
									<td class="tablebold" style="width: 45%"><%=bundle.getString("label.staffpreviewedit.Period")%></td>
									<td class="tablebold"  align=center width='5%'><%= bundle.getString("label.staffpreviewedit.Check")%></td>
								</tr>
								<%
											for (int i = 0; i < instRole.length; i++) 
											{
												out.println("<tr>");
												out.println("<td class='tablelight'>");
												out.println((i + 1));
												out.println("</td>");
												out.println("<td class='tablelight'><input type=text name='instituteRole' maxlength=100 size=25 class=tablelight disabled value='" );
												out.println(instRole[i]);
												out.println("'></td>");
												out.println("<td class='tablelight'><input type=text name='institutePeriod' maxlength=100 size=25 class=tablelight disabled  value='");  
												out.println(instPeriod[i]);
												out.println("'></td>");
												out.println("<td class='tablelight'><input type=checkbox name='experiencecheck'onclick=experiencevalidation(this,'"+i+"') checked></td>");
												out.println("</tr>");   
											}
								%>
							</table>
							</td>
						</tr>
					</table>
			</tbody>
		</table>
		<br>
		</td>
	</tr>
        <%    }
							
	if((area!=null && !area.equals("")) || (publication!=null && !publication.equals("")) ){%>

	<tr valign="top">
		<td >
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffpreviewedit.subAreainterestAndPublication")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<td width="100%" colspan=4>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr>
							<td width="100%">
							<table width="100%" border=0 bgcolor="#ffffff" cellpadding=0
								cellspacing=0>
								<% if(area!=null && !area.equals("")) 
								{%>
								<tr height=20>
									<td  class=tablebold valign=top><b><%= bundle.getString("label.staffpreviewedit.AreaofInterest")%> </td>
									<td  ><textarea	name="areaOfInterest" rows=5 cols=40 	validate="Area of Interest"  onkeydown="textCounter_label(document.f1.areaOfInterest,document.getElementById('remLen2'),2000)"
															onkeypress="textCounter_label(document.f1.areaOfInterest,document.getElementById('remLen2'),2000)"><%=area%></textarea>
														<br>
														<i><font color="red"><label name="remLen2" id="remLen2"><%= bundle.getString("label.staffpreviewedit.2000")%></label>
														<%= bundle.getString("label.staffpreviewedit.charactersRemaining")%></font></i></td>
								</tr>
<%} if(publication!=null && !publication.equals("")) 
									{ %>
<tr height=40>
<td class=tablebold valign=top ><b><%= bundle.getString("label.staffpreviewedit.Publications")%> </td>
	<td  ><textarea	name="publiCations" rows=5 cols=40 	validate="Publications"  onkeydown="textCounter_label(document.f1.publiCations,document.getElementById('remLen22'),2000)"
							onkeypress="textCounter_label(document.f1.publiCations,document.getElementById('remLen22'),2000)"><%=publication%></textarea>
						<br>
						<i><font color="red"><label name="remLen22" id="remLen22"><%= bundle.getString("label.staffpreviewedit.2000")%></label>
						<%= bundle.getString("label.staffpreviewedit.charactersRemaining")%></font></i><br><br><br><br></td></tr>   
														<%} %>
						
						</table>
							</td>
						</tr>
					</table>


					</td>
				</tr>
		</table>
		<br>
		</td>
	</tr>
	<%} %>
	<tr valign="top">
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.staffpreviewedit.AccountInformation")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

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
					<td width="100%" colspan=2>
					<table border=0 bordercolor='#EFEFE7' align=center class=tablehead
						cellpadding=0 cellspacing=0 width="95%" rules="groups">
						<tr> 
							<td width="25%" class=tablebold><font color="red">*</font>&nbsp;<%=bundle.getString("label.staffpreviewedit.UserName")%></td>
							<td width="75%"><input type=text name = "user_id"  size=20 maxlength=12 validate="User Name"   value="<%=username%>" ></td>
						</tr>
						<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.Password")%>&nbsp;</td>
								
								<td><input type = password name = "user_passwd1" id="pass"  size=20 maxlength=25  validate="Password" class=tablelight onfocus="ff()" onkeyup="passwordStrength(this.value)" onchange="passwordStrength(this.value)" value=""><a class=tablelight> &nbsp; &nbsp;<font color=red><%= bundle.getString("label.staffpreviewedit.(4to25Characters)")%></font></a>
								</td>
						</tr>
						<tr>
								<td class="tablebold">&nbsp;&nbsp;<%= bundle.getString("label.staffpreviewedit.PasswordStrength")%>
								</td>  
								<td>
								<div id="passwordDescription"><%= bundle.getString("label.staffpreviewedit.Passwordnotentered")%></div>
								<div id="passwordStrength" class="strengthnot"></div>
								</td>   
						</tr>
						<tr height=30>
								<td class=tablebold><font color="red">*</font>&nbsp;<%= bundle.getString("label.staffpreviewedit.ConfirmPassword")%>&nbsp;</td>
								<td><input type=password name="user_passwd2"  size=20 maxlength=25  class=tablelight validate="Confirm Password" onfocus="ff1()"value=""></td>
						</tr>
					</table>
			</tbody>
		</table>
		</td>
	</tr>
</table>

<a href="#bbsb" name="bbsb" onclick=backfun() class="bt_blue"
	align=center><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.staffpreviewedit.Backtoentry")%></strong><span
	class="bt_blue_r"></span></a>
	<a href="#bbb" name="bbb" onclick='validation_all()' class="bt_green" align=center><span class="bt_green_lft"></span><strong><%=bundle.getString("button.staffedit.Register")%></strong><span class="bt_green_r"></span></a>
      
</form>
<%} %> 
</div>
<!-- end of right content--></div>
<!--end of center content -->  




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>