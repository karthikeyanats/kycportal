<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.bookrenewal.entrytitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script language="JavaScript">


	
function submitfun()
{var status=false;
	if(check_ForParticularElements(document.MainForm.startdate,"text",document.MainForm.enddate,"text"))
	{
	for(var i=0;i<document.MainForm.selectoption.length;i++)
	{
		if(document.MainForm.selectoption[i].checked)
		{
		status=true;
		}
		
	}
	if(status)
	{
		document.MainForm.action= "BookRenewalList.jsp";
		document.MainForm.submit(); 
		
	
	}
	else
	{
		
	alert("Select Book or Journal Option");
	return false;
	}
	}

		

}
function optionselect(obj)
{
var flage_temp=obj.value;
if(flage_temp=="Book")
{

		document.MainForm.flage_temp.value="Book";

}
else
{
		document.MainForm.flage_temp.value="Journal";

}
}
function checkprevdate()
{
	if(check_ForParticularElements(document.MainForm.startdate,"text"))
	{ 
		Calendar_Fun('/kycportal/js/Calendar/CalendarWindow.html','MainForm.enddate','0','event','Not_Less_Than_StartDate',document.MainForm.startdate);
	}
}
</script>
</head>

<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>

<%
String date_str="";
date_str = datebeans.showTime("calendar");

%>
<form name="MainForm" method="post" action="">
	<input type="hidden" name="server_date" value="<%=date_str%>">
		<input type="hidden" name="flage_temp" value="">
	
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
         <h2><%=bundle.getString("label.bookrenewal.entryrootpath")%></h2>
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		<td>
		
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="40%"><%=bundle.getString("label.bookrenewal.entrytableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="10%" ></th>
            <th scope="col" class="rounded" width="10%" ></th>
            <th scope="col" class="rounded" width="15%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
    
     <tbody>
</tbody>
</table>

<table id="rounded-corner" border=0 summary="Department List" width="100%">

    <thead>
    		<tr valign="top">
            <td class="tablebold" valign="top"><%=bundle.getString("label.bookrenewal.StartDate") %>
            </td>
            <td class="tablebold" width="1%">:</td>
            <td>
            <input type=text name="startdate"  validate="Start Date"  onkeydown=this.blur()>&nbsp;&nbsp;
			<input type="button" class="tablehead"  value="^" onclick="document.MainForm.startdate.value='';Calendar_Fun('/kycportal/js/Calendar/CalendarWindow.html','MainForm.startdate','0',event,'Not_Greater_Than_CurrentDate',document.MainForm.server_date);">
			</td>					
			<td class="tablebold" valign="top"><%=bundle.getString("label.bookrenewal.EndDate") %>
            </td>
            <td class="tablebold" width="1%">:</td>
             <td>
            <input type=text name="enddate" validate="End Date"  onkeydown=this.blur()>&nbsp;&nbsp;
			<input type="button" class="tablehead"  value="^" onclick="checkprevdate()">
			</td>
			</tr>  
			<tr>
	   		 <td align="center" colspan=6>
	   
		    <input type="radio" name="selectoption" value="Book" onclick="optionselect(this)"><font size=3>Book</font>&nbsp;&nbsp;
		    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3>Journal</font>
   
		    </td>
		    </tr>
			 </thead>  
			<tfoot>
    	<tr>  
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
		</table>

</table>
<br>
    </br>

    

     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.bookrenewal.SearchBook")%></strong><span class="bt_green_r"></span></a>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>