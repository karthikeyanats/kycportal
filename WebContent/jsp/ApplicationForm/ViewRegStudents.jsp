<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Approval Process | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />


<script type="text/javascript">

function xslfun()
{
	var cid=document.approvalForm.stdscheduleid.value();

		//window.open("RegistrationToday_xsl.jsp?reqsessionid="+document.approvalForm.reg_sessionids.value+"&regsessiontext="+document.approvalForm.reg_sessiontext.value);
}


var a=0;
function chkval1(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}

function chkval(obj)
{
	if(obj.checked){
		
		if(document.approvalForm.chk.length==undefined)
		{
		//a++;
		var checkedBox = 1;
		var availablestat = checkAvailability(checkedBox);
		if(!availablestat){
			alert("Selection Exceeds Total Seats");
			document.approvalForm.chk.checked = false;
		}
		}
		else
		{
			var checkedBox = 0;
			for(i=0;i<document.approvalForm.chk.length;i++)
			{
				if(document.approvalForm.chk[i].checked==true)
					checkedBox = checkedBox+1;				
			}

			var availablestat = checkAvailability(checkedBox);
			if(!availablestat){
				alert("Selection Exceeds Total Seats");
				var row = obj.value;
				row = row.split("@")[1];
				row = parseInt(row)-1;
				document.approvalForm.chk[row].checked = false;
			}			
		}
		
	}
	else
		a--;


}

function checkAvailability(a)
{
		var totalSeats = document.approvalForm.totalSeats.value;
		var allocatedSeats = document.approvalForm.allocatedSeats.value;
		var available = true;
		if(parseInt(totalSeats) < parseInt(allocatedSeats)+parseInt(a))
		{
			available = false;
		}
		
		return available;
		
}

function approvefun()
{
		var test=false;
		var totalSeats = document.approvalForm.totalSeats.value;
		var allocatedSeats = document.approvalForm.allocatedSeats.value;
		
		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
				if(parseInt(totalSeats) >= parseInt(allocatedSeats)+1)
				{
					if(confirm("Do you want to approve the Applicant(s)..?"))
					{
					document.approvalForm.action="./approvalsubmit.jsp";
	    	  		document.approvalForm.submit();
	    	  		}
    	  		}
    	  		else
    	  		{
    	  			var availSeats;
    	  			if(parseInt(totalSeats)-parseInt(allocatedSeats) < 0)
    	  				availSeats = 0;
    	  			else
    	  				availSeats = parseInt(totalSeats)-parseInt(allocatedSeats);

    	  			alert("Approval exceeds Total Seats"+ '\n\n' + "Total Seats:"+parseInt(totalSeats)+ '\n\n' + "Available Seats :"+availSeats+'\n\n' + "Allocated Seats :"+allocatedSeats);
    	  		}			
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
		var totAlltSeats = parseInt(allocatedSeats);
		
  		for(i=0;i<document.approvalForm.chk.length;i++)
  		{
  			if(document.approvalForm.chk[i].checked==true)
  			{
  			        test=true;
  			        totAlltSeats = totAlltSeats+1;
  			}

  		}
  		if(test==true )
		{
			if(parseInt(totalSeats) >= parseInt(totAlltSeats))
			{
					if(confirm("Do you want to approve the Applicant(s)..?"))
					{
		    	   	document.approvalForm.action="./approvalsubmit.jsp";
		    	  	document.approvalForm.submit();
		    	  	}    	  	
		    }
    	  	else
    	  	{
    	  			var availSeats;
    	  			if(parseInt(totalSeats)-parseInt(allocatedSeats) < 0)
    	  				availSeats = 0;
    	  			else
    	  				availSeats = parseInt(totalSeats)-parseInt(allocatedSeats);

    	  			alert("Approval exceeds Total Seats"+ '\n\n' + "Total Seats:"+parseInt(totalSeats)+ '\n\n' + "Available Seats :"+availSeats+'\n\n' + "Allocated Seats :"+allocatedSeats);
    	  	}		


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
		var availablestat = checkAvailability(1);
		if(!availablestat){
				alert("Selection Exceeds Total Seats");
		}
		else{
			document.approvalForm.chk.checked=true;
		}
	}
	else
	{
		var alertcount = 1;
		for(var x=0;x<document.approvalForm.chk.length;x++)
		{
			var availablestat = checkAvailability(x+1);
			if(availablestat){
					document.approvalForm.chk[x].checked=true;
			}
			else{				
					document.approvalForm.chk[x].checked=false;
					if(alertcount==1)
						alert("Selection Exceeds Total Seats");
						alertcount = alertcount + 1;
					//break;				
			}		
			
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

function goBack()
{
	document.approvalForm.action="StudentApproval.jsp";
	document.approvalForm.submit();
}


function Approve1()
{
	document.approvalForm.user_mode.value = "insert";
	document.approvalForm.action="applicantsubmit.jsp";
	document.approvalForm.submit();

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

    <h2>Enrollment / Student Enrollment / Approval</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String regId="";
		String dateofregistration=null;
		String approvalStatus=null;
		
		String standardpublishid="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("reg_sessiontext");
		String batchName=request.getParameter("reg_boardname");
		String courseName=request.getParameter("reg_coursename");
		ArrayList registeredList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		registeredList=(ArrayList)registrationQuery.displayAdmisionssDetails(sessionid,stdscheduleid);
		int totalSeats = 0;
		int allocatedSeats = 0;
		int availableSeats = 0;
		int checkCount = 0;
		if(registeredList.size()!=0)
		{
			
			for(int i=0;i<registeredList.size();i++)
			{
				//count=count+1;
				HashMap map			=	(HashMap)registeredList.get(i);
				if(i==0){
					totalSeats 		= 	Integer.parseInt(map.get("totalseats")+"");
					allocatedSeats 	= 	Integer.parseInt(map.get("promotedseats")+"") + Integer.parseInt(map.get("approvedseats")+"");
					availableSeats  =   totalSeats - allocatedSeats;
					if(availableSeats < 0)
						availableSeats = 0;
				}			
				approvalStatus		=	(String) map.get("approvalstatus");
				//out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+dateofregistration+"</td>");
				if(approvalStatus.equals("NotApproved"))
				{
					checkCount++;
				}
			}
			out.print("<br>");

		}		
       %>

			<br>

<tr><td colspan=2><table border=0  width="100%">
<tr>
	<td class=tablebold width="25%">&nbsp;&nbsp;&nbsp;&nbsp; Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=courseName %></td>
</tr>
<tr>
	<td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; Board </td><td class=tablebold width='2%'>:</td><td  class=tablelight><%=batchName %></td>
	<td class=tablebold>Total Seats </td><td class=tablebold width='2%'>:</td><td  class=tablelight><%=totalSeats%></td>

</tr>
<tr>
	<td class=tablebold>&nbsp;&nbsp;&nbsp;&nbsp; Approved Seats</td><td class=tablebold width='2%'>:</td><td  class=tablelight><%=allocatedSeats %></td>
	<td class=tablebold>Available Seats </td><td class=tablebold width='2%'>:</td><td  class=tablelight><%=availableSeats%></td>

</tr>
</table>
</td></tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 


	if(registeredList.size()!=0)
	{
		out.print("<br>");
		if(checkCount>0)
		{		
%>
<table border=0 cellpadding=3 cellspacing=0 width="100%" align=center>
	<tr><td align=right>
	<a href="javascript:void(0)" onclick=selectallfun() class=tablebold>Select All</a> &nbsp;
	<a href="javascript:void(0)" onclick=deselectallfun() class=tablebold>Deselect All</a>

	</td></tr>
</table>
<% 
	}
	}
	else
	{
		out.print("<br>");
	}
%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="25%">Applicant Name</th>
            <th scope="col" class="rounded" width="35%">Application No.</th>
            <th scope="col" class="rounded" width="25%">Date of Admission</th>
            <th scope="col" class="rounded-q4" width="15%">Check</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
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
			//count=count+1;
			HashMap map			=	(HashMap)registeredList.get(i);
			applicantName		=	(String) map.get("applicantname");
			applicationNo		=	(String) map.get("applicationno");
			regId				=	(String) map.get("regId");
			standardpublishid	=	(String) map.get("standardpublishid");
			dateofregistration 	=	(String) map.get("dateofregistration");
			approvalStatus		=	(String) map.get("approvalstatus");
			//out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+dateofregistration+"</td>");
			if(approvalStatus.equals("Approved"))
			{
				//out.print("<td align='left'><input type='checkbox' disabled></td></tr>");
			}
			else
			{
				count=count+1;
				flag = true;
				out.print("<tr><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+dateofregistration+"</td>");
				out.println("<td align='left'><input type='checkbox' name='chk' value="+regId+"@"+count+" onclick=chkval(this)></td></tr>");
			}

		}
		
	}
	if(count==0)
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>
						</table></td><td></td></tr>

						</table>
<%
//out.print("registeredList.size()-->"+registeredList.size());
 if(registeredList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<%
		
			if(flag == true){
		%>
		    <!--  <input type="button" name=aapp value="Approve" class="buttons" onclick="approvefun()">-->		    
		    <a href="#" class="bt_green" onclick="approvefun()"><span class="bt_green_lft"></span><strong>Approve</strong><span class="bt_green_r"></span></a>
		   <%
			}
		   %>

			
		</td>
		</tr>
	</table>

<%
}
 else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>


<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='registrationid' value='<%=regId%>'>
<input type='hidden' name='totalSeats' value='<%=totalSeats%>'>
<input type='hidden' name='allocatedSeats' value='<%=allocatedSeats%>'>






  	</td>
 						</table></td><td></td></tr>

						</table>

	<!-- <a href="#" class="bt_green" onclick="navAction()"><span class="bt_green_lft"></span><strong>Admit</strong><span class="bt_green_r"></span></a> 
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>-->
     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>