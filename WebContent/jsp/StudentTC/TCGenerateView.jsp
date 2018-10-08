<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
java.util.ResourceBundle bundle1  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TC Generation View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">

var a=0;
function chkval(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}
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
	document.approvalForm.action="TCGenSelect.jsp";
	document.approvalForm.submit();
}

function tcIssueFun(obj)
{
		if(confirm("Do you want to Issue the TC for this Student...?"))
		{
			//alert(obj.getAttribute("rollno"));
			document.approvalForm.studentallocationid_hidden.value = obj.getAttribute("studentallocationid");
			document.approvalForm.rollno_hidden.value = obj.getAttribute("rollno");
			document.approvalForm.applicantname_hidden.value = obj.getAttribute("applicantname");
			
			//alert(document.approvalForm.statuschange.value)
			document.approvalForm.action= "TCGenerate.jsp";
			document.approvalForm.submit();
		}
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
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

    <h2>Certificate / Transfer Certificate / Transfer Certificate Issue</h2>


<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="80%"><%=bundle1.getString("label.applicationissueview.SelectedInformation") %> </th>
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
	 com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String tcgenerationDate=null;
		String reason = "-";
		
		String rollNo="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		//String yearofsession=request.getParameter("req_sessionname");
		//String batchName=request.getParameter("req_boardname");
		//String courseName=request.getParameter("standardnamegp");
		//String secName=request.getParameter("req_sectionname");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList registeredList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		registeredList	=	(ArrayList)tcgenerationQuery.displayTCIssueDetails(request.getParameter("req_sectionpubid"));
       %>

			<br>

<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold><%=bundle1.getString("label.applicationissueview.AcademicYear") %></td>
	<td class=tablebold>:</td>
	<td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
	<td class=tablebold><%=bundle1.getString("label.applicationissueview.Board") %> </td>
	<td class=tablebold>:</td>
	<td class=tablelight><%=request.getParameter("req_boardname") %></td>
</tr>
<tr><td class=tablebold><%=bundle1.getString("label.applicationissueview.Standard") %></td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
<td class=tablebold ><%=bundle1.getString("label.profileview.Section") %></td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("req_sectionname")%></td>
</tr>
</table>
</td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
		out.print("<br>");
%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"><%=bundle1.getString("label.registeredstudentlist.SL.No") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle1.getString("label.registeredstudentlist.ApplicantName") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle1.getString("label.registeredstudentlist.ApplicationNo") %></th>
            <th scope="col" class="rounded" width="8%"><%=bundle1.getString("label.exammark.RollNo") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle1.getString("label.certificate.tcstatus") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle1.getString("label.certificate.reason") %></th>
            <th scope="col" class="rounded-q4" width="11%"><%=bundle1.getString("label.certificate.IssuedDate") %></th>                       
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
  


	<%
	 int count=0;
	boolean flag = false;
	//out.print("registeredList-->"+registeredList.size());
	if(registeredList.size()!=0)
	{
		for(int i=0;i<registeredList.size();i++)
		{
			count=count+1;
			HashMap map				=	(HashMap)registeredList.get(i);
			applicantName			=	(String) map.get("applicantname");
			String firstname			=	(String) map.get("firstname");
			String middlename			=	(String) map.get("middlename");
			String lastname			=	(String) map.get("lastname");
			
			applicationNo			=	(String) map.get("applicationno");
			studentallocationid		=	(String) map.get("studentallocationid");
			rollNo					=	(String) map.get("rollno");
			dateofallocation 		=	(String) map.get("dateofallocation");
			tcgenerationDate		=	(String) map.get("tcgenerationdate");
			reason					=	(String) map.get("reason");
			
			 if(middlename==null || middlename.equals("") || middlename.equals("-")){
				 middlename="";
			 }
			 else
			 {
				 middlename=" "+middlename;
			 }
			 
			 if(lastname==null || lastname.equals("") || lastname.equals("-")){
				 lastname="";
		}
		 else
		 {
			 lastname=" "+lastname;
		 }
			 
			 
			 applicantName = firstname+middlename+lastname;
			
			if(rollNo==null)
				rollNo = "-";
			if(reason==null)
				reason = "-";
			//if(rollNo!="-")
			{
			out.print("<tr><td valign=top>"+(i+1)+"</td><td valign=top>"+applicantName+"</td><td valign=top>"+applicationNo+"</td><td valign=top>"+rollNo+"</td>");
			
			if(tcgenerationDate.equals("NotGenerated"))
				out.print("<td valign=top><a href='#'  applicantname='"+applicantName+"' applicationno='"+applicationNo+"' studentallocationid='"+studentallocationid+"' rollno="+rollNo+" onclick='tcIssueFun(this)' class='ask'><font color=blue>Issue</font></a></td><td valign=top>-</td><td valign=top>-</td></tr>");
			else
				out.print("<td valign=top><font color=green>Issued</font></td><td valign=top>"+reason+"</td><td valign=top>"+tcgenerationDate+"</td></tr>");
			}			
			//out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
</table>
</table>
<br>


<%
//out.print("registeredList.size()-->"+registeredList.size());
 if(registeredList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<!-- <a href="#" class="bt_green" onclick="generateRollNofun()"><span class="bt_green_lft"></span><strong>Generate Roll No</strong><span class="bt_green_r"></span></a> -->
		<%
		
			//if(flag == true){
		%>
		    <!--  <input type="button" name=aapp value="Approve" class="buttons" onclick="approvefun()">	    
		    <a href="#" class="bt_green" onclick="allocatefun()"><span class="bt_green_lft"></span><strong>Allocate</strong><span class="bt_green_r"></span></a>-->	
		   <%
			//}
		   %>

			

<%
}
 else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.department.back") %></strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>


<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>

<input type='hidden' name='studentallocationid_hidden'>
<input type='hidden' name='rollno_hidden'>
<input type='hidden' name='applicantname_hidden'>








	
     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>