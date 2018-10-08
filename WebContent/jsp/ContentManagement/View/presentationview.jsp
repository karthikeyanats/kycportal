
<html>
<head>
<!--Make sure your page contains a valid doctype at the very top-->

<script type = 'text/javascript' src='../js/speech.js'></script>
<link rel="stylesheet" type="text/css"	href="<%=request.getContextPath()%>/css/School_style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript"> 
function incrementfun(id)
{
	        var inc=0;
			document.getElementById("table1").style.width=id+"px";
			id=id+50;
			if(id<=250)
			inc=setTimeout("incrementfun("+id+")",20);
			else
				{
				clearTimeout(inc);
				document.getElementById("tableid").style.display="block";
				document.getElementById("tableid").setAttribute("width","100%");
				document.getElementById("tableid").setAttribute("height","100%");

				document.getElementById("tableid").setAttribute("cellpadding","5");


				}
			document.getElementById("img_MenuOP").src="../View/TreeReport/content_images/aright.gif";
			document.getElementById("img_MenuOP").title="Hide Meta Data";

			document.getElementById("showhidelabel").innerHTML="Hide Meta Data";


}
function decrementfun(id)
{
			document.getElementById("tableid").style.display="none";
	        var inc=0;
			id=parseInt(id)-50;

			document.getElementById("table1").style.width=id+"px";

			if(id>0)
				{
					inc=setTimeout("decrementfun("+id+")",20);
				}
			else
				{
					clearTimeout(inc);
					document.getElementById("img_MenuOP").src="../View/TreeReport/content_images/aleft.gif";
					document.getElementById("img_MenuOP").title="Show Meta Data";

					document.getElementById("showhidelabel").innerHTML="Show Meta Data";
				}


}
function togglefun()
{
	var width=document.getElementById("table1").style.width;
	if(width=="0px")
		incrementfun(0)
	else
		decrementfun(250)
}

</script> 
<script language='javascript'>
var is_ie = (/msie/i.test(navigator.userAgent));

function increaseFrame()
{
  	parent.document.getElementsByTagName('frameset')[1].cols='220,*';
}

function startSpeech()
{
	nativeFrame(0);
}

function stopSpeech()
{
	nativeFrame(4);
}

function speachInitializ()
{
	//document.extra_form.current_url.value = "./jsp/TreeReport/Viewpage.jsp";
	sendWithCurrentPage();
	//parent.location.replace("../../");
	//document.extra_form.submit();
}

function videoPanel()
{
	var ext = document.f1.extension.value;
	var url = document.f1.filePath.value;

	if(is_ie)
	{
	if(ext!=null && ext!="")
	{
	  state = "yes";
    }
    if(ext=="mp3" || ext == "avi" || ext=="mpeg" || ext=="wav" || ext=="wmv" || ext=="mpg" || ext=="mp4" || ext=="mkv")
	{
				if(state=="yes")
				{
					var filetype=url.substring((url.lastIndexOf('.'))+1,url.length);
					if(filetype=="flv")
					{
						var embedText	= '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="100%" height="250" id="player" align="middle">';
						embedText	+= '<param name="allowScriptAccess" value="sameDomain" />';
						embedText	+= '<param name="movie" value="player.swf" />';
						embedText	+= '<param name="quality" value="high" />';
						embedText	+= '<param name="bgcolor" value="#ffffff" />';
						embedText	+= '<param name="allowFullScreen" value="true" />';
						embedText	+= '<param name="FlashVars" value="file='+url+'"';
						embedText	+= '<embed src="player.swf" quality="high" FlashVars ="/VirtualD/Open?r1=VIRTUALKMS&r2='+url+'" allowFullScreen="true" bgcolor="#ffffff" width="640" height="525" name="player" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
						embedText	+= '</object>';
						vplayer.innerHTML=embedText;
					}
					else if(filetype=="mp4" || filetype=="mkv" || ext == "avi" || ext=="mpeg" || ext=="mpg" || ext=="mp4")
					{

						//document.all.vlc.play();

					}
					else
					{

						var embedText='<object classid="clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6" type="video/x-ms-wmv" id="videoplayer" name="videoplayer" width="100%" height="375">';
						  embedText	+='<param name="URL" value="'+url+'">';
						  embedText	+='<param name="rate" value="1">';
						  embedText	+='<param name="balance" value="0">';
						  embedText	+='<param name="currentPosition" value="0">';
						  embedText	+='<param name="defaultFrame" value>';
						  embedText	+='<param name="playCount" value="9999">';
						  embedText	+='<param name="autoStart" value="-1">';
						  embedText	+='<param name="SendPlayStateChangeEvents" value="True">';
						  embedText	+='<param name="currentMarker" value="0">';
						  embedText	+='<param name="invokeURLs" value="0">';
						  embedText	+='<param name="baseURL" value>';
						  embedText	+='<param name="volume" value="100">';
						  embedText	+='<param name="mute" value="0">';
						  embedText	+='<param name="stretchToFit" value="1">';
						  embedText	+='<param name="windowlessVideo" value="0">';
						  embedText	+='<param name="enabled" value="-1">';
						  embedText	+='<param name="enableContextMenu" value="-1">';
						  embedText	+='<param name="fullScreen" value="0">';
						  embedText	+='<param name="SAMIStyle" value>';
						  embedText	+='<param name="SAMILang" value>';
						  embedText	+='<param name="SAMIFilename" value>';
						  embedText	+='<param name="captioningID" value>';
						  embedText	+='<param name="enableErrorDialogs" value="0">';
						  embedText	+='<param name="_cx" value="9419">';
						  embedText	+='<param name="_cy" value="8678">';
						  embedText	+='</object>';

						  if(!is_ie)
						  {

							embedText1='<EMBED type="video/x-ms-wmv" src='+url+' name="myPlayer" id="myPlayer" autostart="true" showcontrols="1" animationatstart="0" transparentatstart="1" AllowChangeDisplaySize="1" enableContextMenu="0" width="600" height="500">';
							var vplayerobj=document.getElementById("vplayer");
							var tabObj=document.getElementById("tb1");
							tabObj.removeChild(tabObj.getElementsByTagName("tbody")[0]);
							var trObj=document.createElement("tr");
							trObj.valign='top';
							var tdObj=document.createElement("td");
							tdObj.align='center';
							tdObj.valign='top';
							tdObj.width='89%';
							tdObj.innerHTML=embedText1;
							trObj.appendChild(tdObj);
							tabObj.appendChild(trObj);

						  }
						 else
						 {
							vplayer.innerHTML=embedText;
						 }



					}
				}
				else
				{
					if(is_ie)
					{
					  document.all.videoplayer.src = "./video_navailable.html";
					}
					else
					{
						document.getElementById("videoplayer").src = "./video_navailable.html";
					}
				}
		}
		else
		{

			if(is_ie)
			{
				document.all.videoplayer.src = url;

			}
			else
			{
				document.getElementById("videoplayer").src = url;

			}
		}
		}
		else
		{

			embedText1='<EMBED type="application/x-vlc-plugin" src="'+url+'" name="myPlayer" id="myPlayer" autostart="true" showcontrols="1" animationatstart="0" transparentatstart="1" AllowChangeDisplaySize="1" enableContextMenu="1" width="600" height="500" />';
			var vplayerobj=document.getElementById("vplayer");
			var tabObj=document.getElementById("tb1");
			tabObj.removeChild(tabObj.getElementsByTagName("tbody")[0]);
			var trObj=document.createElement("tr");
			trObj.valign='top';
			var tdObj=document.createElement("td");
			tdObj.align='center';
			tdObj.valign='top';
			tdObj.width='89%';
			tdObj.innerHTML=embedText1;
			trObj.appendChild(tdObj);
			tabObj.appendChild(trObj);


		}
}

</script>
</head>
<body >
<%@ page import="java.net.InetAddress, java.util.ResourceBundle,java.io.ByteArrayInputStream"%>
<%
   String filePath				= request.getParameter("filePath");
	//System.out.println("filePath:::"+filePath);
	String filename				= request.getParameter("fileName");
	String contentNotes=request.getParameter("contentNotes");
	filename=filename.substring(0,(filename.length())-4);
	 // System.out.println("contentNotes:::"+contentNotes);
	  // System.out.println("fleone:::"+filename);


   String browsertype			= request.getHeader("User-Agent");
   String browsername			= "";
   if(browsertype.indexOf("MSIE")!=-1)
   		browsername				= "InternetExplorer";
   	else
   		browsername				= "FireFox";

   String coursename			= request.getParameter("coursename");
   String semestername 			= request.getParameter("semestername");
   String subjectname			= request.getParameter("subjectname");
   String userid 				= request.getParameter("userid");
   String logid 				= request.getParameter("logid");
   String cmscontentid 			= request.getParameter("cmscontentid");

   
   //out.print("<table width='100%' align=right><tr class=tablebold><td width='100%' class=tablebold align=right><a href='/igeducation/OpenDocument?r1=storagepath&r2="+filePath+"&r3=download&r4="+filename+"'>download</a></td></tr></table><br><br>");
   
   String extension				= null;																									
   int hitstat 					= 0;
  // if(request.getParameter("userid") != null)
   //{
	 // hitstat 					= cmsquery.insertTrack(logid,userid);
   //}
  //String commonsubid 			= request.getParameter("commonsubjectid");
  // String contentUrl 			= query_bean.getContentUrl(commonsubid);
   ResourceBundle rb 			= ResourceBundle.getBundle("resources.serversetup");
   String hostadd 				= request.getServerName();
   String hostport 				= request.getServerPort()+"";
   String contentstoragepath 	= rb.getString("storagepath");
   String dbpath 				= "";
   String contentPath 			=request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filePath;



    if(filePath.startsWith("scorm"))
  	{

		filePath 				= filePath.substring(6,filePath.length());
		String conPath			= "/ScormContent/"+filePath.toString();
		conPath					= conPath.replace('/','\\');
		ByteArrayInputStream bais	= new ByteArrayInputStream(conPath.getBytes());
		java.util.ResourceBundle rbundle	= java.util.ResourceBundle.getBundle("resources.serversetup");
		String storagepath		= rbundle.getString("storagepath");
		String serverip			= rbundle.getString("serverip");
		int cc					= 0;
		String target			= "";

		while((cc=bais.read())!=-1)
		{
			char ch=(char)cc;
			if(ch=='+')
			target=target+"%2B";
			else
			target=target+ch;
		}
		filePath 				= conPath;
  	}
  	else
  	{
		extension=filePath.substring(filePath.lastIndexOf(".")+1,filePath.length());
		if(extension.equals("wav") || extension.equals("mp4") || extension.equals("mpg") || extension.equals("mkv") || extension.equals("mpeg") || extension.equals("wmv") || extension.equals("avi") || extension.equals("mp3"))
		  {
			  filePath=request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filePath;
 		  }
 		  else
 		  {
			  filePath=request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filePath;
		  }
	}
  if(filePath!=null && filePath.lastIndexOf(".")!=-1)
  {
	  int c		= filePath.lastIndexOf(".");
      extension	= filePath.substring(c+1,filePath.length());
  }

 %>
<form name="f1" method="post">

<%
	if(extension.equals("html"))
	{
	%>
	
	<table border="0" BORDERCOLOR='RED' cellpadding="1" cellspacing="1" width="90%">
	<tr><td width="20%">
	&nbsp; &nbsp; &nbsp;<a onclick="increaseFrame()" style="cursor:pointer" class="nvlink"><img border="0" src="../Help/images/next.gif"> </a>
	</td>
	<td align=right><input type='button' name='start_speech' style="background-image: url('../../images/cont_bg1.gif'); background-color: #0099CC; border-style: groove; color:black;" class='tablebold' value='Start Speech' onClick='startSpeech();'>&nbsp;<input type='button' name='stop_speech' style="background-image: url('../../images/cont_bg1.gif'); background-color: #0099CC; border-style: groove; color:black;" class='tablebold' value='Stop Speech' onClick='stopSpeech();'></td>
	<td width="80%" align="right">
	<input type='button' style='border-style: groove' class='tablelight' value='Speech Initialize' onClick='speachInitializ();'>&nbsp;
	</td>
</tr>
</table>
<br>
	<%
	}
	%>
<table border=0width=100% cellpadding='0' bordercolor="#000000" cellspaceing='0'>
<tr>
<td  colspan=3 align=left>
<table border=1 valign='top' cellpadding="10" cellspacing="0" width="100%" bordercolor="#000000" rules=groups>
<tr >
<td class=tablebold  align=left width=20%>
<font size=3px>Lesson Name</font> </td> <td>:</td>
<td  class=tablelight><font size=3px color=green><%=request.getParameter("lessonName") %>
</font></td><td  class=tablebold width=100px rowspan=2> 
<a href="#" style="cursor:hand;float:right;" class="nvlink" onclick="togglefun();" title='Meta Data' class=tablelight> <span id="showhidelabel">Hide Meta Data</span></a>
</td>
</tr>
<tr >
<td class=tablebold  align=left>
<font size=3px>File Name</font> </td> <td>:</td>
<td  class=tablelight> <font size=3px color=green><%=request.getParameter("fileName") %></font></td></tr>
</table>
</td>
</tr>
<tr>
<td width=100% >
<table border="1" BORDERCOLOR=black id="tb1" valign='top' cellpadding="0" cellspacing="0" width="100%" align="center" height="400">
	<tbody>
  	  <tr valign=top>
			<td align="center" valign='top' id="panelController" >
				<%
				if(extension.equals("mpg") || extension.equals("mp4") || extension.equals("mpeg") )
				{

					if(browsername.equals("InternetExplorer"))
					{
					  %>
						<object classid='clsid:E23FE9C6-778E-49D4-B537-38FCDE4887D8' codebase='http://downloads.videolan.org/pub/videolan/vlc/latest/win32/axvlc.cab' width='100%' height='450' id='vlc' events='True'>
							<param name='Src' value='<%=filePath%>' />
							<param name='ShowDisplay' value='True' />
							<param name='AutoLoop' value='True' />
							<param name='AutoPlay' value='True' />
							<param name='Volume' value='100'/>
						</object>
					 <%
					}
					else
					{
					 %>
						<EMBED type='application/x-vlc-plugin' src='<%=filePath%>' name='myPlayer' id='myPlayer' autostart='true' showcontrols='1' animationatstart='0' transparentatstart='1' AllowChangeDisplaySize='1' enableContextMenu='1' width='100%' height='450' />
					 <%
					}
				}
				else if(extension.equals("swf"))
				{
				  %>
					<embed src="<%=filePath%>" width="500" height="450">
					</embed>
				  <%
				}
				else if(extension.equals("flv"))
				{
				  %>
					<span id="vplayer">
						<iframe name="videoplayer" id="videoplayer" value="SLIDE URL" src="<%=request.getContextPath()%>/jsp/ContentManagement/flvplayer/flvplay.jsp?txtval=<%=filePath%>" width="100%" height="400"></iframe>
					</span>

				  <%
				}
				else if(extension.equals("mp3") || extension.equals("wav") || extension.equals("wmv") || extension.equals("avi"))
				{
					if(browsername.equals("InternetExplorer"))
					{
					  %>
						<object classid="clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6" type="video/x-ms-wmv" id="videoplayer" name="videoplayer" width="100%" height="500">
						   <param name="URL" value="<%=filePath%>">
						   <param name="rate" value="1">
						   <param name="balance" value="0">
						   <param name="currentPosition" value="0">
						   <param name="defaultFrame" value>
						   <param name="playCount" value="9999">
						   <param name="autoStart" value="-1">
						   <param name="SendPlayStateChangeEvents" value="True">';
						   <param name="currentMarker" value="0">
						   <param name="invokeURLs" value="0">
						   <param name="baseURL" value>
						   <param name="volume" value="100">
						   <param name="mute" value="0">
						   <param name="stretchToFit" value="1">
						   <param name="windowlessVideo" value="0">
						   <param name="enabled" value="-1">
						   <param name="enableContextMenu" value="-1">
						   <param name="fullScreen" value="0">
						   <param name="SAMIStyle" value>
						   <param name="SAMILang" value>
						   <param name="SAMIFilename" value>
						   <param name="captioningID" value>
						   <param name="enableErrorDialogs" value="0">
						   <param name="_cx" value="9419">
						   <param name="_cy" value="8678">
						</object>
					 <%
					}
					 else
					{
					 %>
						<EMBED type="video/x-ms-wmv" src="<%=filePath%>" name="myPlayer" id="myPlayer" autostart="true" showcontrols="1" animationatstart="0" transparentatstart="1" AllowChangeDisplaySize="1" enableContextMenu="0" width="500" height="450">
					 <%
					}

				}
				else
				{
				 %>
					<span id="vplayer">
					  <iframe name="videoplayer" id="videoplayer" value="SLIDE URL" src="<%=filePath%>" width="100%" height="500"></iframe>
					</span>
				 <%
				}
				%>
			</td>
		</tr>
  </tbody>
</table>
</td>
<td width=1px class=tablelight bgcolor=grey  style="cursor:hand" class="nvlink"  name='arrowmark' onclick="togglefun();" >
<a href="#" style="cursor:hand" class="nvlink"  name='arrowmark' onclick="togglefun();" title='Hide Meta Data'>

<div id=arrow ><b><img id='img_MenuOP' name="img_MenuOP"   border="0" src="../View/TreeReport/content_images/aright.gif"></div></a>
</td>
<td valign=top>
												<div id='table1' style="width:250px;display:block;height:400px;" valign=top   >
												<%@ page language="java" import="com.iGrandee.Content.ContentQurey,java.util.ArrayList,java.util.HashMap"%>
												<%
												    ContentQurey query =new ContentQurey();
												 	String title="-";
												    String cmsmetainfoid="-";
												    String source="-";
												    String presentername="-";
												    String metainstitutename="-";
												    String referenceurl="-";
												    String licensedby="-";
												    String description="-";
												    ArrayList contentlist=query.LoadLessonContentmetainfo(cmscontentid);
												    if(contentlist.size()>0)
													{
														for(int y=0,sno=1;y<contentlist.size();y++)
														{
																HashMap map=(HashMap)contentlist.get(y);
															     title=map.get("contenttitle")+"";
															     cmsmetainfoid=map.get("cmsmetainfoid")+"";
															     source=map.get("source")+"";
															     presentername=map.get("presentername")+"";
															     metainstitutename=map.get("institutionname")+"";
															     referenceurl=map.get("referenceurl")+"";
															     licensedby=map.get("licensedby")+"";
															     description=map.get("description")+"";
															    if(description.equalsIgnoreCase("null") )
															    	description="-";
															    if(licensedby.equalsIgnoreCase("null"))
															    	licensedby="-";
															    if(metainstitutename.equalsIgnoreCase("null"))
																    metainstitutename="-";
															    if(referenceurl.equalsIgnoreCase("null"))
															    	referenceurl="-";
															    if(presentername.equalsIgnoreCase("null"))
															    	presentername="-";
															    if(source.equalsIgnoreCase("null"))
															    	source="-";
															    if(title.equalsIgnoreCase("null"))
															    	title="-";
															    if(description.length()==0 )
															    	description="-";
															    if(licensedby.length()==0)
															    	licensedby="-";
															    if(metainstitutename.length()==0)
																    metainstitutename="-";
															    if(referenceurl.length()==0)
															    	referenceurl="-";
															    if(presentername.length()==0)
															    	presentername="-";
															    if(source.length()==0)
															    	source="-";
															    if(title.length()==0)
															    	title="-";
															    
														}
													}
														out.print("<table width='100%' height='100%' id='tableid' align='center' border='1' bordercolor='black'  valign=top class=tablelight cellpadding=5  cellspacing=0 rules=groups>");
														out.print("<tr><td width='100%' colspan=3 class=tableheading    height='30px'><h3><u>MetaData</u></h3></td></tr>");
														out.print("<tr><td class=tablebold width='45%' >Title</td><td width=1px>:</td><td >"+title+"</td></tr>");
														out.print("<tr><td class=tablebold>Source</td><td width=1px>:</td><td >"+source+"</td></tr>");
														out.print("<tr><td class=tablebold>Presenter Name</td><td width=1px>:</td><td >"+presentername+"</td></tr>");
														out.print("<tr><td class=tablebold>Institute Name</td><td width=1px>:</td><td >"+metainstitutename+"</td></tr>");
														out.print("<tr><td class=tablebold>Reference URL</td><td width=1px>:</td><td >"+referenceurl+"</td></tr>");
														out.print("<tr><td class=tablebold>Licensed By</td><td width=1px>:</td><td >"+licensedby+"</td></tr>");
														out.print("<tr><td colspan=3 class=tablebold>Description </td></tr>");
														out.print("<tr><td  colspan=3>"+description+"</td></tr>");
														out.print("</table>");
													%>
	</div>
</td>
</tr>
<tr>
<td colspan=3>

<table border=0 align="left" bgcolor="#eeeeee" cellpadding=3 cellspacing=2 width=100%>
<tr>
	<td align="left" class="tablebold"><font color=red><u>Content Notes:</u></font></td>
</tr>
<tr>
	<td class="tablelight"><%=(contentNotes+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%></td>
</tr></table>
</td>
</tr>
</table>
<input type="hidden" name="coursename"   value="<%=coursename%>">
<input type="hidden" name="semestername" value="<%=semestername%>">
<input type="hidden" name="subjectname"  value="<%=subjectname%>">
<input type="hidden" name="filePath"     value="<%=filePath%>">
<input type="hidden" name="contentPath"     value="<%=contentPath%>">
<input type="hidden" name="extension"     value="<%=extension%>">
<input type="hidden" name="by_pass_url" value="">
<input type="hidden" name="filename"     value="<%=filename%>">

</form>
</body>
</html>