<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.gradecreation.trashtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>


<script type="text/javascript">
function TrashGrades()
{
if(confirm("Do you want to Trash the Grade...?"))
{
		document.gradeForm.EditStatus.value="T";
		document.gradeForm.action="./GradeEditSubmit.jsp";
		//document.gradeForm.action="./GradeLessonDetails.jsp";
		document.gradeForm.submit();		
}
}
function backfun()
{
		document.gradeForm.action="./GradeCreation.jsp";
		document.gradeForm.submit();		
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

    <h2><%=bundle.getString("label.gradecreation.entryrootpath") %></h2>
<form name="gradeForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;
     String reqboardid = null;
     String boardname = null;
     String scalename = null;
     String scaleid = null;
     String gradeid = null;
     String gradename = null;

     
     
     String reqgroupstatus = null;
     String gradestatus = null;

     
     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 scalename = request.getParameter("reqscalename");
    	 scaleid = request.getParameter("reqscaleid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 instituteid = (String)session.getValue("instituteid");
    	  instituteid = (String)session.getValue("instituteid");
    	  gradeid =  request.getParameter("gradeid");
    	  gradename=  request.getParameter("reqgradename");
    	  gradestatus=gradescaleQuery.CheckGradeSchedule(gradeid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.gradecreation.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4"  width="20%" colspan=3></th>
            
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
	    <td colspan=2>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.BoardName") %></a></td><td class=tablebold>:</td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.StandardName") %></a></td><td class=tablebold>:</td><td><%=scalename %></td>
	    		</tr>
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.SubjectName") %></a></td><td class=tablebold>:</td><td colspan=4><%=gradename %></td>
	    		</tr>
	    	</table>
	    </td>
  </tr>
    </tbody>
    </table>
        <br>
    
 <%
		 if(!gradestatus.equals("null") && !gradestatus.equals("0"))
		 {
		     out.println("<div  class='warning_box'>");
			 out.println("This Grade was Set For Scheduled Standard "+bundle.getString("label.gradecreation.errormessage1"));
			 out.println("</div>"); 

		 }
 %> 
 
      <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradecreation.Back") %> </strong><span class="bt_blue_r"></span></a>
      <% 
      if(gradestatus.equals("null") || gradestatus.equals("0") )
      {
      %>
          <a href="#" class="bt_red" onclick="TrashGrades()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.gradecreation.Trash") %> </strong><span class="bt_red_r"></span></a>
      <%
      }
      %>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqscalename" value="<%=scalename%>">
      <input type="hidden" name="reqscaleid" value="<%=scaleid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="gradeid" value="<%=gradeid %>" >
     <input type="hidden" name="reqgradeid" value="<%=gradeid%>" >
     
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
