<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TC Generation View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language="JavaScript" src="../../js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function generateRollNofun()
{
		var test=false;
	
		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
			  	if(document.approvalForm.rollno.value=="")
  				{
  					alert("Enter Roll No for selected Check Box");
  					document.approvalForm.rollno.focus();
  					return;  				
  				}
				document.approvalForm.action="./generateRollNoSubmit.jsp";
    	  		document.approvalForm.submit();
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
  		for(i=0;i<document.approvalForm.chk.length;i++)
  		{
  			if(document.approvalForm.chk[i].checked==true)
  			{
  				if(document.approvalForm.rollno[i].value=="")
  				{
  					alert("Enter Roll No for selected Check Box");
  					document.approvalForm.rollno[i].focus();
  					return;  				
  				}
  				else
  				{
  			        test=true;
  			    }
  			}

  		}
  		if(test==true )
		{
    	   	document.approvalForm.action="./generateRollNoSubmit.jsp";
    	  	document.approvalForm.submit();

        }
        else
        {
			alert("Select CheckBox")
		}
	}

}
function selectallfun()
{

	if(document.approvalForm.chk.length == null)
	{
		document.approvalForm.chk.checked=true;
	}
	else
	{
		for(var x=0;x<document.approvalForm.chk.length;x++)
		{
			document.approvalForm.chk[x].checked=true;
		}

	}
}
function deselectallfun()
{
	if(document.approvalForm.chk.length == null)
	{
		document.approvalForm.chk.checked=false;
	}
	else
	{
		for(var x=0;x<document.approvalForm.chk.length;x++)
		{
			document.approvalForm.chk[x].checked=false;
		}

	}
}

function checkRollNo()
{

		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
				var rollNo=document.approvalForm.rollno.value;
					url = "../StudentPromotion/getAction.jsp?Action=getRollNo&rollNo="+rollNo;
	
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
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
				
											if(finalValue=="1")
											{
												alert("This Roll No. Already Exist")
												document.approvalForm.rollno.value="";
												document.approvalForm.rollno.focus();
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
		}
		else
		{
  		for(i=0;i<document.approvalForm.rollno.length;i++)
  		{
  		alert("i-->"+i);
  			//if(document.approvalForm.chk[i].checked==true)
  			//{
  				var rollNo=document.approvalForm.rollno[i].value;
  				alert("rollNo-->"+rollNo)
					url = "../StudentPromotion/getAction.jsp?Action=getRollNo&rollNo="+rollNo;
	
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
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
				
											if(finalValue=="1")
											{
												alert("This Roll No. Already Exist")
												document.approvalForm.rollno.value="";
												document.approvalForm.rollno[i].focus();
												return false;	
											}

									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);
			
   		//}
   		}
   		}
}

function goBack()
{
	document.approvalForm.action="TCGenerateView.jsp";
	document.approvalForm.submit();
}

function tcIssueFun()
{
		
		if(check_ForParticularElements(document.approvalForm.tcIssueDate,"text",document.approvalForm.Reason,"text"))
		{
			if(confirm("Do you want to Issue TC for this Student..?"))
			{
			document.approvalForm.action="tcGenerateSubmit.jsp";
			document.approvalForm.submit();
			}
		}
		else
		{
			return false;
		}
		

		
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<jsp:useBean id="date_object" scope="page" class="com.iGrandee.Common.DateTime"/>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="approvalForm" action="" method="post">
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

    <h2>Certificate / Transfer Certificate View</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
            <th scope="col" class="rounded-company" width="80%">Student Information </th>
            <th scope="col" class="rounded-q4" width="20%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 	//com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String tcgenerationStatus=null;
		
		String rollNo="";
		String date_str = date_object.showTime("WithTime");
		//String sessionid=request.getParameter("req_sessionid");
 		//String boardid=request.getParameter("req_boardid");

		//ArrayList registeredList= null;
		//registeredList	=	(ArrayList)tcgenerationQuery.displayTCIssueDetails(request.getParameter("req_sectionpubid"));
       %>

			<br>

<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablebold>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
	<td class=tablebold>Board </td><td class=tablebold>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
<td class=tablebold width="25%">Section</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("req_sectionname")%></td>
</tr>
<tr><td class=tablebold width="25%">Student Name</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("applicantname_hidden") %></td>
<td class=tablebold width="25%">Roll No</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("rollno_hidden")%></td>
</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
            <th scope="col" class="rounded-company" width="80%">TC Issue </th>
            <th scope="col" class="rounded-q4" width="20%"> <font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Date<font color=red>*</font></td><td class=tablebold>:</td><td class=tablelight ><input type=text class='tablelight' name='tcIssueDate' validate='Issue Date' onkeypress='this.blur();'><input type=button class=buttons value='^' onclick=Calendar_Fun('../../js/Calendar/CalendarWindow.html','approvalForm.tcIssueDate','0',event,'Not_Less_Than_Todaydate',document.approvalForm.server_date);></td>
</tr>
<!--  <tr><td class=tablebold width="25">Reason</td>
				<td><textarea validate="Description" class=tablelight cols=50
					rows=2 name="Reason" onkeydown="textCounter(document.approvalForm.Reason,document.approvalForm.remLen2,500)" onkeyup="textCounter(document.approvalForm.Reason,document.approvalForm.remLen2,500)"></textarea>&nbsp; <br><br><input readonly class='tablelight' type="text" name="remLen2" size="3" maxlength="3" value="500"></td>
</tr>-->
<tr>
	<td class=tablebold width="25">Reason<font color=red>*</font></td>
	<td class=tablebold>:</td><td><textarea name='Reason' rows='2' cols='50' validate='Description' onkeypress="calculateRemaining(this,500,'remaining')" onkeyup="calculateRemaining(this,500,'remaining')"></textarea><br><span id='remaining'><font color='red'>500 characters remaining</font></span></td>
</tr>
</table>
</td></tr>
</table>

<br>

<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="tcIssueFun()"><span class="bt_green_lft"></span><strong>Issue</strong><span class="bt_green_r"></span></a>


<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>

<input type='hidden' name='studentallocationid_hidden' value='<%=request.getParameter("studentallocationid_hidden")%>'>
<input type='hidden' name='rollno_hidden'>
<input type='hidden' name='applicantname_hidden'>
<input type=hidden name='server_date' value='<%=date_str%>'>






   

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>