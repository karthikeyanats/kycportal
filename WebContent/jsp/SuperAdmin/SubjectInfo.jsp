<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Subject Wise Pass  Percentage  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />  

<script language='javascript'>

 
function goback()
{
	document.superadminForm.action = "./ExamStandardPass.jsp";
	document.superadminForm.submit();
}

function clickFun(obj)
{
	document.superadminForm.action = "./SubjectInfo.jsp";
	document.superadminForm.submit();
}
</script>
<style type="text/css">
</style>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>                   
     
</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>

  
<div class="center_content">



<div class="left_content"></div>

<div class="right_content">


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>

<form name='superadminForm' method='post'>
<jsp:useBean id="instituteQuery" scope="page"
	class="com.iGrandee.SuperAdmin.SuperAdminQuery" /> 
	<%@ page language="java"
	import="com.iGrandee.Report.Reports"%>
	<%
	Reports reports 		= new Reports();
 	String instituteid = request.getParameter("instituteid")+"";
	String institutenames = request.getParameter("institutename")+"";
	String sessionname = request.getParameter("sessionname")+"";
	String sessionid = request.getParameter("sessionid")+"";
	String boardid = request.getParameter("boardid")+"";
	String boardmedium = request.getParameter("boardmedium")+"";
	String standardscheduleid = request.getParameter("standardscheduleid")+"";
	String standardgroup = request.getParameter("standardgroup")+"";

	String examnameid		= request.getParameter("examnameid")+"";
	String examname			= request.getParameter("examname")+"";
	ArrayList examList		= reports.standardSubjectPassDetails(standardscheduleid,examnameid);
	%>
	<input type="hidden" name="instituteid" value="<%=instituteid %>">
	<input type="hidden" name="institutename" value="<%=institutenames %>">
	<input type="hidden" name="sessionid" value="<%=sessionid %>">
	<input type="hidden" name="sessionname" value="<%=sessionname %>">
	<input type="hidden" name="boardid" value="<%=boardid %>">
	<input type="hidden" name="boardmedium" value="<%=boardmedium %>">
	<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
	<input type="hidden" name="standardgroup" value="<%=standardgroup%>">
	<input type="hidden" name="examnameid" value="<%=examnameid%>">
	<input type="hidden" name="examname" value="<%=examname%>">
	
		<br><br>
	<h2><%=bundle.getString("label.superadmin.examrootpath2")%></h2>
	<tr>
	<td>
	<table id="rounded-corner" border=0   width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="15%"><%=bundle.getString("label.board.selectedinformation") %></th>
  	        <th scope="col" class="rounded" width="1%" align="center"> </th>
  	         <th scope="col" class="rounded" width="25%" align="center"> </th>
  	         <th scope="col" class="rounded-q4" width="60%"align="center"> </th>
        	
            
        </tr>
         <tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.common.schoolname") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%=institutenames%></td>
		</tr>
		<tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.common.academicyear") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%= sessionname%></td>
		</tr> 
		<tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.boardmedium.apprsrc") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%= boardmedium%></td>
		</tr>
		<tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.usernotutil.standardname") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%= standardgroup%></td>
		</tr>
		<tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.examdetails.examname") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%= examname%></td>
		</tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
    </td>
    </tr>
   </table>
    <br><br>
	<tr>
	<td>
	<table id="rounded-corner" border=0  width="100%">
		    <thead>
		    	<tr> 
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="50%"><%=bundle.getString("label.schedule.subjectname")%></th>
		            <th scope="col" class="rounded" ></th>
		            <th scope="col" class="rounded-q4" ><%=bundle.getString("label.schedule.passpercentage")%></th>
		        </tr>
		    </thead>
					
		<%
			String subjectid		= "";
			int totalsubject		= 0;
			int totalpassed			= 0;
			int totalstudents		= 0;
			float percent			= 0.0f;
			String totasubject		= "";
			String passedsubject	= "";
			HashMap hashmap1		= null;
			if(examList != null && examList.size()>0){
				for(int y=0;y<examList.size();y++){    
					HashMap hashmap			= (HashMap)examList.get(y);
					subjectid		= (String)hashmap.get("subjectscheduleid");
					
					totasubject		= (String)hashmap.get("totalstudents");	
					passedsubject	= (String)hashmap.get("passedcount");
					try{
						
						if(totasubject == null || totasubject.equals("") || totasubject.equalsIgnoreCase("null"))
							totasubject	= "0";
						
						if(passedsubject == null || passedsubject.equals("") || passedsubject.equalsIgnoreCase("null"))
							passedsubject	= "0";
					
						
						totalpassed		= Integer.parseInt(totasubject);
						totalstudents	= Integer.parseInt(passedsubject);
						
						percent			= (totalstudents*100/totalpassed);
						
					}
					catch(Exception e){
						percent		= 0;
					}

					out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td><table width='100%' cellspacing='0' cellpadding='0'>");
					out.print("</table></td><td>"+percent+"</td></tr>");
					
					
					//out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("staffname")+"</td><td>"+percent+"</td><td><a href='#cls' subjectscheduleid='"+subjectid+"' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' status='Passed' onclick='callSection(this)'>"+bundle.getString("label.schedule.passedlist")+"</a>&nbsp;|&nbsp;<a href='#cls' subjectscheduleid='"+subjectid+"' status='Failed' subjectname='"+hashmap.get("subjectname")+"' facultyname='"+hashmap.get("staffname")+"' onclick='callSection(this)'>"+bundle.getString("label.schedule.failedlist")+"</a></td></tr>");
						
				}
			}
			else{
				out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				//out.print("<tr><td colspan='5' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
			}

		%>	
		<tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>										
		</table>
</td><td></td></tr>
</table>  
<br>

<a href="#" class="bt_blue" onclick="goback()"><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.usernotutil.back")%> </strong><span class="bt_blue_r"></span></a>
			


</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>