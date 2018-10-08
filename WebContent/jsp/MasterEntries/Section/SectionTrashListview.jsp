<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.section.trashlisttitle") %></title>

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
document.MainForm.action= "SectionList.jsp";
document.MainForm.submit();
}


function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Section...?"))
{
document.MainForm.sectionid.value=obj.getAttribute("sectionid");
document.MainForm.sectionname.value=obj.getAttribute("sectionname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SectionDelete.jsp";
document.MainForm.submit();

}

}
function RestoreFun(obj)
{
if(confirm("Do you want to Restore the Section...?"))
{
document.MainForm.sectionid.value=obj.getAttribute("sectionid");
document.MainForm.sectionname.value=obj.getAttribute("sectionname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SectionRestore.jsp";
document.MainForm.submit();

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
         <h2><%=bundle.getString("label.section.trashlistrootpath") %></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList dept=new ArrayList();
HashMap newdept=new HashMap();
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

dept=query_object.get_All_sectionTrashList(instituteid);
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="sectionid" value="">
<input type="hidden" name="sectionname" value="">
<input type="hidden" name="description" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.section.slno") %></th>
        	<th scope="col" class="rounded" width="35%"><%=bundle.getString("label.section.sectionname") %> </th>
  	        <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.section.description") %> </th>
  	        <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.section.delete") %> </th>
  	        <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.section.restore") %> </th>
        	
            
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
				for(int i=0,j=1;i<dept.size();i++,j++)
				{
					newdept=(HashMap)dept.get(i);
					String newdescription=(String)newdept.get("description");
					out.println("<tr valign='top'>");
					out.println("<td class='tablelight'>"+j+"</td>");
					out.println("<td class='tablelight'>"+newdept.get("sectionname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.println("<td class='tablelight'>-</td>");

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
					out.println("<td class='tablelight'><a href='#' onclick='DeleteFun(this)'  sectionid='"+newdept.get("sectionid")+"' sectionname='"+newdept.get("sectionname")+"' description='"+newdept.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.section.delete")+"' border='0' /></td>");
					out.println("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' sectionid='"+newdept.get("sectionid")+"' sectionname='"+newdept.get("sectionname")+"' description='"+newdept.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.section.restore")+"' border='0' /></td>");


					out.println("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr >");
					//out.println("<td colspan='5' align='center'class='tablelight'>Data Not Found</td>");
					//out.println("</tr>");
	
				}
				%>
			
			
		</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.section.back") %> </strong><span class="bt_blue_r"></span></a>

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