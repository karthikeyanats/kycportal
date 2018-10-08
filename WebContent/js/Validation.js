function optionDelete(option_list_object,num)
{
	var selectcount = option_list_object.options.length;

	if(num == 0)
	{
		for(k=selectcount-1;k>=0;k--)
		{
			option_list_object.options[k]=null;
		}
	}
	else
	{
		if(selectcount > 1)
		{
			for(k=selectcount-1;k>0;k--)
			{
				option_list_object.options[k]=null;
			}
		}
	}
}
function check_ForParticularElements()
{

   var no_of_arguments = arguments.length;

   if(parseInt(no_of_arguments % 2) == 0)
   {
   	for(var i=0;i<no_of_arguments;i++)
   	{
   	   inc = i + 1;
   	   if(!arguments[i].disabled)
   	   {

   		switch(arguments[inc])
   	   	{
   	  
		   case "text":
   	       case "textarea":
   	       case "password":
   	       {
   	          if(arguments[i].value == "")
   	          {
		      	if(arguments[i].getAttribute("validate") == null)
		      	{
					alert("Empty "+arguments[i].name+" is not allowed");
		    	}
		      	else
		      	{
			 		alert("Empty "+arguments[i].getAttribute("validate")+" is not allowed");
		      	}
   	          	arguments[i].focus();
   	          	return false;
   	          }
   	          else
   	          {
				var characters_setted = false;

				for(var kk=0;kk<arguments[i].value.length;kk++)
				{
					if((arguments[i].value.charAt(kk) != "" & arguments[i].value.charAt(kk) != " "))
					{
						characters_setted = true;
					}
				}

				if(!characters_setted)
				{
					if(arguments[i].getAttribute("validate") == null)
					{
						alert("Empty "+arguments[i].name+" is not allowed");
					}
					else
					{
						alert("Empty "+arguments[i].getAttribute("validate")+" is not allowed");
					}
					arguments[i].value = "";
					arguments[i].focus();

					return false;
				}
   	          }
   	          break;
   	       }
   	       case "select":
   	       {
   	          if(arguments[i].options[0].selected || arguments[i].options.selectedIndex == -1)
   	          {
   	        	  
				  if(arguments[i].getAttribute("validate") == null)
				  {
						alert(arguments[i].name+" is not yet selected");
				  }
				  else
				  {
						alert(arguments[i].getAttribute("validate")+" is not yet selected");
				  }
   	              arguments[i].focus();
   	              return false;
   	          }
   	          break;
   	       }
   	       case "email":
   	       {
			   if(!isEmail(arguments[i].value))
			   {
				  if(arguments[i].getAttribute("validate") == null)
				  {
				  	alert(arguments[i].name+" is not valid");
				  }
				  else
				  {
				  	alert(arguments[i].getAttribute("validate")+" is not Valid");
		      	  }
		      	  arguments[i].focus();
		      	  return false;
			   }

		   break;
		   }
		   case "isNaN":
		   {
		   		if(!isNaN(arguments[i].value))
		   		{
		   			if(arguments[i].getAttribute("validate") == null)
		   			{
		   				alert(arguments[i].name+" is not valid");
		   			}
		   			else
		   			{
		   				alert(arguments[i].getAttribute("validate")+" is not Valid");
		   		    }
		   		    arguments[i].focus();
		   		    return false;
		   		}
	   		   break;
		   }
		   case "FNUM":
		   {
			    if(!check_StartingLetter(arguments[i]))
			    return false;
			    break;
		   }
   	       case "radio":
   	       {
   	          var setFlag = false;

   	          for(var j=0;j<arguments[i].length;j++)
   	          {
   	            if(arguments[i][j].checked)
   	            {
			setFlag = true;
			break;
   	            }
   	            else
   	            {
   	                setFlag = false;
   	            }
   	          }

   	          if(!setFlag)
   	          {
	        	  if(arguments[i][0].getAttribute("validate") == null)
		         	  alert("You have to select atleast one "+arguments[i][0].name+".");
	        	  else
	        		  alert("You have to select atleast one "+arguments[i][0].getAttribute("validate")+".");

	        	  arguments[i][0].focus();
   	              return false;
   	          }
   	          break;
   	       }
   	    case "userdefinedradio":
	       {
	          var setFlag = false;

	          for(var j=0;j<arguments[i].length;j++)
	          {
	            if(arguments[i][j].checked)
	            {
			setFlag = true;
			break;
	            }
	            else
	            {
	                setFlag = false;
	            }
	          }

	          if(!setFlag)
	          {
	        	  if(arguments[i][0].getAttribute("validate") == null)
		         	  alert("Select any one option");
	        	  else
	        		  alert("Select any one option");

	        	  arguments[i][0].focus();
	              return false;
	          }
	          break;
	       }
   	    
   	       case "checkbox":
	       {
	          var setFlag = false;

	          for(var j=0;j<arguments[i].length-1;j++)
	          {
	            if(arguments[i][j].checked)
	            {
	            	setFlag = true;
	            	break;
	            }
	          }

	          if(!setFlag)
	          {
	        	  if(arguments[i][0].getAttribute("validate") == null)
		         	  alert("You have to select atleast one "+arguments[i][0].name+".");
	        	  else
	        		  alert("You have to select atleast one "+arguments[i][0].getAttribute("validate")+".");

	        	  arguments[i][0].focus();
	              return false;
	          }
	          break;
	       } 
	       
   	    case "userdefinedcheckbox":
	       {
	          var setFlag = false;

	          for(var j=0;j<arguments[i].length-1;j++)
	          {
	            if(arguments[i][j].checked)
	            {
	            	setFlag = true;
	            	break;
	            }
	          }

	          if(!setFlag)
	          {
	        	  if(arguments[i][0].getAttribute("validate") == null)
		         	  alert("Select any one option");
	        	  else
	        		  alert("Select any one option");

	        	  arguments[i][0].focus();
	              return false;
	          }
	          break;
	       }
   	   	}
   	   	++i;
   	   }
   	}
   }
   return true;
}
var starting_letter_alert = false;

function check_StartingLetter(obj)
{
   var regexp = /\d/;
   var regexp1 = /\W/;


   if(!starting_letter_alert)
   {
    if(regexp.test(obj.value.charAt(0)) | regexp1.test(obj.value.charAt(0)))
    {
           alert("Starting letter should  be in alphabet");
           starting_letter_alert = true;
           obj.select();
           return false;
    }
   }
   else
   {
   	starting_letter_alert = false;
        obj.select();
        return false;

   }
    return true;
}
function email_Validation(emailObject, alertStr, booleanObject) {

	emailStr = emailObject.value;

   if (emailStr.length == 0) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }

   var emailPat=/^(.+)@(.+)$/;
   var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
   var validChars="\[^\\s" + specialChars + "\]";
   var quotedUser="(\"[^\"]*\")";
   var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;
   var atom=validChars + '+';
   var word="(" + atom + "|" + quotedUser + ")";
   var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
   var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");
   var matchArray=emailStr.match(emailPat);
   if (matchArray == null) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }
   var user=matchArray[1];
   var domain=matchArray[2];
   if (user.match(userPat) == null) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }
   var IPArray = domain.match(ipDomainPat);
   if (IPArray != null) {
	   for (var i = 1; i <= 4; i++) {
		  if (IPArray[i] > 255) {
			  alert("Invalid "+alertStr);
			  emailObject.focus();
			  return false;
		  }
	   }
	   return true;
   }
   var domainArray=domain.match(domainPat);
   if (domainArray == null) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }
   var atomPat=new RegExp(atom,"g");
   var domArr=domain.match(atomPat);
   var len=domArr.length;
   if ((domArr[domArr.length-1].length < 2) ||
	   (domArr[domArr.length-1].length > 3)) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }
   if (len < 2) {
	   alert("Invalid "+alertStr);
	   emailObject.focus();
	   return false;
   }
   return true;
}
function stringValidate(obj,str)
{
	 var string= obj.value;


	 if(string!="")
	 {
		 for(var i=0;i<string.length;i++)
		 {
			 if(!((string.charAt(i)>="a" && string.charAt(i)<="z") || (string.charAt(i)>="A" && string.charAt(i)<="Z") ))
			 {
				alert(str+" should be alphabetical");
				return false;
			 }
		}
	}

	 return true;

}
function stringValidateincludesigquots(obj,str)
{
	 var string= obj.value;


	 if(string!="")
	 {
		 for(var i=0;i<string.length;i++)
		 {
		 	if((string.charAt(i)!="'") && (string.charAt(i)!=".") && (string.charAt(i)!=" "))
		 	{
				 if(!((string.charAt(i)>="a" && string.charAt(i)<="z") || (string.charAt(i)>="A" && string.charAt(i)<="Z")))
				 {
					alert(str+" should be alphabetical");
					return false; 
				 }
			 }
		}
	}

	 return true;

}
function checkUserAndPassword(obj)
	{

		 var string= obj.value;
		 string=string.toLowerCase();
		 if(string!="")
		 {
			 for(var i=0;i<string.length;i++)
			 {

				if((string.charCodeAt(i)<48 || string.charCodeAt(i)>57) && (string.charCodeAt(i)<97 || string.charCodeAt(i)>122)  && string.charCodeAt(i)!=95 && string.charCodeAt(i)!=173)
				{
					alert("UserName and Password should be in  small letter and it should not allow any special Characters");
					return false;
				}
	  	 	}
		 /*if(string.charCodeAt(0)<48 || string.charCodeAt(0)>57)
 		 {
 			alert("First letter should be Not  alphabetical");
 			return false;
 		 }
 		 else if((string.charCodeAt(string.length-1)<97 || string.charCodeAt(string.length-1)>122) && (string.charCodeAt(string.length-1)<48 || string.charCodeAt(string.length-1)>57))
		 {
			alert("Last letter should not be special charector");
			return false;
		 }
		 else
		 {
		 }*/
 }
		 obj.value=string;
		 return true;

	}
function checkName(e)
{
var unicode=e.keyCode? e.keyCode : e.charCode
if(unicode == 39 || unicode == 47 || unicode == 92 ||unicode == 58 || unicode == 42 || unicode == 63 || unicode == 34||unicode == 60 ||unicode == 62 ||unicode == 124)
		{
			 alert("The Following Symbols are not allowed in Course Name /  \\\ '  < > * :? \"  |");
			 return false;
		}
}
function numeric_Validation(fields,fieldName)
{
       flag=true;
       field=fields.value;
       var num=parseInt(field.length);



           if(num==0 )
           {
               alert(fieldName+":"+'cannot be Empty');
               fields.focus();
               flag=false;
           }
           else
           {
             //checking starting field
			 startVal = field.charAt(0);

			if( !( (startVal>="0") && (startVal<="9") || (startVal=="\.")) )
			 {
				  alert("String or SpecialCharacter not allowed in the starting of "+ fieldName+".");
				  fields.value = "";
				  fields.focus();
				  flag=false;

			  }
                     else
                        {
				for(var i=0;i<num;++i)
				 {
				      var str=field.substring(i,i+1);
				     if( !((str>="0") && (str<="9") ||  (str=="\.")))
					 {
					   alert(fieldName+":"+'Invalid entry! only number allowed.');
					   fields.focus();
					   flag= false;
					   break;

					   }
				  }//end of for
		      }//end of else

              }//end of else

         return flag;
      }
function checkUsernamePassword(name,test)
{
   if(test=="Username")
   {
   	if(name.charAt(0)=="0" || name.charAt(0)=="1" || name.charAt(0)=="2" || name.charAt(0)=="3" || name.charAt(0)=="4" || name.charAt(0)=="5" ||name.charAt(0)=="6" || name.charAt(0)=="7" || name.charAt(0)=="8" ||name.charAt(0)=="9")
   	{
   	   alert("Username should start with alphabet")
   	   return false;
   	}

   	if(name.indexOf("`")!=-1 || name.indexOf("&")!=-1 ||name.indexOf("/")!=-1 || name.indexOf("\\")!=-1 || name.indexOf(">")!=-1 || name.indexOf("<")!=-1 || name.indexOf("*")!=-1 || name.indexOf(":")!=-1 || name.indexOf("\"")!=-1 || name.indexOf("|")!=-1 || name.indexOf("?")!=-1 || name.indexOf("'")!=-1)
	{
	   alert("The Following Symbols are not allowed in Username ` / \\\  < > ' * :? \" | &");
	   return false;
	}
   }
   else if(test=="Password")
   {
   	if(name.indexOf("`")!=-1 || name.indexOf("/")!=-1 || name.indexOf("\\")!=-1 || name.indexOf(">")!=-1 || name.indexOf("<")!=-1 || name.indexOf("*")!=-1 || name.indexOf(":")!=-1 || name.indexOf("\"")!=-1 || name.indexOf("|")!=-1 || name.indexOf("?")!=-1 || name.indexOf("'")!=-1)
	{
	   alert("The Following Symbols are not allowed in Password ` / \\\  < > ' * :? \" | ");
	   return false;
	}

   }
}
function initRequest()
{
   if(window.XMLHttpRequest)
   	   return new XMLHttpRequest();
   else if (window.ActiveXObject)
   	   return new ActiveXObject("Microsoft.XMLHTTP");
}
function numeric_Validation(fields,fieldName)
{
       flag=true;
       field=fields.value;
       var num=parseInt(field.length);
           if(num==0 )
           {
               fields.focus();
               flag=false;
           }
           else
           {
             //checking starting field
			 startVal = field.charAt(0);

			if( !( (startVal>="0") && (startVal<="9") || (startVal=="\.")) )
			 {
				  alert("String or SpecialCharacter not allowed in the starting of "+ fieldName);
				  fields.value = "";
				  fields.focus();
				  flag=false;

			  }
                     else
                        {
				for(var i=0;i<num;++i)
				 {
				      var str=field.substring(i,i+1);
				     if( !((str>="0") && (str<="9") || (str!="\.")) )
					 {
					   alert(fieldName+":"+'Invalid entry! only number allowed');
					   fields.value = "";
					   fields.focus();
					   flag= false;
					   break;

					   }
				  }//end of for
		      }//end of else

              }//end of else

         return flag;
 }
 
  function validatePeriodTime(current_object, paramType) {

	var timeformat = new Array("nn","n");
	if(current_object.value != "") {
		element_text_format = "";
		for(var i=0;i<current_object.value.length;i++)
		{
			if((parseInt(current_object.value.charAt(i)) >= 0) & (parseInt(current_object.value.charAt(i)) <= 9))
				element_text_format += "n";
			else if(current_object.value.charAt(i) == ":")
				element_text_format += ":";
			else if(current_object.value.charAt(i) == "-")
				element_text_format += "-";
			else
				element_text_format += "d";
		}

		matchChar = 0;
		for(arridx=0;arridx<timeformat.length;arridx++) {
			if(timeformat[arridx] == element_text_format)
				matchChar++;
		}

		if(matchChar == 0) {
			alert("Invalid time format!");
			current_object.value = "";
			current_object.focus();
			return false;
		}
	}
	else {
		current_object.value = "00";
	}
}

function validateSessions(current_object, objname) {

    thisobj 		= current_object;
    idx				= current_object.getAttribute("idx");
	var timeformat = new Array("nn:nn-nn:nn","n:nn-n:nn", "nn:nn-n:nn", "n:nn-nn:nn");
	if(current_object.value != "")
	{
		element_text_format = "";
		for(var i=0;i<current_object.value.length;i++)
		{
			if((parseInt(current_object.value.charAt(i)) >= 0) & (parseInt(current_object.value.charAt(i)) <= 9))
				element_text_format += "n";
			else if(current_object.value.charAt(i) == ":")
				element_text_format += ":";
			else if(current_object.value.charAt(i) == "-")
				element_text_format += "-";
		}

		matchChar = 0;
		for(arridx=0;arridx<timeformat.length;arridx++) {
			if(timeformat[arridx] == element_text_format)
				matchChar++;
		}

		if(matchChar == 0) {
			alert("Invalid time format!");
			setTimeout('thisobj.focus()',0);
			return false;
		}
		else {
			if(Period_Form.periodtime.length > 1) {
				for(jk=0;jk<Period_Form.periodtime.length;jk++) {
					exist_time = eval(objname+"[jk].value");
					
					
					exist_time_split 	= exist_time.split("-");
					exist_sttime 		= exist_time_split[0].replace(":", '');
					exist_endtime 		= exist_time_split[1].replace(":", '');
					curr_time 			= current_object.value;
					curr_time_split 	= curr_time.split("-");
					curr_sttime 		= curr_time_split[0].replace(":", '');
					curr_endtime 		= curr_time_split[1].replace(":", '');
					
					if(parseInt(idx) != parseInt(jk)) {
					
						if((curr_sttime >= exist_sttime) & (curr_sttime <= exist_endtime) || (curr_endtime >= exist_sttime) & (curr_endtime <= exist_endtime)){
							alert("Broadcast session time has conflicted, so please give correct time session.");
							jk = Period_Form.periodtime.length;
							current_object.value = document.getElementById("periodtime_span"+idx).innerHTML;
							setTimeout('thisobj.focus()',0);
							return false;
						}
						
					}
				}
			}
			else {
			}
		}
	}
	else
	{
		alert("Empty broadcast time is not allowed here")
		current_object.focus();
		current_object.select();
		return false;
	}
}
 
function textCounter(field,cntfield,maxlimit)
{
  if (field.value.length > maxlimit) // if too long...trim it!
    {
       alert("Maximum "+maxlimit+" Characters only Allowed");
       field.value = field.value.substring(0, maxlimit-1);
    }
  else
    {
       cntfield.value = maxlimit - field.value.length;
    }
}
function textCounter_label(field,cntfield,maxlimit)
{
  if (field.value.length > maxlimit) // if too long...trim it!
    {
       alert("Maximum "+maxlimit+" Characters only Allowed");
       field.value = field.value.substring(0, maxlimit);
    }
  else
    {
       cntfield.innerHTML = maxlimit - field.value.length;
    }
}
//Allow Only Numbers in a Textbox
function onlyNumbers(e)
{
	if (!e) var e = window.event;
	if (e.keyCode) charCode = e.keyCode;
	else if (e.which) charCode = e.which;


   // var e = event || evt; // for trans-browser compatibility
   // var charCode = e.which || e.keyCode;

    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}
function calculateRemaining(obj,val,ids) {

	var txtlemgth	= obj.value;
	var remobj		= document.getElementById(ids);

	if(txtlemgth.length>=val) {
		alert("Only "+val+" characters allowed.");
		obj.setAttribute("value",txtlemgth.substring(0,val))
		remobj.innerHTML = "<font color=red>0 characters remaining";
		return false;
	}
	else
		remobj.innerHTML = "<font color=red>"+(val-txtlemgth.length)+" characters remaining";
}

	function checkNumber(e) {


	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	

	var character = String.fromCharCode(code);
	

	
	 	if(code == 8 || code == 9 || code==37 || code==38 || code==39 || code==40)
	 	{
			return false;
	 	}
 		if (code==47||code<46||code>57)
 		{
				code=0;
				alert("Enter Number only")

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
		if(code==46)
		{
	 
		}
}

function checkTimeFormat(obj){
	
	var isValid = /^([0-5][0-9])(:[0-5][0-9])?$/.test(obj.value)
	if(!isValid){
		alert("Invalid time format.Please use mm:ss format.");
		obj.value	= "01:00";
		obj.focus();
	}
}

function Trim(TRIM_VALUE)
{
	if(TRIM_VALUE.length < 1){
	return"";
	}
	TRIM_VALUE = RTrim(TRIM_VALUE);
	TRIM_VALUE = LTrim(TRIM_VALUE);
	console.log(TRIM_VALUE);
	if(TRIM_VALUE=="")
	{
		return "";
	}
	else
	{
		return TRIM_VALUE;
	}
} //End Function 

function RTrim(VALUE)
{
	var w_space = String.fromCharCode(32);
	var v_length = VALUE.length;
	var strTemp = "";
	if(v_length < 0){
	return"";
	}
	var iTemp = v_length -1;

	while(iTemp > -1)
	{
		if(VALUE.charAt(iTemp) == w_space){
		}
		else{
		strTemp = VALUE.substring(0,iTemp +1);
		break;
		}
		iTemp = iTemp-1;
	} //End While
	return strTemp;

} //End Function

function LTrim(VALUE)
{
var w_space = String.fromCharCode(32);
if(v_length < 1){
return"";
}
var v_length = VALUE.length;
var strTemp = "";

var iTemp = 0;

while(iTemp < v_length){
if(VALUE.charAt(iTemp) == w_space){
}
else{
strTemp = VALUE.substring(iTemp,v_length);
break;
}
iTemp = iTemp + 1;
} //End While
return strTemp;
} //End Function

function AllTrim(object){

object.value = Trim(object.value);
}

function CheckEmpty(CONTROL){
if(Trim(CONTROL.value)==""){
alert("Please supply some text for trimming");
CONTROL.value="";
CONTROL.focus();
return true;
}
else{
return false;
}
}



function valid(o,w){
	
	o.value = o.value.replace(valid.r[w],'');


	}
	valid.r={
	'special':/^[a-zA-Z0-9 +(),-]+$/,
	'quotes':/['\''&'\"']/g,
	'numbers':/[^\d]/g
	}









