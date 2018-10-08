<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
	<%@ page import="java.util.ArrayList,java.util.HashMap"%>
	
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.access.entrytitle") %></title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="JavaScript">

	
function submitfun()
{
	
	if(check_ForParticularElements(document.MainForm.userstatus,"select",document.MainForm.renewdays,"text",document.MainForm.returndays,"text",document.MainForm.renewcount,"text",document.MainForm.fineperday,"text",document.MainForm.noofbooks,"text"))
	{
		document.MainForm.action= "AccessSubmit.jsp";
		document.MainForm.submit();
		
	}

		

}
function resetfun()
{
	document.MainForm.reset();
}
function nextpage()
{
		document.MainForm.action= "AccessList.jsp";
		document.MainForm.submit();
}
function checkNumber(e) {


	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;

	var character = String.fromCharCode(code);


	 	if(code == 8 || code == 9)
	 	{
			return false;
	 	}
 		if (code==46||code<46||code>57)
 		{
				code=0;
				alert("Enter Number only")

			if(window.event != null)
		 	{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;

			}
			else
			{
				e.preventDefault();
			 }
			 	 return false;
		}
		if(code==46)
		{
	 
		}
}
function userstatuschange()
{
		document.MainForm.submit();

}

</script>
</head>

<body>

<form name="MainForm" method="post" action="">

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
         <h2><%=bundle.getString("label.access.entryrootpath")%></h2>
     <%
    
 	 
 		String instituteid 	= session.getValue("instituteid")+"";
 	 	ArrayList roleList		= query_object.get_All_Role(instituteid);   
 	 
 	 	if(roleList!=null && roleList.size()>0)
 	 	{       
 	 	} 
 	 	else
 	 	{
 	 		out.print("<script>nextpage()</script>");

 	 	}
 	 	
 	 	 
 	 	String categoryname		="";
 
 	 	String userstatus="";
 	 	userstatus=request.getParameter("userstatus");
 	 	if(userstatus!=null)
 	 	{
 	 	 	 categoryname		= query_object.get_All_Categoryname(userstatus,instituteid)+"";   
			
 	 	}
     %>
     

<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.access.entrytableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
    	     <th scope="col" class="rounded" width="20%"></th>
    	      <th scope="col" class="rounded" width="20%"></th>
    	      <th scope="col" class="rounded" width="1%"></th>
     	       <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.access.mandatoryfields") %></th>
            
        </tr>
    </thead>
    
     <tbody>
</tbody>
</table>

<table id="rounded-corner" border=0 width="100%">

    <thead>
    			<tr><td width="25%"></td>   
    			<td class="tablebold"  width="10%"><%=bundle.getString("label.access.Role")%><font color="red"> * </font></td>  			
				 <td width="1%" class="tablebold">:</td>
    			<td class="tablelight" width="20%" align="left"> 
    			<select name="userstatus" validate="Role" onchange="userstatuschange()">
    			<option value="00">--Select Role--</option>
    			<%HashMap roleListMap=new HashMap();
    				if(roleList!=null && roleList.size()>0)
    				{
    					for(int i=0;i<roleList.size();i++)
    					{
    						roleListMap=(HashMap)roleList.get(i);
    						String roleid=roleListMap.get("roleid")+"";
    						if(roleid.equals(userstatus))
    						{
    						out.print("<option value='"+roleListMap.get("roleid")+"' selected>"+roleListMap.get("rolename")+"</option>");
    						}
    						else
    						{
        						out.print("<option value='"+roleListMap.get("roleid")+"' >"+roleListMap.get("rolename")+"</option>");

    						}
    					}
    				}
    			
    			%> 
       			</select>
    			</td>   
    			<td width="15%" class="tablebold"><%=bundle.getString("label.access.RoleCategory")%>   
    			</td>       			
				 <td width="1%" class="tablebold">:</td>
       			<td class="tablelight" width="20%">
    			<%
    			if(categoryname.equals("null") || categoryname.equals("") || categoryname.equalsIgnoreCase("NULL"))
    			{
    				categoryname="-";
    				if(userstatus!=null)
    				{
			   			String role_name		= query_object.get_Rolename(userstatus);
		   				if(role_name.equals("Student"))
		   					categoryname = role_name;
    				}
    			} 
    			%> 
    			<%=categoryname%>
    			
				<%
		 	 		String user_category		="";
					if(categoryname.equalsIgnoreCase("Headmaster") || categoryname.equalsIgnoreCase("HM"))
					{
						user_category = "HM";
							//pstmt1.setString(4, "HM");
					}
					else if(categoryname.startsWith("Non") || categoryname.startsWith("Admin") || categoryname.equalsIgnoreCase("Administrator"))
					{
						user_category = "SA";
							//pstmt1.setString(4, "SA");
					}
					else if(categoryname.startsWith("Library") || categoryname.equalsIgnoreCase("Library Administrator"))
					{
						user_category = "LA";
							//pstmt1.setString(4, "LA");
					}
					else if(categoryname.startsWith("Teach") || categoryname.equalsIgnoreCase("Teacher"))
					{
						user_category = "T";
						//pstmt1.setString(4, "T");
					} 	 	
					else if(categoryname.startsWith("Student"))
					{
						user_category = "S";
						//pstmt1.setString(4, "S");
					}			
				%>
				<input type=hidden name=user_category value=<%=user_category%>>    			
    			</td>
    			</tr>
    			
				 <tr>
				 <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.renewdays")%><font color="red"> * </font></td>  
				 <td width="1%" class="tablebold">:</td>
				 <td class="tablelight" colspan=4><input type="text" name="renewdays" validate="Renewal Days" value="" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>  
				 
 				<tr>
 				<td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.returndays")%><font color="red"> * </font></td>
 				 <td width="1%" class="tablebold">:</td>
 				 <td class="tablelight" colspan=4><input type="text" name="returndays" validate="Return Days" value="" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
   		
   				<tr>
   				 <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.renewcount")%><font color="red"> * </font></td>
				 <td width="1%" class="tablebold">:</td>
				 <td class="tablelight" colspan=4><input type="text" name="renewcount" validate="Renewal Count" value="" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
				 
				 <tr>
				  <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.fineperday")%><font color="red"> * </font></td>
				 <td width="1%" class="tablebold">:</td>
				 <td class="tablelight" colspan=4><input type="text" name="fineperday" validate="Fineper Day"  value="" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
				 
				  <tr>
				   <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.noofbooks")%><font color="red"> * </font></td>
				<td width="1%" class="tablebold">:</td>
				 <td class="tablelight" colspan=4><input type="text" name="noofbooks" validate="No of Books " value="" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
				 
				
			    </thead>
			
		</table>
</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> 
    
    
</table>
 	<a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.access.reset")%></strong><span class="bt_blue_r"></span></a>
     <a href="AccessList.jsp" class="bt_blue" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.access.viewaccesslist")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.access.submit")%></strong><span class="bt_green_r"></span></a>
    

       




     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>