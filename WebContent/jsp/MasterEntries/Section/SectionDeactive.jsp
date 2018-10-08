<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.section.deactivepreviewlisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language="JavaScript">


function goToBack()
{
	document.MainForm.action= "SectionList.jsp";
document.MainForm.submit();
}
function goToDeactive()
{
if(confirm("Do you want to Deactivate the Section...?"))
{
	document.MainForm.action= "SectionDeactiveFinal.jsp";
document.MainForm.submit();
}
else
{
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
         <h2><%=bundle.getString("label.section.deactivepreviewlistrootpath") %></h2>
<%@ page language="java" import="java.util.*"%>
<%
	String sectionid = request.getParameter("sectionid");
	String newdates = request.getParameter("newdates");

String curstatus="D";

instituteBean.setStatus(curstatus);

ArrayList getDetailsForuadate=query_object.getDetailsForuadate(sectionid);

HashMap as1=new HashMap();
ArrayList as=query_object.checkTrashSection(sectionid,(String)session.getValue("instituteid")+"");

HashMap DetailsForuadate=null;
String sectionname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	sectionname=(String)DetailsForuadate.get("sectionname");
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
	
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.section.deactivepreviewtableheading") %> </th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
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
</table>
	<tr>
		<td>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.section.sectionname") %> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=sectionname%></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.section.description") %> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=description%></td>
			</tr>

			<%
			String status="";
			String staffcount="";
		    String studentcount="";			
			if(as.size()>0 && as!=null)
			{
				for(int i=0;i<as.size();i++)
				{
					as1=(HashMap)as.get(i);
					status=(String)as1.get("status");
					if(status.equals("Staff"))
					{
						staffcount=(String)as1.get("studentcount");
					}
					else
					{
						studentcount=(String)as1.get("studentcount");
					}

				}
			}
			%>
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.section.trashpreviewerrormessage") %></td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=studentcount%></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.section.trashpreviewerrormessage_1") %></td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=staffcount%></td>
			</tr>			
			
			<!-- <tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.section.dateofcreation") %></td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=newdates%></td>
			</tr>-->
		</table>
		<br>
		
	 <a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.section.back") %> </strong><span class="bt_blue_r"></span></a>

			 <%
			if(studentcount.equals("0") && staffcount.equals("0"))
			{%>
	     <a href="#" class="bt_green" onclick="goToDeactive()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.section.deactive") %></strong><span class="bt_green_r"></span></a>
	 <%}
	 else
	 {out.println("<div class='warning_box'>");
	 	out.println("<a align=center class='tablebold'>"+bundle.getString("label.section.deactivatepreviewerrormessagedetails")+"</a>");
	 	out.println("</div >");
	 }%>

	<tr><td>
	<input type="hidden" name="sectionid" value="<%=sectionid %>">
	</td></tr>
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