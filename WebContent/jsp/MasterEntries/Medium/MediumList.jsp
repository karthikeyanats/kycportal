<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
			<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.medium.alllisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script language="javascript" >

function DeactiveView()
{
document.MainForm.action= "MediumDeactiveList.jsp";
document.MainForm.submit();

}

function goback()
{
document.MainForm.action= "MediumEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to Trash the Medium...?"))
{
document.MainForm.mediumid.value=obj.getAttribute("mediumid");
document.MainForm.mediumname.value=obj.getAttribute("mediumname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "MediumTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}
function editByClickFun(obj)
{
if(confirm("Do you want to Update the Medium...?"))
{
document.MainForm.mediumid.value=obj.getAttribute("mediumid");
document.MainForm.mediumname.value=obj.getAttribute("mediumname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "MediumUpdateByClick.jsp";
document.MainForm.submit();
}
else
{}
}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Medium...?"))
{
document.MainForm.mediumid.value=obj.getAttribute("mediumid");
document.MainForm.mediumname.value=obj.getAttribute("mediumname");
document.MainForm.description.value=obj.getAttribute("description");
var newdates=obj.getAttribute("newdates");
document.MainForm.action= "MediumDeactive.jsp?newdates="+newdates;
document.MainForm.submit();
}
else
{}
}
function TrashListview()
{

document.MainForm.action= "MediumTrashListview.jsp";
document.MainForm.submit();

}


</script>
</head>

<body>
<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumid" value="">
<input type="hidden" name="mediumname" value="">
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
         <h2><%=bundle.getString("label.medium.alllistrootpath") %></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList Medium=null;
HashMap newMedium=null;
String instituteid = (String)session.getValue("instituteid");
Medium=query_object.get_All_mediums(instituteid);
%>
<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.medium.slno") %></th>
        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.medium.mediumname") %> </th>
  	        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.medium.description") %> </th>
  	        		<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.medium.dateofcreation") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.medium.edit") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.medium.trash") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" align="center"><%=bundle.getString("label.medium.deactive") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
				<% String []count=null;
				if(Medium!=null && Medium.size()>0)
				{	String as=request.getContextPath();							

					for(int i=0,j=1;i<Medium.size();i++,j++)
					{
						out.print("<tr valign='top'>");
						newMedium=(HashMap)Medium.get(i);
						out.print("<td class='tablelight'>"+j+"</td>");
						out.print("<td class='tablelight'>"+newMedium.get("mediumname")+"</td>");
						String a1=newMedium.get("description")+"";
						if(a1.equals("") || a1.equals("null"))
						{
						out.print("<td class='tablelight'>-</td>");
						}
						else
						{
							 String des_temp=newMedium.get("description")+"";
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
								<%=(newMedium.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+newMedium.get("description")+"</td>");

								}			
								
						}
						out.print("<td class='tablelight'>"+newMedium.get("newdates")+"</td>");
						out.print("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' mediumid='"+newMedium.get("mediumid")+"' mediumname='"+newMedium.get("mediumname")+"' description='"+newMedium.get("description")+"' incvalue='"+i+"' tablename='maintab' class'=tablelight' onclick=editByClickFun(this)><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("label.medium.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' mediumid='"+newMedium.get("mediumid")+"' mediumname='"+newMedium.get("mediumname")+"' description='"+newMedium.get("description")+"' incvalue='"+i+"' tablename='maintab' class'=tablelight' onclick=trashFun(this)><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.medium.trash")+"' border=0 /></a></td>");

						out.print("<td class='tablelight'><a href='#' class='tablelight' onclick='DeactiveFun(this)' mediumid='"+newMedium.get("mediumid")+"' mediumname='"+newMedium.get("mediumname")+"' description='"+newMedium.get("description")+"' newdates='"+newMedium.get("newdates")+"'>"+bundle.getString("hlink.medium.deactive")+"</td>");

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
					
	
	
	
	 <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.medium.addnewitem")%> </strong><span class="bt_green_r"></span></a>
		
		    				  <a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.medium.deactivelist")%> </strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.medium.trashlist")%> </strong><span class="bt_red_r"></span></a>
		  
		  	
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