<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesheaddeactivelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardList.jsp";
	document.standardForm.submit();
}
function goSubject(obj)
{

	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.reqstandardname.value = obj.getAttribute("standardname");
	document.standardForm.reqgroupstatus.value = obj.getAttribute("groupstatus");
	document.standardForm.action="../Subject/SubjectCreation.jsp";
	document.standardForm.submit();
	

}
function fessHeadEdit(obj)
{
if(confirm("Do you want to Update the Fees Head...?"))
{
var staffcategoryid=obj.getAttribute("staffcategoryid");
var staffcategoryname=obj.getAttribute("staffcategoryname");


	document.standardForm.staffcategoryid.value=staffcategoryid;
	document.standardForm.staffcategoryname.value=staffcategoryname;
document.standardForm.action="fessHeadEdit.jsp";
	document.standardForm.submit();
} 
else
{}
}

function backfun()
{
document.standardForm.action="staffcategoryview.jsp";
	document.standardForm.submit();  
}
function ActionFun(obj,action)
{                
var staffcategoryid=obj.getAttribute("staffcategoryid");
var staffcategoryname=obj.getAttribute("staffcategoryname"); 
document.standardForm.staffcategoryid_temp.value=staffcategoryid; 

if(action=="A")   
{
if(confirm("Do you Want To Activate the StaffCategory...?"))
{
document.standardForm.action="StaffcategoryAction.jsp?mode_of_operation=activeststus";
	document.standardForm.submit(); 
}
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

    <h2><%=bundle.getString("label.feesheaddeactivelist.rootpath")%></h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.StaffList.StaffCategoryQuery  categoryQuery = new com.iGrandee.StaffList.StaffCategoryQuery();     String instituteid = null;
     ArrayList categoryList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  categoryList = categoryQuery.liststaffcategory(instituteid,"D");
     
    }catch(Exception e){}
    
    %>
    
    


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%">SL.No</th>
            <th scope="col" class="rounded" width="42%">StaffCategory Name</th>
            <th scope="col" class="rounded" width="20%">Date of Creation</th>
              <th scope="col" class="rounded-q4" colspan="1" width="30%">Action</th>
            
          
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     try
     {
    	 
    	 if(categoryList!=null && categoryList.size()>0)
			{
		 	for (int i = 0, j = 1; i < categoryList.size(); i++) {
			
				HashMap categoryListMap=(HashMap)categoryList.get(i);
				String staffcategoryid     = (String)categoryListMap.get("staffcategoryid");
				String staffcategoryname      = (String)categoryListMap.get("categoryname");
				String dateofcreation      = (String)categoryListMap.get("dateofcreation");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=staffcategoryname %></td>
				<td><%= dateofcreation %></td>
				<td><a href="#" staffcategoryid="<%=staffcategoryid%>" staffcategoryname="<%=staffcategoryname%>" onclick="ActionFun(this,'A')">Activate</a></td>
				
				</tr>
				<%
		 }
			}
		 	else
		 	{
		 	out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
		 	//out.println("<tr><td colspan=4 align=center>Data not found</td></tr>");
		 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>
	<input type="hidden" name="staffcategoryid" value="">
		<input type="hidden" name="staffcategoryname" value="">
	
<input type="hidden" name="staffcategoryid_temp" value="">
		<input type="hidden" name="staffcategoryname_temp" value="">
	<a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back to StaffCategory </strong><span class="bt_blue_r"></span></a>


  
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

