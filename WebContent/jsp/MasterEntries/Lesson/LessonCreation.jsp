<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.lesson.lessontitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>
<script type="text/javascript">
function setmark(val)
{
//alert(val);
	if(val=="1")
	{	
		//alert(document.lessonForm.subjectname1.value);
		document.getElementById("mark1span").innerHTML="Theory - Min-25,Max-30 <br> Practical Min-20,Max-30";		
		//alert(document.getElementById("mark1span").innerHTML);
	}	
	else if(val=="2")
	{	
			alert(document.lessonForm.subjectname2.value);
	}
	else if(val=="3")
	{	
			alert(document.lessonForm.subjectname3.value);
	}
	else if(val=="4")
	{	
			alert(document.lessonForm.subjectnam4.value);
	}
}
var validflag  =false;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{
	
		if(!check_ForParticularElements(document.lessonForm.lessonname[chkid],"text",document.lessonForm.lessondescription[chkid],"text")){
			document.lessonForm.check[chkid].checked=false;
		}

	
	
	
	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.lessonForm.check[chkid].checked)  
		{
			for(var k=0;k<document.lessonForm.check.length;k++)
			{
				if(chkid!=k)
					{
					if(document.lessonForm.check[k].checked)
						{
							if(document.lessonForm.lessonname[chkid].value==document.lessonForm.lessonname[k].value)
							{ 
							 checkoption="yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Lesson Name Not Allowed");
		document.lessonForm.check[chkid].checked=false;
		document.lessonForm.lessonname[chkid].focus();
		return false;
		}

	}
	
	validflag  =true;
}

function gobackfun()
{
document.lessonForm.action="../Subject/SubjectCreation.jsp";
document.lessonForm.submit();
}
function TrashList()
{
document.lessonForm.action="./LessonTrashList.jsp";
document.lessonForm.submit();
}
function editlesson(obj)
{
if(confirm("Do you want to Update the Lesson...?"))
		{
			document.lessonForm.reqlessonid.value=obj.getAttribute("lessonid")
			document.lessonForm.action="./LessonEdit.jsp";
			document.lessonForm.submit();
		}
}
function trashlesson(obj)
{
if(confirm("Do you want to Trash the Lesson...?"))
{
        var lessonname=obj.getAttribute("lessonname");
        var lessonid=obj.getAttribute("lessonid");
		document.lessonForm.reqlessonid.value=lessonid;
		document.lessonForm.reqlessonname.value=lessonname;
		document.lessonForm.EditStatus.value="T";
		//document.lessonForm.action="./LessonEditSubmit.jsp";
		document.lessonForm.action="./LessonDetails.jsp";
		document.lessonForm.submit(); 		
}
}
function addLessons()
{
	if(validflag)
	{

	for(var x1=0;x1<document.lessonForm.check.length;x1++)
		{
			if(document.lessonForm.check[x1].checked)
			{
				document.lessonForm.lessonname[x1].disabled =false;
				document.lessonForm.lessondescription[x1].disabled =false;
			}
			else
			{
				document.lessonForm.lessonname[x1].disabled =true;
				document.lessonForm.lessondescription[x1].disabled =true;
				
			}
			
		}
	
	document.lessonForm.action="./LessonSubmit.jsp";
	document.lessonForm.submit();
	}  
	else
	{ 
	alert("select any one of the  option");
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

    <h2><%=bundle.getString("label.lesson.lessonrootpath") %></h2>
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
    	     
    	  lessonList = lessonQuery.listLesson(reqsubjectid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.lesson.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ></th>
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
    	   	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.lesson.SL.No") %></th>
    	   	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.lesson.LessonName") %></th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.lesson.LessonDescription") %></th>
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.lesson.Chk") %></th>
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.lesson.Edit") %></th>
        	<th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.lesson.Trash") %></th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
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
	<tr valign="top">
	
		<td><%=sno %></td>
		<td align="justify"><%=lessonname %></td>
		<td align="justify"><%=lessondescription %></td>
		<td>-</td>
	<td><a href="#"  lessonname="<%=lessonname %>"  lessonid="<%=lessonid %>" onclick="editlesson(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
		<td><a href="#"  lessonname="<%=lessonname %>"  lessonid="<%=lessonid %>" onclick="trashlesson(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
	
	</tr>
	<% 	
	 }
	}
   
   for(int x=0;x<5;x++,sno++)
   {%>
	 <tr valign="top">
	 		<td><%=sno %></td>
	 
	 <td><input type="text" name="lessonname" size="30" maxlength=45 class="tablelight"/></td> 
	 <%
	 out.println(" <td><textarea  cols=50 rows=2 name='lessondescription' onkeydown=textCounter_label(document.lessonForm.lessondescription["+x+"],document.getElementById('labelid"+x+"'),2000) onkeyup=textCounter(document.lessonForm.lessondescription["+x+"],document.getElementById('labelid"+x+"'),2000)></textarea>&nbsp; <br><br><i><font color='red'><label id='labelid"+x+"' >"+bundle.getString("label.lesson.charactercount")+"</label>&nbsp;&nbsp;"+bundle.getString("label.lesson.charactersleft")+"</font></i></td>");
	 %> 
	 <td><input type="checkbox" name="check" chkid="<%=x%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 <td>-</td>
	  <td>-</td>
	 </tr> 
   <%} 
   
   %>
    <!--  <tr>
    <td><input type="text" name="subjectname1"  class=tablelight></td>
    <td><input type="text" name="subjectcode1"  class=tablelight></td>
    <td><input type="text" name="credithours1"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
      <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark('1');return false;">Mark</a><span id="mark1span"></span></td>
    <td><input type="checkbox" name="subjectselect1"  class=tablelight></td>
    </tr>
    
     <tr>
    <td><input type="text" name="subjectname2"  class=tablelight></td>
    <td><input type="text" name="subjectcode2"  class=tablelight></td>
    <td><input type="text" name="credithours2"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
    <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark('2');return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect2"  class=tablelight></td>
    </tr>
    
     <tr>
    <td><input type="text" name="subjectname3"  class=tablelight></td>
    <td><input type="text" name="subjectcode3"  class=tablelight></td>
    <td><input type="text" name="credithours3"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
     <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark(this);return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect3"  class=tablelight></td>
    </tr>
    
    
     <tr>
    <td><input type="text" name="subjectname4"  class=tablelight></td>
    <td><input type="text" name="subjectcode4"  class=tablelight></td>
    <td><input type="text" name="credithours4"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
     <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark(this);return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect4"  class=tablelight></td>
    </tr>-->
    </tbody>
</table>
<div id="modal" style="border:1px solid black; background-color:#9999ff;  display:none;">

	<table border="1" cellpadding="4" cellpspacing=0 width="100%">
	<tr class=tablebold><td><%=bundle.getString("label.lesson.Max") %></td><td><%=bundle.getString("label.lesson.Max") %></td><td><%=bundle.getString("label.lesson.Min") %></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.lesson.Theory") %></td><td><input type=text name="throymax" size="3" class="tablelight"></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.lesson.Practical") %></td><td><input type=text name="throymax" size="3"  class=tablelight></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.lesson.Project") %></td><td><input type=text name="throymax" size="3" class=tablelight></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	</table>
<br><br>
	<center><input type="button" value="OK" class=tablelight onclick="Popup.hide('modal');"/></center>
</div>

     <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.lesson.BacktoSubject") %></strong><span class="bt_blue_r"></span></a>
          <a href="#" onclick="TrashList()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.lesson.TrashList") %></strong><span class="bt_blue_r"></span></a>
     
          <a href="#" class="bt_green" onclick="addLessons()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.lesson.Submit") %></strong><span class="bt_green_r"></span></a>
     
          <input type=hidden name="reqstandardid" value="<%=reqstandardid %>">
     	  <input type="hidden" name="reqstandardname" value="<%=reqstandardname%>">
    	  <input type="hidden" name="reqsubjectid" value="<%=reqsubjectid%>">
    	  <input type="hidden" name="reqsubjectname" value="<%=reqsubjectname%>">
    	  <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
    	  <input type="hidden" name="reqlessonname" value="">
    	  <input type="hidden" name="reqlessonid" value="">
    	  <input type="hidden" name="reqboardname" value="<%=boardname%>">
    	  <input type=hidden name="reqgroupstatus" value="<%=reqgroupstatus %>">
    
    <input type=hidden name="lessonid" value="">
    <input type=hidden name="lessonname" value="">
    <input type=hidden name="EditStatus" value="">
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
