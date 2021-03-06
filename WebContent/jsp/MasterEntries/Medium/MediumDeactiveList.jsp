<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.medium.deactivelistlisttitle") %></title>

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
document.MainForm.action= "MediumList.jsp";
document.MainForm.submit();
}


function RestoreFun(obj)
{
if(confirm("Do you want to Activate the Medium...?"))
{
document.MainForm.mediumid.value=obj.getAttribute("mediumid");
document.MainForm.mediumname.value=obj.getAttribute("mediumname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "MedumActive.jsp";
document.MainForm.submit();

}

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
         <h2><%=bundle.getString("label.medium.deactivelistrootpath") %></h2>
<%@ page import="java.util.*"%>

<%
ArrayList Medium=new ArrayList();
HashMap newMedium=new HashMap();
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
Medium=query_object.get_All_mediumDeactivateList(instituteid);

%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumid" value="">
<input type="hidden" name="mediumname" value="">
<input type="hidden" name="description" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		
	
		<tr><td valign="top">
		

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%" align="right"><%=bundle.getString("label.medium.slno") %></th>
        	<th scope="col" class="rounded" width="30%" align="right"><%=bundle.getString("label.medium.mediumname") %> </th>
  	        	<th scope="col" class="rounded" width="40%" align="right"><%=bundle.getString("label.medium.description") %> </th>
  	        	<th scope="col" class="rounded-q4" width="10%" align="right" ><%=bundle.getString("label.medium.active") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<%  String []count=null;
				if(Medium!=null && Medium.size()>0)
				{
				for(int i=0,j=1;i<Medium.size();i++,j++)
				{					newMedium=(HashMap)Medium.get(i);
					String newdescription=(String)newMedium.get("description");
					out.println("<tr valign='top'>");
					out.println("<td class='tablelight' width='5%'>"+j+"</td>");
					out.println("<td class='tablelight'>"+newMedium.get("mediumname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.println("<td class='tablelight'>-</td>");

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

							}						}
					out.println("<td class='tablelight'><a href='#'  mediumid='"+newMedium.get("mediumid")+"' mediumname='"+newMedium.get("mediumname")+"' description='"+newMedium.get("description")+"' onclick='RestoreFun(this)'>"+bundle.getString("hlink.medium.active")+"</td>");

					out.println("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr >");
					//out.println("<td colspan='4' align='center'class='tablelight'>Data Not Found</td>");
					//out.println("</tr>");
	
				}
				%>
			
			
		</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.medium.back") %> </strong><span class="bt_blue_r"></span></a>

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