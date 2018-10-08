
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.group.updatelistlisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">


function goToBack()
{
	document.MainForm.action= "GroupList.jsp";
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.groupname,"text"))
	{
		
if(confirm("Do you want to Update the Group...?"))
{

	document.MainForm.action= "GroupEditUpdate.jsp";
document.MainForm.submit();
}
}

else{}
}

</script>
</head>

<body>
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
         <h2><%=bundle.getString("label.group.updatelistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<%

	String groupid = request.getParameter("groupid");
	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(groupid);    
	HashMap DetailsForuadate=null;
	String groupname=null;
	String description=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		groupname=(String)DetailsForuadate.get("groupname");
		 description=(String)DetailsForuadate.get("description");

	}
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
<table id="rounded-corner" border=0 summary="Medium List" width="100%">
    <thead> 
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.group.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.board.mandatoryfields") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0 summary="Medium List" width="100%">


    <thead>
			<tr bordercolor=white valign="top">
				<td class="tablebold"><%=bundle.getString("label.group.groupname") %>  <font color=red>*</font></td>
					<td class=tablebold>:</td><td class="tablelight"><input type="text" name="groupname" validate="Group Name" size=50 maxlength=45 value="<%=groupname.replaceAll("\"","&quot;")%>"></td>
			</tr>
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.group.description") %> </td>
				<td class=tablebold>:</td><td class="tablelight">
			<textarea validate="Description" class="tablelight" cols=75 rows=2 name="deptdescription" onkeydown="textCounter_label(document.MainForm.deptdescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.deptdescription,document.getElementById('labelid'),2000)"><%=description %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.group.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.group.charactersleft") %></font></i>
			
			</td>		
			</tr>  
			
		
		</table>
				  <a href="#" onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.group.back") %> </strong><span class="bt_blue_r"></span></a>
		
	 <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.group.update") %></strong><span class="bt_green_r"></span></a>

	<tr>	
		<td colspan="2">
		<input type="hidden" name="groupid" value="<%=groupid %>"></td></tr>
			
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