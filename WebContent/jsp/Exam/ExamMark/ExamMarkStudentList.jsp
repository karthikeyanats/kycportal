<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Mark Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

	var a=0;
function chkval(obj)
{
alert("obj>>"+obj.value);
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
				document.ExammarkEntrySubmitForm.action="./ExamMarkSubmit.jsp";
    	  		document.ExammarkEntrySubmitForm.submit();
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
  				else
  				{
  			        test=true;
  			    }
  			}

  		}
  		if(test==true )
		{
    	   	document.ExammarkEntrySubmitForm.action="./ExamMarkSubmit.jsp";
    	  	document.ExammarkEntrySubmitForm.submit();

        }
        else
        {
			alert("Select CheckBox")
		}
	}

}
function goBack()
{

		document.ExammarkEntrySubmitForm.action="ExamMarkEntry.jsp";
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

    <h2>Exam / Exam Mark Entry / MarkEntry</h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="10"></th>
            	<th scope="col" class="rounded" width="100%">Selected Information</th>
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
      	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();

      	String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		
		String rollNo="";
		String marktaken="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("reg_sessiontext");
		String boardName=request.getParameter("reg_boardname");
		String examName=request.getParameter("reg_examname");
		String courseName=request.getParameter("reg_coursename");
		String secName=request.getParameter("reg_sectionname");
		String secSchedId=request.getParameter("reg_sectionpubid");
		String subjName=request.getParameter("reg_subjectname");
		String subjectschid=request.getParameter("reg_subjectschid");
		String examschid=request.getParameter("reg_examschid");
		
		
		//out.println("subjectschid-->"+subjectschid+"secSchedId-->"+secSchedId+"examschid--->"+examschid);
		ArrayList registeredList= null;
		

		//out.println("<script>alert('"+sessionid+"')</script>");
		//registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentList(secSchedId);
		registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentListformark(subjectschid,examschid,secSchedId);
		//System.out.println("registeredList>>>>"+registeredList);
		
		
	    String instituteid = null;
	    
	    try
	    {
	    	instituteid = (String)session.getValue("instituteid");
	    
	    }catch(Exception e){}
		
		
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold>Board </td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
<tr><td class=tablebold width="25%">Exam Name</td><td class=tablelight><%=examName %></td>
<td class=tablebold width="25%">Standard</td><td class=tablelight><%=courseName %></td>
</tr>
<tr>
<td class=tablebold width="25%">Section</td><td class=tablelight><%=secName%></td>
<td class=tablebold width="25%">Subject Name</td><td class=tablelight><%=subjName%></td>
</tr>


</table>
</td><td></td></tr>
  </table>
  <br>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="40%">Student Name</th>
            <th scope="col" class="rounded" width="25%">Roll No.</th>
            <th scope="col" class="rounded" width="25%">Mark Obtained</th>
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
			count=count+1;
			HashMap map				=	(HashMap)registeredList.get(i);
			applicantName			=	(String) map.get("studentname");
			studentallocationid		=	(String) map.get("studentallocationid");
			String studallocid		=	(String) map.get("studallocid");
			
			
			rollNo					=	(String) map.get("rollno");
			marktaken				=	(String) map.get("marktaken");
			
				
			if(rollNo==null)
				rollNo = "";
			if(marktaken==null)
				marktaken = "";
			//System.out.println("i-->"+i+"marktaken-->"+marktaken);
			if(marktaken!="")
			{
			out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+rollNo+"</td><td><input type=text size='10' readonly  maxlength=3 value='"+marktaken+" '></td>");
			out.println("<td align='left'>-</td></tr>");
			}
			else
			{
				out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+rollNo+"</td><td><input type=text size='10' name='marktaken' maxlength=3 ></td>");
				out.println("<td align='left'><input type='checkbox' name='chk' value="+studallocid+"@"+count+" onclick=chkval(this)></td></tr>");
			}
				
			
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
      
      </table>

      <a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>
    			<a href="#" class="bt_blue" onclick="submitFun()"><span class="bt_blue_lft"></span><strong>Submit</strong><span class="bt_blue_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->
    <input type=hidden name=req_examschid value="<%=examschid %>">

	<%@ include file="../../include/footer.jsp" %>

	</div>
</form>
</body>
</html>
       	