<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesheadupdate.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function gobackfun()
{
document.fessheadForm.action="FeesHeadView.jsp";
document.fessheadForm.submit();
}
 
function goToUpdate(feesheadid,feesheadname)
{
if(confirm("Do you want to Update the Fees Head...?"))
{
document.fessheadForm.feesheadid_temp.value=feesheadid;
document.fessheadForm.feesheadname_temp.value=feesheadname;
document.fessheadForm.action="FeesAction.jsp?mode_of_operation=updatefeeshead";
document.fessheadForm.submit();
}
else
{}
}

function checkNames() 
{

  	goToUpdate(document.fessheadForm.feesheadid.value,document.fessheadForm.feesheadname.value);

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

    <h2><%=bundle.getString("label.feesheadupdate.rootpath")%></h2>
<form name="fessheadForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Lesson.LessonQuery"%>

     <%
     
  
     
     com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String feesheadid = null;
     String feesheadname = null;
   
     try
     {
    	 feesheadid = request.getParameter("feesheadid");
    	 feesheadname =  request.getParameter("feesheadname");
    	
    	 // BoardList = lessonQuery.listBoard(instituteid);
    }catch(Exception e){
    	e.printStackTrace();
    }
    
    %>
    
    
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="80%" colspan=2><%=bundle.getString("label.feesheadupdate.FeesHeadName")%></th>
        	<th scope="col" class="rounded-q4" width="20%" align=right><font color=red>*</font> <%=bundle.getString("label.feesheadupdate.MandatoryFields")%></th>        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
  
	%>
	<tr>
		<td colspan=3>
			<table>
				<tr>
					<td><%=bundle.getString("label.feesheadupdate.FeesHeadName")%> <font color=red>*</font></td>
					<td><input type="text" name="feesheadname" value="<%=feesheadname %>" size="65"><input type="hidden" name="feesheadid" value="<%=feesheadid %>" size="10"></td>
				</tr>
			</table>
		</td>
	</tr>
    </tbody>
</table>

<input type="hidden" name="feesheadid_temp" value="">
<input type="hidden" name="feesheadname_temp" value="">

     <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesheadupdate.BacktoFeesHeadList")%></strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="checkNames()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feesheadupdate.Submit")%></strong><span class="bt_green_r"></span></a>
    
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
     

</div>
</body>
</html>
