<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.subjecttype.deactivelistlisttitle") %></title>

<LINK rel=stylesheet href="../css/kyccss.css">
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
document.MainForm.action= "SubjectTypeList.jsp";
document.MainForm.submit();
}



function RestoreFun(obj)
{
if(confirm("Do you want to Activate the Subject Type...?"))
{
document.MainForm.subjectypename.value=obj.getAttribute("subjectypename");
document.MainForm.subjecttypeid.value=obj.getAttribute("subjecttypeid");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SubjectTypeActive.jsp";
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
         <h2><%=bundle.getString("label.subjecttype.deactivelistrootpath") %></h2>

<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList SubjectType=new ArrayList();
HashMap newSubjectType=new HashMap();
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

SubjectType=query_object.get_All_groupDeactivateList(instituteid);
%>

<form name="MainForm" method="post" action="">
<input type="hidden" name="subjectypename" value="">
<input type="hidden" name="subjecttypeid" value="">
<input type="hidden" name="description" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.subjecttype.slno") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.subjecttype.subjecttypename") %> </th>
  	        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.subjecttype.description") %> </th>
  	        	<th scope="col" class="rounded-q4" width="10%"  ><%=bundle.getString("label.subjecttype.active") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(SubjectType!=null && SubjectType.size()>0)
				{
				for(int i=0,j=1;i<SubjectType.size();i++,j++)
				{					newSubjectType=(HashMap)SubjectType.get(i);
					String newdescription=(String)newSubjectType.get("description");
					out.print("<tr valign='top'>");
					out.print("<td class='tablelight'>"+j+"</td>");
					out.print("<td class='tablelight'>"+newSubjectType.get("subjectypename")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight'>-</td>");

					}
					else
					{
						String des_temp=newSubjectType.get("description")+"";
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
							<%=(newSubjectType.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newSubjectType.get("description")+"</td>");

							}							}
					out.print("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' subjecttypeid='"+newSubjectType.get("subjecttypeid")+"' subjectypename='"+newSubjectType.get("subjectypename")+"' description='"+newSubjectType.get("description")+"'>"+bundle.getString("hlink.subjecttype.active") +"</td>");
					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='4' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");
	
				}
				%>
			
			
		</table>
 <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subjecttype.back") %> </strong><span class="bt_blue_r"></span></a>

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