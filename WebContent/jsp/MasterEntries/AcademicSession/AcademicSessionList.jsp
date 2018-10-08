<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.alllisttitle") %></title>

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
document.MainForm.action= "AcademicSessionEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to Trash the Academic Session...?"))
{

var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");
var sessionstatus=obj.getAttribute("sessionstatus");

document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.sessionstatus.value=sessionstatus;


document.MainForm.action= "AcademicSessionTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}
function editByClickFun(obj)
{
if(confirm("Do you want to Update the Academic Session...?"))
{
var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");
var sessionstatus=obj.getAttribute("sessionstatus");

document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.sessionstatus.value=sessionstatus;
document.MainForm.action= "AcademicSessionUpdateByClick.jsp";
document.MainForm.submit();
}
else
{}
}
function DeactiveFun(obj)
{


document.MainForm.action= "AcademicSessionDeactiveList.jsp";
document.MainForm.submit();

}
function TrashListview()
{

document.MainForm.action= "AcademicSessionTrashListview.jsp";
document.MainForm.submit();

}
function BoardDeactiveView(obj)
{
if(confirm("Do you want to Deactivate the Academic Session...?"))
{

var newdates=obj.getAttribute("newdates");


var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");
var sessionstatus=obj.getAttribute("sessionstatus");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.newdates.value=newdates;
document.MainForm.sessionstatus.value=sessionstatus;


document.MainForm.action= "AcademicSessionDeactiveView.jsp";
document.MainForm.submit();
}
else{}
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
         <h2><%=bundle.getString("label.academicsession.alllistrootpath") %></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList AcademicSec=new ArrayList();
HashMap newAcademicSec=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
AcademicSec=query_object.get_All_AcademicSessions(instituteid);

%>
<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<tr><td valign="top">

		
<table id="rounded-corner" border=0  width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.academicsession.slno") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.academicsession.academicsessionname") %></th>
            <th scope="col" class="rounded" width="30%">Duration</th>
            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.academicsession.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.academicsession.dateofcreation") %></th>
			<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.academicsession.edit") %> </th>
  	        <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.academicsession.trash") %> </th>
  	        <%-- <th scope="col" class="rounded-q4" width="10%" align="center"><%=bundle.getString("label.academicsession.deactive") %> </th></tr> --%>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <% String []count=null;
     String startmonth= null;
     String startyear= null;
     String endmonth= null;
     String endyear= null;
				if(AcademicSec!=null && AcademicSec.size()>0)
				{	String as=request.getContextPath();							

					for(int i=0,j=1;i<AcademicSec.size();i++,j++)
					{
						out.println("<tr valign='top'>");
						newAcademicSec=(HashMap)AcademicSec.get(i);
						
						
						if(newAcademicSec.get("startmonth")==null)
							startmonth = "-";
						else
							startmonth=(String)newAcademicSec.get("startmonth");
						
						if(newAcademicSec.get("startyear")==null)
							startyear = "-";
						else
						startyear=(String)newAcademicSec.get("startyear");
						
						if(newAcademicSec.get("endmonth")==null)
							endmonth = "-";
						else
							endmonth = (String)newAcademicSec.get("endmonth");
						
						if(newAcademicSec.get("endyear")==null)
							endyear = "-";
						else
						endyear =(String) newAcademicSec.get("endyear");
						
						out.println("<td class='tablelight'>"+j+"</td>");
						out.println("<td class='tablelight'>"+newAcademicSec.get("sessionname")+"</td>");
						if(newAcademicSec.get("startmonth") == null  && newAcademicSec.get("startyear")==null && newAcademicSec.get("endyear")==null && newAcademicSec.get("endmonth")==null)
						{
							out.println("<td class='tablelight'>Not Yet Set</td>");
						}
						else
						{
							out.println("<td class='tablelight'>"+startmonth+"-"+startyear+" TO "+endmonth+"-"+endyear+"</td>");
						}
						String a1=newAcademicSec.get("description")+"";
						if(a1.equals("") || a1.equals("null"))
						{
						out.println("<td class='tablelight'>-</td>");
						}
						else{
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

								}						}
						out.println("<td class='tablelight'>"+newAcademicSec.get("newdates")+"</td>");
						out.println("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' sessionstatus='"+newAcademicSec.get("sessionstatus")+"' sessionid='"+newAcademicSec.get("sessionid")+"' sessionname='"+newAcademicSec.get("sessionname")+"' description='"+newAcademicSec.get("description")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.academicsession.edit")+"' border=0 /></a></td>");
						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='trashFun(this)' sessionstatus='"+newAcademicSec.get("sessionstatus")+"' sessionname='"+newAcademicSec.get("sessionname")+"' sessionid='"+newAcademicSec.get("sessionid")+"' description='"+newAcademicSec.get("description")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.academicsession.trash")+"' border=0 /></a></td>");
						
						/* out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='BoardDeactiveView(this)' sessionstatus='"+newAcademicSec.get("sessionstatus")+"' sessionname='"+newAcademicSec.get("sessionname")+"' sessionid='"+newAcademicSec.get("sessionid")+"' description='"+newAcademicSec.get("description")+"' newdates='"+newAcademicSec.get("newdates")+"'>"+bundle.getString("hlink.academicsession.deactive")+"</td>"); */

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
    </tbody>
</table>
</td>
</tr>
	</table>
			
	
	
	
	
		
	 <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%= bundle.getString("button.academicsession.addnewitem")%> </strong><span class="bt_green_r"></span></a>
		
<%-- 		    				  <a href="#" onclick="DeactiveFun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.academicsession.deactivelist")%> </strong><span class="bt_blue_r"></span></a>
 --%>		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%= bundle.getString("button.academicsession.trashlist")%> </strong><span class="bt_red_r"></span></a>
		  
		  	
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistAcademicSession">
			<input type="hidden" name="roleids" value="<%=roleids%>">
						<input type="hidden" name="sessionname" value="">
						<input type="hidden" name="sessionid" value="">
						<input type="hidden" name="description" value="">
						
						<input type="hidden" name="sessionstatus" value="">
					<input type="hidden" name="newdates" value="">
			
			
</td></tr>	

</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>