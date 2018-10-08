
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<LINK rel=stylesheet href="../../../css/kyccss.css">


<head>
<title><%=bundle.getString("label.subjecttype.updatelistlisttitle") %></title>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">


function goToBack()
{
	document.MainForm.action= "SubjectTypeList.jsp";
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.subjecttypename,"text"))
	{
		
if(confirm("Do you want to Update the Subject Type...? "))
{

	document.MainForm.action= "SubjectTypeEditUpdate.jsp";
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
         <h2><%=bundle.getString("label.subjecttype.updatelistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<%

	String subjecttypeid = request.getParameter("subjecttypeid");
ArrayList getDetailsForuadate=query_object.getDetailsForuadate(subjecttypeid);     
HashMap DetailsForuadate=null;
String subjectypename=null; 
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	subjectypename=(String)DetailsForuadate.get("subjectypename");
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
        
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.subjecttype.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.subjecttype.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0 summary="Medium List" width="100%">


    <thead>
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.subjecttype.subjecttypename") %> <font color=red>*</font></td>
				<td class=tablebold>:</td><td><input type="text" name="subjecttypename" size=50 maxlength=45 validate="Group Name" value="<%=subjectypename.replaceAll("\"","&quot;")%>"></td>
			</tr>
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.subjecttype.description") %> </td>
							
					<td class=tablebold>:</td>	<td>
				<textarea validate="Description" class="tablelight" cols=75 rows=2 name="deptdescription" onkeydown="textCounter_label(document.MainForm.deptdescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.deptdescription,document.getElementById('labelid'),2000)"><%=description %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.subjecttype.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.subjecttype.charactersleft") %></font></i>
						</td>
				
			</tr>
			
		<tr>	
		<td colspan=2><input type="hidden" name="subjecttypeid" value="<%=subjecttypeid %>"></td></tr>
			
		</table>
		
			  <a href="#" onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subjecttype.back") %> </strong><span class="bt_blue_r"></span></a>
	
	 <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subjecttype.update") %></strong><span class="bt_green_r"></span></a>
	
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