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
document.staffcategoryForm.action="staffcategoryview.jsp";
document.staffcategoryForm.submit();
}
 
function goToUpdate(staffcategoryid,staffcategory)
{
if(check_ForParticularElements(document.staffcategoryForm.staffcategory,"text"))
		{ 
if(confirm("Do you want to Update the Staffcategory...?"))
{
document.staffcategoryForm.staffcategoryid_temp.value=staffcategoryid;
document.staffcategoryForm.staffcategoryname_temp.value=staffcategory;
document.staffcategoryForm.action="StaffcategoryAction.jsp?mode_of_operation=updatestaffcategory";
document.staffcategoryForm.submit();
}
else
{}
		}
}

function checkNames() 
{

  	goToUpdate(document.staffcategoryForm.staffcategoryid.value,document.staffcategoryForm.staffcategory.value);

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

    <h2>Staff / StaffCategory / Update</h2>
<form name="staffcategoryForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Lesson.LessonQuery"%>

     <%
     
  
     
     com.iGrandee.MasterEntries.Lesson.LessonQuery  lessonQuery = new com.iGrandee.MasterEntries.Lesson.LessonQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String staffcategoryid = null;
     String staffcategory = null;
   
     try
     {
    	 staffcategoryid = request.getParameter("staffcategoryid");
    	 staffcategory =  request.getParameter("categoryname");
    	
    	 // BoardList = lessonQuery.listBoard(instituteid);
    }catch(Exception e){
    	e.printStackTrace();
    }
    
    %>
    
    
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="80%" colspan=2>StaffCategory Name </th>
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
					<td>StaffCategory Name <font color=red>*</font></td>
					<td><input type="text" name="staffcategory" value="<%=staffcategory %>" size="65" validate="StaffCategory Name"><input type="hidden" name="staffcategoryid" value="<%=staffcategoryid %>" size="10"></td>
				</tr>
			</table>
		</td>
	</tr>
    </tbody>
</table>

<input type="hidden" name="staffcategoryid_temp" value="">
<input type="hidden" name="staffcategoryname_temp" value="">

     <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back to Staff Category View</strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="checkNames()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
    
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
     

</div>
</body>
</html>
