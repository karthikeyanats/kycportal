<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.trashlisttitle") %></title>

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
document.MainForm.action= "AcademicSessionList.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.action= "SubjectModeTrashPriview.jsp";
document.MainForm.submit();


}

function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Academic Session...?"))
{
var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.action= "AcademicSessionDelete.jsp";
document.MainForm.submit();



}
else
{}
}
function RestoreFun(obj)
{
if(confirm("Do you want to Restore the Academic Session...?"))
{
var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;

document.MainForm.action= "AcademicSessionRestore.jsp";
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
         <h2><%=bundle.getString("label.academicsession.trashlistrootpath") %></h2>

<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList AcademicSec=new ArrayList();
HashMap newAcademicSec=new HashMap();
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

AcademicSec=query_object.get_All_SessionTrashList(instituteid);
%>
<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.academicsession.slno") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.academicsession.academicsessionname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.academicsession.description") %></th>
           <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.academicsession.delete") %></th>
           <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.academicsession.restore") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
				<% String []count=null;
				if(AcademicSec!=null && AcademicSec.size()>0)
				{
				for(int i=0,j=1;i<AcademicSec.size();i++,j++)
				{	
					newAcademicSec=(HashMap)AcademicSec.get(i);
					String newdescription=(String)newAcademicSec.get("description");
					out.println("<tr valign='top'>");
					out.println("<td class='tablelight'>"+j+"</td>");
					out.println("<td class='tablelight'>"+newAcademicSec.get("sessionname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.println("<td class='tablelight'>-</td>");

					}
					else
					{
						String des_temp=newAcademicSec.get("description")+"";
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
							<%=(newAcademicSec.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newAcademicSec.get("description")+"</td>");

							}					}
					out.println("<td class='tablelight'><a href='#' onclick='DeleteFun(this)'  sessionid='"+newAcademicSec.get("sessionid")+"' sessionname='"+newAcademicSec.get("sessionname")+"' description='"+newAcademicSec.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.academicsession.delete")+"' border='0' /></td>");
					out.println("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' sessionid='"+newAcademicSec.get("sessionid")+"' sessionname='"+newAcademicSec.get("sessionname")+"' description='"+newAcademicSec.get("description")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.academicsession.restore")+"' border='0' /></td>");
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
			
			
</tbody>
</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.academicsession.back") %> </strong><span class="bt_blue_r"></span></a>

<input type="hidden" name="sessionname" value="">
						<input type="hidden" name="sessionid" value="">
						<input type="hidden" name="description" value="">
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