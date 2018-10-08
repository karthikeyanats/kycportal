
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.facultyremarkstatus.updatelistlisttitle") %> </title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>


<script language="JavaScript">

	



function goToUpdate()
{
	if(check_ForParticularElements(document.MainForm.facultyremarkname,"text"))
	{
		
		if(confirm("Do you want to Update the Faculty Remarks...?"))
		{
		
			document.MainForm.action= "FacultyRemarkEditUpdate.jsp";
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
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.facultyremarkstatus.updatelistrootpath") %> </h2>
<%@ page language="java" import="java.util.*"%>
<%

	String fremarkstatusid = request.getParameter("fremarkstatusid");
	
	
String instituteid=session.getValue("instituteid")+"";

ArrayList getDetailsForuadate=query_object.getDetailsForuadate("A",fremarkstatusid); 
HashMap DetailsForuadate=null;
String remarkstatusname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	remarkstatusname=DetailsForuadate.get("remarkstatusname")+"";

}

%>
<form name="MainForm" method="post" action=""> 
<input type="hidden" name="fremarkstatusid" value="<%=fremarkstatusid%>"> 


     
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>  
        	<th scope="col" class="rounded-company" width="35%"><%=bundle.getString("label.facultyremarkstatus.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="40%"></th>
        	<th scope="col" class="rounded-q4" width="20%" align="right"><font color=red>*</font> <%=bundle.getString("label.facultyremarkstatus.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>

    <thead>

			<tr valign="top">
				<td  class="tablebold" width="35%"><%=bundle.getString("label.facultyremarkstatus.facultyremarkname") %> <font color=red>*</font></td>
				<td class="tablelight" colspan=2><input type="text" name="facultyremarkname" validate="Faculty Remark" maxlength="45" size="50" value="<%=remarkstatusname.replaceAll("\"","&quot;")%>"></td>    
			</tr>
			
				</table>
</td>
</tr>
  
    
   
</table>
		
	
     		  <a href="FacultyRemarkList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.back") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.update") %></strong><span class="bt_green_r"></span></a>
     
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