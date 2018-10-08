<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.photogallery.updatephotodetailstitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function backfun()
{
	
		document.temp_form.action="phodetails.jsp";
		document.temp_form.submit();
		
}
function windopen(obj)
{
	var attachments=obj.getAttribute("gallerypath");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachments);
}



function windopen(obj)
{
	var attachments=obj.getAttribute("gallerypath");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachments);
}
function checkphoto(obj)  
	{
		var pho_val=getExtension(obj.value);
		if((pho_val != "jpg") & (pho_val != "gif")& (pho_val != "png") & (pho_val != "bmp") & (pho_val != "jpeg"))
		{
			document.getElementById("button_submit").style.visibility='hidden';
			alert("Allowing following Formats : \n *.jpg,*.jpeg,*.gif,*.png,*.bmp");
			obj.value="";
			obj.select();
			return false; 
		}
		else
		{
			document.getElementById("button_submit").style.visibility='visible';
		
		}
		
}
function getExtension(file_value)
{
	if(file_value.lastIndexOf(".") != -1)
	{
		var ext_of_file = file_value.substring(file_value.lastIndexOf(".")+1);
		return ext_of_file.toLowerCase();
	}
	else
	{
		return 0;
	}
}
function updateun()
{
document.curricularevententryform.action="PhotoGalleryEditUpdate.jsp";
document.curricularevententryform.submit();
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
 
    <h2><%=bundle.getString("label.photogallery.udatephotodetailsrootpath")%></h2>
<form name="curricularevententryform"  method="post" enctype="multipart/form-data" >


<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>

<%
com.iGrandee.PhotoGallery.PhotoGalleryQuery PhotoGalleryQuery = new com.iGrandee.PhotoGallery.PhotoGalleryQuery();

String 	curriculareventid=null;
String 	yearofsession_temp=null;
String 	curricularcategory_temp=null;
String 	sessionstatus=null;
String reqsessionid=null;
String eventphotogalleryid=null;
String curriculareventname=null;
String venue=null;
String eventdate=null;
String photoname=null;
String sessionstatus_temp=null;
reqsessionid=request.getParameter("reqsessionid");
curriculareventid=request.getParameter("curriculareventid");
yearofsession_temp=request.getParameter("yearofsession_temp");
curricularcategory_temp=request.getParameter("curricularcategory_temp");
sessionstatus=request.getParameter("sessionstatus");
String caption=request.getParameter("caption");
String gallerypath=request.getParameter("gallerypath");
eventphotogalleryid=request.getParameter("eventphotogalleryid");
curriculareventname=request.getParameter("curriculareventname");
venue=request.getParameter("venue");
eventdate=request.getParameter("eventdate");
photoname=request.getParameter("photoname");
sessionstatus_temp=request.getParameter("sessionstatus_temp");

%>
<input type="hidden" name="photoname" value="<%=photoname %>">

<input type="hidden" name="eventphotogalleryid" value="<%=eventphotogalleryid %>">
<input type="hidden" name="gallerypath" value="<%=gallerypath %>">
<input type="hidden" name="caption" value="<%=caption %>">
<input type="hidden" name="curriculareventid" value="<%=curriculareventid %>">
<input type="hidden" name="reqsessionid" value="<%=reqsessionid %>">
<input type="hidden" name="yearofsession" value="<%=reqsessionid %>">
<input type="hidden" name="yearofsession_temp" value="<%=yearofsession_temp %>">
<input type="hidden" name="curricularcategory_temp" value="<%=curricularcategory_temp %>">
<input type="hidden" name="curriculareventname" value="<%=curriculareventname %>">
<input type="hidden" name="venue" value="<%=venue%>">
<input type="hidden" name="eventdate" value="<%=eventdate%>">
<input type="hidden" name="sessionstatus_temp" value="<%=sessionstatus_temp%>">

<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
         <tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.photogallery.selectedinformation")%></th>
					<th scope="col" class="rounded" width="10%"></th>
					<th scope="col" class="rounded" width="20%"></th>
					<th scope="col" class="rounded" width="20%"></th>
					<th scope="col" class="rounded" width="10%"></th>
					<th scope="col" class="rounded-q4" width="20%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td> 
					<td class="rounded-foot-right">&nbsp;</td> 
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold"><%=bundle.getString("label.photogallery.academicsession")%></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=yearofsession_temp %></td>  
				
					<td class="tablebold"><%=bundle.getString("label.extracurricularactivity.curricularactivity")%></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=curricularcategory_temp %></td>  
					
					
				</tr>
				
				<tr>
					<td class="tablebold"><%=bundle.getString("label.photogallery.photo")%></td> 
					<td class="tablebold">:</td> 
					<%
					if(gallerypath !=null)
					{
					out.print("<td class='tablelight'><a href='#' gallerypath='"+gallerypath+"' onClick=windopen(this)>"+photoname+"</td>");
					}
					
					else
					{%>
					<td class="tablelight">-</td>  
				   <%}%>
					<td class="tablebold"><%=bundle.getString("label.photogallery.eventname")%></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=curriculareventname %></td>  
					</tr>
					
					<tr>
									
					<td class="tablebold"><%=bundle.getString("label.photogallery.venue")%> </td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=venue%></td>  
			
			         <td class="tablebold"><%=bundle.getString("label.photogallery.eventdate")%></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight" ><%=eventdate%></td>
				</tr>
					
					
				
				
			</thead>
		</table>
		</td>
	</tr>
	</table>
	<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
           			 <th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.photogallery.updatephotodetailstableheading")%></th>
					<th scope="col" class="rounded" width="10%"></th>
					<th scope="col" class="rounded" width="20%"></th>
					<th scope="col" class="rounded" width="20%"></th>
					<th scope="col" class="rounded" width="10%"></th>
					<th scope="col" class="rounded-q4" width="20%"></th>
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
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>			<tr valign="top">
				<td class="tablebold" ><%=bundle.getString("label.photogallery.photoname")%></td>
				<td class="tablebold" width="1%">:</td>
				<td>
			<input type="file" name="photo_url" validate="Photo" value="" class="tabledivision" onKeyPress='this.blur();' size="15" onchange=checkphoto(this);>
				</td>
			</tr>
			<tr valign="top">
				<td class="tablebold"  ><%=bundle.getString("label.photogallery.description")%></td>
				<td class="tablebold" width="1%">:</td>
				<td>
				<textarea validate="Description" class='tablelight' cols=70 rows=6 name="descryption" onkeydown="textCounter_label(document.curricularevententryform.descryption,document.getElementById('labelid'),300)" onkeyup="textCounter(document.curricularevententryform.descryption,document.getElementById('labelid'),300)"><%=caption %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.photogallery.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.photogallery.charactersleft") %></font></i>
				
				</td>
			</tr>
			
			</thead>
		</table>
	</td><td width="30%">&nbsp;</td></tr></table>	
	
	           <a href="#" onclick="backfun()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.photogallery.back")%></strong><span class="bt_blue_r"></span></a>
	 	 		<a href="#" class="bt_green" id="button_submit" name=acts value=''  onclick=updateun()><span class="bt_green_lft"></span><strong><%=bundle.getString("button.photogallery.update")%></strong><span class="bt_green_r"></span></a>
	  <font color=red>	
		<%=bundle.getString("label.photogallery.notemessage_2")%>
   </font>
				
</form>
<form name="temp_form" action="" method="post">
<input type="hidden" name="eventphotogalleryid" value="<%=eventphotogalleryid %>">
<input type="hidden" name="gallerypath" value="<%=gallerypath %>">
<input type="hidden" name="caption" value="<%=caption %>">
<input type="hidden" name="curriculareventid" value="<%=curriculareventid %>">
<input type="hidden" name="reqsessionid" value="<%=reqsessionid %>">
<input type="hidden" name="yearofsession" value="<%=reqsessionid %>">
<input type="hidden" name="yearofsession_temp" value="<%=yearofsession_temp %>">
<input type="hidden" name="curricularcategory_temp" value="<%=curricularcategory_temp %>">
<input type="hidden" name="curriculareventname" value="<%=curriculareventname %>">
<input type="hidden" name="venue" value="<%=venue%>">
<input type="hidden" name="eventdate" value="<%=eventdate%>">
<input type="hidden" name="sessionstatus_temp" value="<%=sessionstatus_temp%>">
<input type="hidden" name="photoname" value="<%=photoname %>">

</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>