
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackEntry" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.rack.updatelistlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="JavaScript">

function goToUpdate()
{
	if(check_ForParticularElements(document.MainForm.rackname,"text"))
	{
		
		if(confirm("Do you want to Update the Rack Details...?"))
		{
		
			document.MainForm.action= "RackEditUpdate.jsp";
			document.MainForm.submit();
		}
	}
}
function charcount()
{
var countlen=500-document.MainForm.description.value.length;
labelid.innerHTML=countlen;
}
</script>
</head>

<body onload="charcount()">
<form name="MainForm" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.rack.updatelistrootpath") %> </h2>
<%@ page language="java" import="java.util.*"%>
<%

	String rackid = request.getParameter("rackid");
	
	
String instituteid=session.getValue("instituteid")+"";

ArrayList getDetailsForuadate=query_object.getDetailsForuadate(rackid,"A",instituteid);
HashMap DetailsForuadate=null;
String rackname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	rackname=DetailsForuadate.get("rackname")+"";
	 description=DetailsForuadate.get("description")+"";

}
if(description == null || description.equals("") || description.equals("-") || description.equalsIgnoreCase("null"))
{
	description="-";
}

%>
<form name="MainForm" method="post" action="" > 
<input type="hidden" name="rackid" value="<%=rackid%>"> 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>  
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.rack.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.rack.mandatoryfields") %></th>
            
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
		<table id="rounded-corner" border=0  width="100%">


    <thead>

			<tr valign="top">
				<td  class="tablebold"><%=bundle.getString("label.rack.rackname") %> <font color=red>*</font></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text" name="rackname" validate="Rack Name" maxlength="45" size="50" value="<%=rackname.replaceAll("\"","&quot;")%>"></td>    
			</tr>
			<tr valign="top">
			<td  class="tablebold"><%=bundle.getString("label.rack.description") %></td>
			<td width="1%" class="tablebold">:</td>
			<td class="tablelight">  
				<textarea name="description" class="tablelight" validate="Description" cols=75 rows=2  onkeydown="textCounter_label(document.MainForm.description,document.getElementById('labelid'),500)" onkeyup="textCounter(document.MainForm.description,document.getElementById('labelid'),500)"><%=description%></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.rack.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.rack.charactersleft") %></font></i>
				</td>
				</tr>
				</table>
</td>
</tr>
  
    
   
</table>
		
	
     		  <a href="RackList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.rack.back") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.rack.update") %></strong><span class="bt_green_r"></span></a>
     
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
    
<%@ include file="../../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>