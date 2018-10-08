<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title><%=bundle.getString("label.photogallery.photodetailsviewtitle")%></title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" href="basic.css" type="text/css" />
<link rel="stylesheet" href="menu-base.css" type="text/css" />
<link rel="stylesheet" href="galleriffic.css" type="text/css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery.galleriffic.js"></script>
<script type="text/javascript" src="menu.js"></script>
<script type="text/javascript">


function openimage(obj)
{
var path_image=obj.getAttribute("path");
var path_final="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+path_image;

var obj_temp=document.getElementById("openimage");
obj_temp.src=path_final;

}
function goBack()
{
window.close();
}

</script>	
</head>

<body>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery,com.iGrandee.Registration.InstitutionQurey"%>
<%
String instituteid		= (String)session.getValue("instituteid");

String reqcurriculareventid=request.getParameter("reqcurriculareventid");
com.iGrandee.PhotoGallery.PhotoGalleryQuery PhotoGalleryQuery = new com.iGrandee.PhotoGallery.PhotoGalleryQuery();
ArrayList photolist=PhotoGalleryQuery.getPhotos(reqcurriculareventid,instituteid);
String yearname=request.getParameter("yearname");
String categoryname=request.getParameter("categoryname");
String curriculareventname=request.getParameter("curriculareventname");
String eventdate=request.getParameter("eventdate");
String venue=request.getParameter("venue");
String flage=request.getParameter("flage");
InstitutionQurey insquery=new InstitutionQurey();
ArrayList insdetails=insquery.getInstituteDetails(instituteid);

%>
<table align="center" cellpadding="0" cellspacing="0" style="width: 1000px">
	<tr>
	  <td>

  <tr>
    <td>
	<div class="topnav" id="ddtopmenubar">
		
	</div>
	<script type="text/javascript">
	ddlevelsmenu.setup("ddtopmenubar", "topbar") //ddlevelsmenu.setup("mainmenuid", "topbar|sidebar")
	</script>
	<!--Top Drop Down Menu 1-->
	
	<!--Top Drop Down Menu 4-->
	
	<!--Top Drop Down Menu 5-->
	
	</td>
  </tr>
</table>
<table  border=0  width=640 >
		<tr height=50px><td align=center>
		<table  border=0 width=100% class=tablebold cellpadding='0' cellspacing='0'>
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		
		<tr class=tablebold>
				<td width="35%" valign=top align=left><%=bundle.getString("label.photogallery.eventgallery")%> - <%=curriculareventname %></td>
		
		</tr>
		

	<tr>
	  <td class="content"><table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="18">&nbsp;</td>
          <td width="964">&nbsp;</td>
          <td width="18">&nbsp;</td>
        </tr>
        <tr>
          <td width="18">&nbsp;</td>
          <td width="964" align="left" valign="top" class="body">
			<div id="page">
			<table width="100%" align="center" border=0>
				<tr>
				<%
				if(flage.equals("admin"))
				{
				%>
				<td width="15%"  class="tablebold"><%=bundle.getString("label.photogallery.academicsession")%></td><td width="1%" class=tablebold>:</td><td width="15%" class="tablelight"><%=yearname%></td>
				<td width="15%" class="tablebold"><%=bundle.getString("label.extracurricularactivity.curricularactivity")%></td><td width="1%" class="tablebold">:</td><td width="20%" class="tablelight"><%=categoryname%></td>
				</tr>
				<%
				}
				%>
				<tr>
				<td width="15%" class="tablebold"><%=bundle.getString("label.photogallery.eventdate")%></td><td width="1%" class="tablebold">:</td><td width="15%" class="tablelight"><%=eventdate%></td>
				<td width="15%" class="tablebold"><%=bundle.getString("label.photogallery.eventname")%></td><td width="1%"  class=tablebold>:</td><td width="15%" class="tablelight"><%=curriculareventname%></td>
				</tr>
				<tr>
				<td width="15%" class="tablebold"><%=bundle.getString("label.photogallery.venue")%> </td><td width="1%" class="tablebold">:</td><td colspan=4 width="15%" class="tablelight"><%=venue%></td>
				</tr>
				</table>
			<div id="container">
				<!-- Start Advanced Gallery Html Containers -->
				
				<div id="gallery" class="content">
					<div id="controls" class="controls"></div>
					<div id="loading" class="loader"></div>
					<div id="slideshow" class="slideshow"></div>
					<div id="caption" class="embox"></div>
				</div>
				
				<div id="thumbs" class="navigation">
					<ul class="thumbs noscript">
						

							
							
							<%

							String caption=null;
							HashMap photolistmap=null;
							String path=null;
							String path1=null;

									if(photolist!=null && photolist.size()>0)
									{
									for(int i=0;i<photolist.size();i++)
									{
										photolistmap=(HashMap)photolist.get(i);
										 path=(String)photolistmap.get("gallerypath");
										String  photoname=(String)photolistmap.get("photoname");
										 caption=(String)photolistmap.get("caption");
										out.print("<li><a class='thumb' href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+path+"' title='"+photoname+"'>");
										out.print("<img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+path+"' alt='Picture Title #01' width='75' height='75' border='0' path='"+path+"' /></a>");							
										out.print("<div class='caption'>");
										out.print("<div class='image-title'>"+caption+"</div>");
										//out.print("<div class='image-desc'> </div>");
										out.print("</div></li>");
										
									}  
																
									}
									else
									{
										out.print("<li><a align='center' >");
										out.print("Data Not Found</a>");							
										out.print("<center><div class='caption'>");
										out.print("<div class='image-title' align='center'>Data Not Found</div>");
										out.print("</div></center></li>");	
									}
									
							%>
			
					</ul>
				</div>
				   
				<!-- End Advanced Gallery Html Containers -->
				
				<div style="clear: both;"></div>
			</div>
		</div>
		<table width="100%" align="center">
		<tr>
		<td align="center">
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		</td>
		</tr>
		</table>
		<script type="text/javascript">
			// We only want these styles applied when javascript is enabled
			$('div.navigation').css({'width' : '300px', 'float' : 'left'});
			$('div.content').css('display', 'block');

			// Initially set opacity on thumbs and add
			// additional styling for hover effect on thumbs
			var onMouseOutOpacity = 0.67;
			$('#thumbs ul.thumbs li').css('opacity', onMouseOutOpacity)
				.hover(
					function () {
						$(this).not('.selected').fadeTo('fast', 1.0);
					}, 
					function () {
						$(this).not('.selected').fadeTo('fast', onMouseOutOpacity);
					}
				);

			$(document).ready(function() {
				// Initialize Advanced Galleriffic Gallery
				var galleryAdv = $('#gallery').galleriffic('#thumbs', {
					delay:                  2000,
					numThumbs:              12,
					preloadAhead:           10,
					enableTopPager:         true,
					enableBottomPager:      true,
					imageContainerSel:      '#slideshow',
					controlsContainerSel:   '#controls',
					captionContainerSel:    '#caption',
					loadingContainerSel:    '#loading',
					renderSSControls:       true,
					renderNavControls:      true,
					playLinkText:           'Play Slideshow',
					pauseLinkText:          'Pause Slideshow',
					prevLinkText:           '&lsaquo; Previous Photo',
					nextLinkText:           'Next Photo &rsaquo;',
					nextPageLinkText:       'Next &rsaquo;',
					prevPageLinkText:       '&lsaquo; Prev',
					enableHistory:          true,
					autoStart:              false,
					onChange:               function(prevIndex, nextIndex) {
						$('#thumbs ul.thumbs').children()
							.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
							.eq(nextIndex).fadeTo('fast', 1.0);
					},
					onTransitionOut:        function(callback) {
						$('#caption').fadeTo('fast', 0.0);
						$('#slideshow').fadeTo('fast', 0.0, callback);
					},
					onTransitionIn:         function() {
						$('#slideshow').fadeTo('fast', 1.0);
						$('#caption').fadeTo('fast', 1.0);
					},
					onPageTransitionOut:    function(callback) {
						$('#thumbs ul.thumbs').fadeTo('fast', 0.0, callback);
					},
					onPageTransitionIn:     function() {
						$('#thumbs ul.thumbs').fadeTo('fast', 1.0);
					}
				});
			});
		</script>	
		
			  </td>
          <td width="18" align="left" valign="top" class="body">&nbsp;</td>
        </tr>
        <tr>
          <td width="18">&nbsp;</td>
          <td width="964" align="left" valign="top" class="body">&nbsp;</td>
          <td width="18" align="left" valign="top" class="body">&nbsp;</td>
        </tr>
      </table>
      </td>
	</tr>
			
	

</body>

</html>
