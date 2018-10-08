<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.lesson.trashdetail") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function TrashSubjects()
{
if(confirm("Do you want to Trash the Lesson...?"))
{
		document.subjectForm.EditStatus.value="T";
		document.subjectForm.action="./LessonEditSubmit.jsp";
		//document.subjectForm.action="./SubjectLessonDetails.jsp";
		document.subjectForm.submit();		
}
}
function backfun()
{
		document.subjectForm.action="./LessonCreation.jsp";
		document.subjectForm.submit();		
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

    <h2><%=bundle.getString("label.lesson.entryrootpath") %></h2>
<form name="subjectForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Subject.SubjectQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String reqboardid = null;
     String reqboardname = null;
     String reqstandardname = null;
     String reqstandardid = null;
     String reqsubjectid = null;
     String reqsubjectname = null;

     
     
     String reqgroupstatus = null;
     String Lessonstatus = null;
     String Lessonname = null;
     String lessonid = null;

     
     
     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 reqboardname = request.getParameter("reqboardname");
    	 reqstandardname = request.getParameter("reqstandardname");
    	 reqstandardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 instituteid = (String)session.getValue("instituteid");
    	 reqsubjectid =  request.getParameter("reqsubjectid");
    	 reqsubjectname=  request.getParameter("reqsubjectname");
    	 Lessonname=  request.getParameter("reqlessonname");
    	 lessonid=  request.getParameter("reqlessonid");
    	 Lessonstatus=subjectQuery.CheckLessonSchedule(lessonid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.lesson.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
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
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.BoardName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td><%=reqboardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.StandardName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td><%=reqstandardname %></td>
	    		</tr>
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.SubjectName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td ><%=reqsubjectname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.LessonName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td ><%=Lessonname %></td>
	    		</tr>
	    	</table>
	    </td>
	    
  </tr>
    </tbody>
    </table>
        <br>
    
 <%
		 if(!Lessonstatus.equals("null") && !Lessonstatus.equals("0"))
		 {
		     out.println("<div  class='warning_box'>");
			 out.println("This Lesson ( "+Lessonname+" ) is Scheduled For Current Academic Session "+bundle.getString("label.lesson.errormessage"));
			 out.println("</div>"); 

		 }
 %> 
      <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.Back") %> </strong><span class="bt_blue_r"></span></a>
      <% 
      if(Lessonstatus.equals("null") || Lessonstatus.equals("0") )
      {
    	       %>
          <a href="#" class="bt_red" onclick="TrashSubjects()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.subject.Trash") %> </strong><span class="bt_red_r"></span></a>
      <%
      }
      %>
          <input type="hidden" name="reqstandardid" value="<%=reqstandardid%>">
    	  <input type="hidden" name="reqstandardname" value="<%=reqstandardname%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="reqboardname" value="<%=reqboardname%>">
    	  <input type="hidden" name="reqsubjectid" value="<%=reqsubjectid%>">
    	  <input type="hidden" name="reqsubjectname" value="<%=reqsubjectname%>">
      	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
          <input type=hidden name="EditStatus" value="T">
          <input type=hidden name="lessonid" value="<%=lessonid %>">
          <input type=hidden name="lessonname" value="<%=Lessonname %>">
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
