<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.exam.markentrytitle_1") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

	var a=0;
function chkval(obj)
{
//alert("obj>>"+obj.value);
	if(obj.checked)
		a++;
	else
		a--;

}
function submitFun()
{
		var test=false;
	
		if(document.ExammarkEntrySubmitForm.chk.length==undefined)
		{
			if(document.ExammarkEntrySubmitForm.chk.checked==true)
			{
			  	if(document.ExammarkEntrySubmitForm.marktaken.value=="")
  				{
  					alert("Enter the Mark for selected Check Box");
  					document.ExammarkEntrySubmitForm.marktaken.focus();
  					return;  				
  				}
  				else if(document.ExammarkEntrySubmitForm.marktaken.value!="A")
  				{
  					if(isNaN(document.ExammarkEntrySubmitForm.marktaken.value))
  					{
  						alert("Invalid Mark Entry");
  						document.ExammarkEntrySubmitForm.marktaken.focus();
  						return;
  					}  				
  				}  	  				
  				
  				if(parseInt(document.ExammarkEntrySubmitForm.marktaken.value)>parseInt(document.ExammarkEntrySubmitForm.req_theoryexternalmax.value))
				{ 
				 alert("You cant enter Marks greater than Maximum marks");
				 document.ExammarkEntrySubmitForm.marktaken.focus();
				 return;
				}
					if(document.ExammarkEntrySubmitForm.staffremarks.value=="")
						document.ExammarkEntrySubmitForm.staffremarks.value = "-";

					if(document.ExammarkEntrySubmitForm.comboremarks.value=="00")
					{
						alert("Select Status")
						document.ExammarkEntrySubmitForm.comboremarks.focus();
						return;
					}	
											
					//if(document.ExammarkEntrySubmitForm.comboremarks.value=="00")
						//document.ExammarkEntrySubmitForm.comboremarks.value = "-";	
									
				if(confirm("Do you want to submit the Marks..?"))
				{
					if(document.ExammarkEntrySubmitForm.staffremarks.value=="")
						document.ExammarkEntrySubmitForm.staffremarks.value = "-";
						
					//if(document.ExammarkEntrySubmitForm.comboremarks.value=="00")
						//document.ExammarkEntrySubmitForm.comboremarks.value = "-";
						  				
					document.ExammarkEntrySubmitForm.action="./markEntryStaffSubmit.jsp";
	    	  		document.ExammarkEntrySubmitForm.submit();
	    	  	}
	    	  	else
	    	  	{
					if(document.ExammarkEntrySubmitForm.staffremarks.value=="-")
					document.ExammarkEntrySubmitForm.staffremarks.value = "";
	    	  	
	    	  	//document.ExammarkEntrySubmitForm.comboremarks.value = "00";
	    	  	}
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
  		for(i=0;i<document.ExammarkEntrySubmitForm.chk.length;i++)
  		{
  			if(document.ExammarkEntrySubmitForm.chk[i].checked==true)
  			{
  				if(document.ExammarkEntrySubmitForm.marktaken[i].value=="")
  				{
  					alert("Enter the Mark for selected Check Box");
  					document.ExammarkEntrySubmitForm.marktaken[i].focus();
  					return;  				
  				}
  				else if(document.ExammarkEntrySubmitForm.marktaken[i].value!="A")
  				{
  					if(isNaN(document.ExammarkEntrySubmitForm.marktaken[i].value))
  					{
  						alert("Invalid Mark Entry");
  						document.ExammarkEntrySubmitForm.marktaken[i].focus();
  						return;
  					}  				
  				}  	  				
  				if(parseInt(document.ExammarkEntrySubmitForm.marktaken[i].value)>parseInt(document.ExammarkEntrySubmitForm.req_theoryexternalmax.value))
				{ 
				 alert("You cant enter Marks greater than Maximum marks");
				 document.ExammarkEntrySubmitForm.marktaken[i].focus();
				 return;
				}
				
  				else
  				{
					if(document.ExammarkEntrySubmitForm.staffremarks[i].value=="")
						document.ExammarkEntrySubmitForm.staffremarks[i].value = "-";
						
					if(document.ExammarkEntrySubmitForm.comboremarks[i].value=="00")
					{
						alert("Select Status")
						document.ExammarkEntrySubmitForm.comboremarks[i].focus();
						test=false;
						return;
					}
						  				
  			        test=true;
  			    }
  			}

  		}
  		if(test==true )
		{
			if(confirm("Do you want to enter the Marks..?"))
			{
	    	   	document.ExammarkEntrySubmitForm.action="./markEntryStaffSubmit.jsp";
	    	  	document.ExammarkEntrySubmitForm.submit();
	    	}
    	  	else
    	  	{
				for(i=0;i<document.ExammarkEntrySubmitForm.chk.length;i++)
				{
					if(document.ExammarkEntrySubmitForm.chk[i].checked==true)
					{
			    	  	if(document.ExammarkEntrySubmitForm.staffremarks[i].value == "-")
			    	  		document.ExammarkEntrySubmitForm.staffremarks[i].value = "";
			    	  	if(document.ExammarkEntrySubmitForm.comboremarks[i].value == "-")
			    	  		document.ExammarkEntrySubmitForm.comboremarks[i].value = "";
			    	}
    	  		}	    	
        	}
        }
        else
        {
			alert("Select CheckBox")
		}
	}

}

//var count=0;
//var temp=false;
//var numberOfcount=0;

function checkNumber(e) {

	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;

	var character = String.fromCharCode(code);

	 	if(code == 8 || code == 9)
	 	{
			return false;
	 	}
	 	if(code==65)
	 	{
	 		return false;
	 	}
 		else if (code==46||code==47||code<46||code>57)
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
		/*if(code==46)
		{
		 count=count+1;
		 temp=true;
		}
		if(count>1)
		{
			code=0;
			alert("Only One Dot Allowed")
			document.ExammarkEntrySubmitForm.marktaken.value="";
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
		  document.ExammarkEntrySubmitForm.marktaken.value="";
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
	  }*/		 
}

function checkMark()
{
	if(parseInt(document.ExammarkEntrySubmitForm.marktaken.value)>parseInt(document.ExammarkEntrySubmitForm.req_theoryexternalmax.value))
	{ 
	 alert("You cant enter Marks greater than Maximum marks");
	 document.ExammarkEntrySubmitForm.marktaken.focus();
	 return;
	}
}

function editFun()
{
	if(confirm("Do you want to edit the Marks..?"))
	{
		document.ExammarkEntrySubmitForm.action="MarkEntryStaffEdit.jsp";
		document.ExammarkEntrySubmitForm.submit();
	}
}

function goBack()
{

		document.ExammarkEntrySubmitForm.action="MarkEntryStaffSelect.jsp";
		document.ExammarkEntrySubmitForm.submit();
}	


</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ExammarkEntrySubmitForm" action="" method="post">
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.exam.markentryrootpath_1") %></h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		
            	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.exam.SelectedInformation") %></th>
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
      	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
      	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
      	
      	String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		
		String maxMark=null;
		String passMark=null;
		
		
		String rollNo="";
		int rollNoNote = 0;
		String markTaken="";
		String staffRemarks="";
		String comboRemarks="";
		String markUserId="";
		String createdby 		=	(String)session.getValue("userid");		
		String publishStatus="";
		String statusColor="";
		
		
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		//String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String examName=request.getParameter("req_examallotmentname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String secSchedId=request.getParameter("req_sectionpubid");
		String subjName=request.getParameter("req_subjectname");
		String subjectschid=request.getParameter("req_subjectpubid");
		String examschid=request.getParameter("req_examscheduleid");
		
		if(request.getParameter("req_theoryexternalmax")!=null && !(request.getParameter("req_theoryexternalmax")).equals("null") && !(request.getParameter("req_theoryexternalmax")).equals(""))
			maxMark  = request.getParameter("req_theoryexternalmax");
		else
			maxMark  = "-";
		
		if(request.getParameter("req_theoryexternalmin")!=null && !(request.getParameter("req_theoryexternalmin")).equals("null") && !(request.getParameter("req_theoryexternalmin")).equals(""))
			passMark  = request.getParameter("req_theoryexternalmin");
		else
			passMark  = "-";

		//out.print("publishStatus-->"+request.getParameter("req_examschedulestatus"));
		//if(request.getParameter("req_examschedulestatus")!=null && !(request.getParameter("req_examschedulestatus")).equals("null"))
		if(request.getParameter("req_markpublishstatus")!=null && !(request.getParameter("req_markpublishstatus")).equals("null"))
		{
			publishStatus  = request.getParameter("req_markpublishstatus");
			
			if(publishStatus == "R" || publishStatus.equals("R"))
			{				
				publishStatus = "Result Published";
				statusColor	  = "red";	
			}
			else
			{
				publishStatus = "Result not Published";
			}
		}
		else
			publishStatus  = "-";
		
		//out.println("req_theoryexternalmax-->"+request.getParameter("req_theoryexternalmax")+"req_theoryexternalmin-->"+request.getParameter("req_theoryexternalmin"));
		//out.println("subjectschid-->"+subjectschid+"secSchedId-->"+secSchedId+"examschid--->"+examschid);
		ArrayList registeredList	= null;
		ArrayList statusList		= null;

	    String instituteid = null;
	    
	    try
	    {
	    	instituteid = (String)session.getValue("instituteid");
	    
	    }catch(Exception e){}

		//out.println("<script>alert('"+sessionid+"')</script>");
		//registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentList(secSchedId);
		registeredList		=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentListformark(subjectschid,examschid,secSchedId);
		statusList			=	(ArrayList)registrationQuery.getFacultyStatus(instituteid);
		HashMap statusMap	=	null;	
		//System.out.println("registeredList>>>>"+registeredList);
		
		

		
		
       %>



<tr>
<td colspan=2>
	<table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.exam.AcademicYear") %></td><td class=tablebold width="2%">:</td><td class=tablelight ><%=session.getValue("sessionname")%></td>
			<td class=tablebold><%=bundle.getString("label.exam.Board") %> </td><td class=tablebold width="2%">:</td><td  colspan=2  class=tablelight><%=boardName %></td>
		</tr>
		<tr><td class=tablebold width="25%"><%=bundle.getString("label.exam.ExamName") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=examName %></td>
			<td class=tablebold width="25%"><%=bundle.getString("label.exam.Standard") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=courseName %></td>
		</tr>
		<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.exam.Section") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=secName%></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.exam.SubjectName") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=subjName%></td>
		</tr>
		<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.exam.MaximumMark") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=maxMark%></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.exam.MinimumMark") %></td><td class=tablebold width="2%">:</td><td class=tablelight><%=passMark%></td>
		</tr>
		<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.exam.PublishStatus") %></td><td class=tablebold width="2%">:</td><td class=tablelight><font color=<%=statusColor%>><%=publishStatus%></font></td>
		</tr>
	</table>
</td>
</tr>
  </table>
  <br/>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="8%"><%=bundle.getString("label.exam.SL.No") %></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.exam.StudentName") %></th>
            <th scope="col" class="rounded" width="12%"><%=bundle.getString("label.exam.RollNo") %>.</th>
            <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.exam.Marks") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.exam.StaffRemarks") %></th>
            <th scope="col" class="rounded" width="23%"><%=bundle.getString("label.exam.Status") %></th>
            <th scope="col" class="rounded" width="24%">Mark Entry By</th>
            <th scope="col" class="rounded-q4" width="13%"><%=bundle.getString("label.exam.Check") %></th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="7" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    	<%
	 int count=0;
     int size = 0;
     int editsize = 0;
     int rollnosize = 0;
     int checkboxsize = 0;
     int datacount = 0;
	boolean flag = false;
	
	if(statusList.size()==0)
		out.print("<div class=warning_box>Faculty Remark Status is not yet Entered</div>");
	
	//out.print("registeredList-->"+registeredList.size());
	if(maxMark!="-" && passMark!="-")
	{
	if(registeredList.size()!=0 && statusList.size()!=0)
	{
		for(int i=0;i<registeredList.size();i++)
		{
			count=count+1;
			HashMap map				=	(HashMap)registeredList.get(i);
			applicantName			=	(String) map.get("studentname");
			studentallocationid		=	(String) map.get("studentallocationid");
			String studallocid		=	(String) map.get("studallocid");
			
			
			rollNo					=	(String) map.get("rollno");
			markTaken				=	(String) map.get("marktaken");
			
			staffRemarks				=	(String) map.get("staffremarks");
			comboRemarks				=	(String) map.get("comboremarks");
			markUserId				= 	(String) map.get("createdby");
			
				
			if(rollNo==null){
				rollNo = "NYG";
				rollNoNote = rollNoNote+1;
			}
			else
				rollnosize++;
			
			if(markTaken==null)
				markTaken = "-";
			if(staffRemarks==null || staffRemarks=="" || staffRemarks.equals(""))
				staffRemarks = "-";
			if(comboRemarks==null  || comboRemarks=="" || comboRemarks.equals(""))
				comboRemarks = "-";
			
			out.println("i-->"+i+"markTaken-->"+markTaken);
			if(markTaken!="-")
			{
				if(publishStatus=="Result not Published" || publishStatus.equals("Result not Published"))
				{
					if(markUserId.equals(createdby))
						editsize = i+1;
				}
				datacount++;	
			//out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+rollNo+"</td><td><input type=text size='3' readonly  maxlength=3 value='"+markTaken+" '></td><td>"+staffRemarks+"</td><td>"+comboRemarks+"</td>");
			out.print("<tr><td valign=top>"+(i+1)+"</td><td valign=top>"+applicantName+"</td><td valign=top>"+rollNo+"</td><td valign=top>"+markTaken+"<input type=hidden name='marktaken'></td><td valign=top>"+staffRemarks+"<input type=hidden name='staffremarks'></td><td valign=top>"+comboRemarks+"<input type=hidden name='comboremarks'></td><td valign=top>"+map.get("staffname")+"</td>");
			out.println("<td align='left' valign=top>-<input type=checkbox style=visibility:hidden name='chk'></td></tr>");
			}
			else
			{				
				if(publishStatus=="Result not Published" || publishStatus.equals("Result not Published"))
				{
					size = i+1;	
				
				if(rollNo=="NYG" || rollNo.equals("NYG"))	
				out.print("<tr><td valign=top>"+(i+1)+"</td><td valign=top>"+applicantName+"</td><td valign=top><i><font color=red>"+rollNo+"</font></i></td><td valign=top><input type=text size='3' name='marktaken' maxlength=3 OnkeyPress='checkNumber(event)'></td><td><input type=text size='25' name='staffremarks' maxlength=200 ></td>");
				else
					out.print("<tr><td valign=top>"+(i+1)+"</td><td valign=top>"+applicantName+"</td><td valign=top>"+rollNo+"</td><td valign=top><input type=text size='3' name='marktaken' maxlength=3 OnkeyPress='checkNumber(event)'></td><td><input type=text size='25' name='staffremarks' maxlength=200 ></td>");	
				//out.print("<td valign=top><select name=comboremarks class=tablelight><option value='00'>-Select Status-</option><option value='Excellent'>Excellent</option><option value='Very Good'>Very Good</option><option value='Good'>Good</option><option value='Average'>Average</option><option value='Improve'>Improve</option><option value='Poor'>Poor</option><option value='Very Poor'>Very Poor</option></td>");
				out.print("<td valign=top><select name=comboremarks class=tablelight><option value='00'>-Select Status-</option>");
				for(int j=0;j<statusList.size();j++)
				{
					statusMap = (HashMap)statusList.get(j);
					out.print("<option value='"+statusMap.get("fremarkstatusid")+"'>"+statusMap.get("remarkstatusname")+"</option>");
				}
				out.print("</td><td>-</td>");
				if(rollNo=="NYG" || rollNo.equals("NYG")){
					out.println("<td align='left' valign=top>-<input type=checkbox style=visibility:hidden name='chk'></td></tr>");
				}
				else{
					out.println("<td align='left' valign=top><input type='checkbox' name='chk' value="+studallocid+"@"+count+" onclick=chkval(this)></td></tr>");
					checkboxsize++;
				}
				}
				else
				{
					if(i==registeredList.size()-1 && datacount==0)
						out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
					
					
				}
				
			}
				
			
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
	  }
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Maximum and Minimum Mark is not yet set</font></td></tr>");
	}


	%>
      
      </table>

				<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exam.Back") %></strong><span class="bt_blue_r"></span></a>      
	<% 
				if(editsize>0)
				{	
	%>	
				<a href="#" class="bt_blue" onclick="editFun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exam.Edit") %></strong><span class="bt_blue_r"></span></a>
	<%
				}
				if(size>0 && publishStatus=="Result not Published" && rollnosize>0 && checkboxsize>0)
				{	
	%>	
			
    			<a href="javascript:void(0)" class="bt_green" onclick="submitFun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.exam.Submit") %></strong><span class="bt_green_r"></span></a>
	<%
				}
	
	%>
	
	<%
				if(rollNoNote>0)	
			        	{
	%>	
			<tr><td>
			<br><a class=tablebold>Note :</a><br>
			Marks can be entered only if the Roll No. is generated.
			</br></td></tr>  			    
	<%
			        	}
	%>			
	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->
   
    
    <input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
	<input type="hidden" name="req_sessionname" value='<%=request.getParameter("req_sessionname")%>'>
	<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
	<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
	<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
	<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
	<input type="hidden" name="req_sectionpubid" value="<%=request.getParameter("req_sectionpubid")%>">
	<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
	<input type="hidden" name="req_subjectpubid" value="<%=request.getParameter("req_subjectpubid")%>">
	<input type="hidden" name="req_subjectname" value="<%=request.getParameter("req_subjectname")%>">
	<input type=hidden name=req_examscheduleid value="<%=request.getParameter("req_examscheduleid") %>">
	<input type="hidden" name="req_examallotmentname" value="<%=request.getParameter("req_examallotmentname")%>">
	<input type=hidden name=req_theoryexternalmax value="<%=request.getParameter("req_theoryexternalmax")%>">
	<input type=hidden name=req_theoryexternalmin value="<%=request.getParameter("req_theoryexternalmin")%>">
	<input type=hidden name=req_examschedulestatus value="<%=request.getParameter("req_examschedulestatus")%>">
	<input type=hidden name=req_markpublishstatus value="<%=request.getParameter("req_markpublishstatus")%>">
	<input type=hidden name=req_backfile value="MarkEntryStaff.jsp">
	
	
	<%@ include file="../../include/footer.jsp" %>

	</div>
</form>
</body>
</html>
       	