<jsp:useBean id="circularEntryBean" 	scope="page" class="com.iGrandee.Circular.CircularEntryBean"/>
<jsp:useBean id="circularQuery" 		scope="page" class="com.iGrandee.Circular.CircularEntryQuery"/>
<jsp:useBean id="date_object" 			scope="page" class="com.iGrandee.Common.DateTime"/>

<%@ page import="com.iGrandee.Circular.CircularEntryUpload" %>
<%@ page import="java.util.ResourceBundle,java.io.File,java.util.List,java.util.Iterator" %>
  <%
	ResourceBundle bundle = ResourceBundle
			.getBundle("resources.serversetup");    
	String mode					="";  
	String recievers="";
	String recievers_temp="";
	String subject				="";
	String smsstatus="";
	String resultword = "";
	int result=0;


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
function LoadStatus()
{
	if(document.wprkallotment.smsstatus.value=="YES")
	{
	loadStudents1();
	}
	else
	{
	loadStudents2();
	}
		
}
function loadStudents1()
{
var aftersplit="";
	
	var ids=document.wprkallotment.recievers_id.value;
	var mode=document.wprkallotment.mode.value;
	var ids_temp_new="";
	 var url ="";
	if(mode=="Standard")
	{
	var ids_temp=ids.split(",");
	for(var i=0;i<ids_temp.length;i++)
	{
		ids_temp_new +=ids_temp[i];
		if(i!=(ids_temp.length-1))  
		{
		ids_temp_new +="','";
		}
	}  
	   url = "getDetails.jsp?ids="+ids_temp_new+"&mode=Standard";
  	}
  	else if(mode=="Role")
  	{
	  	var role="";
	  	var dept="";
  		var ids_temp=ids.split(",");
  		
 		for(var i=0;i<ids_temp.length;i++)
	    {
			var arra=ids_temp[i].split("&")
			
			 role +=arra[0];
			 dept +=arra[1];
			 if(i!=(ids_temp.length-1))
			 {
			 role +="','";
			 dept +="','";
			 }
			
	    }  
	   
	  	  url = "getDetails.jsp?roleid="+role+"&deptid="+dept+"&mode=Role";
	  
  	
  	}
  	else if(mode=="staff")
  	{
	  	var ids_temp=ids.split(",");
		for(var i=0;i<ids_temp.length;i++)
		{
			ids_temp_new +=ids_temp[i];
			if(i!=(ids_temp.length-1))  
			{
			ids_temp_new +="','";
			}
		} 
	   url = "getDetails.jsp?ids="+ids_temp_new+"&mode=staff";
  	}
  	else if(mode=="student")
  	{
	  	var ids_temp=ids.split(",");
		for(var i=0;i<ids_temp.length;i++)
		{
			ids_temp_new +=ids_temp[i];
			if(i!=(ids_temp.length-1))  
			{
			ids_temp_new +="','";
			}
		} 
		url = "getDetails.jsp?ids="+ids_temp_new+"&mode=student";
  	}
  	
  	
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
		var hiddentext=document.wprkallotment.subjectname.value;
		
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
if(cNode_1>0)
{
	var url="http://"+ipaddress+":"+port+"/ShortMessage/ShortMessage";
	var StudentName = studentnames.split(";");
		var MobileNo = teleNumbers.split(";");
		var fz=0;
				var table=document.getElementById("tableid");
			var moblelen="";
			var status=false;
		
	for(var i=0;i<((StudentName.length)-1);i++)
	{
		var temp_msg="Circular INFO : Dear   " +StudentName[i]+ "   "+hiddentext;
		var teleNumbers_new=MobileNo[i];
		var params = "to="+encodeURIComponent(teleNumbers_new)+"&message="+encodeURIComponent(temp_msg);
		//document.getElementById("fileopener").src=url+"?"+params;
		fz++;
		var rowobj=document.createElement("tr");
		var cellobj=document.createElement("td");
		cellobj.innerHTML="<iframe id='frameid"+i+"' width='0px' height='0px' src='"+url+"?"+params+"'></iframe>";
		rowobj.appendChild(cellobj);
		table.appendChild(rowobj);
		if(fz==((MobileNo.length)-1))
		{
			status=true;
		}
		
	}
	//alert("SMS Send Successfully");	
}
else
{
	status=true;
}
	if(status)
	{
		
 		loadStudents2();
 		
	}		
}	
function loadStudents2()
{			
 		//document.wprkallotment.action = "./../Opration_result_withrequestOperation_Result.jsp";		
 		document.wprkallotment.action = "./../Opreation_result_withrequest.jsp";
		document.wprkallotment.submit();
}		  
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Schedule</title>
</head>
<body onload="LoadStatus()">
	<form name='wprkallotment' method='post'>

<%
try{
	CircularEntryUpload upload=new CircularEntryUpload(request);
	String Attach=upload.startProcess()+"";
	String 	curdate				= date_object.showTime("for_secure");
	String toWhom				= null;
	 recievers			= upload.getParameter("recievers_id");
	 subject				= upload.getParameter("subject");
	String content				= upload.getParameter("content");
	String startDate			= upload.getParameter("start_date");
	String endDate				= upload.getParameter("end_date");
	mode=upload.getParameter("rad_course");
	String Status				= upload.getParameter("Status");
	String circularid			= upload.getParameter("circularid");
	String attachment			= upload.getParameter("attach");
	smsstatus=upload.getParameter("smsstatus");

	if(mode.equalsIgnoreCase("Individual"))
		mode = upload.getParameter("rad_staff");
	circularEntryBean.setOperation(Status);
	if(Status.equals("Edit") && Attach.equals("null") && !attachment.equals("null"))
	{
		circularEntryBean.setAttachfile(attachment);
	}
	else
	{
		circularEntryBean.setAttachfile(Attach);
	}
	circularEntryBean.setCircularid(circularid);
	String userid		= session.getValue("userid")+"";
	circularEntryBean.setCreatedby(userid);
	circularEntryBean.setSubject(subject);
	circularEntryBean.setContent(content);
	circularEntryBean.setStartdate(startDate); 
	circularEntryBean.setEndDate(endDate);
	circularEntryBean.setReceiverid(recievers);
	circularEntryBean.setIpaddress(request.getRemoteHost());
	circularEntryBean.setStatus("A");
	circularEntryBean.setMode(mode);
	
	result=circularQuery.dataManipulation(circularEntryBean);
	if(result >0){
		if(Status.equals("Edit"))
		{
			resultword="Circular Successfully Updated";
		}
		else if (smsstatus.equals("YES"))
		{
			resultword="Circular Successfully Inserted and SMS Send Successfully";
		}
		else
		{
			resultword="Circular Successfully Inserted";

		}
	}
	else
	{
		resultword="operation Failed";
	}
	//String return_file = "./Circular/CircularEntry.jsp";

	//response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?message="+resultword+"&result="+result+"&returnurl="+return_file);


	
}
catch(Exception e)
{
	e.printStackTrace();
	//response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?message=Opertion Failed&result=0&returnurl=./Circular/CircularEntry.jsp");
	}

	if(recievers.endsWith(","))
	{
		recievers=recievers.substring(0,recievers.lastIndexOf(","));
	}


%>
<table id="tableid">

</table>
<input type='hidden' name='message' 		value='<%=resultword%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Circular/CircularEntry.jsp'>
<iframe src="" width="0" height="0" id="fileopener">
<p>Your browser does not support iframes.</p>
</iframe> 
	<input type='hidden' name='mode' 	value='<%=mode%>'> 
	<input type='hidden' name='recievers_id' 	value='<%=recievers%>'> 
	<input type='hidden' name='subjectname' 	value='<%=subject%>'>  
		<input type='hidden' name='smsstatus' 	value='<%=smsstatus%>'> 
	
	<input type="hidden"
	name="smsipaddress"
	value="<%=bundle.getString("label.smsipaddress.smsipaddress") %>"><input
	type="hidden" name="port"
	value="<%=bundle.getString("label.smsipaddress.port") %>">
			<input type='hidden' name='sendstatus' 	value=""> 
		 
	
</form>
</body>
</html>