<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.subjecttype.entrytitle") %></title>

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
document.MainForm.action= "SubjectTypeEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to Trash the Subject Type...?"))
{

document.MainForm.subjectypename.value=obj.getAttribute("subjectypename");
document.MainForm.subjecttypeid.value=obj.getAttribute("subjecttypeid");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SubjectTypeTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}
function editByClickFun(obj)
{
if(confirm("Do you want to Update the Subject Type...?"))
{
document.MainForm.subjectypename.value=obj.getAttribute("subjectypename");
document.MainForm.subjecttypeid.value=obj.getAttribute("subjecttypeid");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SubjectTypeUpdateByClick.jsp";
document.MainForm.submit();
}

}
function DeactiveFun(obj)
{


document.MainForm.action= "SubjectTypeDeactiveList.jsp";
document.MainForm.submit();

}
function TrashListview()
{

document.MainForm.action= "SubjectTypeTrashListview.jsp";
document.MainForm.submit();

}
function BoardDeactiveView(obj)
{
if(confirm("Do you want to Deactivate the Subject Type...?"))
{
document.MainForm.newdates.value=obj.getAttribute("newdates");
document.MainForm.subjectypename.value=obj.getAttribute("subjectypename");
document.MainForm.subjecttypeid.value=obj.getAttribute("subjecttypeid");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "SubjectTypeDeactiveView.jsp";
document.MainForm.submit();
}

}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">
<input type="hidden" name="subjectypename" value="">
<input type="hidden" name="subjecttypeid" value="">
<input type="hidden" name="description" value="">
<input type="hidden" name="newdates" value="">

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
         <h2><%=bundle.getString("label.subjecttype.alllistrootpath") %></h2>

<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList SubjectType=new ArrayList();
HashMap newSubjectType=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

SubjectType=query_object.get_All_groups(instituteid);
%>

<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
	        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.subjecttype.slno") %></th>
	        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.subjecttype.subjecttypename") %></th>
        	  	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.subjecttype.description") %> </th>
        	  	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.subjecttype.dateofcreation") %></th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.subjecttype.edit") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.subjecttype.trash") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" ><%=bundle.getString("label.subjecttype.deactive") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(SubjectType!=null && SubjectType.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0,j=1;i<SubjectType.size();i++,j++)
					{
						out.println("<tr valign='top'>");
						newSubjectType=(HashMap)SubjectType.get(i);
						out.println("<td class='tablelight'>"+j+"</td>");
						out.println("<td class='tablelight'>"+newSubjectType.get("subjectypename")+"</td>");
						
						String a1=newSubjectType.get("description")+"";
						if(a1.equals("") || a1.equals("null"))
						{
						out.println("<td class='tablelight'>-</td>");
						}
						else{
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

								}						}
						out.println("<td class='tablelight'>"+newSubjectType.get("newdates")+"</td>");
												
						out.println("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"'  subjecttypeid='"+newSubjectType.get("subjecttypeid")+"'  incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.subjecttype.edit") +"' border=0 /></a></td>");
						out.println("<td class='tablelight'><a href='#' class='tablelight'   subjecttypeid='"+newSubjectType.get("subjecttypeid")+"' onclick='trashFun(this)'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.subjecttype.trash")+"' border=0 /></a></td>");
						
						out.println("<td class='tablelight'><a href='#' class='tablelight'  subjectypename='"+newSubjectType.get("subjectypename")+"' description='"+newSubjectType.get("description")+"' subjecttypeid='"+newSubjectType.get("subjecttypeid")+"'  newdates='"+newSubjectType.get("newdates")+"' onclick='BoardDeactiveView(this)'>"+bundle.getString("hlink.subjecttype.deactive")+"</td>");

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
			
			
		</table>
				 
		
		
		
		 <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subjecttype.addnewitem") %> </strong><span class="bt_green_r"></span></a>
		<a href="#" onclick="DeactiveFun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subjecttype.deactivelist") %> </strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.subjecttype.trashlist") %> </strong><span class="bt_red_r"></span></a>	
		  
		  
		</td>
	</tr>
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			<input type="hidden" name="roleids" value="<%=roleids%>">
			
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