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
<title><%=bundle.getString("label.access.updatetitle") %></title>

<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="JavaScript">

	
function submitfun()
{
	
	if(check_ForParticularElements(document.MainForm.renewdays,"text",document.MainForm.returndays,"text",document.MainForm.renewcount,"text",document.MainForm.fineperday,"text",document.MainForm.noofbooks,"text"))
	{ 
		document.MainForm.action= "AccessEditUpdate.jsp";
		document.MainForm.submit();
		 
	}

		

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
         <h2><%=bundle.getString("label.access.updaterootpath")%></h2>
   
    <%
    HashMap AccessListMap=new HashMap();
    String accessid="";
    accessid=request.getParameter("accessid");
    String instituteid=session.getValue("instituteid")+"";
   
    
    String renewdays="";
    String returndays="";
    String renewcount="";
    String fineperday="";
    String noofbooks="";
   	String rolename="";
   	
    ArrayList AccessList		= query_object.get_Access_detail(instituteid,"A",accessid);  
    if(AccessList!=null && AccessList.size()>0)
    {
    	for(int i=0;i<AccessList.size();i++)
    	{
    		   AccessListMap=(HashMap)AccessList.get(i);
    		   renewdays=AccessListMap.get("renewdays")+"";
    		   returndays=AccessListMap.get("returndays")+"";
    		   renewcount=AccessListMap.get("renewcount")+"";
    		   fineperday=AccessListMap.get("fineperday")+"";
    		   noofbooks=AccessListMap.get("noofbooks")+"";
    		   rolename=AccessListMap.get("rolename")+"";

    	}
    }
    %> 
    <input type="hidden" name="accessid" value="<%=accessid%>">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		<td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.access.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="15%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.access.mandatoryfields") %></th> 
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>

<table id="rounded-corner" border=0 width="100%">

    <thead>
    			<tr>
    			<td width="25%"></td>
    			<td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.RoleName")%></td>
    			 <td width="1%" class="tablebold">:</td>
    			<td class="tablelight" width="50%" >
    			<%=rolename%>
    			</td>
    			</tr>
    			
				 <tr>
				 <td ></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.renewdays")%><font color="red"> * </font></td>
				<td width="1%" class="tablebold">:</td>
				 <td class="tablelight"><input type="text" name="renewdays" validate="Renewal Days" value="<%=renewdays %>" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>  
				 
 				<tr>
 				<td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.returndays")%><font color="red"> * </font></td>
				 <td width="1%" class="tablebold">:</td>
				 <td class="tablelight"><input type="text" name="returndays" validate="Return Days" value="<%=returndays %>" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
   		
   				<tr>
   				 <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.renewcount")%><font color="red"> * </font></td>
				 <td width="1%" class="tablebold">:</td>
				 <td class="tablelight"><input type="text" name="renewcount" validate="Renewal Count"  value="<%=renewcount %>" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
				 
				 <tr>
				  <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.fineperday")%><font color="red"> * </font></td>
				<td width="1%" class="tablebold">:</td>
				 <td class="tablelight"><input type="text" name="fineperday" validate="Fineper Day"  value="<%=fineperday %>" size="3" maxlength="3" onkeypress="checkNumber(event)">
				 </td>
				 </tr>
				 
				  <tr>
				   <td width="25%"></td>
				 <td class="tablebold" align="left" width="25%"><%=bundle.getString("label.access.noofbooks")%><font color="red"> * </font></td>
				<td width="1%" class="tablebold">:</td>
				 <td class="tablelight"><input type="text" name="noofbooks" validate="No of Books " value="<%=noofbooks %>" size="3" maxlength="3" onkeypress="checkNumber(event)">
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
 	<a href="AccessList.jsp"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.access.back")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.access.update")%></strong><span class="bt_green_r"></span></a>
   






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>