<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.photogallery.photodetailstrashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>    

<script type="text/javascript">



function windopen(obj)
{
	var attachments=obj.getAttribute("gallerypath");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachments);
}


function actionfun(obj,flage)
{
document.curricularevententryform.curricularcategory_temp.value=obj.getAttribute("curricularcategory_temp");
document.curricularevententryform.yearofsession_temp.value=obj.getAttribute("yearofsession_temp");
document.curricularevententryform.reqsessionid.value = obj.getAttribute("reqsessionid");
document.curricularevententryform.curriculareventid.value=obj.getAttribute("curriculareventid");
if(flage=="R")
{
if(confirm("Do you want to Restore the Photo...?"))
{

document.curricularevententryform.eventphotogalleryid.value=obj.getAttribute("eventphotogalleryid");
document.curricularevententryform.flage.value="R";
document.curricularevententryform.action="PhotoAction.jsp";
document.curricularevententryform.submit();
}
}
else if(flage=="D")
{
if(confirm("Do you want to Delete the Photo...?"))
{

document.curricularevententryform.eventphotogalleryid.value=obj.getAttribute("eventphotogalleryid");
document.curricularevententryform.flage.value="D";
document.curricularevententryform.action="PhotoAction.jsp";
document.curricularevententryform.submit();
}
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

    <h2><%=bundle.getString("label.photogallery.photodetailstrashlistrootpath") %></h2>
<form name="curricularevententryform" action="" method="post">
<input type="hidden" name="sessionstatus" value="">

<input type="hidden" name="eventphotogalleryid" value="">
<input type="hidden" name="gallerypath" value="">
<input type="hidden" name="caption" value="">
<input type="hidden" name="reqsessionid" value="">
<input type="hidden" name="yearofsession_temp" value="">
<input type="hidden" name="curriculareventid" value="">
<input type="hidden" name="curricularcategory_temp" value="">
<input type="hidden" name="flage" value="">

<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>

<%
com.iGrandee.PhotoGallery.PhotoGalleryQuery PhotoGalleryQuery = new com.iGrandee.PhotoGallery.PhotoGalleryQuery();

//String 	curriculareventid=null;
String 	yearofsession_temp=null;
String 	curricularcategory_temp=null;
String 	sessionstatus=null;
String reqsessionid=null;
String curriculareventid=null;
String venue=null;
String eventdate=null;
String sessionstatus_temp=null;

reqsessionid=request.getParameter("yearofsession");
//curriculareventid=request.getParameter("curriculareventid");
yearofsession_temp=request.getParameter("yearofsession_temp");
curricularcategory_temp=request.getParameter("curricularcategory_temp");
sessionstatus=request.getParameter("sessionstatus");
String curriculareventname=request.getParameter("curriculareventname");
 curriculareventid=request.getParameter("curriculareventid");
 venue=request.getParameter("venue");
 eventdate=request.getParameter("eventdate");
 sessionstatus_temp=request.getParameter("sessionstatus_temp");
ArrayList eventCategoryList =null;
HashMap  eventCategory=null; 
eventCategoryList=PhotoGalleryQuery.listeventphotogallery("T",reqsessionid,curriculareventid); 
//out.println(reqsessionid+"--"+curriculareventid);

%>
<input type="hidden" name="curriculareventname" value="<%=curriculareventname %>">
<input type="hidden" name="venue" value="<%=venue%>">
<input type="hidden" name="eventdate" value="<%=eventdate%>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
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
					<td class="tablelight" ><%=venue%></td>  
					
				</tr>
				<tr>
									
					<td class="tablebold"><%=bundle.getString("label.photogallery.eventdate") %></td> 
					<td class="tablebold">:</td> 
					<td class="tablelight" colspan=4><%=eventdate%></td>  
					
					
					
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
        	<th scope="col" class="rounded" width="20%" ><%=bundle.getString("label.photogallery.photoname") %> </th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.photogallery.description") %> </th>
        	 <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.photogallery.dateofcreation") %> </th>
        	  <th scope="col" class="rounded" width="7%"><%=bundle.getString("label.photogallery.delete") %> </th>
        	   <th scope="col" class="rounded-q4" width="7%" ><%=bundle.getString("label.photogallery.restore") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

	<%String[] count=null;
	if(eventCategoryList !=null && eventCategoryList.size()>0)
	{
		String as=request.getContextPath();		
		for(int i=0;i<eventCategoryList.size();i++)
		{   out.print("<tr valign=top>");
			eventCategory=(HashMap)eventCategoryList.get(i);
			String gallerypath=(String)eventCategory.get("gallerypath");
			String eventphotogalleryid=(String)eventCategory.get("eventphotogalleryid");
			 curriculareventid=(String)eventCategory.get("curriculareventid");

			String caption=(String)eventCategory.get("caption");
			String photoname=(String)eventCategory.get("photoname");
			
			out.print("<td width='5%'>"+(i+1)+"</td>");
			if(gallerypath !=null && !gallerypath.equals(""))
			out.print("<td><a href ='#' gallerypath='"+gallerypath+"' onClick='windopen(this)'>"+photoname+"</a></td>");
			else
			out.print("<td>-</td>");
			
			if(caption == null || caption.equals("") || caption.equals("-") || caption.equalsIgnoreCase("null"))
			{
			
			out.print("<td class='tablelight'>-</td>");
			}
			else{
				
				   count=caption.split(" ");
					if((count.length-1)>15)
					{
						out.print("<td class='tablelight' ");
						String des_tempnew="";
						for(int k=0;k<15;k++)
						{
							des_tempnew+=count[k]+" ";
						}%>
						<div>
						<%=caption%><a href="index.htm" onclick="return hs.htmlExpand(this)">
					[<font color="red">More..</font>]
				</a>  
				<div class="highslide-maincontent">
					<h3></h3>
					<%=(caption).replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
				</div>
					</div>
					<% }
					else
					{
						out.print("<td class='tablelight'>"+caption+"</td>");

					}
					}	
			
			
			out.print("<td>"+eventCategory.get("newdates")+"</td>");
			if(sessionstatus_temp.equals("R"))
			{
				out.print("<td colspan=2 class='tablelight'>Archival</td>");

			}
			else
			{
				out.println("<td class='tablelight'><a href='#'    eventphotogalleryid='"+eventphotogalleryid+"' gallerypath='"+gallerypath+"' caption='"+caption+"' reqsessionid='"+reqsessionid+"' yearofsession_temp='"+yearofsession_temp+"' curriculareventid='"+curriculareventid+"' curricularcategory_temp='"+curricularcategory_temp+"' class='tablelight' onclick=actionfun(this,'D')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a></td>");
				out.println("<td class='tablelight'><a href='#' class='tablelight'   eventphotogalleryid='"+eventphotogalleryid+"' gallerypath='"+gallerypath+"' caption='"+caption+"' reqsessionid='"+reqsessionid+"' yearofsession_temp='"+yearofsession_temp+"' curriculareventid='"+curriculareventid+"' curricularcategory_temp='"+curricularcategory_temp+"' onclick=actionfun(this,'R')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></a></td>");
			}
			out.print("</tr>");
		}
		
		
		
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
		//out.print("<tr><td colspan=6 align='center'>Data Not Found</td></tr>");
	}
	%>
	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	
	
	           <a href="PhotoGalleryEvent.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.photogallery.back") %></strong><span class="bt_blue_r"></span></a>
	 
				
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>