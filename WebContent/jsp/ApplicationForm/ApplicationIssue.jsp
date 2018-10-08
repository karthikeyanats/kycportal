<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.applicationissueentry.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function back_fun()
{
	document.ApplicantSearch.action="./ApplicationIssue_Pre1.jsp";
	document.ApplicantSearch.submit();
}
function Insert()
{
	//if(check_ForParticularElements(document.ApplicantSearch.standardpublish,"select",document.ApplicantSearch.applicantName,"text",document.ApplicantSearch.applicationNo,"text",document.ApplicantSearch.applicationCost,"text",document.ApplicantSearch.contactno,"text")){
	if(check_ForParticularElements(document.ApplicantSearch.standardpublish,"select",document.ApplicantSearch.applicantName,"text",document.ApplicantSearch.applicationCost,"text",document.ApplicantSearch.contactno,"text")){
		if(document.ApplicantSearch.applicationCost.value!="")
		{
	         var field=document.ApplicantSearch.applicationCost.value;
	         var flag=true;
			 var num=parseInt(field.length);
			 if(num==0 )
			   {
				   alert("ApplicationCost should not be empty");
				    flag=false;
			   }
			   else
			   {
				    startVal = field.charAt(0);
					for(var i=0;i<num;++i)
					 {
						  var str=field.substring(i,i+1);
						 if( !((str>="0") && (str<="9") ||  (str=="\.")))
						 {
						   alert('Invalid entry! only number allowed.');
						   document.ApplicantSearch.applicationCost.focus();
						   return
						   flag= false;
						   break;
	
						   }
					  }
	
				  }

				  if(document.ApplicantSearch.emailid.value !="")
				  {
					  if(!email_Validation(document.ApplicantSearch.emailid,"Mail Id",true))
					  {
					      return false;
					  }
				  }
	
				  if(flag==true)
				  {
					if(confirm("Do you want to issue the Application..?"))
					{			  		
				  	  document.ApplicantSearch.standardnamegp.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].text;
					  document.ApplicantSearch.action="ApplicantInsert.jsp";
					  document.ApplicantSearch.submit();
				  	}
				  }
		}
	
	}
}


function view_fun()
{
	if(document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].value =="00")
	{
		alert("Select Standard to View Applicants");
		document.ApplicantSearch.standardpublish.focus();
		return false;
	}
	else
	{
		document.ApplicantSearch.standardnamegp.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].text;
		document.ApplicantSearch.standardpublishid.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].value;
		document.ApplicantSearch.action="ApplicationIssueView.jsp";
		document.ApplicantSearch.submit();
	}
}

function Insert1()
{

	/*if(document.ApplicantSearch.receiptno.value=="")
	{
		alert("Enter Receipt No.");
		document.ApplicantSearch.receiptno.focus();
	}*/
	if(document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].value =="00")
	{
	  alert("Standard is not yet selected");
	  document.ApplicantSearch.standardpublish.focus();
	  return false;
	}	
	if(document.ApplicantSearch.applicantName.value=="")
	{
		alert("Applicant Name should not be empty");
		document.ApplicantSearch.applicantName.focus();
	}


	else if(document.ApplicantSearch.applicationNo.value=="")
	{
		alert("Application Number should not be empty")
		document.ApplicantSearch.applicationNo.focus();
	}

	else if(document.ApplicantSearch.applicationCost.value=="")
	{
		alert("Application Fee should not be empty")
		document.ApplicantSearch.applicationCost.focus();
	}
	else if(document.ApplicantSearch.applicationCost.value!="")
	{
         var field=document.ApplicantSearch.applicationCost.value;
         var flag=true;
		 var num=parseInt(field.length);
		 if(num==0 )
		   {
			   alert("ApplicationCost should not be empty");
			    flag=false;
		   }
		   else
		   {
			    startVal = field.charAt(0);
				for(var i=0;i<num;++i)
				 {
					  var str=field.substring(i,i+1);
					 if( !((str>="0") && (str<="9") ||  (str=="\.")))
					 {
					   alert('Invalid entry! only number allowed.');
					   document.ApplicantSearch.applicationCost.focus();
					   return
					   flag= false;
					   break;

					   }
				  }

			  }
			  if(document.ApplicantSearch.contactno.value =="")
			  {
				  alert("Phone No. should not be empty");
				  document.ApplicantSearch.contactno.focus();
				  return
			  }
			  if(document.ApplicantSearch.emailid.value !="")
			  {
				  if(!email_Validation(document.ApplicantSearch.emailid,"Mail Id",true))
				  {
				      return false;
				  }
			  }

			  if(flag==true)
			  {
				if(confirm("Do you want to issue the Application..?"))
				{			  		
			  	  document.ApplicantSearch.standardnamegp.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].text;
				  document.ApplicantSearch.action="ApplicantInsert.jsp";
				  document.ApplicantSearch.submit();
			  	}
			  }
	}
	else
	{

	}
}


function view_fun1()
{
	if(document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].value =="00")
	{
		alert("Select Standard to View Applicants");
		document.ApplicantSearch.standardpublish.focus();
		return false;
	}
	else
	{
		document.ApplicantSearch.standardnamegp.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].text;
		document.ApplicantSearch.standardpublishid.value = document.ApplicantSearch.standardpublish.options[document.ApplicantSearch.standardpublish.options.selectedIndex].value;
		document.ApplicantSearch.action="ApplicationIssueView.jsp";
		document.ApplicantSearch.submit();
	}
}


var count=0;
var temp=false;
var numberOfcount=0;

function checkNumber1(e) {


	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;

	var character = String.fromCharCode(code);


	//alert(code);

//code >48,49,50,51,52,53,54,55,56,57,58 <code
//if(code > 48 && 59<code)
//{
//	alert("enter onlynumeric value");
//}

	 //if(code == 8)
	 /*if(code > 48 && 59<code)
		 {
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

		 }*/
	 	if(code == 8 || code == 9)
	 	{
			return false;
	 	}
 		if (code==47||code<46||code>57)
 		{
				code=0;
				alert("Enter a Number only")

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
		 count=count+1;
		 temp=true;
		}
		if(count>1)
		{
			code=0;
			alert("Only One Dot Allowed")
			document.ApplicantSearch.applicationCost.value="";
			numberOfcount=0;
			temp=false;
			count=0;
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
		}
      if(temp==true)
      {
		  numberOfcount=numberOfcount+1;
	  }
	  if (numberOfcount==4)
	  {
		  alert("After Dot Two Digit Only Allowed");
		  code=0;
		  numberOfcount=0;
		  document.ApplicantSearch.applicationCost.value="";
		  temp=false;
		  count=0;
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
	  }		 
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
 		if (code==46||code<46||code>57)
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

function checkNumerickey(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);

if(code!=9 && code!=46 && code!=8 && code!=41 && code!=40 && code!=43 && code!=44 && code!=32 && code!=37 && code!=38 && code!=39 && code!=40)
{
if (code<45||code>57)
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

function checkAppNo()
{

	var appNo=document.ApplicantSearch.applicationNo.value;
	//alert(appNo);
	url = "../StudentPromotion/getAction.jsp?Action=getApplicationNo&appNo="+appNo+"&instituteid="+document.ApplicantSearch.req_instituteid.value;
	
	var req=null;

	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  req=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
	    {
	    req=new ActiveXObject("Msxml2.XMLHTTP");
	    }
	  catch (e)
	    {
	    req=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	  }
	  //alert(req)
	
			req.onreadystatechange = function()
			{
			//	alert(req.readyState)
				if (req.readyState == 4)
				   {
					//   alert(req.status)
				  		 if(req.status == 200)
						 {
		              			var parseXML=req.responseXML;
	
								var rootObj=parseXML.getElementsByTagName("checkNumber");
								var cNode_1=rootObj[0].childNodes.length;
								var username=null;
								var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
								//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
	
								if(finalValue=="1")
								{
									alert("This Application No. Already Exist")
									//document.ApplicantSearch.applicationNo.value="";
									document.ApplicantSearch.applicationNo.focus();
									return;	
								}
								else
								{
									Insert();
								}
						  }
					   	 else if (req.status == 204)
					     {
						 }
				   	}
		   };
		req.open("GET",url,true);
		req.send(null);
}

</script>
</head>
<body onload="document.ApplicantSearch.standardpublish.focus()">
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

    <h2><%=bundle.getString("label.applicationissueentry.rootpath")%></h2>
<form name="ApplicantSearch" action="" method="post">
						<%
							if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
						%>
						<table>		
						<tr>
							<td width='20%' valign=top class='tablebold'>Archival Details</td>
							<td width='1%' valign=top class='tablebold'>:</td>
							<td valign=top class='tablelight' width='79%'>
								<h2><%=bundle.getString("label.applicationissueentry.message")%></h2>
							</td>
						</tr>
						</table>
						<%		
							}
						%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
       
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.applicationissueentry.ApplicationIssue")%></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.applicationissueentry.MandatoryFields")%></th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     </tbody>
	<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.Application.ApplicationQuery"%>
     
	<%
	///ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_eng");
	
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	

	try{
	String req_sessionid = "";
	String req_sessionname  = "";
	String req_sessionstatus  = "";
	
	String req_boardid  = "";
	String req_boardname  = "";
	String instituteid	  = (String)session.getValue("instituteid");
	
	//if(request.getParameter("req_sessionid") != null)
		req_sessionid  = request.getParameter("req_sessionid");
		req_sessionstatus  = request.getParameter("req_sessionstatus");
		
		//out.print("session's sessionid --> "+session.getValue("sessionid"));
		//out.println(req_sessionid);

	//if(request.getParameter("req_sessionname") == null)
			req_sessionname  = request.getParameter("req_sessionname");
			req_boardid		 = request.getParameter("req_boardid");
			req_boardname	 = request.getParameter("req_boardname");

	%>

		<input type=hidden name="req_sessionname" value = "<%=req_sessionname %>">
		<input type=hidden name="req_sessionid" value = "<%=req_sessionid %>">
		<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">
		<input type=hidden name="req_boardname" value = "<%=req_boardname %>">
		<input type=hidden name="req_boardid" value = "<%=req_boardid %>">
		<input type=hidden name="req_instituteid" value = "<%=instituteid %>">

    		<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
								<%

								String temp=applicationQuery.receiptNo(req_sessionid,instituteid);
								//System.out.println("temp value ==>"+temp);
								//String recNo[]=null;
								 //recNo=temp.split("@");
								%>
									<tr align=left>
										<td class=tablebold ><%=bundle.getString("label.applicationissueentry.AcademicYear")%></td>
										<td class=tablebold width="2%">:</td>										
										<td class=tablelight>
										<%=req_sessionname %>
										</td>
									</tr>
									<tr align=left>
										<td class=tablebold ><%=bundle.getString("label.applicationissueentry.BoardName")%></td>
										<td class=tablebold width="2%">:</td>
										<td class=tablelight>
										<%=req_boardname%>
										</td>
									</tr>
									<% 
									if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("A"))
									{
									out.print("<tr class=tablebold align=left><td class=labelboldfont>"+bundle.getString("label.applicationissueentry.ReceiptNo")+"</td><td class=tablebold width='2%'>:</td><td>"+temp+"</td></tr>");	
									}
									%>

									<tr  align=left>
										<td class=tablebold> <%=bundle.getString("label.applicationissueentry.Standard")%> <font color=red>*</font></td>
										<td class=tablebold width="2%">:</td>
										<td>
										<select name=standardpublish validate='Standard' class=tablelight>

										<option value="00">- Select Standard - </option>
										<%
										ArrayList valueList = null;
										String req_type ="";
										valueList = applicationQuery.listYearofSessionStandard(req_sessionid,req_boardid);
									//System.out.println("valueList ==>"+valueList);
										
										if(valueList != null)
										{
											for(int i=0;i<valueList.size();i++)
											{
												HashMap map=(HashMap)valueList.get(i);
												//String coursecode=(String)map.get("coursecode");
												String standardscheduleid=(String)map.get("standardscheduleid");
												String standardid=(String)map.get("standardid");
												String standardname=(String)map.get("standardname");
												String groupid=(String)map.get("groupid");
												String sessionname=(String)map.get("sessionname");
												String groupname=(String)map.get("groupname");
												
												//String concat =
													if(!groupname.equals("NoGroup"))
													{												
														standardname = standardname+" - "+groupname; 
													}
												out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
											}
										}




											%>
										</select>
										</td>
									</tr>
									<% 
									if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("A"))
									{
									out.print("<tr class=tablebold align=left><td class=labelboldfont>"+bundle.getString("label.applicationissueentry.ApplicantName")+"<font color=red>*</font></td><td class=tablebold width='2%'>:</td><td><input type=text name=applicantName validate='"+bundle.getString("label.applicationissueentry.ApplicantName")+"' class=tablelight maxlength=30></td></tr>");	
									//out.print("<tr class=tablebold align=left><td class=labelboldfont>"+bundle.getString("label.applicationissueentry.ApplicationNo")+".<font color=red>*</font></td><td class=tablebold width='2%'>:</td><td><input type=text name=applicationNo validate='"+bundle.getString("label.applicationissueentry.ApplicationNo")+"' class=tablelight maxlength=30 ></td></tr>");
									//out.print("<tr class=tablebold align=left><td>Application Fee<font color=red>*</font></td><td><input type=text class=tablelight name=applicationCost validate='Application Fee' onkeypress='checkNumber(event)' maxlength=7> ["+bundle.getString("label.examschedule.rs")+"]</td></tr>");
									out.print("<tr class=tablebold align=left><td>"+bundle.getString("label.applicationissueentry.ApplicationFee")+"<font color=red>*</font></td><td class=tablebold width='2%'>:</td><td><input type=text class=tablelight name=applicationCost validate='"+bundle.getString("label.applicationissueentry.ApplicationFee")+"' onkeypress='checkNumber(event)' maxlength=7></td></tr>");
									out.print("<tr class=tablebold align=left><td>"+bundle.getString("label.applicationissueentry.PhoneNo")+".<font color=red>*</font></td><td class=tablebold width='2%'>:</td><td><input type=text class=tablelight name=contactno validate='"+bundle.getString("label.applicationissueentry.PhoneNo")+".' maxlength=20 onkeypress='checkNumerickey(event)'> </td></tr>");
									out.print("<tr class=tablebold align=left><td>"+bundle.getString("label.applicationissueentry.E-mail")+"</td><td class=tablebold width='2%'>:</td><td><input type=text class=tablelight name=emailid maxlength=30> </td></tr>");
									}
									%>



								</table></td></tr>

							</table>
							
							<input type="hidden" name="standardnamegp" value="">
							<input type="hidden" name="standardpublishid">
							


			<%
			}
			catch(Exception e){e.printStackTrace();
			}%>
   	
    
</form>

<a href="#" class="bt_red" onclick="back_fun()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.applicationissueentry.Back")%></strong><span class="bt_red_r"></span></a>
<a href="#" class="bt_blue" onclick="view_fun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationissueentry.ViewallApplicantsbasedonStandard")%></strong><span class="bt_blue_r"></span></a>
<% 
if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("A")){
%>
<!-- <a href="#" class="bt_green" onclick="checkAppNo()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.applicationissueentry.Issue")%></strong><span class="bt_green_r"></span></a> -->
<a href="#" class="bt_green" onclick="Insert()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.applicationissueentry.Issue")%></strong><span class="bt_green_r"></span></a>
<%} %>     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>