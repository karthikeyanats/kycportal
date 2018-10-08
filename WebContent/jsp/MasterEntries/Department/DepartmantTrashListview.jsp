<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.department.trashlisttitle") %> </title>

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
document.MainForm.action= "DepartmentList.jsp";
document.MainForm.submit();
}


function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Department...?"))
{
document.MainForm.Deptid.value=obj.getAttribute("Deptid");
document.MainForm.action= "DepartmantDelete.jsp";
document.MainForm.submit();

}
else
{}
}
function RestoreFun(obj)
{
if(confirm("Do you want to Restore the Department...?"))
{
document.MainForm.Deptid.value=obj.getAttribute("Deptid");
document.MainForm.departmentname.value=obj.getAttribute("departmentname");
document.MainForm.description.value=obj.getAttribute("description");

document.MainForm.action= "DepartmantRestore.jsp";
document.MainForm.submit();

}
else
{}
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
         <h2><%=bundle.getString("label.department.trashlistrootpath") %> </h2>
     
<%@ page import="java.io.*,java.util.*"%>


<%
ArrayList dept=null;
HashMap newdept=null;
String instituteid = (String)session.getValue("instituteid");
dept=query_object.get_All_DepartmentTrashList(instituteid);

%>
<form name="MainForm" method="post" action="">
			<input type="hidden" name="Deptid" 			value=''>
			<input type="hidden" name="departmentname" 	value=''>
			<input type="hidden" name="description" 	value=''>

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		
	
		<tr><td valign="top">
		

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%" align="right"><%=bundle.getString("label.department.slno") %></th>
        	<th scope="col" class="rounded" width="25%" align="right"><%=bundle.getString("label.department.departmentname") %> </th>
  	        	<th scope="col" class="rounded" width="45%" align="right"><%=bundle.getString("label.department.description") %>  </th>
  	        	<th scope="col" class="rounded" width="10%" align="right"  ><%=bundle.getString("label.department.delete") %>  </th>
        	  	<th scope="col" class="rounded-q4" width="10%" align="right"  ><%=bundle.getString("label.department.restore") %>  </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(dept!=null && dept.size()>0)
				{
				for(int i=0;i<dept.size();i++)
				{
					newdept=(HashMap)dept.get(i);
				    String newdescription=(String)newdept.get("description");
					out.print("<tr valign='top'>");
					out.print("<td class='tablelight'  width='5%' >"+(i+1)+"</td>");
					out.print("<td class='tablelight'>"+newdept.get("departmentname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight'>-</td>");
					}
					
					else
					{

						  String des_temp=newdept.get("description")+"";
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
							<%=(newdept.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newdept.get("description")+"</td>");

							}					}
					out.print("<td class='tablelight'><a href='#' onclick='DeleteFun(this)'  Deptid='"+newdept.get("departmentid")+"' departmentname='"+newdept.get("departmentname")+"' description='"+newdept.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.department.delete")+"' border='0' /></td>");
					out.print("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' Deptid='"+newdept.get("departmentid")+"' departmentname='"+newdept.get("departmentname")+"' description='"+newdept.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.department.restore")+"' border='0' /></td>");

					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr >");
					//out.print("<td colspan='5' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");
	
				}
				%>
				
			
			
		</table>
  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.department.back") %> </strong><span class="bt_blue_r"></span></a>

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