<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Examr List  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />  

<script language='javascript'>

 
function goback()
{
	document.superadminForm.action = "./StandardInfo.jsp";
	document.superadminForm.submit();
}

function clickFun(obj)
{
	document.superadminForm.examnameid.value=obj.getAttribute("examnameid");
	document.superadminForm.examname.value=obj.getAttribute("examname");
	document.superadminForm.action = "./ExamStandardPass.jsp";
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
	<%
 	String instituteid = request.getParameter("instituteid")+"";
	String institutenames = request.getParameter("institutename")+"";
	String sessionname = request.getParameter("sessionname")+"";
	String sessionid = request.getParameter("sessionid")+"";
	String boardid = request.getParameter("boardid")+"";
	String boardmedium = request.getParameter("boardmedium")+"";
	String standardscheduleid = request.getParameter("standardscheduleid")+"";
	String standardgroup = request.getParameter("standardgroup")+"";

	
 	ArrayList ExamList = new ArrayList();
	ExamList = instituteQuery.listExam(sessionid,standardscheduleid,instituteid); 
	%>
	<input type="hidden" name="instituteid" value="<%=instituteid %>">
	<input type="hidden" name="institutename" value="<%=institutenames %>">
	<input type="hidden" name="sessionid" value="<%=sessionid %>">
	<input type="hidden" name="sessionname" value="<%=sessionname %>">
	<input type="hidden" name="boardid" value="<%=boardid %>">
	<input type="hidden" name="boardmedium" value="<%=boardmedium %>">
	<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
	<input type="hidden" name="standardgroup" value="<%=standardgroup%>">
	<input type="hidden" name="examnameid" value="">
	<input type="hidden" name="examname" value="">
	
		<br><br>
	<h2><%=bundle.getString("label.superadmin.examrootpath")%></h2>
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
	        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.common.slno")%></th>
	            <th scope="col" class="rounded-q4" width="40%"><%=bundle.getString("label.examdetails.examname")%></th>                                   
	        </tr>
	    </thead>
	    <tfoot>
	    	<tr>
	        	<td colspan=1 class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	
			<% 
			try
			{
			if(ExamList!=null && ExamList.size()>0)
			{
				for(int i=0;i<ExamList.size();i++)
				{
					HashMap ExamListMap=(HashMap)ExamList.get(i);
					out.print("<tr valign='top' class='tablelight'>");
					out.print("<td>"+(i+1)+"</td>");
					out.print("<td><a href='#' examnameid='"+ExamListMap.get("examnameid")+"' examname='"+ExamListMap.get("examname")+"' onclick='clickFun(this)'>"+ExamListMap.get("examname")+"</td>");
					out.print("</tr>");
						
				}
			}
			else
			{ 
				out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");	

			}
			
		}
		catch(Exception ex){
			System.out.print("Exception :"+ex);		
		}			
		//out.print("totPendingCount"+totPendingCount);
	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>

<a href="#" class="bt_blue" onclick="goback()"><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.usernotutil.back")%> </strong><span class="bt_blue_r"></span></a>
			
<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="backward" value="adminhome"/>


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