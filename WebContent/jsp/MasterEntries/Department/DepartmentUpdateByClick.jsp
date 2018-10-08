
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.department.updatelistlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>


<script language="JavaScript">

function charcount()
{
var countlen=2000-document.MainForm.deptdescription.value.length;
document.getElementById("labelid").innerHTML	= countlen;

}	

 
function goToBack()
{
	document.MainForm.action= "DepartmentList.jsp";
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.deptname,"text"))
	{
		
if(confirm("Do you want to Update the Department...?"))
{

	document.MainForm.action= "DepartmentEditUpdate.jsp";
document.MainForm.submit();
}
}
else{}
}

</script>
</head>

<body onload="charcount()">
<form name="MainForm" method="post" action="">

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
         <h2><%=bundle.getString("label.department.updatelistrootpath") %> </h2>
<%@ page language="java" import="java.util.*"%>
<%

	String Deptid = request.getParameter("Deptid");
	
	


ArrayList getDetailsForuadate=query_object.getDetailsForuadate(Deptid);
HashMap DetailsForuadate=null;
String departmentname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	 departmentname=(String)DetailsForuadate.get("departmentname");
	 description=(String)DetailsForuadate.get("description");

}
if(departmentname!= null)
if(description.equals(""))
{
description="-";
}

%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>  
        	
         
          <th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.department.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.department.mandatoryfields") %></th>   
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>

			<tr valign="top">
				<td  class="tablebold"><%=bundle.getString("label.department.departmentname") %> <font color=red>*</font></td>
								<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text" name="deptname" validate="Department Name" maxlength="45" size="50" value="<%=departmentname.replaceAll("\"","&quot;")%>"></td>    
			</tr>
			<tr valign="top">
			<td  class="tablebold"><%=bundle.getString("label.department.description") %></td>
			<td width="1%" class="tablebold">:</td>
			<td class="tablelight">  
				<textarea class="tablelight" validate="Description" cols=75 rows=2 name="deptdescription" onkeydown="textCounter_label(document.MainForm.deptdescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.deptdescription,document.getElementById('labelid'),2000)"><%=description %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.department.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.department.charactersleft") %></font></i>
				</td>
				</tr>
				</table>
</td>
</tr>
  
    
   
</table>
		
			<input type="hidden" name="deptid" value="<%=Deptid %>">
	
     		  <a href="DepartmentList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.department.back") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.department.update") %></strong><span class="bt_green_r"></span></a>
     
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
     <tbody>
    
    </tbody>
</table>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>