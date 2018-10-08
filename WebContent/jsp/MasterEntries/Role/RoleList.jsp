<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title><%=bundle.getString("label.role.alllisttitle") %></title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
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

function DeactiveView()
{
document.MainForm.action= "RoleDeactiveView.jsp";
document.MainForm.submit();

}


function goback()
{
document.MainForm.action= "RoleEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to Trash the Role...? "))
{
document.MainForm.roleid.value=obj.getAttribute("roleid");
document.MainForm.rolename.value=obj.getAttribute("rolename");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "RoleTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}

function editByClickFun(obj) 
{      
if(confirm("Do you want to Update the Role...?"))
{
	document.MainForm.roleid.value=obj.getAttribute("roleid");
	document.MainForm.rolename.value=obj.getAttribute("rolename");
	document.MainForm.description.value=obj.getAttribute("description");            
	document.MainForm.action= "RoleUpdateByClick.jsp";
	document.MainForm.submit();
}

}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Role...?"))
{
document.MainForm.roleid.value=obj.getAttribute("roleid");
document.MainForm.rolename.value=obj.getAttribute("rolename");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "RoleDeactivatePreview.jsp";
document.MainForm.submit();
}
else
{}
}
function TrashListview()
{

document.MainForm.action= "RoleTrashListview.jsp";
document.MainForm.submit();

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
         <h2><%=bundle.getString("label.role.alllistrootpath") %></h2>
<%@ page import="java.util.*"%>

<%
ArrayList Role=new ArrayList();
HashMap newRole=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
instituteBean.setinstituteid(instituteid);
Role=query_object.get_All_Roles(instituteid);
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="roleid" value="">
<input type="hidden" name="rolename" value="">
<input type="hidden" name="description" value="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.role.slno") %></th>
        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.role.rolename") %>  </th>
  	        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.role.description") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.role.dateofcreation") %></th>
				<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.role.edit") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.role.trash") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" align="center"><%=bundle.getString("label.role.deactive") %> </th>    	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
				<% 
				String []count=null;
				if(Role!=null && Role.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0;i<Role.size();i++)
					{
						out.print("<tr valign='top'>");
						newRole=(HashMap)Role.get(i);
						out.print("<td class='tablelight' valign='top'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+newRole.get("rolename")+"</td>");
						String a1=newRole.get("description")+"";
						if(a1 == null || a1.equals("") || a1.equals("null"))	
						{
						out.print("<td class='tablelight' valign='top'>-</td>");
						}
						else
						{
							String des_temp=newRole.get("description")+"";
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
								<%=(newRole.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+newRole.get("description")+"</td>");

								}
						}
						out.print("<td class='tablelight' valign='top'>"+newRole.get("newdates")+"</td>");


						out.print("<td class='tablelight' valign='top'><a href='#'  id='check' rowpos='"+i+"' roleid='"+newRole.get("roleid")+"' rolename='"+newRole.get("rolename")+"' description='"+newRole.get("description")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.role.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight' valign='top'><a href='#' class='tablelight' onclick='trashFun(this)' roleid='"+newRole.get("roleid")+"' rolename='"+newRole.get("rolename")+"' description='"+newRole.get("description")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.role.trash")+"' border=0 /></a></td>");
						out.print("<td class='tablelight' valign='top'><a href='#' class='ask' onclick='DeactiveFun(this)' roleid='"+newRole.get("roleid")+"' rolename='"+newRole.get("rolename")+"' description='"+newRole.get("description")+"'>"+bundle.getString("label.role.deactive")+"</td>");
						out.print("</tr>");
						
			
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='7' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");

				}
				

				%>
			
			
		</table>
				
	
	
	
	
		  <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.role.addnewitem") %></strong><span class="bt_green_r"></span></a>
		  <a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.role.deactivelist") %> </strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.role.trashlist") %> </strong><span class="bt_red_r"></span></a>
		  
		  
		  
		  	
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