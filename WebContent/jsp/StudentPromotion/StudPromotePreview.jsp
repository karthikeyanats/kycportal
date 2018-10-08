<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Promotion | Powered by i-Grandee</title>
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
	
function promoFun()
{
		//alert("promoFun");
		var test=false;
		
		if(document.approvalForm.promoResult.value == "Pass")
		{
			var confirmResult = "Promote";
		}
		if(document.approvalForm.promoResult.value == "Fail")
		{
			var confirmResult = "DePromote";
		}
		
		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
				if(confirm("Do you want to "+confirmResult+" the Selected Student(s)..?"))
				{
				document.approvalForm.action="./promotionSubmit.jsp";
    	  		document.approvalForm.submit();
    	  		}
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
				if(confirm("Do you want to "+confirmResult+" the Selected Student(s)..?"))
				{
    	   		document.approvalForm.action="./promotionSubmit.jsp";
    	  		document.approvalForm.submit();
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
	document.approvalForm.action="StudPromoSelect.jsp";
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

    <h2>Enrollment / Student Enrollment / Student Promotion Preview</h2>


<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%">Selected Information for Student Promotion</th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 	com.iGrandee.Promotion.PromotionQuery  promotionQuery = new com.iGrandee.Promotion.PromotionQuery();
		com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();	

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		String candidateregisterId="";
		
		String rollNo="";
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("stdscheduleid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String secSchedId=request.getParameter("sectionSchedId");
 		String promoYrofSession=request.getParameter("promoSessionName");
		String promoBrdName=request.getParameter("promoBoardName");
		String promoStdName=request.getParameter("promoStandardName");
		String promoStdSchedId=request.getParameter("promoStandardSchedId");
		String promoResult=request.getParameter("promoResult");
		
		
		
		String promoSecName=request.getParameter("promoSectionName");
		//String promoSecSchedId=request.getParameter("sectionSchedId");
		//out.println("sessionid-->"+sessionid+"boardid-->"+boardid+"stdscheduleid-->"+stdscheduleid);
		//out.println("secSchedId-->"+secSchedId+"promoSecSchedId-->"+promoSecSchedId);
		ArrayList registeredList= null;
		//ArrayList sectionList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		registeredList	=	(ArrayList)promotionQuery.displayToPromoteDetails(secSchedId);
		//out.println("<script>alert('"+registeredList+"')</script>");
		//sectionList		=	(ArrayList)registrationQuery.listSections(stdscheduleid);
	    String instituteid = null;
	    ArrayList BoardList = null;
	    try
	    {
	    	instituteid = (String)session.getValue("instituteid");
	    	BoardList = standardQuery.listBoard(instituteid);
	    }catch(Exception e){}
		ArrayList yearList = registrationQuery.listYearofSessiontoPromote(sessionid);
		ArrayList standardList = registrationQuery.listStandard(sessionid,boardid);
       %>

			<br>

<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablelight ><%=promoYrofSession %></td>
	<td class=tablebold>Board </td><td  colspan=2  class=tablelight><%=promoBrdName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablelight><%=promoStdName%></td>
<!--  <td class=tablebold width="25%">Section</td><td class=tablelight><%=promoSecName%></td>-->
</tr>
</table>
</td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
	if(registeredList.size()!=0)
	{
		out.print("<br>");
%>
<table border=0 cellpadding=3 cellspacing=0 width="100%" align=center>
	<tr><td align=right>
	<a href="javascript:void(0)" onclick=selectallfun() class=tablebold>Select All</a> &nbsp;
	<a href="javascript:void(0)" onclick=deselectallfun() class=tablebold>Deselect All</a>

	</td></tr>
</table>
<% 
	}
	else
	{
		out.print("<br>");
	}
%>
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="20%">Applicant Name</th>
            <th scope="col" class="rounded" width="15%">Application No.</th>
            <th scope="col" class="rounded" width="20%">Roll No.</th>
            <th scope="col" class="rounded" width="25%">Date of Allocation</th>
            <th scope="col" class="rounded-q4" width="15%">Check</th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
  


	<%

	 int count=0;
	int position;
	boolean flag = false;
	//out.print("registeredList-->"+registeredList.size());
	String[] chkBoxId=null;
	String[] chkBoxIdSplit=null;
	chkBoxId= request.getParameterValues("chk");
	if(registeredList.size()!=0)
	{
	 if(chkBoxId != null && chkBoxId.length>0)
	 {
			for(int j=0;j<chkBoxId.length;j++){
				//String[] var=null;
				chkBoxIdSplit=chkBoxId[j].split("@");
				position = Integer.parseInt(chkBoxIdSplit[1]);


		//for(int i=0;i<registeredList.size();i++)
		{
			count=count+1;
			HashMap map				=	(HashMap)registeredList.get(position-1);
			applicantName			=	(String) map.get("applicantname");
			applicationNo			=	(String) map.get("applicationno");
			studentallocationid		=	(String) map.get("studentallocationid");
			candidateregisterId		=	(String) map.get("candidateregisterid");			
			rollNo					=	(String) map.get("rollno");
			dateofallocation 		=	(String) map.get("dateofallocation");
			rollgenerationStatus	=	(String) map.get("rollgenerationstatus");
			
			if(rollNo==null)
				rollNo = "-";

			out.print("<tr><td>"+(j+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+dateofallocation+"</td>");
			out.println("<td align='left'><input type='checkbox' checked name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
			//if(rollgenerationStatus.equals("NotAllocated"))
			//{
				//flag = true;
				//out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
				
			//}
			//else
			//{				
				////out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
				//out.print("<td align='left'><input type='checkbox' disabled></td></tr>");
			//}

		}
	}
			}
	 }
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
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
<%
		//out.println("RESULT"+request.getParameter("promoResult"));
		if(promoResult.equals("Pass"))
		{
%>		
		<a href="#" class="bt_green" onclick="promoFun()"><span class="bt_green_lft"></span><strong>Promote</strong><span class="bt_green_r"></span></a>
<% 
		}else{
%>
		<a href="#" class="bt_red" onclick="promoFun()"><span class="bt_red_lft"></span><strong>DePromote</strong><span class="bt_red_r"></span></a>
		<%
		}
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
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>

	<%
	}
	%>

		<input type=hidden name=req_sessionid>
		<input type=hidden name=req_boardid>
<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>

<input type='hidden' name='promoStdSchedId' value='<%=promoStdSchedId%>'>
<input type='hidden' name='promoResult' value='<%=promoResult%>'>


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