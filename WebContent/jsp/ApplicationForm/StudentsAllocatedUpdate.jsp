<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Allocation Update Process | Powered by i-Grandee</title>
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

function allocatefun()
{
		var test=false;
		if(document.approvalForm.section.value=="0")
		{
			alert("Select Section");
			document.approvalForm.section.focus();
			return
		}
		
		document.approvalForm.sectionSchedId.value =  document.approvalForm.section.value;
		
		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
				document.approvalForm.action="./allocationSubmit.jsp";
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
  			        test=true;
  			}

  		}
  		if(test==true )
		{
    	   	document.approvalForm.action="./allocationSubmit.jsp";
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

function goBack()
{
	document.approvalForm.action="StudentsAllocatedView.jsp";
	document.approvalForm.submit();
}

function updtAllocatefun()
{
		if(document.approvalForm.section.value=="0")
		{
			alert("Select Section");
			document.approvalForm.section.focus();
			return
		}
		else
		{
			if(confirm("Do you want to Update the Allocation Details..?"))
			{
				document.approvalForm.sectionSchedId.value =  document.approvalForm.section.value;
				document.approvalForm.action="./allocationUpdateSubmit.jsp";
	    	  	document.approvalForm.submit();
	     	}
		
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

    <h2>Enrollment / Student Enrollment / Allocation Update</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String candidateregisterid="";
		String dateofapproval=null;
		String allocationStatus=null;
		
		String standardpublishid="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("reg_sessiontext");
		String batchName=request.getParameter("reg_boardname");
		String courseName=request.getParameter("reg_coursename");
		//ArrayList registeredList= null;
		ArrayList sectionList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid);
		//sectionList		=	(ArrayList)registrationQuery.listSections(stdscheduleid);
		sectionList		=	(ArrayList)registrationQuery.listSections(request.getParameter("standardpublishid"));
		
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
	<td class=tablebold width="15%">Academic Year</td><td class=tablebold width='2%'>:</td><td align=left width="35%" colspan=2  class=tablelight><%=request.getParameter("req_sessionname") %></td>
	<td class=tablebold width="15%">Board</td><td class=tablebold width='2%'>:</td><td align=left width="35%" class=tablelight><%=request.getParameter("req_boardname") %></td>
</tr>
<tr>
	<td class=tablebold width="15%">Standard</td><td class=tablebold width='2%'>:</td><td align=left width="35%" colspan=2  class=tablelight><%=request.getParameter("standardnamegp") %></td>
	<td class=tablebold width="15%">Section</td><td class=tablebold width='2%'>:</td><td align=left width="35%" class=tablelight><%=request.getParameter("req_sectionname") %></td>
</tr>
</table>
</td><td></td></tr>
</table>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">Update Section </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <br>
	<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
	<td class=tablebold width="15%">Student Name</td><td class=tablebold width='2%'>:</td><td align=left width="35%" colspan=2  class=tablelight><%=request.getParameter("applicantname_hidden") %></td>
	<td class=tablebold width="15%">Application No</td><td class=tablebold width='2%'>:</td><td align=left width="35%"  colspan=2  class=tablelight><%=request.getParameter("applicationno_hidden") %></td>	
	<tr>
		<td class=tablebold width="15%">Roll No</td><td class=tablebold width='2%'>:</td><td align=left width="35%" colspan=2  class=tablelight><%=request.getParameter("rollno_hidden") %></td>
		<td align="left" class="tablebold" width="15%">Section</td>
		<td class=tablebold width='2%'>:</td>
		<td class="styleClass" width="35%">
		 <select name="section">
			<option value="0" >--Select Section--</option>
			<%
				//System.out.println("sectionList.size()"+sectionList.size()+"stdscheduleid-->"+stdscheduleid);
				if(sectionList.size()!=0)
				{
					HashMap map1=new HashMap();
					for(int i=0;i<sectionList.size();i++)
					{
						map1=(HashMap)sectionList.get(i);
						String sectionId=(String)map1.get("sectionid");
						String sectionSchedId=(String)map1.get("sectionscheduleid");
						String sectionName=(String)map1.get("sectionname");
						//out.println("<option value='"+sectionId+"'>"+sectionName+"</option>");
						if(sectionSchedId.equals(request.getParameter("req_sectionpubid")))
							out.println("<option selected value='"+sectionSchedId+"'>"+sectionName+"</option>");
						else 
							out.println("<option value='"+sectionSchedId+"'>"+sectionName+"</option>");
						
					}
				}
			%>
		</select>
	</td>
</tr>
</table>
</td><td></td></tr>
</table>

<br>
						</table></td><td></td></tr>

						</table>
						
<%
if(!request.getParameter("rollno_hidden").equals("<font color=red><i>-NYG-</i></font>"))
{
%>
<br>
<div class=warning_box>Roll No. generated for this Student.So yo cant Update.
</div>
<br><%
}
%>
						
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
		<%
	if(request.getParameter("rollno_hidden").equals("<font color=red><i>-NYG-</i></font>"))
	{
	%>
	
	<a href="#" class="bt_green" onclick="updtAllocatefun()"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
	<br><%
	}
	%>
	
	



<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId'>
<input type='hidden' name='studentallocationid' value='<%=request.getParameter("studentallocationid_hidden")%>'>

<input type='hidden' name='candidateregisterid' value='<%=candidateregisterid%>'>

	<input type=hidden name="req_sectionname" value = "<%=request.getParameter("req_sectionname")%>">
	<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>	
	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">








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