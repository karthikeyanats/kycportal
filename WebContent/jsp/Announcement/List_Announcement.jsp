<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.Announcement.AnnouncementEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.Announcement.AnnouncementBean" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>		
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.announcement.trashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>    
<script type="text/javascript">
function goToBack()
{
	document.frm.action= "announcement.jsp";
document.frm.submit();
}

function actionfun(obj,thisobj)
{
msgstr = "Do you want to "+obj+" the Announcement...?";
if(confirm(msgstr))
{
var contentid=thisobj.getAttribute("contentid");
document.frm.mode_of_operation.value=obj;
document.frm.head_id.value=contentid;

document.frm.action= "AnnouncementAction.jsp";
document.frm.submit();

}

}
</script>
</head>
<body>


<%@ page language="java"%>

<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%
ArrayList no_of_rows = new ArrayList();
String mode = "";
	try 
{
		mode = request.getParameter("list");
		String instituteid=(String)session.getValue("instituteid");
		instituteBean.setInstituteid(instituteid);

		instituteBean.setMode(mode);

		no_of_rows = query_object.listAnnouncement(instituteBean);
		


	} 
	catch (NullPointerException e)
	{     
		e.printStackTrace();     

	}
	
%>

<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
  
    <h2><%=bundle.getString("label.announcement.trashlistrootpath") %></h2>
<form name=frm method="post">
 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="StudentDiaryPage.jsp"></a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%" cellspacing=0
	cellpadding=0>
    <thead>
    	<tr>
        	    	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.announcement.slno") %></th>
            <th scope="col" class="rounded" width="55%"> <%=bundle.getString("label.announcement.contentname") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.announcement.dateofcreation") %></th>
             <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.announcement.delete") %></th>
             <th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.announcement.restore") %></th>
          </tr>
    </thead>
     <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    
			
		  	<tr>
		  <%
		  	try
		  	{String[] count=null;
				if(no_of_rows != null && no_of_rows.size()>0)
				{
					String state_str 	= null;
					int contentlen		= 0;
					for(int y=0,j=1;y<no_of_rows.size();y++,j++)
					{		out.println("<tr valign='top'>"); 

						HashMap hm =(HashMap)no_of_rows.get(y);
						String contentid = (String)hm.get("announcementid");
						String content = (String)hm.get("annoucementdetails");
						String status= (String)hm.get("announcementstatus");
						String newdates = (String)hm.get("newdates");
						out.println("<td class='tablelight' width='5%'>"+j+"</td>");
						if(content == null || content.equals("") || content.equals("-") || content.equalsIgnoreCase("null"))
						{
						
						out.print("<td class='tablelight'>-</td>");
						}
						else{
							
							   count=content.split(" ");
								if((count.length-1)>15)
								{
									out.print("<td class='tablelight' ");
									String des_tempnew="";
									for(int k=0;k<15;k++)
									{
										des_tempnew+=count[k]+" ";
									}%>
									<div>
									<%=content%><a href="index.htm" onclick="return hs.htmlExpand(this)">
								[<font color="red">More..</font>]
							</a>  
							<div class="highslide-maincontent">
								<h3></h3>
								<%=(content).replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+content+"</td>");

								}
								}						out.println("<td class='tablelight'>"+newdates+"</td>");
						out.println("<td class='tablelight'><a href='#' onclick=actionfun('Delete',this)  contentid='"+hm.get("announcementid")+"' content='"+hm.get("annoucementdetails")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></td>");
						out.println("<td class='tablelight'><a href='#' onclick=actionfun('Restore',this) contentid='"+hm.get("announcementid")+"' content='"+hm.get("annoucementdetails")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></td>");

						out.println("</tr>");
						
					}     
				}
				else
				{
					out.println("<td colspan='5' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.println("<td align=center colspan=5>Data Not Found</td>");
				}
		  	}
		  	catch(Exception e)
		  	{
		  		System.out.println(e);
		  	}
		  	%>
		  
    
    
    
    
   
   
     <tbody>
</tbody>
</table>
    		<a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.announcement.back") %> </strong><span class="bt_blue_r"></span></a>	



    <thead>
    
 
 <input type=hidden name=mode_of_operation>
         <input type=hidden name=head_id>

</td></tr></TABLE>
    </thead>
</table>
</form>


   
 
     </td>
     </tr>
     </TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    
</form>

</div>
</body>
</html>