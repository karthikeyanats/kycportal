<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.lesson.lessonupdatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>
<script type="text/javascript">
function gobackfun()
{
document.lessonForm.action="./LessonCreation.jsp";
document.lessonForm.submit();
}
function TrashLesson()
{
if(confirm("Do you want to Trash the Lesson...?"))
{
		document.lessonForm.EditStatus.value="T";
		document.lessonForm.action="./LessonEditSubmit.jsp";
		document.lessonForm.submit();		
}
}

	function EditLessons()
	{
		if(check_ForParticularElements(document.lessonForm.lessonname,"text",document.lessonForm.lessondescription,"textarea"))
		{
			document.lessonForm.EditStatus.value="E";
			document.lessonForm.action="./LessonEditSubmit.jsp";
			document.lessonForm.submit();	
		}		
	}
	
function checkDuplicate(givenstring,flag)
{
	var url = "";
	var date = new Date();

	if(flag=="duplicateLessonname")
	{
	 		url = "LessonInfo.jsp?action=duplicateLessonname&lessonname="+givenstring+"&reqsubjectid="+document.lessonForm.reqsubjectid.value+"&reqlessonid="+document.lessonForm.lessonid.value+"&date="+date;
	}
	var req =initRequest();
	req.onreadystatechange = function()
	{
	
		if (req.readyState == 4)
		{
			if (req.status == 200)
			{
				if(flag=="duplicateLessonname")
				{
				 	parseMessages(req.responseXML,flag);
			  	}
			}
		}
	};
	req.open("GET", url, true);
	req.send(null);
}
function parseMessages(xmlObj,flag)
	{
		
		if(flag=="duplicateLessonname")
		{
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
					if(temp=="true")
						{
							alert("Lesson Name already exists");
							document.lessonForm.subjectcode.focus();
							document.lessonForm.check.checked=false;
							return false;
						}
					else
						{
							if(check_ForParticularElements(document.lessonForm.lessondescription,"textarea"))
								{
										document.lessonForm.EditStatus.value="E";
										document.lessonForm.action="./LessonEditSubmit.jsp";
										document.lessonForm.submit();	
								}		
						}
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

    <h2><%=bundle.getString("label.lesson.lessonupdaterootpath") %></h2>
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
     String reqlessonid = null;
     try
     {
    	 reqlessonid = request.getParameter("reqlessonid");
    	 instituteid = (String)session.getValue("instituteid");
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 reqstandardname = request.getParameter("reqstandardname");
    	 reqstandardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 reqsubjectid = request.getParameter("reqsubjectid");
    	 reqsubjectname = request.getParameter("reqsubjectname");
    	 lessonList = lessonQuery.loadLessonForLessonid(reqsubjectid,reqlessonid);
    	 // BoardList = lessonQuery.listBoard(instituteid);
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
    	   	
    	   	<th scope="col" class="rounded-company" width="98%" ><%=bundle.getString("label.lesson.LessonDetails") %></th>
        	<th scope="col" class="rounded-q4" width="2%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
  int sno=1;
   if(lessonList!=null && lessonList.size()>0)
	{
	   ////subjectid, subjectname, subjecttypeid, subjectypename
	 	for (int i1 = 0; i1 < lessonList.size(); i1++,sno++) {
		HashMap lessonListMap=(HashMap)lessonList.get(i1);
		String lessonid     = (String)lessonListMap.get("lessonid");
		String lessonname      = (String)lessonListMap.get("lessonname");
		String lessondescription      = (String)lessonListMap.get("lessondescription");
	%>
	<tr><td colspan=2><table width=100%>
	<tr><td class=tablebold><%=bundle.getString("label.lesson.LessonName") %></td>
	<td class=tablebold>:</td>
	<td><input type="text" name="lessonname" value="<%=lessonname %>" size="65"><input type="hidden" name="lessonid" value="<%=lessonid %>" size="10"></td>
	</tr>
	<tr>
	<td class=tablebold><%=bundle.getString("label.lesson.LessonDescription") %></td>
	<td class=tablebold>:</td>
		<td><textarea rows="4" cols="50"  name="lessondescription" onkeydown="textCounter_label(document.lessonForm.lessondescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.lessonForm.lessondescription,document.getElementById('labelid'),2000)"><%=lessondescription %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.lesson.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.lesson.charactersleft") %></font></i></td>
	</tr>
	<% 	
	 }
	}
   %>
    </table></td></tr></tbody>
</table>
     <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.lesson.BacktoLessonList") %></strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="EditLessons()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.lesson.Submit") %></strong><span class="bt_green_r"></span></a>
     <input type=hidden name="reqstandardid" value="<%=reqstandardid %>">
     	  <input type="hidden" name="reqstandardname" value="<%=reqstandardname%>">
    	  <input type="hidden" name="reqsubjectid" value="<%=reqsubjectid%>">
    	  <input type="hidden" name="reqsubjectname" value="<%=reqsubjectname%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="reqboardname" value="<%=boardname%>">
    	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">  
    	  <input type=hidden  name="EditStatus" value="">
    	  
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
