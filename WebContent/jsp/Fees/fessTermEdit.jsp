<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feestermupdate.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
function gobackfun()
{
document.fessheadForm.action="FeesTermView.jsp";
document.fessheadForm.submit();
}
 
function goToUpdate(termid,termname)
{
if(confirm("Do you want to Update the Fees Term...?"))
{
document.fessheadForm.feesheadid_temp.value=termid;
document.fessheadForm.feesheadname_temp.value=termname;
document.fessheadForm.action="FeestermAction.jsp?mode_of_operation=updatefeesterm";
document.fessheadForm.submit();
}
else
{}
}

function checkNames() 
{ 
  	 goToUpdate(document.fessheadForm.termid.value,document.fessheadForm.termname.value);
}
 	
 
function parseMessages(parseXML,check_var,termid,termname)
{
	   var fromarray=new Array();
       var toarray=new Array();
		
			var rootObj=parseXML.getElementsByTagName("complaintdetails");
			var cNode_1=rootObj.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
					if(temp=="true")
						{
							alert("Fees Term Name Already Exists");
							document.MainForm.deptname.focus();
							return false;
						}
					else
						{
							goToUpdate(termid,termname);
						}
				
	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.feestermupdate.rootpath")%></h2>
<form name="fessheadForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Lesson.LessonQuery"%>

     <%
     
  
     
     com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String termname = null;
     String termid = null;
   
     try
     {
    	 termid = request.getParameter("termid");
    	 termname =  request.getParameter("termname");
    	
    	 // BoardList = lessonQuery.listBoard(instituteid);
    }catch(Exception e){
    	e.printStackTrace();
    }
    
    %>
    
    
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	
    	   	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.feestermupdate.FeesTermName")%></th>
        	<th scope="col" class="rounded-q4" width="20%" align=right><font color=red>*</font> <%=bundle.getString("label.feestermupdate.MandatoryFields")%></th>        </tr>
   
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
	<table ><tr>
	<td><%=bundle.getString("label.feestermupdate.FeesHeadName")%> <font color=red>*</font></td><td><input type="text" name="termname" value="<%=termname %>" size="65"><input type="hidden" name="termid" value="<%=termid %>" size="10"></td>
	</tr></table>
	</td>
	
	</tr>
	

    </tbody>
</table>

<input type="hidden" name="feesheadid_temp" value="">
<input type="hidden" name="feesheadname_temp" value="">

     <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feestermupdate.BacktoFeesTermList")%></strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="checkNames()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feestermupdate.Submit")%></strong><span class="bt_green_r"></span></a>
    
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
     

</div>
</body>
</html>
