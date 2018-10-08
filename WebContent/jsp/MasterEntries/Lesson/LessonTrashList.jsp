<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.lesson.lessontrashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>
<script type="text/javascript">
function Trashfun(obj)
{
var status=obj.getAttribute("editstatus");
var lessonid=obj.getAttribute("lessonid");


var statusword="";
if(status=="A")
{
		statusword="Restore";
}
else if(status=="X")
{
		statusword="Delete";
}
if(confirm("Do You Want to "+statusword+" the Lesson...?"))
{
		document.lessonForm.EditStatus.value=status;
		document.lessonForm.lessonid.value=lessonid;
		document.lessonForm.action="./LessonEditSubmit.jsp";
		document.lessonForm.submit();		
}
}
function gobackfun()
{
document.lessonForm.action="./LessonCreation.jsp";
document.lessonForm.submit();
}
function editlesson(obj)
{
document.lessonForm.reqlessonid.value=obj.getAttribute("lessonid")
document.lessonForm.action="./LessonEdit.jsp";
document.lessonForm.submit();
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

    <h2><%=bundle.getString("label.lesson.lessontrashlistrootpath") %></h2>
<form name="lessonForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Lesson.LessonQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String reqboardid = null;
     String boardname = null;
     String reqstandardname = null;
     String reqstandardid = null;
     String reqgroupstatus = null;
     ArrayList lessonList = null;
     String reqsubjectname = null;
     String reqsubjectid = null;
     

     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 reqstandardname = request.getParameter("reqstandardname");
    	 reqstandardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 reqsubjectid = request.getParameter("reqsubjectid");
    	 reqsubjectname = request.getParameter("reqsubjectname");
    	 lessonList = lessonQuery.LessonTrashList(reqsubjectid);
   	      }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="95%"><%=bundle.getString("label.lesson.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="5"></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td   class="rounded-foot-left"><em></em></td>
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
	    			<td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.StandardName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td><%=reqstandardname  %></td>
	    		</tr>
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.lesson.SubjectName") %></a></td>
	    			<td class=tablebold>:</td>
	    			<td><%=reqsubjectname %></td>
	    			
	    		</tr>
	    	</table>
	    </td>
	    
  </tr>
    </tbody>
    </table>
    
    <br><br>
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.lesson.SL.No") %></th>
    	   	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.lesson.LessonName") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.lesson.LessonDescription") %></th>
        	<th scope="col" class="rounded" width="8%"><%=bundle.getString("label.lesson.Delete") %></th>
              	<th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.lesson.Restore") %></th>
      
       </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
  int sno=1;
   String lessonid     ="";
   if(lessonList!=null && lessonList.size()>0)
	{
	   ////subjectid, subjectname, subjecttypeid, subjectypename
	 	for (int i1 = 0; i1 < lessonList.size(); i1++,sno++) {
		HashMap lessonListMap=(HashMap)lessonList.get(i1);
		lessonid     = (String)lessonListMap.get("lessonid");
		String lessonname      = (String)lessonListMap.get("lessonname");
		String lessondescription      = (String)lessonListMap.get("lessondescription");
	%>
	<tr>
	
		<td><%=sno %></td>
	
	<td><%=lessonname %></td>
	<td><%=lessondescription %></td>
	<td><a href="#Trash2"  lessonid='<%=lessonid%>' name="Trash2" onclick="Trashfun(this)"  editstatus='X'><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
		<td><a href="#Trash1" name="Trash1"  lessonid='<%=lessonid%>' onclick="Trashfun(this)"  editstatus='A' ><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /> </a></td>
	
	</tr>
	<% 	
	 }
	  }
   else
   {
	   out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td align=center colspan='5'>Data Not Found</td></tr>");

   }
   
   %>
     </tbody>
</table>
     		<a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.lesson.BacktoLessonList") %></strong><span class="bt_blue_r"></span></a>
 
     	  <input type=hidden name="reqstandardid" value="<%=reqstandardid %>">
     	  <input type="hidden" name="reqstandardname" value="<%=reqstandardname%>">
    	  <input type="hidden" name="reqsubjectid" value="<%=reqsubjectid%>">
    	  <input type="hidden" name="reqsubjectname" value="<%=reqsubjectname%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="lessonid" value="">
	      <input type="hidden" name="EditStatus" value="">
    	  <input type="hidden" name="reqboardname" value="<%=boardname%>">
    	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
