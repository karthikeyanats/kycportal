<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionupdate.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function back_fun()
{
	document.ApplicantSearch.action="./RegistrationView.jsp";
	document.ApplicantSearch.submit();
}
function Update()
{
	if(document.ApplicantSearch.admissionfee.value=="")
	{
		alert("Application Fee should not be empty")
		document.ApplicantSearch.admissionfee.focus();
	}
	else if(document.ApplicantSearch.admissionfee.value!="")
	{
         var field=document.ApplicantSearch.admissionfee.value;
         var flag=true;
		 var num=parseInt(field.length);
		 if(num==0 )
		   {
			   alert("Admission Fee should not be empty");
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
					   flag= false;
					   break;

					   }
				  }

			  }

			  if(flag==true)
			  {
			  	if(confirm("Do you want to Update the Admission Fee..?"))
			  	{	
			  	//checkAppNo(); 
				document.ApplicantSearch.action="registrationUpdateSubmit.jsp";
				document.ApplicantSearch.submit();
				}
			  }
	}
	else
	{

	}
}

var count=0;
var temp=false;
var numberOfcount=0;

function checkNumber(e) {


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
	 	if(code == 8)
	 	{
			return false;
	 	}
 		if (code==47||code<46||code>57)
 		{
				code=0;
				alert("Enter A Number only")

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
			document.ApplicantSearch.admissionfee.value="";
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
		  document.ApplicantSearch.admissionfee.value="";
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

function numberChecking()
{
 		if (event.keyCode==47||event.keyCode<46||event.keyCode>57)
 		{
				event.keyCode=0;
				alert("Enter A Number only")
		}
		if(event.keyCode==46)
		{
		 count=count+1;
		 temp=true;
		}
		if(count>1)
		{
			event.keyCode=0;
			alert("Only One Dot Allowed")
			document.ApplicantSearch.admissionfee.value="";
			numberOfcount=0;
			temp=false;
			count=0;
		}
      if(temp==true)
      {
		  numberOfcount=numberOfcount+1;
	  }
	  if (numberOfcount==4)
	  {
		  alert("After Dot Two Digit Only Allowed");
		  event.keyCode=0;
		  numberOfcount=0;
		  document.ApplicantSearch.admissionfee.value="";
		  temp=false;
		  count=0;
	  }
}

function checkAppNo()
{

	var appNo=document.ApplicantSearch.applicationNo.value;
	//alert(appNo);
	url = "../StudentPromotion/getAction.jsp?Action=getApplicationNo&appNo="+appNo;
	
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
									document.ApplicantSearch.applicantName.focus();
									return;	
								}
								else
								{
	
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
<body>
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

    <h2><%=bundle.getString("label.admisionupdate.rootpath")%></h2>
<form name="ApplicantSearch" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="85%"><%=bundle.getString("label.admisionupdate.AdmissionFeeUpdate")%></th>
        	<th scope="col" class="rounded-q4" width="15%" ><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     </tbody>
	<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>
     
	<%
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	

	try{
	String req_sessionid = "";
	String req_sessionname  = "";
	String req_boardid  = "";
	String req_boardname  = "";
	String instituteid = (String)session.getValue("instituteid");
	
	
	//if(request.getParameter("req_sessionid") != null)
		req_sessionid  = request.getParameter("req_sessionid");
		//out.println(req_sessionid);

	//if(request.getParameter("req_sessionname") == null)
			req_sessionname  = request.getParameter("req_sessionname");
			req_boardid		 = request.getParameter("req_boardid");
			req_boardname	 = request.getParameter("req_boardname");

	%>

		<input type=hidden name="req_sessionname" value = "<%=req_sessionname %>">
		<input type=hidden name="req_sessionid" value = "<%=req_sessionid %>">
		<input type=hidden name="req_boardname" value = "<%=req_boardname %>">
		<input type=hidden name="req_boardid" value = "<%=req_boardid %>">

    		<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
								<%

								String temp=applicationQuery.receiptNo(req_sessionid,instituteid);
								//System.out.println("temp value ==>"+temp);
								//String recNo[]=null;
								 //recNo=temp.split("@");
								%>
									<tr align=left>
										<td class=tablebold ><%=bundle.getString("label.admisionupdate.AcademicYear")%></td>
										<td class=tablebold>:</td>
										
										<td class=tablelight>
										<%=req_sessionname %>
										</td>
									</tr>
									<tr align=left>
										<td class=tablebold ><%=bundle.getString("label.admisionupdate.StandardName")%></td>
										<td class=tablebold>:</td>
										<td class=tablelight>
										<%=request.getParameter("standardnamegp")%>
										</td>
									</tr>
									<tr align=left>
										<td class=tablebold ><%=bundle.getString("label.admisionupdate.Board-Medium")%></td>
										<td class=tablebold>:</td>
										<td class=tablelight>
										<%=req_boardname%>
										</td>
									</tr>									
									<tr align=left>
										<td class="tablebold" ><%=bundle.getString("label.admisionupdate.ApplicationNo")%>.</td>
										<td class=tablebold>:</td>
										<td><%=request.getParameter("applicationno_hidden")%></td>
									</tr>
									<tr align=left>
										<td class="tablebold" ><%=bundle.getString("label.admisionupdate.ReceiptNo")%>.</td>
										<td class=tablebold>:</td>
										<td><%=request.getParameter("receiptno_hidden")%></td>
									</tr>
									
									<tr align=left>
										<td class="tablebold"><%=bundle.getString("label.admisionupdate.ApplicantName")%></td>
										    <td class=tablebold>:</td>
										<td><%=request.getParameter("applicantname_hidden")%></td>
									</tr>

									<tr class="tablebold" align=left>
										<td><%=bundle.getString("label.admisionupdate.AdmissionFee")%><font color=red>*</font></td>
										<td class=tablebold>:</td>
										<td><input type="text" class=tablelight name="admissionfee" onkeypress="checkNumber(event)" maxlength="7" value="<%=request.getParameter("regamount_hidden")%>"></td>
									</tr>

								</table></td></tr>

							</table>
							
							<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
							<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpubid_hidden")%>">
							<input type="hidden" name="registrationid" value="<%=request.getParameter("registrationid_hidden")%>">
							<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">


			<%
			}
			catch(Exception e){e.printStackTrace();
			}%>
   	
    
</form>

		<%
		if(!request.getParameter("approvestatus").equals("InActive"))
		{
		%>
		<br>
		<div class=warning_box>Student Already Approved. so you can't Update.
		</div>
		<br><%
		}
		%>

<a href="#" class="bt_blue" onclick="back_fun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionupdate.Back")%></strong><span class="bt_blue_r"></span></a>

	<%
	if(request.getParameter("approvestatus").equals("InActive"))
	{
	%>
<a href="#" class="bt_green" onclick="Update()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisionupdate.Update")%></strong><span class="bt_green_r"></span></a>
     <% 
	}
     %>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>