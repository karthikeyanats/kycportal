<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.group.deactivelistlisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>
<script language="JavaScript">

	

function Groupview()
{
document.MainForm.action= "GroupList.jsp";
document.MainForm.submit();
}
function goback()
{
document.MainForm.action= "GroupList.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{

var groupid=obj.getAttribute("groupid");
var groupname=obj.getAttribute("groupname");
var description=obj.getAttribute("description");
document.MainForm.action= "SectionTrashPriview.jsp";
document.MainForm.submit();
}

function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Group...?"))
{
var groupid=obj.getAttribute("groupid");
var groupname=obj.getAttribute("groupname");
var description=obj.getAttribute("description");
document.MainForm.action= "GroupDelete.jsp";
document.MainForm.submit();

}
else
{}
}
function RestoreFun(obj)
{
if(confirm("Do you want to Activate the Group...?"))
{
document.MainForm.groupid.value=obj.getAttribute("groupid");
document.MainForm.groupname.value=obj.getAttribute("groupname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "GroupActive.jsp";
document.MainForm.submit();

}
else
{}
}
</script>
</head>

<body>
<form name="MainForm" method="post" action="">
<input type="hidden" name="groupid" value="">
<input type="hidden" name="groupname" value="">
<input type="hidden" name="description" value="">
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
         <h2><%=bundle.getString("label.group.deactivelistrootpath") %></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList Group=null;
HashMap newGroup=null;
String instituteid = (String)session.getValue("instituteid");

Group=query_object.get_All_groupDeactivateList(instituteid);
%>

<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		
	
		<tr><td valign="top">
		

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%" align="right"><%=bundle.getString("label.group.slno") %></th>
        	<th scope="col" class="rounded" width="30%" align="right"><%=bundle.getString("label.group.groupname") %> </th>
  	        	<th scope="col" class="rounded" width="40%" align="right"><%=bundle.getString("label.group.description") %> </th>
  	        	<th scope="col" class="rounded-q4" width="10%" align="right" ><%=bundle.getString("label.group.active") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String[] count=null;
				if(Group!=null && Group.size()>0)
				{
				for(int i=0,j=1;i<Group.size();i++,j++)
				{					newGroup=(HashMap)Group.get(i);
					String newdescription=(String)newGroup.get("description");
					out.print("<tr valign='top'>");
					out.print("<td class='tablelight' width='5%'>"+j+"</td>");
					out.print("<td class='tablelight'>"+newGroup.get("groupname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight'>-</td>");

					}
					else
					{
						String des_temp=newGroup.get("description")+"";
						   count=des_temp.split(" ");
							if((count.length-1)>15)
							{
								out.print("<td class='tablelight' ");
								String des_tempnew="";
								for(int s=0;s<15;s++)
								{
									des_tempnew+=count[s]+" ";
								}%>
								<div>
								<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
							[<font color="red">More..</font>]
						</a>  
						<div class="highslide-maincontent">
							<h3></h3>
							<%=(newGroup.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newGroup.get("description")+"</td>");

							}						}
					out.print("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' groupid='"+newGroup.get("groupid")+"' groupname='"+newGroup.get("groupname")+"' description='"+newGroup.get("description")+"'>"+bundle.getString("label.group.active")+"</td>");

					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr >");
					//out.print("<td colspan='4' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");
	
				}
				%>
			
			
		</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.group.back") %> </strong><span class="bt_blue_r"></span></a>

		</td>
	</tr>

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