<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.gradecreation.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function TrashGrades()
{
if(confirm("Do you want to Trash the Grade...?"))
{
		document.gradeForm.EditStatus.value="T";
		document.gradeForm.action="./GradeLessonDetails.jsp";
		document.gradeForm.submit();		
}
}
function backfun()
{
		document.gradeForm.action="./GradeCreation.jsp";
		document.gradeForm.submit();		
}
	
	function addGrades()
	{
	
	
		if(!check_ForParticularElements(document.gradeForm.gradename,"text")){
				
				//document.gradeForm.credithours,"text",
		}
		else{
			  checkDuplicate(document.gradeForm.gradename.value,"duplicategradename");
 
		}
	
	}
	
function checkDuplicate(givenstring,flag)
{
	   var url = "";
	   	   var date = new Date();

	   if(flag=="duplicategradename")
	   {
 		   url = "GradeInfo.jsp?action=duplicategradename&gradename="+givenstring+"&reqscaleid="+document.gradeForm.reqscaleid.value+"&reqgradeid="+document.gradeForm.gradeid.value+"&date="+date;
	   }
	   
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
  
			   if (req.status == 200)
			   {
				  if(flag=="duplicategradename")
				  {
				  	parseMessages(req.responseXML,flag)
				  }
			  }
			}
		};
	   req.open("GET", url, true);
	   req.send(null);
	}
	function parseMessages(xmlObj,flag)
	{
		if(flag=="duplicategradename")
		{
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
			if(temp=="true")
			{
				alert("Grade Name already exists");
				validflag="yes";
				document.gradeForm.gradename.focus();
				return false;
			}
			else
			{
				document.gradeForm.EditStatus.value="E";
				document.gradeForm.action="./GradeEditSubmit.jsp";
				document.gradeForm.submit();						
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

    <h2><%=bundle.getString("label.gradecreation.updaterootpath") %></h2>
<form name="gradeForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     //com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;
     String reqboardid = null;
     String boardname = null;
     String scalename = null;
     String scaleid = null;
     String gradeid = null;
     ArrayList gradeList = null;
     String gradename ="";
     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 scalename = request.getParameter("reqscalename");
    	 scaleid = request.getParameter("reqscaleid");
    	 gradeid = request.getParameter("reqgradeid");
    	 instituteid = (String)session.getValue("instituteid");

    	  gradeList = gradescaleQuery.loadGradeforgradeid(scaleid,gradeid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.gradecreation.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="10%"></th>
            
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
	    	</table>
	    </td>
  </tr>
    </tbody>
    </table>
    
    <br>
<table id="rounded-corner" border="0" summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="50%"><%=bundle.getString("label.gradecreation.SubjectName") %></th>
         <th scope="col" class="rounded-q4" width="50%"></th>
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
   if(gradeList!=null && gradeList.size()>0)
	{
	   ////gradeid, gradename, gradetypeid, gradeypename
	 	for (int i1 = 0; i1 < gradeList.size(); i1++) {
		HashMap gradeListMap=(HashMap)gradeList.get(i1);
		gradename      = (String)gradeListMap.get("gradename");
	 	}
	}
	%>
	<tr>
	 <td align=right><a class=tablebold><%=bundle.getString("label.gradecreation.SubjectName") %></a>&nbsp;<b>:</b>&nbsp;</td>
	 <td><input type="text" name="gradename" size="30" validate="Grade Name" maxlength="50" class="tablelight" value="<%=gradename %>" />
	 <input type="hidden" name="gradeid" size="30" maxlength="50" class="tablelight" value="<%=gradeid %>" /></td>
	</tr>
	</tbody>
</table>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradecreation.BackToSubjectList") %> </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addGrades()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradecreation.Submit") %></strong><span class="bt_green_r"></span></a>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqscalename" value="<%=scalename%>">
      <input type="hidden" name="reqscaleid" value="<%=scaleid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="reqgradeid" value="" >
     
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
