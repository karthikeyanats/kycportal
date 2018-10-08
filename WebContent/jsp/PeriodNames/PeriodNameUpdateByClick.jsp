
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.periodnames.updatelistlisttitle") %> </title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language="JavaScript">

	



function goToUpdate()
{
	if(check_ForParticularElements(document.MainForm.periodname,"text"))
	{
		
		if(confirm("Do you want to Update the Period Name...?"))
		{
		
			document.MainForm.action= "PeriodNameEditUpdate.jsp";
			document.MainForm.submit();
		}
	}
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

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
         <h2><%=bundle.getString("label.periodnames.updatelistrootpath") %> </h2>
<%@ page language="java" import="java.util.*"%>
<%

	String periodnameid = request.getParameter("periodnameid");
	
	
String instituteid=session.getValue("instituteid")+"";

ArrayList getDetailsForuadate=query_object.getDetailsForuadate("A",periodnameid); 
HashMap DetailsForuadate=null;
String periodname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	periodname=DetailsForuadate.get("periodname")+"";

}

%>
<form name="MainForm" method="post" action=""> 
<input type="hidden" name="periodnameid" value="<%=periodnameid%>"> 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>  
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.periodnames.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.periodnames.mandatoryfields") %></th>
            
        </tr>
    </thead>
   
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0  width="100%">


    <thead>

			<tr valign="top">
				<td  class="tablebold"><%=bundle.getString("label.periodnames.periodname") %> <font color=red>*</font></td>
				<td class="tablelight" colspan=2><input type="text" name="periodname" validate="Period Name" maxlength="45" size="50" value="<%=periodname.replaceAll("\"","&quot;")%>"></td>    
			</tr>
      <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>			
				</table>
				
				
</td>
</tr>
  
    
   
</table>
		
	
     		  <a href="PeriodNameList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.periodnames.back") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.periodnames.update") %></strong><span class="bt_green_r"></span></a>

    
     <tbody>
    
    </tbody>
</table>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>