<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Profile Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<style>
#passwordStrengthstudent

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

#passwordStrengthparent

{

	height:10px;

	display:block;

	float:left;

}

</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
	
<script type="text/javascript">
function passwordStrength(password,flage)

{

	var desc = new Array();
	desc[0] = "Password not entered";

	desc[1] = "Very Weak";

	desc[2] = "Weak";

	desc[3] = "Better";

	desc[4] = "Medium";

	desc[5] = "Strong";

	desc[6] = "Strongest";

	var score   = 0;


	if (password.length > 0) score++;

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


if(flage=="student")
{
	 document.getElementById("passwordDescriptionstudent").innerHTML = desc[score];

	 document.getElementById("passwordStrengthstudent").className = "strength" + score;
	 }
	 else if(flage=="parent")
	 {
	 document.getElementById("passwordDescriptionparent").innerHTML = desc[score];

	 document.getElementById("passwordStrengthparent").className = "strength" + score;
	 }

}
function ff(flage)
{
if(flage=="student")
{
	var s1=document.applicationform.studusername.value.length;

	if(s1 == 0)
	{
		alert("UserName Empty !");
		document.applicationform.studusername.focus();
		return false;

	}


	if(s1 < 4)
	{

		alert("UserName minmum 4 Characters Must !");
		document.applicationform.studusername.focus();
		return false;
	}
	}
	else if(flage=="parent")
	{
	var s1=document.applicationform.studparentusername.value.length;

	if(s1 == 0)
	{
		alert("UserName Empty !");
		document.applicationform.studparentusername.focus();
		return false;

	}


	if(s1 < 4)
	{

		alert("UserName minmum 4 Characters Must !");
		document.applicationform.studparentusername.focus();
		return false;
	}
	}

}
function checkmonth(val)
{
   var str = val.value;

   for(var i=0;i<str.length;i++)
   {
	if(!((str.charAt(i)>="a" && str.charAt(i)<="z")||(str.charAt(i)>="A" && str.charAt(i)<="Z")|| (str.charAt(i)>="0") && (str.charAt(i)<="9")||  (str.charAt(i)==' ') ))
        {
        alert("Invalid entry");
	   	val.value="";
	   	val.select();
        return false;
        }
   }
   return true;
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

function Submitfun()
{
	

	
	
/* if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.studentlastname,"text",document.applicationform.fathername,"text",document.applicationform.mothername,"text",document.applicationform.photo,"text",document.applicationform.agedate,"select",document.applicationform.agemonth,"select",document.applicationform.ageyear,"select",document.applicationform.bloodgroup,"select",document.applicationform.AddressForCommunication,"textarea",document.applicationform.permanent,"textarea",document.applicationform.communicationcountry,"text",document.applicationform.communicationstate,"text",document.applicationform.communicationcity,"text",document.applicationform.communicationpin,"text",document.applicationform.permanentcountry,"text",document.applicationform.permanentstate,"text",document.applicationform.permanentcity,"text",document.applicationform.permanentpin,"text",document.applicationform.email,"text",document.applicationform.mobileno,"text",document.applicationform.smscontactno,"text",document.applicationform.guardianname,"text",document.applicationform.guardianmailid,"text",document.applicationform.relation,"text",document.applicationform.organization,"text",document.applicationform.annualincome,"text",document.applicationform.position,"text",document.applicationform.physicalmarks,"text",document.applicationform.studusername,"text",document.applicationform.studpassword,"text",document.applicationform.studpassword1,"text",document.applicationform.studparentusername,"text",document.applicationform.studparentpassword,"text",document.applicationform.studparentpassword1,"text")) */
if(check_ForParticularElements(document.applicationform.studentname,"text",document.applicationform.studentlastname,"text",document.applicationform.agedate,"select",document.applicationform.agemonth,"select",document.applicationform.ageyear,"select",document.applicationform.fathername,"text",document.applicationform.nationalityradio,"radio",document.applicationform.community,"radio",document.applicationform.religion,"radio",document.applicationform.mothertonque,"radio",document.applicationform.AddressForCommunication,"text",document.applicationform.communicationcountry,"select",document.applicationform.communicationstate,"select",document.applicationform.communicationcity,"text",document.applicationform.communicationpin,"text",document.applicationform.permanent,"text",document.applicationform.permanentcountry,"select",document.applicationform.permanentstate,"select",document.applicationform.permanentcity,"text",document.applicationform.permanentpin,"text",document.applicationform.mobileno,"text",document.applicationform.smscontactno,"text",document.applicationform.guardianname,"text",document.applicationform.guardianmailid,"text",document.applicationform.relation,"text",document.applicationform.organization,"text",document.applicationform.annualincome,"text",document.applicationform.position,"text",document.applicationform.physicalmarks,"text",document.applicationform.studusername,"text",document.applicationform.studpassword,"text",document.applicationform.studpassword1,"text",document.applicationform.studparentusername,"text",document.applicationform.studparentpassword,"text",document.applicationform.studparentpassword1,"text"))
{
			if(document.applicationform.photo.value!="")
			{
			
					var pho_val=getExtension(document.applicationform.photo.value);
					pho_val = pho_val.toLowerCase();
					if((pho_val != "jpg") & (pho_val != "gif") & (pho_val != "jpeg") & (pho_val != "png"))
					{
					alert("*.jpeg,*.jpg,*.gif,*.png,*.bmp Image type only allowed")
					document.applicationform.user_photo.select();
					return false;
					}
			}
			if( document.applicationform.fathername.value.charAt(0)==" ")
				 {
				 	alert("Father Name should not start with Empty Character");
				    document.applicationform.fathername.focus();
					return false;
				 }
				 if(!stringValidateincludesigquots(document.applicationform.fathername,"Father Name"))
				 {
					
					document.applicationform.fathername.focus();
					return false;
				 }
				
				 if(!stringValidateincludesigquots(document.applicationform.mothername,"Mother Name"))
				 {
					  
					document.applicationform.mothername.focus();
					return false;
				 }
				    var nationalitycheck=false;
				    if(document.applicationform.nationalityradio.length!=undefined)
				    {
					for(var i=0;i<document.applicationform.nationalityradio.length;i++)   
								{
									if(document.applicationform.nationalityradio[i].checked)
									{
									nationalitycheck=true;
									}
								}	
					}
					else
					{
					if(document.applicationform.nationalityradio.checked)
						{
						nationalitycheck=true;
						}
					}	
					if(nationalitycheck)
					{
						if(document.applicationform.nationalityradio.length!=undefined)
					    {
						for(var i=0;i<document.applicationform.nationalityradio.length;i++)   
									{
										if(document.applicationform.nationalityradio[i].checked)
										{	
											if(document.applicationform.nationalityradio[i].value!="other")
												{
												    document.getElementById("nationality").style.display="block";
													document.applicationform.nationality.value=document.applicationform.nationalityradio[i].value;
												}
										}
									}
						}else
						{
							if(document.applicationform.nationalityradio.checked)
										{	
											if(document.applicationform.nationalityradio.value!="other")StudentApplicationEntry
												{
												    document.getElementById("nationality").style.display="block";
													document.applicationform.nationality.value=document.applicationform.nationalityradio.value;
												}
										}
						}
					}
					else
					{
					alert("Empty Nationality Not Allowed");
					document.applicationform.nationalityradio[0].focus();
					return false;
					}

					
					if(document.applicationform.communityflag.value=="yes")
					{
						var communitycheck=false;
						if(document.applicationform.community.length!=undefined)
					    {
						for(var i=0;i<document.applicationform.community.length;i++)   
									{
										if(document.applicationform.community[i].checked)
										{
											communitycheck=true;
										}
									}	
						}
						else
						{
							if(document.applicationform.community.checked)
											{
												communitycheck=true;
											}
						}	
								
						if(!communitycheck)
						{
						alert("Empty Community Not Allowed");
						document.applicationform.community[0].focus();   
						return false;
						}
					}
					
					if(document.applicationform.religionflag.value=="yes")
					{
					var religioncheck=false;
					if(document.applicationform.religion!=undefined)
						{
					if(document.applicationform.religion.length!=undefined)
				    {
						for(var i=0;i<document.applicationform.religion.length;i++)   
									{
										if(document.applicationform.religion[i].checked)
										{
											religioncheck=true;
										}
									}	
						}
						else
						{
									if(document.applicationform.religion.checked)
										{
											religioncheck=true;
										}
						}
						}
						if(!religioncheck)
						{
						alert("Empty Religion Not Allowed");
						if(document.applicationform.religion.length!=undefined)
					    {
						document.applicationform.religion[0].focus();
						}
						else
						{
							document.applicationform.religion.focus();
						}   
						return false;
						}
					}				
					
					var mothertonquecheck=false;
					
					for(var i=0;i<document.applicationform.mothertonque.length;i++)   
								{
									if(document.applicationform.mothertonque[i].checked)
									{
										mothertonquecheck=true;
									}
								}	
					if(mothertonquecheck)
					{
					for(var i=0;i<document.applicationform.mothertonque.length;i++)   
								{
									if(document.applicationform.mothertonque[i].checked)
									{	
										if(document.applicationform.mothertonque[i].value!="other")
											{
											    document.getElementById("othersmothertonque").style.display="block";
												document.applicationform.othersmothertonque.value=document.applicationform.mothertonque[i].value;
											}
									}
								}
					}
					else
					{
					alert("Empty Language Not Allowed");
					document.applicationform.mothertonque[0].focus();
					return false;
					}
				
				if(document.applicationform.permanentstate.length>1)
					{
						document.applicationform.othercommunicationstate1.value=document.applicationform.permanentstate.value;
					}
				if(document.applicationform.communicationstate.length>1)
					{
						document.applicationform.othercommunicationstate.value=document.applicationform.communicationstate.value;
					}
						var extracurricular=new Array();
						extracount=0;
						if(document.applicationform.extra!=undefined)
						{
							if(document.applicationform.extra.length!=undefined)
						       {
									for(var i=0;i<document.applicationform.extra.length;i++)
									{
									
										if(document.applicationform.extra[i].checked)
											{
												extracount++
												if(document.applicationform.extra[i].value=="Other")
												{
												extracurricular[extracurricular.length]=document.applicationform.othersextra.value;
												}
												else
												{
												extracurricular[extracurricular.length]=document.applicationform.extra[i].value;
												}
											}
									}
								}
								else
								{
									if(document.applicationform.extra.checked)
									{
										extracount++
										if(document.applicationform.extra.value=="Other")
										{
										extracurricular[extracurricular.length]=document.applicationform.othersextra.value;
										}
										else
										{
										extracurricular[extracurricular.length]=document.applicationform.extra.value;
										}
									}
							}
						}
						/*if(!extracount>0)
						{
							alert("Select Any One Extra Curricular Activities");
								document.applicationform.extra[0].focus();
							return false;
						}*/
		
			for(var i=0;i<document.applicationform.schoolstatus.length;i++)
			{
				if(document.applicationform.schoolstatus[i].checked)
				{
					if(document.applicationform.schoolstatus[i].value=="yes")
					{
						if(check_ForParticularElements(document.applicationform.schoolname,"text",document.applicationform.schooladdress,"textarea",document.applicationform.medium,"radio"))
						{
						}
						else
						{
							return false;
						}
						if(markcheckcount>0)
						{
						}
						else
						{
							alert("Select Any One Mark Details");
							document.applicationform.chk[0].focus();
							return false;
						}
						
				for(var i=0;i<document.applicationform.chk.length;i++)
		
				{
		
				   if(!document.applicationform.chk[i].checked)
		
				   {
		
				       document.applicationform.subject[i].disabled=true;
		
					   document.applicationform.month[i].disabled=true;
		
					   document.applicationform.registrationno[i].disabled=true;
		
					   document.applicationform.mark[i].disabled=true;
		
					   document.applicationform.max[i].disabled=true;
		
				   }
		
				   else
		
				   {
		
					    document.applicationform.subject[i].disabled=false;
		
					    document.applicationform.month[i].disabled=false;
		
					    document.applicationform.registrationno[i].disabled=false;
		
					    document.applicationform.mark[i].disabled=false;
		
					    document.applicationform.max[i].disabled=false;
		
				   }
		
				}
		
		
			}
		
		}
		
	}

if(!password_v())
{
return false;
}
if(document.applicationform.communicationstate.length==1)
{
if(document.applicationform.othercommunicationstate.value=="")
{
alert("Enter the State");
document.applicationform.communicationstate.style.visibility="visible";
document.applicationform.communicationstate.focus();
return false;
}
}
if(document.applicationform.permanentstate.length==1)
{
if(document.applicationform.othercommunicationstate1.value=="")
{
alert("Enter the State");
document.applicationform.permanentstate.style.visibility="visible";
document.applicationform.permanentstate.focus();
return false;
}
}
/* if(!email_Validation(document.applicationform.email,"Mail Id",true))
 {
 	return false;
 } */

if(!email_Validation(document.applicationform.guardianmailid,"Guardian E-Mail",true))
{
	return false;
}


document.applicationform.extrahidden.value=extracurricular;
document.applicationform.studusernamehidden.value=document.applicationform.studusername.value;

	

searchbrosister(document.applicationform.studusername.value,"username");

}
}

	function cancelSelection(){
		
		for(var i=0;i<document.applicationform.scholarshipallocation.options.length;i++){
			
			document.applicationform.scholarshipallocation.options[i].selected	= false;
		}
	}


function password_v()
{
if(document.applicationform.studpassword.value == "")
	{
		alert("Empty Password not Allowed");
		document.applicationform.studpassword.focus();
		return false;
	}

	if(document.applicationform.studpassword1.value == "")
	{
		alert("Empty Verify Password  not Allowed");
		document.applicationform.studpassword1.focus();
		return false;
	}


	if(document.applicationform.studpassword.value==document.applicationform.studpassword1.value)
	{
  		return true;
  	}
  	else
  	{
  		alert("please type the correct password");
  		document.applicationform.studpassword.focus();
  		return false;
	}
	if(document.applicationform.studparentpassword.value == "")
	{
		alert("Empty Password not Allowed");
		document.applicationform.studparentpassword.focus();
		return false;
	}

	if(document.applicationform.parentstudpassword1.value == "")
	{
		alert("Empty Verify Password  not Allowed");
		document.applicationform.parentstudpassword1.focus();
		return false;
	}

	if(document.applicationform.studparentpassword.value==document.applicationform.studparentpassword1.value)
	{
  		return true;
  	}
  	else
  	{
  		alert("please type the correct password");
  		document.applicationform.studparentpassword.focus();
  		return false;
	}
}
markcheckcount=0;
function markvalidation(obj,count)
{
if(obj.checked)
{
if(check_ForParticularElements(document.applicationform.subject[count],"text",document.applicationform.month[count],"text",document.applicationform.registrationno[count],"text",document.applicationform.mark[count],"text",document.applicationform.max[count],"text"))
{
   document.applicationform.subject[count].disabled=true;
   document.applicationform.month[count].disabled=true;
   document.applicationform.registrationno[count].disabled=true;
   document.applicationform.mark[count].disabled=true;
   document.applicationform.max[count].disabled=true;
   markcheckcount++;
}
else
{
obj.checked=false;
}
}
else
{
   document.applicationform.subject[count].disabled=false;
   document.applicationform.month[count].disabled=false;
   document.applicationform.registrationno[count].disabled=false;
   document.applicationform.mark[count].disabled=false;
   document.applicationform.max[count].disabled=false;
   markcheckcount--;
}
}
var xmlDoc=null;
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
				obj.options[obj.options.length] = new Option(val,val);

			}
		}
		document.applicationform.othercommunicationstate1.style.visibility="hidden";
				document.applicationform.othercommunicationstate.style.visibility="hidden";
		
		country_fun_2();
	}

	function country_fun_2()
	{
		var obj=document.applicationform.permanentcountry;

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
		profileview();
	}

	function state_fun(name,source,hiddenelement)
	{
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
							name.options[j] = new Option(states[i].attributes.getNamedItem("name").nodeValue,states[i].attributes.getNamedItem("name").nodeValue);
						j++;
						}
						hiddenelement.style.visibility="hidden";
					}
					else
					{
					//alert("==>>");
					optionDelete(name,1);
					//alert("======>>");
					hiddenelement.style.visibility="visible";
					//alert("======>>");
					}
					break;
    		   }
			}
		}
	}
	

function ageCalc(SelectValue){

	var ageDate = document.applicationform.agedate.options[document.applicationform.agedate.options.selectedIndex].value;
	var ageMonth = document.applicationform.agemonth.options[document.applicationform.agemonth.options.selectedIndex].value;
	var ageYear = document.applicationform.ageyear.options[document.applicationform.ageyear.options.selectedIndex].value;
	if(ageDate!="-" && ageMonth!="-" && ageYear!="-"){
		var currentAge = calcAge(ageMonth+"/"+ageDate+"/"+ageYear);
		document.applicationform.ageyears.value = currentAge;
		document.getElementById("agess").innerHTML= "<a class=tablelight>"+currentAge+" years</a>";;
		//alert(ageDate+"-"+ageMonth+"-"+ageYear);
	document.applicationform.originaldob.value=ageYear+"-"+ageMonth+"-"+ageDate;
	}
	

}
var is_ie 		= (/msie/i.test(navigator.userAgent));
function calcAge(args)
{
	//alert(args);
	var ages = 0;
		var birthDate = new Date(args);
		var currentDate = new Date(document.applicationform.currentDate.value);
		var birthYear = "0";
		if(2000<=birthDate.getYear())
		{

		   birthYear = birthDate.getYear();
		}
		else
		//alert("YOU ARE HERE");
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
function searchbrosistercheck(obj)
{
//alert(obj.value);
if(obj.value=="Y")
{
	document.getElementById("relationchecksearch").style.visibility="visible";
	document.getElementById("parentdetailstable").style.visibility="hidden";
	document.getElementById("passwordDescriptionparent").style.visibility="hidden";
	document.getElementById("passwordStrengthparent").style.visibility="hidden";
	document.getElementById("parentpassword").style.visibility="hidden";
	
}
else if(obj.value=="N")
{
	document.getElementById("parentdetails").innerHTML="";
	document.getElementById("parentid").value="nodatafound";
	document.getElementById("relationchecksearch").style.visibility="hidden";
	document.getElementById("parentdetailstable").style.visibility="visible";
	document.getElementById("passwordDescriptionparent").style.visibility="visible";
	document.getElementById("passwordStrengthparent").style.visibility="visible";
	document.getElementById("parentpassword").style.visibility="visible";
	
	document.getElementById("studparentusername").disabled=false;
	document.getElementById("studparentpassword").disabled=false;
	document.getElementById("studparentpassword1").disabled=false;
	document.getElementById("studparentusername").value="";
	document.getElementById("studparentpassword").value="";
	document.getElementById("studparentpassword1").value="";
}
}
function searchbrosister(id,flag)
{
var url = "";
document.getElementById("loadingimage").style.visibility="visible";

	   if(flag=="RelationCheck")
	   {
		   if(id=="")
		   {
		   alert("Enter Roll No To Search");
		   document.getElementById("loadingimage").style.visibility="hidden";
		   
		   return false;
		   }
		   else
		   {
		   		   url = "../getLoginInfo.jsp?action=RelationCheck&name="+id;
		   }
	   }
	 else if(flag=="username")
	   {
		   url = "../getLoginInfo.jsp?action=username&name="+id;
	   }
	   else if(flag=="parentname")
	   {
		   url = "../getLoginInfo.jsp?action=parentname&name="+id;
	   }
	   else
	   {
		   alert("The Key does not match with any value,URL is Empty, Please contact Administrator/Programmer");
		   document.getElementById("loadingimage").style.visibility="hidden";
		   
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				  if(flag=="RelationCheck")
				  {
				  //alert("=="+flag)
					 parseMessages(req.responseXML,flag);
				  }
				 else if(flag=="username")
				  {
					 parseMessages(req.responseXML,flag);
				  }
				   else if(flag=="parentname")
				  {
					 parseMessages(req.responseXML,flag);
				  }
				  
			   }
			}
	   };
	   req.open("GET",url,true);
	   req.send(null);
	}

	function parseMessages(parseXML,flag)
	{
		

		if(flag=="RelationCheck")
		{
					//alert(flag+"==RelationCheck");
		
			var rootObj=parseXML.getElementsByTagName("relationcheck");
			var cNode_1=rootObj[0].childNodes.length;
			if(cNode_1>0)
			{
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var parentid=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				var parentusername=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
				var fathername=rootObj[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue;
				var mothername=rootObj[0].childNodes.item(i).childNodes.item(3).firstChild.nodeValue;
				var uname=rootObj[0].childNodes.item(i).childNodes.item(4).firstChild.nodeValue;
				var photo=rootObj[0].childNodes.item(i).childNodes.item(5).firstChild.nodeValue;
				
				document.getElementById("parentdetails").innerHTML="<table border=0 cellpadding=0 cellspacing=0 align=left width='62%' ><tr  align=left><td class='tablebold' colspan=4  align=left><u>Parent Details</u></td></tr><tr align=left><td class='tablebold' width=25%>StudentName</td><td  width=1px>:</td><td  width=38%>"+uname+"</td><td rowspan=3 valign=top><img src='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+photo+"'	name='stphoto_img1' id=stphoto_img width=100 height=100 ></td></tr><tr align=left><td class='tablebold'>FatherName</td><td>:</td><td>"+fathername+"</td></tr><tr align=left><td class='tablebold'>MotherName</td><td>:</td><td>"+mothername+"</td></tr></table>";  	
				document.getElementById("parentid").value=parentid;
				if(parentid=="nodatafound")
				{
				alert("Student not found");
				document.getElementById("parentdetailstable").style.visibility="visible";
				document.getElementById("passwordDescriptionparent").style.visibility="hidden";
				document.getElementById("passwordStrengthparent").style.visibility="hidden";
				}
				else
				{
				document.getElementById("parentdetailstable").style.visibility="visible";
				document.getElementById("passwordDescriptionparent").style.visibility="visible";
				document.getElementById("passwordStrengthparent").style.visibility="visible";
				document.getElementById("passwordDescriptionparent").style.visibility="hidden";
				document.getElementById("passwordStrengthparent").style.visibility="hidden";
				document.getElementById("parentpassword").style.visibility="hidden";
				
				document.getElementById("studparentusername").value=parentusername;
				document.getElementById("studparentpassword").value=parentusername;
				document.getElementById("studparentpassword1").value=parentusername;
				document.getElementById("studparentusername").disabled=true;
				document.getElementById("studparentpassword").disabled=true;
				document.getElementById("studparentpassword1").disabled=true;
				}
			}
		}
		else
		{
			document.getElementById("parentid").value="nodatafound";
			alert("Student not found");
			document.getElementById("parentdetailstable").style.visibility="visible";
			document.getElementById("parentdetails").innerHTML="<table border=0 align=left><tr><td class='tablebold' colspan=2>Parent Details</td><tr><tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr></table>";
			document.getElementById("parentid").value="nodatafound";
			document.getElementById("relationchecksearch").style.visibility="hidden";
			document.getElementById("parentdetailstable").style.visibility="visible";
			document.getElementById("passwordDescriptionparent").style.visibility="visible";
			document.getElementById("passwordStrengthparent").style.visibility="visible";
			document.getElementById("parentpassword").style.visibility="visible";
			document.getElementById("studparentusername").disabled=false;
			document.getElementById("studparentpassword").disabled=false;
			document.getElementById("studparentpassword1").disabled=false;
			document.getElementById("studparentusername").value="";
			document.getElementById("studparentpassword").value="";
			document.getElementById("studparentpassword1").value="";
		}
		}
		if(flag=="username")
		{
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				
				if(temp=="true")  
				{
					alert("User Name already exists");
					document.getElementById("loadingimage").style.visibility="hidden";
					return false;
				}
				searchbrosister(document.applicationform.studparentusername.value,"parentname");
				//document.applicationform.action="./StudentApllicationEntrysubmit.jsp";
				//document.applicationform.submit();
			}
		}
		if(flag=="parentname")
		{
		
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				if(document.applicationform.parentid.value=="nodatafound")
				{
				if(temp=="true")
				{
					alert("Parent User Name already exists");
					document.getElementById("loadingimage").style.visibility="hidden";

					return false;
				}
				}
				if(confirm("Do you want to Submit the student info...?"))
				{
					document.applicationform.action="./StudentApllicationEntrysubmit.jsp";
					document.applicationform.submit();
				}
			}
		}
		document.getElementById("loadingimage").style.visibility="hidden";
		
	}
	

	function address_Validation(fields,fieldName)
{
   flag=true;
   field=fields.value;
     var num=parseInt(field.length);
     if(num==0)
     {

       flag=false;

     }
     //to check the starting char is not a special character
     else
     {           startVal=field.charAt(0);
		  }//end of else
     return flag;
}
function backfun()
{
document.applicationform.action="./StudentApplicationSearch.jsp";
document.applicationform.submit();
}
function profileview()
{
if(document.f2.candidateregisterstatus.value=="Registered")
{
document.getElementById("contentdiv").style.visibility="hidden";
document.f2.action="./Studentprofileview.jsp";
document.f2.submit();
}
}

dispcount=0;

	function schoolstatuscheck(obj)
	{
		if(obj.value=="no")
		{
			document.getElementById("previousSchooldetails").style.display 		= "none";
			document.getElementById("previousStudentexam").style.display 		= "none";
			//document.getElementById("Certificateverification").style.display 	= "none";
			document.getElementById("insertrowid").style.display 				= "none";
			
			
		}
		else if(obj.value=="yes")
		{
			document.getElementById("previousSchooldetails").style.display 		= "block";
			document.getElementById("previousStudentexam").style.display 		= "block";
			//document.getElementById("Certificateverification").style.display 	= "block";
			document.getElementById("insertrowid").style.display 				= "block";
			
		}
	}

function copyfun()
{
	document.applicationform.permanent.value = document.applicationform.AddressForCommunication.value;
	document.applicationform.permanentStreet2.value = document.applicationform.communicationStreet2.value;
	
	document.applicationform.permanentcountry.value = document.applicationform.communicationcountry.value;
	state_fun(document.getElementById('permanentstate'),document.applicationform.permanentcountry,document.getElementById('othercommunicationstate1'));
	if(document.getElementById('othercommunicationstate').style.visibility!="hidden")
	{
	document.getElementById('othercommunicationstate1').value=document.getElementById('othercommunicationstate').value;
	}
	document.applicationform.permanentstate.value = document.applicationform.communicationstate.value;
	document.applicationform.permanentcity.value = document.applicationform.communicationcity.value;
	document.applicationform.permanentpin.value = document.applicationform.communicationpin.value;
}
var filednumber=6;
function createexamdetails()
{
	rowlen = document.getElementById("previousStudentexam").rows.length;
	table=document.getElementById("previousStudentexam").getElementsByTagName("tbody")[0];
	row = document.createElement("tr");
	row.align="Left";

	cell = document.createElement("td");
	cell.innerHTML = "<input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'	onblur='checkmonth(this)'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'>";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' >";
	row.appendChild(cell);

	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type='text' class='labeltextbox' name='max' maxlength='3' size=10 value='' onkeypress='checkNumber(event)'>";
	row.appendChild(cell);
	
	cell = document.createElement("td");
	cell.align = "left";
	cell.innerHTML = "<input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'"+filednumber+"')>";
	row.appendChild(cell);
	table.appendChild(row);

	filednumber++;
}

function removeexamdetails(tabname)
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

function loadphototype(type)
{
	if(type=="local")
	{
		document.getElementById('webcamspan').style.display='none';
		document.getElementById('localphoto').style.display='';
		document.applicationform.photo.disabled=false;

	}
	else
	{
		document.getElementById('webcamspan').style.display='';
		document.getElementById('localphoto').style.display='none';
		document.applicationform.photo.disabled=true;

	}
}
</script>
</head>
<body onload="loadFirst()">
<div id="main_container">

	<div class="header">
	
<%@ include file="../include/userheader.jsp" %>
   
	</div>
	<div style="position:fixed;left:400px;top:250px;visibility:hidden;" id="loadingimage"><img	src="<%=request.getContextPath()%>/images/ajaxloadinimage/ajax_loading.gif" width=120 height=130></img></div>
    <div class="main_content" >
    
<%@ include file="../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

<div class="right_content" id="contentdiv">

<table width=100%><tr><td width=80% align=left><h2><%=bundle.getString("label.studentprofileentry.rootpath")%></h2></td><td align=right><a class=tablebold><font color=red>*</font>&nbsp;<font color=#000000><%=bundle.getString("label.studentprofileentry.Mandatory")%></font> </a></td></tr></table>
<%@ page
	import="com.iGrandee.MasterEntries.Standard.StandardQuery,java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.StudentRegistrationQuery"%>

<%
try{
System.out.println("*********************************************************************");

	StandardQuery standardQuery 	= new StandardQuery();
	String instituteid 				= (String) session.getValue("instituteid");
	String userid 					= (String) session.getValue("userid");
 	StudentRegistrationQuery Staffquery = new StudentRegistrationQuery();
	ArrayList BoardList 			= null;
	String Applicantname 			= "";
	String Standardname 			= "";
	String groupname 				= "";
	String applicationno 			= "";
	String standardscheduleid		= "";
	String studentapprovalid		= "";
	String candidateregisterstatus	= "";
 	StringBuffer currentDate 		= new StringBuffer();
 	Date dateObj 					= new Date();
 	currentDate.append((dateObj.getMonth() + 1) + "/"
 			+ dateObj.getDate() + "/" + (dateObj.getYear() + 1900));
 	String requestapplicationno		= request.getParameter("ApplicationNumber");
 	//out.println(requestapplicationno);
 
 	
 	ArrayList detaillist 			= Staffquery.apllicantdetails(requestapplicationno);
 	//out.println("detaillist"+detaillist);
 	ArrayList extracurricular 		= Staffquery.loadExtrcurricular(userid);
 	
 	if(detaillist != null && detaillist.size()>0)
 	{
	 	HashMap detaillist2 	= (HashMap)detaillist.get(0);
	 	standardscheduleid 		= (String)detaillist2.get("standardpublishid");
	 	studentapprovalid 		= (String)detaillist2.get("studentapprovalid");
	 	Applicantname 			= (String)detaillist2.get("applicantname");
	 	Standardname 			= (String)detaillist2.get("standardname");
	 	groupname 				= (String)detaillist2.get("groupname");
	 	applicationno 			= (String)detaillist2.get("applicationno");
	 	candidateregisterstatus = (String)detaillist2.get("candidateregisterstatus");
	 	//candidateregisterid = (String)detaillist2.get("candidateregisterid");
 	}
 	//out.println("candidateregisterstatus"+candidateregisterstatus);
 	String studentstate 			= Staffquery.loadstudentstate(studentapprovalid);
 	
//out.println("studentstate -->"+studentstate);
 	ArrayList scholarshipList	= Staffquery.loadScholarship(standardscheduleid);
 	
 	
 	java.util.ResourceBundle rb=java.util.ResourceBundle.getBundle("resources.serversetup");
	String shapshotpath=rb.getString("shapshot");
	//out.println("shapshotpath********* "+shapshotpath);
	String imagePath=rb.getString("storagepath")+"/imagestorage/";
	String imageName="studentimage_"+studentapprovalid+".jpg";  
	BoardList 						= Staffquery.loadboard(instituteid);
 	ArrayList communityList 		= Staffquery.loadcommunity(instituteid);
 	ArrayList religionList 			= Staffquery.loadreligion(instituteid);
 %>
 <form name="f2"  action="" method="post">  
	 <input type="hidden" name="stundentapproveid" value="<%=studentapprovalid%>">
	  <input type="hidden" id="candidateregisterstatus" name="candidateregisterstatus" value="<%=candidateregisterstatus%>">
	  <input type="hidden" name="ApplicationNumber" value="<%=requestapplicationno%>">
 </form>
 <form name="applicationform" method="post" action="" enctype="multipart/form-data">
 <%@ page
		import="java.io.*,java.util.*"%>  <input type="hidden" name="currentDate" value="<%=currentDate%>">
  <input type="hidden" name="studusernamehidden" value="">
 <input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>">
 <input type="hidden" name="studentapprovalid" value="<%=studentapprovalid%>">
   <input type="hidden" name="extrahidden" value="">
   	<input type=hidden name="religionflag" value="<%=rb.getString("religionflag")%>">
					<input type=hidden name="communityflag" value="<%=rb.getString("communityflag")%>">
    <input type="hidden" id="parentid" name="parentid" value="nodatafound">
    <% 
    if((candidateregisterstatus.equals("NotRegistered") || candidateregisterstatus.equals("Registered")) && (studentstate == null || studentstate.equals("A")))
    {
    	%>
 	<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.studentprofileentry.SelectedDetails")%></th>
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
			<TR>
				<TD valign=top width="90%" colspan="2"  align=left >
				<table border=0 cellpadding=0 cellspacing=0 width="80%" align=left
					rules="groups">
					<tr>
						<td class=tablebold><%=bundle.getString("label.studentprofileentry.ApplicantName")%></td>
						<td class=tablebold>:</td>
						<td class=tablelight><%=Applicantname%></td>
						<td class=tablebold>Application No.</td>
						<td class=tablebold>:</td>
						<td class=tablelight><%=applicationno%></td>
					</tr>
					<tr>
						<td class=tablebold><%=bundle.getString("label.studentprofileentry.StandardApplied")%></td><td class=tablebold>:</td>
						<td class=tablelight><%=Standardname%></td>
						<%
							if (!groupname.equals("NoGroup")) {
						%>
						<td class=tablebold><%=bundle.getString("label.studentprofileentry.GroupName.")%></td><td class=tablebold>:</td>
						<td class=tablelight><%=groupname%></td>
						<%
							}
						%>
					</tr>
				</table>
				</TD>
			</TR>
			</tbody>
			</table>
			<br>
			<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="1%"></th>
				<th scope="col" class="rounded" width="80%"><%=bundle.getString("label.studentprofileentry.StudentpersonalDetails")%>  </th>
				<th scope="col" class="rounded-q4" width="20%"> </th>
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
			<td></td>
				<td colspan=2 align=left><br>
				<table border="0" width="80%" cellpadding="5" cellspacing="0"
					rules="groups">
					<tr align="left" class=tablebold>
						<td><%=bundle.getString("label.studentprofileentry.Prefix")%><font color=red>&nbsp;&nbsp;*</font></td><td>
										<select name="stud_prefix"  maxlength=6  class=tablelight validate="Prefix">
										 <option value="Mr.">Mr.</option>
										 <option value="Mrs.">Mrs.</option>
										 <option value="Ms.">Ms.</option>
										 <option value="Dr.">Dr.</option>
										 <option value="Sir.">Sir.</option>
									 </select></td>
					</tr>
					
					<tr align="left">
						<td class=tablebold width="33%"><%=bundle.getString("label.studentprofileentry.FirstName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td align="left"><input type=text class=tablelight
							name="studentname"  maxlength="40" size="29" value="<%=Applicantname %>" validate="Student First Name"></td>
					</tr>
					<tr align="left">
						<td class=tablebold width="33%"><%=bundle.getString("label.studentprofileentry.MiddleName")%></td>
						<td align="left"><input type=text class=tablelight
							name="studentmiddlename" value="" maxlength="40" size="29" validate="Student Middle Name"></td>
					</tr>
					<tr align="left">
						<td class=tablebold width="33%"><%=bundle.getString("label.studentprofileentry.LastName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td align="left"><input type=text class=tablelight
							name="studentlastname" value="" maxlength="40" size="29" validate="Student Last Name"></td>
					</tr>
					

					</tr>
					<tr align="left">
					<td colspan=2>
					<input type="radio" name="phototype" value='local' onclick="loadphototype('local')" checked/><%=bundle.getString("label.studentprofileentry.UploadImage")%><input type="radio" name="phototype" value='snapshot' onclick="loadphototype('webcam')"/><%=bundle.getString("label.studentprofileentry.CaptureImage")%>
					</td>
					</tr>
					<tr align="left">
					<td colspan=2>
					<table border='0' bordercolor='yellow' id="localphoto" style="display:block;" >  
						<tr>  
						<td width="33%" align="left" class=tablebold><%=bundle.getString("label.studentprofileentry.Photo")%>&nbsp;&nbsp;</td>
						<td align="left" valign="bottom" width="55%"><input size='30' type=file class="browses" name="photo"	></td>
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
				
			<tr>
				<td  align=left class=tablebold>
				<%=bundle.getString("label.studentprofileentry.DateofBirth")%></nobr>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td><td>
						<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="0"
					cellspacing="0">
					<tr align="left">
						<td class="labelfont" width="15%"><%=bundle.getString("label.studentprofileentry.Date")%> <select
							class="labelfont" name="agedate" validate="Date" onchange="ageCalc(this.value)">
							<option value="-">Select</option>
							<%
								for (int i = 1; i <= 31; i++) {
							%>
							<option value='<%=i%>'><%=i%></option>
							<%
								}
							%>
						</select></td>
						<td class="labelfont" width="15%" ><%=bundle.getString("label.studentprofileentry.Month")%> <select
							class="labelfont" name="agemonth" validate="Month" onchange="ageCalc(this.value)">
							<option value="-">Select</option>
							<%
							String [] mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
								for (int i = 1; i <= 12; i++) {
							%>
							<option value='<%=i%>'><%=mon[i-1]%></option>
							<%
								}
							%>
						</select></td>

						<td class="labelfont" width="15%"><%=bundle.getString("label.studentprofileentry.Year")%> <select
							class="labelfont" name="ageyear" onchange="ageCalc(this.value)" validate="Year">
							<option value="-">Select</option>
							<%
								Date d = new Date();
								int year = d.getYear() + 1900;
								//	out.println("<script>alert('"+year+"')</script>");

								for (int i = 1950; i <= year; i++) {
							%>
							<option value='<%=i%>'><%=i%></option>
							<%
								}
							%>
						</select></td>
						<td class=tableboldwidth="10%"></td>
						<td class=tablebold width="40%"><div id=agess style=position:absolute;class=tablelight ></div>&nbsp;<input type="hidden" class=tablelight
							readonly name="ageyears" maxlength="3" size=5 > 
							<input type="hidden" class=tablelight
							readonly name="originaldob" maxlength="3" size=5 validate="Date of Birth"></td>
					</tr>
				</table>
				</td>
			</tr>
				<tr align="left">
						<td class=tablebold width="29%"><%=bundle.getString("label.studentprofileentry.Gender")%></td>
						<td class=tablelight width="71%"><input type="radio"
							name="studsex" value="Male" checked>Male<input type="radio"
							name="studsex" value="Female" >Female</td>

					</tr>
				<tr>
				<tr align="left">
						<td width="33%" class=tablebold><%=bundle.getString("label.studentprofileentry.FatherName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td align="left" width="55%"><input type="text"
							class="labeltextbox" class="labelfont" name="fathername"
							maxlength="40" size="30"
							validate="Father Name"></td>
						<td rowspan=3 align="center"><image src="#"
							style="visibility:hidden" id="img1" width="125" height="125"\></td>
					</tr>
					<tr align="left">
						<td width="33%" class=tablebold><%=bundle.getString("label.studentprofileentry.MotherName")%>&nbsp;</td>
						<td align="left" width="55%"><input type="text"	class="labeltextbox" class="labelfont" name="mothername" maxlength="40" size="30"		validate="Mother Name"></td>
					</tr>
				<tr align="left">    
						<td class=tablebold width="29%"><%=bundle.getString("label.studentprofileentry.Nationality")%>&nbsp;<font color=red class=tablebold>*</font></td>
						<td class=tablelight width="71%"><input type="radio" name="nationalityradio" validate="Nationality" value="Indian" onclick="document.getElementById('nationality').style.display='none';" >Indian<input type="radio"
							name="nationalityradio" value="other" onclick="document.getElementById('nationality').style.display='block';">OtherSpecify<input type="text" 	id="nationality"  style="display:none;" name="nationality" value="" size=30 maxlength="40"></td>
   
					</tr>  
					<% if(rb.getString("communityflag").equals("yes")){ %>
					<tr align=left>
						<td class=tablebold width="30%"><%=bundle.getString("label.studentprofileentry.Community")%>&nbsp;<font color=red>*</font></td><td align='left' width='70%'>
						<%
							//out.println(communityList);
							for (int i = 0; communityList != null && i < communityList.size(); i++) {
								HashMap communityMap = (HashMap) communityList.get(i);
								String communityName = null;
								String communityid = null;
	
								if (communityMap.get("communityname") != null) {
									communityName = (String) communityMap.get("communityname");
									communityid   = (String) communityMap.get("communityid");
									if (i==0) {
										out
												.println("<input type='radio' validate='Community' name='community' value="
														+ communityid
														+ " >"
														+ communityName +"  ");
									} else
										out
												.println(" / <input type='radio' validate='Community' name='community' value="
														+ communityid
														+ " >"
														+ communityName
														+ "  ");
								}
								communityMap = null;
								communityName = null;
							}
						%>
						</td>
					</tr>
					<%} %>
					<% if(rb.getString("religionflag").equals("yes")){ %>
					
					<tr align='left'>
						<td width="30%" class=tablebold><%=bundle.getString("label.studentprofileentry.Religion")%>&nbsp;<font color=red>*</font></td>
						<td align='left' width='70%'>
								
							<%
							for (int i = 0; religionList != null && i < religionList.size(); i++) {
								HashMap religionMap = (HashMap) religionList.get(i);
								String religionName = null;
								String religionid = null;

								if (religionMap.get("religionname") != null) {
									religionid = (String) religionMap.get("religionid");
									religionName = (String) religionMap.get("religionname");

									if (i == 0) {
										out
												.println("<input type='radio' validate='Religion' name='religion' value="
														+ religionid
														+ " >"
														+ religionName +"  ");
									} else
										out
												.println(" / <input type='radio' validate='Religion' name='religion' value="
														+ religionid
														+ " >"
														+ religionName
														+ "  ");
								}
								religionMap = null;
								religionName = null;
							}
						%>
					</tr>
					<%} %>
				<tr align="left">
					<td  width="30%" class=tablebold><%=bundle.getString("label.studentprofileentry.Language")%>&nbsp;<font color=red>*</font></td>
						<td width="80%"><input type="radio"  
							name="mothertonque" validate="Language" value="Tamil"  onclick="document.getElementById('othersmothertonque').style.display='none';"> Tamil
						&nbsp;&nbsp;&nbsp; <input type="radio" name="mothertonque" 
							value="Hindi" validate="Language" onclick="document.getElementById('othersmothertonque').style.display='none';"> Hindi &nbsp;&nbsp;&nbsp; <input
							type="radio" name="mothertonque" validate="Language" value="other"  onclick="document.getElementById('othersmothertonque').style.display='block';">OtherSpecify
						<input type=text class="labeltextbox" class="labelfont"
							maxlength="30"  id="othersmothertonque" validate="Language" name="othersmothertonque"   style="display:none;" ></td>
			</tr>
				<tr>
						<td align="left" class=tablebold width="30%"><%=bundle.getString("label.studentprofileentry.BloodGroup")%>&nbsp;</td>
						<td align="left" width="70%">
							&nbsp;<select name="bloodgroup" validate="Blood Group">
							<option >-Select Blood Group-</option>
							<option value="O+">O+</option>
							<option value="A+">A+</option>
							<option value="B+">B+</option>
							<option value="AB+">AB+</option>
							<option value="AB-">AB-</option>
							<option value="A-">A-</option>
							<option value="B-">B-</option>
							<option value="O-">O-</option>
							<option value="A1B">A1B</option>
							</select>
						</td>
					
			</tr>
			</table>
			</td>
			</tr>
			
			</tbody>
			</table>
			<br>
			<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.studentprofileentry.StudentCommunicationDetails")%></th>
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
			<tr height="90"><td></td>
				<td colspan=2  align=left width="100%"><br>
				<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="5"
					cellspacing="0" >
					<tr class=tablebold align=left>
						<td width="50%">
						<%=bundle.getString("label.studentprofileentry.CommunicationAddress")%>&nbsp;<font color=red>*</font>
						</td>
						<td width="50%">
						<%=bundle.getString("label.studentprofileentry.PermanentAddress")%>&nbsp;<font
							color=red>*</font>
						</td>
					</tr >
					<tr align=left>
						<td valign="top" width="50%" >
						<table border="0" width="100%" bordercolor="#EEEEEE"		cellpadding="5" cellspacing="0" rules=groups>
							<tr>
							<td width="50%" class=tablebold>
							<%=bundle.getString("label.studentprofileentry.Street1")%>&nbsp;<font color=red>*</font>
							</td>
							<td width="50%"><input type=text name="AddressForCommunication" validate="Communication Street 1" maxlength=100 size=25>
							</input>
							</td>
							</tr>
							<tr>
							<td width="50%" class=tablebold>
							<%=bundle.getString("label.studentprofileentry.Street2")%>
							</td>
							<td width="50%"><input type=text name="communicationStreet2" maxlength=100 size=25>
							</input>
							</td>
							</tr>
							<tr height=30 align="left">
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.country")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp;</td>
								<td colspan=2><select size=1 cols=20 style="width:200px"
									name="communicationcountry" validate="Communication Country" class=tablelight
									onchange="state_fun(document.getElementById('communicationstate'),this,document.getElementById('othercommunicationstate'));">
									<option value="">&nbsp;&nbsp; -- Select Country --
									&nbsp;&nbsp;</option>
								</select></td>
							</tr>
							<tr height=30>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.state")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp;
								</td>
								<td colspan=2>
											<select name="communicationstate" id="communicationstate" style="width:200px"  validate="Communication State">
														<option>-- Select State --</option>
											</select><br><input type="text" name="othercommunicationstate" id="othercommunicationstate" value="" />
								</td>
							</tr>
							<tr height=30>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.city")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp; 
								</td>
								<td colspan=2> <input type=text name="communicationcity" maxlength=50 size=15 validate="Communication City" class=tablelight></input></td>
							</tr>
							<tr>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.Pin")%>&nbsp;<font color=red class=tablebold>*</font></td>
								<td><input type="text" class="labeltextbox"
									class="labelfont" name="communicationpin" size="6" validate="Communication Pin Code"
									maxlength="6" maxlength="15"
									 onkeypress="checkNumber(event)"></td>
							</tr>
						</table>
						</td>
						<td valign="top" width="50%">
						<table border="0" width="100%" bordercolor="#EEEEEE"
							cellpadding="5" cellspacing="0" >
								<tr>
							<td width="50%" class=tablebold>
							<%=bundle.getString("label.studentprofileentry.Street1")%>&nbsp;<font color=red>*</font>
							</td>
							<td width="50%"><input type=text name="permanent" validate="Permanent Street 1" maxlength=100 size=25>
							</input>
							</td>
							</tr>
							<tr>
							<td width="50%" class=tablebold>
							<%=bundle.getString("label.studentprofileentry.Street2")%>
							</td>
							<td width="50%"><input type=text name="permanentStreet2" maxlength=100 size=25>
							</input>
							</td>
							</tr>
							<tr height=30>
								<td class=tablebold width="50%" align="left"><%=bundle.getString("label.studentprofileentry.country")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp;</td>
								<td width="90%" align="left"><select size=1 id="permanentcountry" style="width:200px"
									name="permanentcountry" validate="Permanent Country" class=tablelight
									onchange="state_fun(document.getElementById('permanentstate'),this,document.getElementById('othercommunicationstate1'));">
									<option value="">&nbsp;&nbsp; -- Select Country --
									&nbsp;&nbsp;</option>
								</select></td>
							</tr>
							<tr height=30>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.state")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp;</td>
								 <td ><select name="permanentstate" id="permanentstate"	validate="Permanent State" style="width:200px" class=tablelight >
									<option value="0">&nbsp;&nbsp; -- Select State --
									&nbsp;&nbsp;</option>
								</select><br><input type="text" name="othercommunicationstate1" validate="Permanent State" id="othercommunicationstate1" value="" /></td> 
								
								<!-- <td colspan=2>
											<select name="permanentstate" id="permanentstate" style="width:200px"  validate="Permanent State">
														<option>-- Select State --</option>
											</select><br><input type="text" name="othercommunicationstate1" validate="Permanent State" id="othercommunicationstate1" value="" />
								</td> -->
								
							</tr>
							<tr height=30>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.city")%>&nbsp;<font color=red class=tablebold>*</font>&nbsp;</td>
								<td > <input type=text name="permanentcity" id="citycity1" maxlength=50 size=15 validate="Permanent City" class=tablelight></td>
							</tr>
							<tr>
								<td class=tablebold><%=bundle.getString("label.studentprofileentry.Pin")%>&nbsp;<font color=red class=tablebold>*</font></td>
								<td><input type="text" class="labeltextbox"
									class="labelfont" name="permanentpin" size="6" maxlength="6" validate="Permanent Pin Code" onkeypress="checkNumber(event)"></td>
							</tr>
							
						</table>
						</td> 
					</tr>
					 <tr>
						<td colspan=2 align=left><input type=button name=copps
									value="Copy and Paste into Permanent Address" class=tablelight
									onclick=copyfun()></td>
					</tr>
				</table>
				</td>
				</tr>
			</tbody>
			</table>
			
			<br>
			<table id="rounded-corner" border=0 width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="1%"></th>
						<th scope="col" class="rounded" width="98%"><%=bundle.getString("label.studentprofileentry.ContactNumberDetails")%></th>
						<th scope="col" class="rounded-q4" width="1%"></th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan=2 class="rounded-foot-left"><em></em></td>
						<td class="rounded-foot-right">&nbsp;</td>
					</tr>
				</tfoot>
				<tbody>
					<tr><td></td>
						<td colspan='2'  align=left>
							<table  border=0 width="100%">
								<tr>
									<td class=tablebold width="20%"><%=bundle.getString("label.studentprofileentry.landlineno")%></td>
									<td class=tablelight width="30%"><input type="text" class="labeltextbox" class="labelfont" name="telephone" value="" size="25" maxlength="50" onkeypress="checkNumber(event)"></td>
									<td class=tablebold width="20%">E-mail</td>
									<td class=tablebold width="30%" align=left><input type="text" class="labelfont" maxlength="50" name="email" size="38" ></td>
								</tr>
								<tr>
									<td class=tablebold width="20%"><%=bundle.getString("label.studentprofileentry.MobileNo.")%><font color=red class=tablebold>*</font></td>
									<td class=tablebold width="30%"><input type="text" class="labeltextbox" class="labelfont" name="mobileno" value="" size="25" validate='Mobile Number' maxlength="44" onkeypress="checkNumber(event)"></td> 
									<td class=tablebold width="20%"><%=bundle.getString("label.studentprofileentry.SMSContactNo.")%><font color=red class=tablebold>*</font></td>
									<td class=tablebold width="30%"><input type="text" class="labeltextbox" class="labelfont" name="smscontactno" value="" size="25" validate='SMS Contact Number' maxlength="44" onkeypress="smsmobilecontactcheck(event)"></td> 
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>	
			
			
			<br>
		<table id="rounded-corner" border=0 width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.studentprofileentry.StudentParent/GuardianDetails")%></th>
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
			<tr><td></td>
				<td colspan=2  align=left >
				<table border="0" width="80%" bordercolor="#EEEEEE" cellpadding="5"
					cellspacing="0" >
					<tr align=left>
						<td class=tablebold colspan=2><%=bundle.getString("label.studentprofileentry.Parent/GuardiansupportingyourEducation(ifguardian,staterelationship)")%>
						</td>
					</tr>
					<tr align=left>
						<td class=tablebold width="30%"><%=bundle.getString("label.studentprofileentry.Parent/GuardianName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="70%" colspan=4><input type="text"
							class="labeltextbox" class="labelfont" maxlength="40" name="guardianname" size="50%" validate="Guardian Name" onblur="address_Validation(this,this.name)"></td>
					</tr>
					<tr align=left>
						<td class=tablebold width="30%"><%=bundle.getString("label.studentprofileentry.Parent/GuardianMail")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="70%" colspan=4><input type="text" class="labeltextbox" class="labelfont" maxlength="40"  name="guardianmailid" validate="Guardian Mailid" size="30%" onblur="address_Validation(this,this.name)"></td>
					</tr>
					
					<tr align=left>
						<td class=tablebold width="25%"><%=bundle.getString("label.studentprofileentry.Relation")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="75%"><input type="text" class="labeltextbox" class="labelfont" maxlength="40" name="relation" validate="Relation" onblur="address_Validation(this,this.name)"></td>
					</tr>
					<tr align=left>
						<td class=tablebold  width="25%"><%=bundle.getString("label.studentprofileentry.WhetherSelfEmployed")%>&nbsp;&nbsp;</td>
							<td width="75%" colspan=4 class=tablebold><input
							type="radio" name="self" value="Yes" checked> Yes <input type="radio"
							name="self" value="No" > No</td>
					</tr>
					<tr align=left>
						<td class=tablebold width="25%"><%=bundle.getString("label.studentprofileentry.NameOforganization")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="75%" colspan=4><input type="text" class="labeltextbox" maxlength="50" class="labelfont" id="organization" name="organization" validate="Organization" size="50%"
							onblur="address_Validation(this,this.name)"></td>
					</tr>
					<tr align=left>
						<td class=tablebold width="25%"><%=bundle.getString("label.studentprofileentry.AnnualIncomeRs")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="75%"><input type="text" class="labeltextbox" class="labelfont" name="annualincome" maxlength="20" size="30%" validate="Annual Income"></td>
					</tr>
					<tr align=left>
						<td class=tablebold width="25%"><%=bundle.getString("label.studentprofileentry.Position")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
						<td width="75%"><input type="text" class="labeltextbox" class="labelfont" name="position" validate="Position" maxlength="30" size="30%" onblur="address_Validation(this,this.name)"></td>
					</tr>
				</table>
				</td>
			</tr>
			</tbody>
			</table>
			
			<br>
			<table id="rounded-corner" border=0 width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="1%"></th>
						<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.studentprofileentry.AdditionalInformation")%></th>
						<th scope="col" class="rounded-q4" width="1%"></th>
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
					<td></td>
						<td colspan='2'  align=left>
							<table  border=0 width="100%">
								<tr>
									<td class=tablebold width="30%"><%=bundle.getString("label.studentprofileentry.PhysicallyChallenged")%>&nbsp;&nbsp;</td>
									<td class=tablebold colspan='2'><input type="radio" name="physically" value="Yes"> Yes <input type="radio" name="physically" validate="Personal Physical Marks" value="No" checked> No</td> 
								</tr>
								<tr >
									<td class=tablebold ><%=bundle.getString("label.studentprofileentry.Son/DaughterofEx-Serviceman")%>&nbsp;&nbsp;</td>
									<td class=tablebold colspan='2'><input type="radio" name="exservice" value="Yes"> Yes <input type="radio" name="exservice" value="No" checked> No</td>
								</tr>
								<tr>
									<td class=tablebold valign=top ><%=bundle.getString("label.studentprofileentry.Personalphysicalmarks")%><font color=red>*</font></td>
									<td class="labelfont" colspan='2'><textarea class="labelfont" validate="Physical Marks" name="physicalmarks" rows=5 cols=50 onkeydown="textCounter(document.applicationform.physicalmarks,document.applicationform.reminLen2,100)"  onkeypress="textCounter(document.applicationform.physicalmarks,document.applicationform.reminLen2,100)"></textarea><br><input readonly type="text" name="reminLen2" size="3" maxlength="3" value="100"><font color="red">characters left</font></td>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>	
			
			<br>
			<table id="rounded-corner" border=0 width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="1%"></th>
						<th scope="col" class="rounded" width="98%"><%=bundle.getString("label.studentprofileentry.ExtraCurricularactivities")%></th>
						<th scope="col" class="rounded-q4" width="1%"></th>
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
					<td></td>
						<td colspan='2'  align=left>
							<table  border=0 width="100%">
								<% 
									HashMap hashmap		= null;
									HashMap hashmap1	= null;
									if(extracurricular != null && extracurricular.size()>0){
										for(int u=0;u<extracurricular.size();u++){
											hashmap		= (HashMap)extracurricular.get(u);
											out.print("<tr>");
											if(extracurricular.size()>(u+1)){
												hashmap1	= (HashMap)extracurricular.get(u+1);
												out.print("<tr><td width='50%'><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td><td width='50%'><input type='checkbox' name='extra' value='"+hashmap1.get("extracurricularactivityid")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap1.get("extracurricularname")+"</td></tr>");
												u	= u+1;
											}
											else{
												out.print("<tr><td colspan='2'><input type='checkbox' name='extra' value='"+hashmap.get("extracurricularactivityid")+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hashmap.get("extracurricularname")+"</td></tr>");
											}
										}
									}
									else
										out.print("<tr><td colspan='2' align='center'>Extra Curricular Activity Not Entered</td></tr>");
										
								%>
							</table>
						</td>
					</tr>
				</tbody>
			</table>			
					
			
			<br>
			
			<table id="rounded-corner" border='0' bordercolor='red' width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="99%" ><%=bundle.getString("label.studentprofileentry.StudentPreviousSchoolDetails")%></th>
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
						<td align=left  colspan=2>
							<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="5"  align=left cellspacing="0" rules="groups">
								<tr align=left>
									<td class=tablebold width="29%"  align=left><%=bundle.getString("label.studentprofileentry.PreviousSchoolStatus")%>&nbsp;&nbsp;</td>
									<td><input	type="radio" name="schoolstatus" value="yes"  onclick="schoolstatuscheck(this)"> Yes &nbsp; <input	type="radio" name="schoolstatus" value="no" checked onclick="schoolstatuscheck(this)">No</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align=left colspan=2>
							<table border="0" width="100%" style='display:none' bordercolor="#EEEEEE" cellpadding="5"  align=left cellspacing="0" rules="groups" id="previousSchooldetails">
								<tr align=left>
									<td class='tablebold' width='30%'><%=bundle.getString("label.studentprofileentry.NameoftheSchool")%>&nbsp;<font color=red class=tablebold>*</font></td>
									
									<td class='tablelight' align='left'><input type='text'  maxlength='50' validate="School Name" name='schoolname' size='40'></td>
								</tr>
								<tr align=left>
									<td class='tablebold' width='30%' valign='top'><%=bundle.getString("label.studentprofileentry.AddressoftheSchool")%>&nbsp;<font color=red class=tablebold>*</font></font></td>
									
									<td class='tablelight'><textarea  name='schooladdress' validate="School Address" rows='5' cols='50' onkeydown=textCounter_label(this,document.getElementById('remschoolLen2'),100) onkeypress=textCounter_label(this,document.getElementById('remschoolLen2'),100)></textarea><br><font color=red><label id='remschoolLen2' >100</label>&nbsp;characters Remaining</font></td>
								</tr>
								<tr align=left>
									<td class='tablebold' width='30%' valign='top'><%=bundle.getString("label.studentprofileentry.MediumofInstruction")%>&nbsp;<font color=red class=tablebold>*</font></font></td>
									<td class='tablelight' align='left'><input type='radio' name='medium' validate="Medium" value='Tamil'> Tamil &nbsp; <input type='radio' name='medium' value='English' checked>English</td>
								</tr>
							</table>
</td>
					</tr>
					<tr>
						<td align=left colspan=2>
							
							<table border="0" width="100%" style='display:none' bordercolor="#EEEEEE" cellpadding="3" id="previousStudentexam"  align=left cellspacing="0" rules="groups">
								<tr>
									<td class='tablebold' colspan='6' align=left><u><%=bundle.getString("label.studentprofileentry.EXAMINATIONDETAILS")%></u></td>
								</tr>
								<tr align=left>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.Subjects")%></td>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.Month-Year")%> <br> Ex:<font color=red size=1><%=bundle.getString("label.studentprofileentry.May2007")%></font></td>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.RegistrationNo")%></td>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.MarksScored")%></td>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.MaxMarks")%></td>
									<td class='tablebold' ><%=bundle.getString("label.studentprofileentry.Check")%></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='hidden' name='subject' value='Language'		><%=bundle.getString("label.studentprofileentry.Language")%></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max' maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'0')></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='hidden' name='subject' value='English'><%=bundle.getString("label.studentprofileentry.English")%></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max' maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'1')></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'	onblur='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max'  maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'2')></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'	onblur='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max'  maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'3')></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'	onblur='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark'  maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max'  maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'4')></td>
								</tr>
								<tr align=left>
									<td class='tablebold'><input type='text' class='labeltextbox' maxlength='30' size=15 name='subject'	onblur='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text'	class='labeltextbox' maxlength='20' size=15 name='month'	onblur='checkmonth(this)' onchange='checkmonth(this)'></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' maxlength='30' size=15 name='registrationno'></td>
									<td class='tablebold' ><input type='text' name='mark' maxlength='3' size=10 onkeypress='checkNumber(event)' ></td>
									<td class='tablebold' ><input type='text' class='labeltextbox' name='max'  maxlength='3' size=10 value='' onkeypress='checkNumber(event)'></td>
									<td class='tablebold' ><input type=checkbox class=tablelight name=chk onclick=markvalidation(this,'5')></td>
								</tr>
							</table>
							</td>
					</tr>
					<tr>
						<td align=left colspan=2>
							<table id="insertrowid" border="0" style='display:none' cellpadding="5" cellspacing="0" width="100%">
								<tr>
									<td  align="right" width='100%'>
							     		<a href="#ck" name='ck' onclick="removeexamdetails('previousStudentexam')" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("label.studentprofileentry.Remove")%></strong><span class="bt_red_r"></span></a>
									 	<a href='#bb' name="bb" onclick="createexamdetails()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.studentprofileentry.AddNewRow")%></strong><span class="bt_green_r"></span></a>
									</td>
							   </tr>
							   <tr>
							   		<td>
										<table border="0" cellpadding="5" cellspacing="0" width="100%">
											<tr align=left>
												<td class='tablebold' colspan='2'><u><%=bundle.getString("label.studentprofileentry.VerificationofCertificates")%></u></td>
											</tr>
											<tr align=left>
												<td class='tablebold' width='30%'><%=bundle.getString("label.studentprofileentry.T.C")%></td>
												<td class='tablebold' align='left'><input type='radio' name='tc' value='Yes'>Yes	/<input type='radio' name='tc' checked value='No'>No</td>
											</tr>
											<tr align=left>
												<td class='tablebold'><%=bundle.getString("label.studentprofileentry.C.C")%></td>
												<td class='tablebold' align='left'><input type='radio' name='cc' value='Yes'>Yes	/<input type='radio' name='cc' checked value='No'>No</td>
											</tr>
											<tr align=left>
												<td class='tablebold'><%=bundle.getString("label.studentprofileentry.Spl.Category")%></td>
												<td class='tablebold' align='left'><input type='radio' name='splCategory' value='Yes'>Yes/<input type='radio' name='splCategory' checked value='No'>No</td>
											</tr>
											<tr align=left>
												<td class='tablebold'><%=bundle.getString("label.studentprofileentry.MedicalCertificate")%></td>
												<td class='tablebold' align='left'><input type='radio' name='mc' value='Yes'>Yes	/<input type='radio' name='mc' checked value='No'>No</td>
											</tr>
											<tr align=left>
												<td class='tablebold'><%=bundle.getString("label.studentprofileentry.MarkSheet")%></td>
												<td class='tablebold' align='left'><input type='radio' name='ms' value='Yes'>Yes	/<input type='radio' name='ms' checked value='No'>No</td>
											</tr>
											<tr align=left>
												<td class='tablebold'><%=bundle.getString("label.studentprofileentry.SportsCertificate")%></td>
												<td class='tablebold' align='left'><input type='radio' name='sc' value='Yes'>Yes	/<input type='radio' name='sc' checked value='No'>No</td>
											</tr>
										</table>							   		
							   		
							   		</td>
							   </tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			<table id="rounded-corner" border=0 width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="1%"></th>
						<th scope="col" class="rounded" width="40%">Student Scholarship Details</th>
						<th scope="col" class="rounded-q4" width="1%"></th>
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
						<td></td>
						<td valign="top" colspan="2">
					
							
							
							<table width="100%" border="0">
							<tr class=tableheading><td>SL. No.</td><td>Scholarship Name</td><td>Select</td></tr>
					
					<%
							HashMap hashmapscholar	= null;
							int inc=0;
							if(scholarshipList != null && scholarshipList.size()>0)
							for(int y=0;y<scholarshipList.size();y++){
								hashmapscholar			= (HashMap)scholarshipList.get(y);
								/* if(hashmapscholar.get("schemeforstudentid")==null) 
								{ */
									inc++;
								out.print("<tr><td>"+(inc)+"</td><td>"+hashmapscholar.get("termname")+"</td><td>"+hashmapscholar.get("scholarshipname")+"</td>");
									out.print("<td><input type=checkbox name=scholarshipallocation value='"+hashmapscholar.get("scholarshipamountallocationid")+"'><input type=hidden name='termfeesid' value='"+hashmapscholar.get("termfeesid")+"'><input type=hidden name='amount' value='"+hashmapscholar.get("amount")+"'>");
/* 									} */
								
/* 								else
									out.print("<td><input type=checkbox checked name=scholarshipallocation value='"+hashmap.get("scholarshipamountallocationid")+"'><input type=hidden name='termfeesid' value='"+hashmap.get("termfeesid")+"'><input type=hidden name='amount' value='"+hashmap.get("amount")+"'></tr>");
 */									
							}
							if(inc ==0)
							{
								out.print("<tr><td>Data Not Found</td></tr>");
							}
					%>
					</table>
							
							
										
						</td>
					</tr>
					<!-- <tr>
						<td valign="top" colspan="3">
							<a href="#" class="bt_green" onclick="cancelSelection()"><span class="bt_green_lft"></span><strong>Cancel Selection</strong><span class="bt_green_r"></span></a>
						</td>
					</tr> -->
				</tbody>
			</table>			
			
			<br>
			<table id="rounded-corner" border=0 width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="1px"></th>
						<th scope="col" class="rounded" width="100%" ><%=bundle.getString("label.studentprofileentry.Student/ParentAccountDetails")%></th>
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
			<tr><td></td>
			<td colspan=2  align=center>
			<table border="0" width="100%" bordercolor="#EEEEEE"
							cellpadding="3" cellspacing="0">
							<tr>
								<td width="40%" align=left  class='tablebold' ><%=bundle.getString("label.studentprofileentry.YourBrother/SisterStudiedInThisSchool")%></td>
								<td width="60%" align=left><input type="radio" name="Studied" value="Y" onclick="searchbrosistercheck(this)">Yes<input type="radio" name="Studied" value="N" checked onclick="searchbrosistercheck(this)">No</td>
							</tr>
							<tr id="relationchecksearch" align=left style="visibility:hidden;">
								<td class="tablebold"><%=bundle.getString("label.studentprofileentry.EnterYourBrother/SisterRollNumber")%></td>
								<td align=left><input type="text" name="relationsearch" value=""><input type="button" name="relationsearchbutt" value="Search" onclick="searchbrosister(document.applicationform.relationsearch.value,'RelationCheck')"></td>
							</tr>
							</table>
						</td>
					</tr>
				<tr>
				<td colspan=3 align=left>
				<table border=0 width=100%>
					<tr>
						<td>
							<table border="0" align=left width="100%" cellpadding="3" cellspacing="0" rules="groups">
							<tr>
						<td>
						<div id="parentdetails" style="position:relative;"></div>
						</td>
						</tr>
						</table>
					</td>
					</tr>
					<tr>
					<td>
					<table border="0" width="100%" bordercolor="#EEEEEE" cellpadding="3"
						cellspacing="0" rules="groups">
						<tr>
							<td class=headerfont align=center>
							<table border="0" width="100%" bordercolor="#EEEEEE" align=left
								cellpadding="3" cellspacing="0">
								<tr align=left>
									<td colspan=2 class=tablebold align=left><u><%=bundle.getString("label.studentprofileentry.StudentAccountDetails")%></u></td>
								</tr>
								<tr  align=left>
									<td class=tablebold><%=bundle.getString("label.studentprofileentry.UserName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
									<td><input type="text" name="studusername" validate="Student Username" value="" size=20 maxlength=20></td>
								</tr>
								<tr>
								<td></td>
								<td ><font color=red><%=bundle.getString("label.studentprofileentry.(4to25Characters)")%></font></td>
								</tr>
								<tr  align=left>
									<td class=tablebold><%=bundle.getString("label.studentprofileentry.Password")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
									<td><input type="password" name="studpassword"  validate="Student Password" value="" size=20  maxlength=25 onkeyup="passwordStrength(this.value,'student')" onfocus="ff('student')"></td>
								</tr>
								    <tr>   
									<td class="tablebold" align=left><%=bundle.getString("label.studentprofileentry.PasswordStrength")%>
									</td>    
									<td  align=left>
									<div id="passwordDescriptionstudent">Password not entered</div>
									<div id="passwordStrengthstudent" class="strength0"></div>
									</td>   
									</tr>     
									
								<tr  align=left>
									<td class=tablebold><%=bundle.getString("label.studentprofileentry.Confirmpassword")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
									<td><input type="password" name="studpassword1" validate="Student Confirm Password" value="" size=20 maxlength=25></td>
								</tr>
							</table>
							</td>
							<td    align=left>
							<table border="0" width="100%" bordercolor="#EEEEEE" id="parentdetailstable"
								cellpadding="3" cellspacing="0">
								<tr   align=left>
									<td colspan=2 class=tablebold><u><%=bundle.getString("label.studentprofileentry.ParentAccountDetails")%></u></td>
								</tr>
								<tr   align=left>
									<td class=tablebold><%=bundle.getString("label.studentprofileentry.UserName")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
									<td><input type="text" name="studparentusername" id="studparentusername"  validate="Parent Username" value="" size=20 maxlength=12></td>
								</tr>
								<tr>
								<td></td>
								<td><font color=red><%=bundle.getString("label.studentprofileentry.(4to25Characters)")%></font></td>
								</tr>
								<tr  align=left>
									<td class=tablebold><%=bundle.getString("label.studentprofileentry.Password")%>&nbsp;&nbsp;<font color=red class=tablebold>*</font></td>
									<td ><input type="password" name="studparentpassword" size=20 maxlength=25 id="studparentpassword"  validate="Parent Password"  value="" onkeyup="passwordStrength(this.value,'parent')" onfocus="ff('parent')"></td>
								</tr>
								 <tr id="parentpassword">
									<td class="tablebold" ><%=bundle.getString("label.studentprofileentry.PasswordStrength")%>
									</td>  
									<td>
									<div id="passwordDescriptionparent">Password not entered</div>
									<div id="passwordStrengthparent" class="strength0"></div>
									</td>
									</tr>
									
								<tr  align=left>
									<td class="tablebold"><%=bundle.getString("label.studentprofileentry.Confirmpassword")%>&nbsp;&nbsp;<font color=red class=tablelight>*</font></td>
									<td><input type="password" name="studparentpassword1" id="studparentpassword1" validate="Parent Confirm Password" size=20 maxlength=25  value=""></td>
								</tr>
							</table>
							</td>
						</tr>

				</table>
				
				</td>
				</tr>
				</table>
				</td>
				</tr>
			</tbody>
	</table>
	<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentprofileentry.Back")%></strong><span
		class="bt_blue_r"></span></a>
	<a href="#" class="bt_green"
		onclick="Submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.studentprofileentry.Submit")%></strong><span
		class="bt_green_r"></span></a></form>
<%}
  else if (studentstate != null && studentstate.equals("C")) 
  {
	  %>
	  <table id="rounded-corner" border=0 width="100%">
	  			<thead>
	  			<tr>
	  				<th scope="col" class="rounded-company" width="5"></th>
	  				<th scope="col" class="rounded" width="100%">Student Profile Entry</th>
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
	  				<td colspan=3 align=center>
	  				<h3><font color=red>TC Issued to this student</font></h3> 
	  				</td>
	  				</tr>
	  				</tbody>
	  		</table>
	  		<a href="#"  onclick="backfun()" class="bt_blue"><span
	  		class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	  				   
  <%}
  else
   {
	  %>
<table id="rounded-corner" border=0 width="100%">
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%">Student Profile Entry</th>
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
				<td colspan=3 align=center>
				<h3><font color=red>Invalid Application Number</font></h3> 
				</td>
				</tr>
				</tbody>
		</table>
		<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
				   <%}%>
				   <% }catch(Exception e){e.printStackTrace();} %>
</div>
<!-- end of right content--></div>
<!--end of center content -->

<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>