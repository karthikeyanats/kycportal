<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.periodnames.alllisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language="JavaScript">

	function goback()
	{
		document.MainForm.action= "periodnamesEntry.jsp";
		document.MainForm.submit();
	}
	
	function trashFun(obj)
	{
		if(confirm("Do you want to trash the Period Name...?"))
		{
			document.MainForm.periodnameid.value			= obj.getAttribute("periodnameid");
			document.MainForm.periodname.value			= obj.getAttribute("periodname");
			document.MainForm.flage.value="Trash";
			document.MainForm.action						= "./PeriodNameTrashview.jsp";
			document.MainForm.submit();
		}
	} 
        
	function editByClickFun(obj)
	{
		if(confirm("Do you want to Update the Period Name...?"))
		{
			document.MainForm.periodnameid.value			= obj.getAttribute("periodnameid");
			document.MainForm.action= "PeriodNameUpdateByClick.jsp";
			document.MainForm.submit();
		}
	}

	function TrashListview()
	{
		document.MainForm.action= "PeriodNameTrashListview.jsp";
		document.MainForm.submit();
	} 

	function updateOrderValue(){
		if(confirm("Are you sure want to update order value?")){
			document.MainForm.action	= "UpdateOrderValue.jsp";
			document.MainForm.submit();
		}
	}


</script>
</head>

<body>


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
         <h2><%=bundle.getString("label.periodnames.alllistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";

	ArrayList PeriodNameList		= query_object.get_All_PeriodNameList("A",createdby,instituteid); 
%>
<form name="MainForm" method="post">
<input type="hidden" name="periodnameid">
<input type="hidden" name="periodname">
<input type="hidden" name="flage">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.periodnames.slno") %></th>
		        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.periodnames.periodname") %> </th>
		        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.periodnames.dateofcreation") %> </th>
		        	<th scope="col" class="rounded" width="12%"><%=bundle.getString("label.periodnames.ordervalue") %> </th>
		        	<th scope="col" class="rounded" width="9%"><%=bundle.getString("label.periodnames.edit") %> </th>
		        	<th scope="col" class="rounded-q4" width="9%"><%=bundle.getString("label.periodnames.trash") %> </th>
		        </tr>
		    </thead>
		    <tfoot>
		    	<tr>
		        	<td colspan=5  class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
   
		
				<%
				try
				{	
					HashMap PeriodNameListHash=new HashMap();
					int totalschedule	= 0;
					String ordervalue	= "";
				if(PeriodNameList!=null && PeriodNameList.size()>0)
				{	String as=request.getContextPath();					
				totalschedule	= PeriodNameList.size();
					for(int i=0,j=1;i<PeriodNameList.size();i++,j++)
					{
						out.print("<tr  valign='top'>");
						PeriodNameListHash=(HashMap)PeriodNameList.get(i); 
						String description=PeriodNameListHash.get("description")+"";
						ordervalue	= PeriodNameListHash.get("ordervalue")+"";
						out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						out.print("<td class='tablelight'>"+PeriodNameListHash.get("periodname")+"</td>");
						out.print("<td class='tablelight'>"+PeriodNameListHash.get("newdates")+"</td>");
						out.print("<td class='tablelight'><select name='ordervalue'>");
						for(int y=1;y<=totalschedule;y++){
							if(ordervalue != null && ordervalue.equals(y+""))
								out.print("<option value='"+y+"' selected>"+y+"</option>");
							else
								out.print("<option value='"+y+"'>"+y+"</option>");
						}
						out.print("</select><input type='hidden' name='periodnames' value='"+PeriodNameListHash.get("periodnameid")+"'></td>");
						out.print("<td class='tablelight'><a href='#'    periodnameid='"+PeriodNameListHash.get("periodnameid")+"' onclick=editByClickFun(this)><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.periodnames.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight'><a href='#'   periodnameid='"+PeriodNameListHash.get("periodnameid")+"'   periodname='"+PeriodNameListHash.get("periodname")+"' onclick=trashFun(this)><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.periodnames.trash")+"' border=0 /></a></td>");
						out.print("</tr>");
								
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='6' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");

				}
				}catch(Exception e){
					System.out.println(e);
				}

				%>
			
			
		</table>
	     	
	     	<%if(PeriodNameList!=null && PeriodNameList.size()>0) {%>
	     	<a href="#" class="bt_green" onclick="updateOrderValue()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.periodnames.updateordervalue") %> </strong><span class="bt_green_r"></span></a>
	     	<%}%>
	     	<a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.periodnames.addnewitem") %> </strong><span class="bt_green_r"></span></a>
	  		<a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.periodnames.trashlist") %></strong><span class="bt_red_r"></span></a>
	
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
    
<%@ include file="../include/footer.jsp" %>

</div>

</body>
</html>