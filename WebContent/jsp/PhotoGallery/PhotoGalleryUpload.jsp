<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.photogallery.uploadtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function gotoaction(obj)
{   
	
	if(obj.getAttribute("reqaction") == "upload")
	{
		document.curricularevententryform.action="PhotoGalleryUpload.jsp";
		document.curricularevententryform.submit();
	} 
	else if(obj.getAttribute("reqaction") == "view")
	{
		document.curricularevententryform.action="PhotoGalleryView.jsp";
		document.curricularevententryform.submit();
	}
		
}
function goback()
{   
	
		document.curricularevententryform.action="PhotoGalleryEvent.jsp";
		document.curricularevententryform.submit();
	
		
}
var checked_flag;
function validatefun(obj)
{
	var val=obj.getAttribute("val");
	var pho_val=getExtension(document.curricularevententryform.photo_url[val].value);
			
		
		
	var flag=obj.checked;

	checked_flag =flag;
	if(checked_flag)
	{	
	checked_flag =true;
		
		if(document.curricularevententryform.photo_url[val].value.length==0)
		{
			alert("Empty file is not allowed");
			document.curricularevententryform.chk[val].checked=false;
			return false;

		}
		
		if(!check_ForParticularElements(eval("document.curricularevententryform.photo_description"+val),"textarea"))
		{
			document.curricularevententryform.chk[val].checked=false;
			eval("document.curricularevententryform.photo_description"+val).focus();
			return false;
		}
		if((pho_val != "jpg") & (pho_val != "gif")& (pho_val != "png") & (pho_val != "bmp") & (pho_val != "jpeg"))
		{  
	
			obj.value="";
			obj.select();
			document.curricularevententryform.chk[val].checked=false;	
			alert("Allowing following Formats : \n *.jpg,*.jpeg,*.gif,*.png,*.bmp");
			return false; 
			
		}  
		document.curricularevententryform.photo_url[val].disabled=true;
		document.curricularevententryform.chkno[val].disabled=true;
		eval("document.curricularevententryform.photo_description"+val).disabled=true;
	}
	else
	{
	    document.curricularevententryform.photo_url[val].disabled=false;
	    document.curricularevententryform.chkno[val].disabled=false;
		eval("document.curricularevententryform.photo_description"+val).disabled=false;
		
	}
	
}
var k=0;
function submitfun()
{
				if(checked_flag)
				{
				
					   for (var i=0;i<document.curricularevententryform.chk.length;i++)
						{
						if(document.curricularevententryform.chk[i].checked)
						{	         
						    document.curricularevententryform.photo_url[i].disabled=false;
							document.curricularevententryform.chkno[i].disabled=false;
							eval("document.curricularevententryform.photo_description"+i).disabled=false;
							
						}
						else
						{
							document.curricularevententryform.photo_url[i].disabled=true;
							document.curricularevententryform.chkno[i].disabled=true;
							eval("document.curricularevententryform.photo_description"+i).disabled=true;
						
						}
						}
						document.curricularevententryform.action="PhotoGallerySubmit.jsp";
			            document.curricularevententryform.submit();
				}
				else
				{
				alert("Select any one Option");
				return false;
				}

	}
	
function checkphoto(obj)  
	{
		var pho_val=getExtension(obj.value);
		if((pho_val != "jpg") & (pho_val != "gif")& (pho_val != "png") & (pho_val != "bmp") & (pho_val != "jpeg"))
		{  
			alert("Allowing following Formats : \n *.jpg,*.jpeg,*.gif,*.png,*.bmp");
	
			document.curricularevententryform.photo_url.value="";
			obj.value="";
			obj.select();
			return false; 
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

function checkfun()
{
  	 var url = "checkStorage.jsp";
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		if(!clength)
		{
		alert("Storage Path Not Found Contact Administrator");
		return false;
		}
		else
		{
		submitfun()
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

    <h2><%=bundle.getString("label.photogallery.uploadrootpath") %> </h2>
<form name="curricularevententryform"  method="post" enctype="multipart/form-data" >
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>

<%
com.iGrandee.PhotoGallery.PhotoGalleryQuery PhotoGalleryQuery = new com.iGrandee.PhotoGallery.PhotoGalleryQuery();

String instituteid= null;

String 	extracurricularcategoryid=null;
String 	yearofsession_temp=null;
String 	curricularcategory_temp=null;
String 	sessionstatus=null;
String reqsessionid=null;
String eventdate=null;
String venue=null;

reqsessionid=request.getParameter("yearofsession");
extracurricularcategoryid=request.getParameter("extracurricularcategoryid");
yearofsession_temp=request.getParameter("yearofsession_temp");
curricularcategory_temp=request.getParameter("curricularcategory_temp");
sessionstatus=request.getParameter("sessionstatus");
String curriculareventname=request.getParameter("curriculareventname");
String reqcurriculareventid=request.getParameter("reqcurriculareventid");
venue=request.getParameter("venue");
eventdate=request.getParameter("eventdate");





try
{
instituteid = (String)session.getValue("instituteid");
}catch(Exception e){}
%>
<input type="hidden" name="sessionstatus" value="<%=sessionstatus %>">
<input type="hidden" name="yearofsession" value="<%=reqsessionid %>">
<input type="hidden" name="extracurricularcategoryid" value="<%=extracurricularcategoryid %>">
<input type="hidden" name="curriculareventname" value="<%=curriculareventname %>">
<input type="hidden" name="yearofsession_temp" value="<%=yearofsession_temp %>">
<input type="hidden" name="curricularcategory_temp" value="<%=curricularcategory_temp %>">
<input type="hidden" name="reqcurriculareventid" value="<%=reqcurriculareventid %>">
<input type="hidden" name="venue" value="<%=venue %>">
<input type="hidden" name="eventdate" value="<%=eventdate %>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	
	
	<br>
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.photogallery.selectedinformation") %></th>
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
					<td class="tablebold"><%=bundle.getString("label.photogallery.academicsession") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=yearofsession_temp %></td>  
				
					<td class="tablebold"><%=bundle.getString("label.extracurricularactivity.curricularactivity") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight"><%=curricularcategory_temp %></td>  
					
				</tr>
				<tr>
									
					<td class="tablebold"><%=bundle.getString("label.photogallery.eventname") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight" ><%=curriculareventname %></td>  
					
					<td class="tablebold"><%=bundle.getString("label.photogallery.venue") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight" ><%=venue %></td>  
					
				</tr>
				
				<tr>
									
					<td class="tablebold"><%=bundle.getString("label.photogallery.eventdate") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight" colspan=4><%=eventdate %></td>  
					
					
					
				</tr>
				
			</thead>
		</table>
		</td>
	</tr>
	</table>
	
<br>

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.photogallery.slno") %></th>
        	<th scope="col" class="rounded" width="30%" ><%=bundle.getString("label.photogallery.photo") %> </th>
        	<th scope="col" class="rounded" width="50%"><%=bundle.getString("label.photogallery.description") %></th>
        	<th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.photogallery.check") %> </th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

	<%
	
	
	for(int i=0,j=1;i<5;i++,j++)
	{
		out.println("<tr id=tabs"+i+">");
%>
		<td class=tablelight align=center><%=j%></td>
		<td><input type="file" name="photo_url" validate="Photo" value="" class="tabledivision" onKeyPress='this.blur();' size="15" onchange=checkphoto(this);></td>
		
<%
		out.println("<td align=left><textarea class='tabledivision' validate='Description' remid='remLens"+i+"' rows='3' cols='35' name='photo_description"+i+"' idx='"+i+"' maxvalue='100' vals='ans' onkeydown=textCounter_label(document.curricularevententryform.photo_description"+i+",document.getElementById('labelid"+i+"'),300) onkeyup=textCounter_label(document.curricularevententryform.photo_description"+i+",document.getElementById('labelid"+i+"'),300)></textarea><br><br><i><font color='red'><label id='labelid"+i+"' >"+bundle.getString("label.photogallery.charactercount")+"</label>&nbsp;&nbsp;"+bundle.getString("label.photogallery.charactersleft")+"</font>");

%>
		<td align=center><input type=checkbox name=chk class=tablelight val=<%=i%> value="<%=i%>" onclick=validatefun(this)><input type=hidden name=chkno class=tablelight value="<%=i%>" ></td>
		</tr>
<%
	}
%>
	 </tbody>
	 <font color=red>	
	<%=bundle.getString("label.photogallery.notemessage_1")%>
   </font>
	 </table>
	 
	
	           <a href="#" class="bt_blue" onclick="goback()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.photogallery.back")%></strong><span class="bt_blue_r"></span></a>
	 
		  <a href="#" class="bt_green" name=acts value='ACTIVE' flag_v='A'  operationMode='ACTIVATE' onclick=checkfun()><span class="bt_green_lft"></span><strong><%=bundle.getString("button.photogallery.upload")%></strong><span class="bt_green_r"></span></a>
     <font color=red>	
	<%=bundle.getString("label.photogallery.notemessage_2")%>
   </font>
		
				
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>