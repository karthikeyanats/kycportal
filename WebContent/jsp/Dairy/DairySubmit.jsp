<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	ResourceBundle bundle = ResourceBundle
			.getBundle("resources.serversetup");  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function LoadStatus()
	{
	loadStudents();
		
	}
function loadStudents()
{
	
  	var url = "getStudentDetails.jsp?section="+document.wprkallotment.section.value;
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 }
function parseMessages(parseXML,check_var)
{
	   var rootObj=parseXML.getElementsByTagName("complaintdetails");
		var cNode_1=rootObj[0].childNodes.length;
		var hiddentext=document.wprkallotment.dairyname.value;
		if(cNode_1>0)
		{   var phoneno="";
			var studentnames="";
			
			for(var i=0;i<parseInt(cNode_1);i++)
			{
			 studentnames+=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue+";";
			 phoneno+=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue+";";
			}
			requestProcess(phoneno,hiddentext,studentnames,cNode_1);
			
		}
		else
		{
			requestProcess(phoneno,hiddentext,studentnames,cNode_1);
	
		}
		
}
		
function requestProcess(phonenos,hiddentext,studentnames,cNode_1)
{
	
	if(cNode_1>0)
	{
		var teleNumbers = phonenos;
		var teleNumber = teleNumbers.split(";");
	}
/*	for(var i=0;i<((teleNumber.length)-1);i++)
	{
		{
		if(!checkNumber(teleNumber[i]))
		{
			alert("Invalid Mobile Number..");
			document.wprkallotment.clickname[i].focus();
			document.wprkallotment.clickname[i].checked=false;
			return;
		}else 
		{
			if(teleNumber[i].length!=10){
				alert("Invalid Mobile Number..");
			  document.wprkallotment.clickname[i].focus();
			  document.wprkallotment.clickname[i].checked=false;
				return;
			}
		}
		
	}
	}  */
	 initRequest_sms(teleNumbers,hiddentext,studentnames,cNode_1);
	
}
function initRequest_sms(teleNumbers,hiddentext,studentnames,cNode_1)
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
	var url="http://"+ipaddress+":"+port+"/ShortMessage/ShortMessage";
	if(cNode_1>0)
	{   
				var StudentName = studentnames.split(";");
				var MobileNo = teleNumbers.split(";");
				var fz=0;
				var status=false;
				var subjectname=document.wprkallotment.subjectname.value;
			for(var i=0;i<((StudentName.length)-1);i++)
			{
				var temp_msg="Diary INFO : "+subjectname+" Dear parent  " +StudentName[i]+" \n "+hiddentext;
				var teleNumbers_new=MobileNo[i];
				var params = "to="+encodeURIComponent(teleNumbers_new)+"&message="+encodeURIComponent(temp_msg);
				document.getElementById("fileopener").src=url+"?"+params;
				//var win = window.open(url+"?"+params,"SMS","");
				//win.close();	  
				fz++;
			}    
			if(fz==((MobileNo.length)-1))
			{		
					status=true;
			}
			
	}
	else
	{
	status=true;
	}
			
	
	//url += "?"+params;
	//var win = window.open(url,"SMS","");
	//win.close();
	if(status)
	{
		//document.wprkallotment.action = "./../Operation_Result.jsp";
		
		document.wprkallotment.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
		document.wprkallotment.submit();
	}
	
			  
}	
			  

	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Schedule</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,com.iGrandee.Dairy.DairyBean"%>
<%@ page language="java"
	import="com.iGrandee.Dairy.Dairy"%>
	
	<form name='wprkallotment' method='post'>
	<%
	String status				= null;
	int result					= 0;
	Dairy allot					= new Dairy();
	DairyBean bean				= new DairyBean();
	String userid				= (String)session.getValue("userid");
	String sessionid			= request.getParameter("session");
	String sectionid			= request.getParameter("section");
	String standardid			= request.getParameter("standard");
	String sessionname			= request.getParameter("sessionname");
	String sectionname			= request.getParameter("sectionname");
	String standardname			= request.getParameter("standardname");
	String lessonid				= request.getParameter("lesson");
	String subjectid			= request.getParameter("subject");
	String lessonname			= request.getParameter("lessonname");
	String subjectname			= request.getParameter("subjectname");
	String dairyname			= request.getParameter("dairyname");
	
	
	bean.setSubject(request.getParameter("dairyname"));
	bean.setWorkdetails(request.getParameter("description"));
	bean.setIpaddress(request.getRemoteAddr());
	bean.setCreatedby(userid);
	bean.setSubjectscheduleid(subjectid);
	bean.setSectionscheduleid(sectionid);
	bean.setDairydate(request.getParameter("dairydate"));
	bean.setDairysubmissiondate(request.getParameter("enddate"));
	
	result						= allot.dairyInsert(bean);
	
	
	//result						= allot.dairyInsert(
		
	//	request.getParameter("dairyname"),
	//	request.getParameter("description"),
	//	request.getRemoteAddr(),userid,subjectid,sectionid,
	//	request.getParameter("dairydate"),
	//	request.getParameter("enddate")

	//);

	
	if(result >0)
		status	= "Diary Created Successfully.";
	else
		status	= "Diary Creation Failed.";



	%>
	<iframe src="" width="0" height="0" id="fileopener">
<p>Your browser does not support iframes.</p>
</iframe> 
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
	<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
	<input type='hidden' name='section' 		value='<%=sectionid%>'>
	<input type='hidden' name='session' 		value='<%=sessionid%>'>
	<input type='hidden' name='subject' 		value='<%=subjectid%>'>
	<input type='hidden' name='lesson' 			value='<%=lessonid%>'>
	<input type='hidden' name='subjectname'		value='<%=subjectname%>'>
	<input type='hidden' name='lessonname' 		value='<%=lessonname%>'>
	<input type='hidden' name='standard'		value='<%=standardid%>'>
	<input type='hidden' name='dairyname'		value='<%=dairyname%>'>

	<input type="hidden"
	name="smsipaddress"
	value="<%=bundle.getString("label.smsipaddress.smsipaddress") %>"><input
	type="hidden" name="port"
	value="<%=bundle.getString("label.smsipaddress.port") %>">
	
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Dairy/Dairy.jsp'>
	
	</form>
</body>
</html>