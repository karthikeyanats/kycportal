<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.access.trashlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language="JavaScript">



      
function editByClickFun(obj,status)
{
	
		if(confirm("Do you want to "+status+" the Details"))
		{ 
			if(status=="Delete")
			{
			document.MainForm.accessid.value			= obj.getAttribute("accessid");
			document.MainForm.flage.value			= "Delete";
			document.MainForm.action= "AcessStatusUpdate.jsp";
			document.MainForm.submit();
			}
			else
			{
			document.MainForm.accessid.value			= obj.getAttribute("accessid");
			document.MainForm.flage.value			= "Restore";
			document.MainForm.action= "AcessStatusUpdate.jsp";
			document.MainForm.submit();
			}
		}
	
}




</script>
</head>

<body>


<div id="main_container">

	<div class="header">
	
<%@ include file="../../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.access.alltrashlistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";
	ArrayList AccessList		= query_object.get_All_AccessList(instituteid,"T");   
%>
<form name="MainForm" method="post">
<input type="hidden" name="rackid">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.access.slno") %></th>
        	<th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.RoleName") %> </th>
  	        	<th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.renewdays") %> </th>
  	        	<th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.returndays") %> </th>
  	        	<th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.renewcount") %> </th>
  	        	<th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.fineperday") %> </th>
        	  	 <th scope="col" class="rounded" width="13%"><%=bundle.getString("label.access.noofbooks") %> </th>
	  	         <th scope="col" class="rounded" width="7%"><%=bundle.getString("label.access.delete") %> </th>
	  	          <th scope="col" class="rounded-q4" width="7%" ><%=bundle.getString("label.access.restore") %> </th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=8  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>  
   
		
				<% 
				boolean flage_teacher=false;
				boolean flage_student=false;
				try
				{	
					
					HashMap AccessListMap=new HashMap();
					if(AccessList!=null && AccessList.size()>0)
					{	
						String as=request.getContextPath();	
						for(int i=0,k=1;i<AccessList.size();i++,k++)
						{
							AccessListMap=(HashMap)AccessList.get(i);
							String userstatus=AccessListMap.get("userstatus")+"";
							 String rolename=AccessListMap.get("rolename")+"";							
						
						out.print("<tr valign='top'>"); 
						out.print("<td class='tablelight'>"+k+"</td>");
						out.print("<td class='tablelight'>"+rolename+"</td>");
						out.print("<td class='tablelight'>"+AccessListMap.get("renewdays")+"</td>");
						out.print("<td class='tablelight'>"+AccessListMap.get("returndays")+"</td>");
						out.print("<td class='tablelight'>"+AccessListMap.get("renewcount")+"</td>");
						out.print("<td class='tablelight'>"+AccessListMap.get("fineperday")+"</td>");
						out.print("<td class='tablelight'>"+AccessListMap.get("noofbooks")+"</td>");
						out.print("<td class='tablelight'><a href='#'    accessid='"+AccessListMap.get("accessid")+"' onclick=editByClickFun(this,'Delete')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a></td>");
						out.print("<td><a href='#'   accessid='"+AccessListMap.get("accessid")+"'   onclick=editByClickFun(this,'Restore')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></a></td>");
						out.print("</tr>"); 
						}
					}  
					else
					{
						out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
						//out.print("<tr><td colspan='9' align=center>Data Not Found</td></tr>");
					}
				}
				catch(Exception e)
				{
					System.out.println(e);
				}

				%>
			
			
		</table>
		    
		  <input type="hidden" name="accessid">  
		  <input type="hidden" name="flage">
	  		<a href="AccessList.jsp"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.access.back")%></strong><span class="bt_blue_r"></span></a>
	 
		
			
			
		    
		    
		    
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
    
<%@ include file="../../../include/footer.jsp" %>

</div>

</body>
</html>