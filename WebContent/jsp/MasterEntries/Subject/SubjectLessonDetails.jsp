<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.subject.trashtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function TrashSubjects()
{
if(confirm("Do you want to Trash the Subject...?"))
{
		document.subjectForm.EditStatus.value="T";
		document.subjectForm.action="./SubjectEditSubmit.jsp";
		//document.subjectForm.action="./SubjectLessonDetails.jsp";
		document.subjectForm.submit();		
}
}
function backfun()
{
		document.subjectForm.action="./SubjectCreation.jsp";
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

    <h2><%=bundle.getString("label.subject.entryrootpath") %></h2>
<form name="subjectForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Subject.SubjectQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String reqboardid = null;
     String boardname = null;
     String standardname = null;
     String standardid = null;
     String subjectid = null;
     String subjectname = null;

     
     
     String reqgroupstatus = null;
     ArrayList LessonList = null;
     String subjectstatus = null;

     
     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 standardname = request.getParameter("reqstandardname");
    	 standardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 instituteid = (String)session.getValue("instituteid");
    	  instituteid = (String)session.getValue("instituteid");
    	  subjectid =  request.getParameter("subjectid");
    	  subjectname=  request.getParameter("reqsubjectname");
    	  LessonList = subjectQuery.LoadLessonForSubject(subjectid);
    	  subjectstatus=subjectQuery.CheckSubjectSchedule(subjectid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.subject.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="5" colspan=3></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
    <tr>
	    <td></td>
	    <td>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.BoardName") %></a></td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.StandardName") %></a></td><td><%=standardname %></td>
	    		</tr>
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.SubjectName") %></a></td><td colspan=3><%=subjectname %></td>
	    		</tr>
	    	</table>
	    </td>
	    <td></td>
  </tr>
    </tbody>
    </table>
        <br>
    
 <%
		 if(!subjectstatus.equals("null") && !subjectstatus.equals("0"))
		 {
		     out.println("<div  class='warning_box'>");
			 out.println("This Subject( "+subjectname+" ) is Scheduled For Current Academic Session "+bundle.getString("label.subject.errormessage1"));
			 out.println("</div>"); 

		 }
 %> 
 <h4> 
 <%=subjectname %> <%=bundle.getString("label.subject.errormessage") %>
 <%
 if(LessonList!=null && LessonList.size()>0)
 {
  out.println(" "+bundle.getString("label.subject.errormessage1"));
 }
 %>
 </h4>  
   <table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.subject.SL.No") %></th>
    	   	<th scope="col" class="rounded" width="35%"><%=bundle.getString("label.subject.LessonName") %></th>
        	<th scope="col" class="rounded-q4" width="35%"><%=bundle.getString("label.subject.LessonDescription") %></th>
       </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
  int sno=1;
   String lessonid     ="";
   if(LessonList!=null && LessonList.size()>0)
	{
	   ////subjectid, subjectname, subjecttypeid, subjectypename
	 	for (int i1 = 0; i1 < LessonList.size(); i1++,sno++) {
		HashMap lessonListMap=(HashMap)LessonList.get(i1);
		lessonid     = (String)lessonListMap.get("lessonid");
		String lessonname      = (String)lessonListMap.get("lessonname");
		String lessondescription      = (String)lessonListMap.get("lessondescription");
	%>
	<tr>
	<td><%=sno %></td>
	<td><%=lessonname %></td>
	<td><%=lessondescription %></td>
	</tr>
	<% 	
	 }
	  }
   else
   {
	   out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td align=center colspan='3'>Data Not Found</td></tr>");

   }
   %>
	</tbody>
	</table>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.Back") %> </strong><span class="bt_blue_r"></span></a>
      <% 
      if(subjectstatus.equals("null") || subjectstatus.equals("0") )
      {
    	  if(LessonList==null || LessonList.size()==0)
    	  {
      %>
          <a href="#" class="bt_red" onclick="TrashSubjects()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.subject.Trash") %> </strong><span class="bt_red_r"></span></a>
      <%
    	  }
      }
      %>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqstandardname" value="<%=standardname%>">
      <input type="hidden" name="reqstandardid" value="<%=standardid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="subjectid" value="<%=subjectid %>" >
     <input type="hidden" name="reqsubjectid" value="<%=subjectid%>" >
     
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
