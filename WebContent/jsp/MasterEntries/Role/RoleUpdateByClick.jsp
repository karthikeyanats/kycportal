<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.role.updatelistlisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="JavaScript">


function goToBack()
{
	document.MainForm.action= "RoleList.jsp";
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.rolename,"text"))
	{
		
if(confirm("Do you want to Update the Role...?"))
{
	document.MainForm.action= "RoleEditUpdate.jsp";
document.MainForm.submit();
}
else{}

}
}
function charcount()
{
var countlen=2000-document.MainForm.roledescription.value.length;
document.getElementById("labelid").innerHTML	= countlen;

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
         <h2><%=bundle.getString("label.role.updatelistrootpath") %></h2>
<%@ page language="java" import="java.util.*"%>
<%

	String roleid = request.getParameter("roleid");
	
	String instituteid = (String)session.getValue("instituteid");
	
	

	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(roleid); 
	HashMap DetailsForuadate=null;
	String rolename=null;
	String description=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		 rolename=(String)DetailsForuadate.get("rolename");
		 description=(String)DetailsForuadate.get("description");

	}
	if(description.equals(""))
	{
	description="-";
	}
	
%>
<form name="MainForm" method="post" action="">
  <input type="hidden" name="roleid" value="<%=roleid %>">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
            
              <th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.role.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.role.mandatoryfields") %></th>
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

			<tr  valign="top">
				<td  class="tablebold"><%=bundle.getString("label.role.rolename")%> <font color=red>*</font></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text" name="rolename" validate="Role Name" maxlength=45 size=50 value="<%=rolename.replaceAll("\"","&quot;")%>"></td>
			</tr>
			<tr valign="top">
				<td a class="tablebold"><%=bundle.getString("label.role.description")%> </td>
							
			<td width="1%" class="tablebold">:</td>
			<td class="tablelight">
			<textarea validate="Description" class="tablelight" cols=75 rows=2 name="roledescription" onkeydown="textCounter_label(document.MainForm.roledescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.roledescription,document.getElementById('labelid'),2000)"><%=description %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.role.charactercount")%></label>&nbsp;&nbsp;<%=bundle.getString("label.role.charactersleft")%></font></i>
			</td>	
			</tr>
			
		
		</table>
		     		  <a href="RoleList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.role.back")%> </strong><span class="bt_blue_r"></span></a>
		
	     <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.role.update")%></strong><span class="bt_green_r"></span></a>
     
   <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
			</thead>
</table>
	

	</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</TABLE>


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>