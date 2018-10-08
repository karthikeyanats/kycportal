<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.group.alllisttitle") %></title>

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

function goback()
{
document.MainForm.action= "GroupEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to Trash the Group...?"))
{
document.MainForm.groupid.value=obj.getAttribute("groupid");
document.MainForm.groupname.value=obj.getAttribute("groupname");
document.MainForm.description.value=obj.getAttribute("description");

document.MainForm.action= "GroupTrashPriview.jsp";
document.MainForm.submit();
}

}
function editByClickFun(obj)
{
if(confirm("Do you want to Update the Group...?"))
{
document.MainForm.groupid.value=obj.getAttribute("groupid");
document.MainForm.groupname.value=obj.getAttribute("groupname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "GroupUpdateByClick.jsp";
document.MainForm.submit();
}

}
function DeactiveFun(obj)
{


document.MainForm.action= "GroupDeactiveList.jsp";
document.MainForm.submit();

}
function TrashListview()
{

document.MainForm.action= "GroupTrashListview.jsp";
document.MainForm.submit();

}
function BoardDeactiveView(obj)
{
	if(confirm("Do you want to Deactivate the Group...?"))
	{
		document.MainForm.groupid.value=obj.getAttribute("groupid");
		document.MainForm.groupname.value=obj.getAttribute("groupname");
		document.MainForm.description.value=obj.getAttribute("description");
		document.MainForm.newdates.value=obj.getAttribute("newdates");
		document.MainForm.action= "GroupDeactiveView.jsp";
		document.MainForm.submit();
	}

}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">
<input type="hidden" name="groupid" value="">
<input type="hidden" name="groupname" value="">
<input type="hidden" name="description" value="">
<input type="hidden" name="newdates" value="">

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
         <h2><%=bundle.getString("label.group.alllistrootpath") %></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList Group=new ArrayList();
HashMap newGroup=new HashMap();
String instituteid = (String)session.getValue("instituteid");
Group=query_object.get_All_groups(instituteid);

%>
<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.group.slno") %></th>
        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.group.groupname") %> </th>
  	        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.group.description") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.group.dateofcreation") %></th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.group.edit") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.group.trash") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" align="center"><%=bundle.getString("label.group.deactive") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(Group!=null && Group.size()>0)
				{	String as=request.getContextPath();							
					

					for(int i=0,j=1;i<Group.size();i++,j++)
					{
						out.println("<tr valign='top'>");
						newGroup=(HashMap)Group.get(i);
						out.println("<td class='tablelight'>"+j+"</td>");
						out.println("<td class='tablelight'>"+newGroup.get("groupname")+"</td>");
						String a1=newGroup.get("description")+"";
						if(a1.equals("") || a1.equals("null"))	
						{
						out.println("<td class='tablelight'>-</td>");
						}
						else{
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
						out.println("<td class='tablelight'>"+newGroup.get("newdates")+"</td>");

						out.println("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' groupid='"+newGroup.get("groupid")+"' groupname='"+newGroup.get("groupname")+"' description='"+newGroup.get("description")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.group.edit")+"' border=0 /></a></td>");
						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='trashFun(this)' groupid='"+newGroup.get("groupid")+"' groupname='"+newGroup.get("groupname")+"' description='"+newGroup.get("description")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.group.trash")+"' border=0 /></a></td>");

						
						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='BoardDeactiveView(this)' groupid='"+newGroup.get("groupid")+"' groupname='"+newGroup.get("groupname")+"' description='"+newGroup.get("description")+"' newdates='"+newGroup.get("newdates")+"'>"+bundle.getString("hlink.group.deactive")+"</td>");

						out.println("</tr>");
						
			
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan='7' align='center'class='tablelight'>Data Not Found</td>");
					//out.println("</tr>");

				}
				

				%>
			
			
		</table>
 		
	
	
	
	
	
	
		 <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.group.addnewitem") %></strong><span class="bt_green_r"></span></a>
		
		    				  <a href="#" onclick="DeactiveFun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.group.deactivelist") %></strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.group.trashlist") %> </strong><span class="bt_red_r"></span></a>
	
	
	
		</td>
	</tr>
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			
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