<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.gradecreation.subjecttrashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function backfun()
{
		document.gradeForm.action="./GradeCreation.jsp";
		document.gradeForm.submit();		
}
function Trashfun(obj)
{
var status=obj.getAttribute("editstatus");
var gradeid=obj.getAttribute("gradeid");
var statusword="";
if(status=="A")
{
		statusword="Restore the Grade...?";
}
else if(status=="X")
{
		statusword="Delete the Grade...?";
}
if(confirm("Do You Want to "+statusword))
{
		document.gradeForm.EditStatus.value=status;
		document.gradeForm.gradeid.value=gradeid;
		document.gradeForm.action="./GradeEditSubmit.jsp";
		document.gradeForm.submit();		
}
}
</script>
</head>
<body>
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

    <h2><%=bundle.getString("label.gradecreation.subjecttrashlistrootpath") %></h2>
<form name="gradeForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Subject.SubjectQuery"%>

     <%
     
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;

     String reqboardid = null;
     String boardname = null;
     String scalename = null;
     String scaleid = null;
     ArrayList gradeList = null;

     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 scalename = request.getParameter("reqscalename");
    	 scaleid = request.getParameter("reqscaleid");
    	 instituteid = (String)session.getValue("instituteid");
    	  gradeList = gradescaleQuery.listGrade(scaleid,instituteid,"T");
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.gradecreation.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="20%" colspan=3></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
    <tr>
	    <td>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.BoardName") %></a></td><td class=tablebold>:</td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.StandardName") %></a></td><td class=tablebold>:</td><td><%=scalename %></td>
	    		</tr>
	    	</table>
	    </td>
	    <td></td>
  </tr>
    </tbody>
    </table>
    
    <br>
<table id="rounded-corner" border="0" summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.gradecreation.SL.No") %></th>
    	   	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.gradecreation.SubjectName") %></th>
            <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.gradecreation.Delete") %></th>
            <th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.gradecreation.Restore") %></th>
        
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   if(gradeList!=null && gradeList.size()>0)
	{
	 	for (int i1 = 0,sno=1; i1 < gradeList.size(); i1++,sno++) {
		HashMap gradeListMap=(HashMap)gradeList.get(i1);
		String gradeid      = (String)gradeListMap.get("gradeid")+"";
		String gradename      = (String)gradeListMap.get("gradename")+"";
	%>
	<tr>
	<td><%=sno %> </td>
	 <td><%=gradename %> </td>
<td><a href="#Trash2"  gradeid='<%=gradeid %>' name="Trash2" onclick="Trashfun(this)"  editstatus='X'><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
	 <td><a href="#Trash1" name="Trash1" gradeid='<%=gradeid %>' onclick="Trashfun(this)"  editstatus='A' ><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /></a></td>

	</tr>
	<% }
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td align=center colspan='7'>Data Not Found</td></tr>");
	}%>
	</tbody>
	</table>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradecreation.BacktoSubjectList") %> </strong><span class="bt_blue_r"></span></a>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqscalename" value="<%=scalename%>">
      <input type="hidden" name="reqscaleid" value="<%=scaleid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="gradeid" value="" >
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
