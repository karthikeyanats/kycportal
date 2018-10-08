<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.department.alllisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language="JavaScript">

function DeactiveView()
{
document.MainForm.action= "DeactiveView.jsp";
document.MainForm.submit();

}


function goback()
{
document.MainForm.action= "DepartmentEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
	if(confirm("Do you want to trash the Department...?"))
	{
		document.MainForm.Deptid.value			= obj.getAttribute("Deptid");
		document.MainForm.departmentname.value	= obj.getAttribute("departmentname");
		document.MainForm.description.value		= obj.getAttribute("description");
		
		document.MainForm.action				= "DepartmentTrashPriview.jsp";
		document.MainForm.submit();
	}
}         
function editByClickFun(obj)
{
	if(confirm("Do you want to Update the Department...?"))
	{
		document.MainForm.Deptid.value			= obj.getAttribute("Deptid");
		document.MainForm.departmentname.value	= obj.getAttribute("departmentname");
		document.MainForm.description.value		= obj.getAttribute("description");
		
		document.MainForm.action= "DepartmentUpdateByClick.jsp";
		document.MainForm.submit();
	}

}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Department...?"))
{
  
		document.MainForm.Deptid.value			= obj.getAttribute("Deptid");
		document.MainForm.departmentname.value	= obj.getAttribute("departmentname");
		document.MainForm.description.value		= obj.getAttribute("description");
		document.MainForm.action= "DepartmentDeactivePreview.jsp";
		document.MainForm.submit();
}

}
function TrashListview()
{

document.MainForm.action= "DepartmantTrashListview.jsp";
document.MainForm.submit();

}


</script>
</head>

<body>


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
         <h2><%=bundle.getString("label.department.alllistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	HashMap newdept		= null;
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";
	ArrayList dept		= query_object.get_All_Departments(instituteid);

%>
<form name="MainForm" method="post">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.department.slno") %></th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.department.departmentname") %> </th>
  	        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.department.description") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.department.dateofcreation") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.department.edit") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.department.trash") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" align="center"><%=bundle.getString("label.department.deactive") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<% 
				try
				{
					String []count=null;

				if(dept!=null && dept.size()>0)
				{	String as=request.getContextPath();					

					for(int i=0,j=1;i<dept.size();i++,j++)
					{
						out.print("<tr  valign='top'>");
						newdept=(HashMap)dept.get(i); 
						out.print("<td class='tablelight'>"+j+"</td>");
						out.print("<td class='tablelight'>"+newdept.get("departmentname")+"</td>");
						if(newdept.get("description").equals(""))
						{
						out.print("<td class='tablelight'>-</td>");
						}
						else{
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

								}
								}
						out.print("<td class='tablelight'>"+newdept.get("newdates")+"</td>");
						out.print("<td class='tablelight'><a href='#'    Deptid='"+newdept.get("departmentid")+"' departmentname='"+newdept.get("departmentname")+"' description='"+newdept.get("description")+"' class='tablelight' onclick=editByClickFun(this)><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.department.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight'><a href='#'   Deptid='"+newdept.get("departmentid")+"' departmentname='"+newdept.get("departmentname")+"' description='"+newdept.get("description")+"'  onclick=trashFun(this)><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.department.trash")+"' border=0 /></a></td>");
						out.print("<td class='tablelight'><a href='#'  onclick='DeactiveFun(this)' Deptid='"+newdept.get("departmentid")+"' departmentname='"+newdept.get("departmentname")+"' description='"+newdept.get("description")+"'>"+bundle.getString("hlink.department.deactive")+"</td>");
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
				}catch(Exception e){}

				%>
			
			
		</table>
		     <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.department.addnewitem") %> </strong><span class="bt_green_r"></span></a>
		
		    				  <a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.department.deactivelist") %> </strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.department.trashlist") %></strong><span class="bt_red_r"></span></a>
	
		</td>
	</tr>
	<tr><td>
			<input type="hidden" name="sessiontype" 	value="ExistSession">
			<input type="hidden" name="roleids" 		value="<%=roleids%>">
			<input type="hidden" name="Deptid" >  
			<input type="hidden" name="departmentname" >   
			<input type="hidden" name="description" >   
			
</td></tr>	

</TABLE>   
</form> 
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

</body>
</html>