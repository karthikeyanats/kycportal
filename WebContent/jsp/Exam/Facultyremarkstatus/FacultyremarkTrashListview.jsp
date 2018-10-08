<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.facultyremarkstatus.trashlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language="JavaScript">

function editByClickFun(obj,flage)
{
	if(confirm("Do you want to "+flage+" the Faculty Remarks...?"))
	{
	
		document.MainForm.fremarkstatusid.value			= obj.getAttribute("fremarkstatusid");
		document.MainForm.flage.value=flage;
		document.MainForm.action				= "FacultyRemarkStatusUpdate.jsp";
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
         <h2><%=bundle.getString("label.facultyremarkstatus.trashlistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";
	ArrayList FacultyremarkList		= query_object.get_All_RemarlList("T",createdby,instituteid); 
%>
<form name="MainForm" method="post">
<input type="hidden" name="fremarkstatusid">
<input type="hidden" name="flage">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.facultyremarkstatus.slno") %></th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.facultyremarkstatus.facultyremarkname") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.facultyremarkstatus.dateofcreation") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.facultyremarkstatus.delete") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.facultyremarkstatus.restore") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<%
				try
				{	
					String newdescription="";
					HashMap FacultyremarkListHash=new HashMap();
				if(FacultyremarkList!=null && FacultyremarkList.size()>0)
				{	String as=request.getContextPath();					

					for(int i=0,j=1;i<FacultyremarkList.size();i++,j++)
					{
						out.print("<tr  valign='top'>");
						FacultyremarkListHash=(HashMap)FacultyremarkList.get(i); 
						String description=FacultyremarkListHash.get("description")+"";
						out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						out.print("<td class='tablelight'>"+FacultyremarkListHash.get("remarkstatusname")+"</td>");
						out.print("<td class='tablelight'>"+FacultyremarkListHash.get("newdates")+"</td>");
						out.print("<td class='tablelight'><a href='#'    fremarkstatusid='"+FacultyremarkListHash.get("fremarkstatusid")+"'  onclick=editByClickFun(this,'Delete')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.facultyremarkstatus.delete")+"' border='0' /></a></td>");
						out.print("<td class='tablelight'><a href='#'   fremarkstatusid='"+FacultyremarkListHash.get("fremarkstatusid")+"'   onclick=editByClickFun(this,'Restore')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.facultyremarkstatus.restore")+"' border='0' /></a></td>");
						out.print("</tr>");
					

					}

				}
				
				else
				{
					out.print("<tr>");
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<td colspan='5' align='center'class='tablelight'>Data Not Found</td>");
					out.print("</tr>");

				}
				}catch(Exception e){
					System.out.println(e);
				}

				%>
			
			
		</table>
		     <a href="FacultyRemarkList.jsp" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.back") %> </strong><span class="bt_green_r"></span></a>
		
	
		</td>
	</tr>
	<tr><td>
			
			
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