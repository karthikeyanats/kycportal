<%@ page import="java.util.*,java.lang.*,java.io.*,com.iGrandee.Content.ContentQurey,com.iGrandee.Content.ContentViewQry"%>

<HTML>
<HEAD>
<title>Learning</title>
<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/School_style.css" type="text/css" />
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="NetObjects Fusion 4.0 Trial for Windows">
<SCRIPT language="JavaScript" src="../js/MenuRoller.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/ServerPath.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/Elements.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/form_label.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/Validation.js"></SCRIPT>
<SCRIPT language="JavaScript" src='../js/Calendar/Calendar.js'></SCRIPT>
<script language="javascript">
var is_ie = (/msie/i.test(navigator.userAgent));
function getQuiz(requestType)
{
	if(document.listform.lessonNamehid.value!="")
	{
		if(requestType=="Quiz")
		{
			document.listform.action = "./ViewQuiz.jsp";
			document.listform.submit();
		}
		else
		{
			document.listform.action = "./ViewExcercise.jsp";
			document.listform.submit();
		}
	}
	else
	{
		alert("Please Select Lesson to view "+requestType);
		return false;
	}
}

function increaseFrame()
{
	
	var path=document.forms["listform"].img_MenuOP.src;
	if(path.indexOf("aleft")>-1)
	{
		parent.document.getElementsByTagName('frameset')[1].cols='0,*';
		//parent.resizeFrame('0,*')
		document.forms["listform"].img_MenuOP.src="../View/TreeReport/content_images/aright.gif";
	}
	else
	{
		parent.document.getElementsByTagName('frameset')[1].cols='220,*';
		//parent.resizeFrame('220,*')
		document.forms["listform"].img_MenuOP.src="../View/TreeReport/content_images/aleft.gif";
	}
}

function initRequest()
{
   if(window.XMLHttpRequest)
   {
	   return new XMLHttpRequest();
   }
   else if (window.ActiveXObject)
   {
	   //alert("NOT ACTIVE");
	   isIE = true;
	   return new ActiveXObject("Microsoft.XMLHTTP");
   }
}

function doCompletion(obj)
{
	url ="presentationview.jsp?filePath="+obj.filepath;
	var req =initRequest();
	req.onreadystatechange = function()
	{
		if (req.readyState == 4)
		{
			if (req.status == 200)
			{
				document.getElementById("run_span").innerHTML=req.responseText;
			}
			else if (req.status == 204)
			{}
		}
	};
	req.open("GET", url, true);
	req.send(null);
}
function gotoDownload(obj)
{
		var ext = obj.getAttribute("ext");
		var url = obj.getAttribute("filepath");
		window.open(url+"&r3=download");
}
function runFile(obj)
{
	document.getElementById("tab_pre_first").style.display = "none";
	document.getElementById("tab_aud_first").style.display = "none";
	document.getElementById("tab_vid_first").style.display = "none";

 	document.getElementById("div_pre").style.height = "25px";
	document.getElementById("div_aud").style.height = "25px";
	document.getElementById("div_vid").style.height = "25px";

	var ext = obj.getAttribute("ext");
	//alert("ext"+ext);
	var url = obj.getAttribute("filepath");

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
				run_span.innerHTML=embedText;
			}
			else if(filetype=="mp4" ||  filetype=="mkv")
			{
				var embedText='<object classid="clsid:E23FE9C6-778E-49D4-B537-38FCDE4887D8" codebase="http://downloads.videolan.org/pub/videolan/vlc/latest/win32/axvlc.cab" width="100%" height="250" id="vlc" events="True">';
				embedText	+='<param name="Src" value='+url+' />';
				embedText	+='<param name="ShowDisplay" value="True" />';
				embedText	+='<param name="AutoLoop" value="False" />';
				embedText	+='<param name="AutoPlay" value="False" />';
				embedText	+='<param name="Volume" value="100"/>';
				embedText	+='</object>';
				run_span.innerHTML=embedText;
				document.all.vlc.play();
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
					embedText	+='<EMBED type="video/x-ms-wmv" src='+url+' name="myPlayer" id="myPlayer" autostart="1" showcontrols="1" animationatstart="0" transparentatstart="1" AllowChangeDisplaySize="1" enableContextMenu="0" width="100%" height="500">';
					var run_spanobj=document.getElementById("run_span");

					var tabObj=document.getElementById("tb1");
					tabObj.removeChild(tabObj.getElementsByTagName("tbody")[0]);
					var trObj=document.createElement("tr");
					trObj.valign='top';
					var tdObj=document.createElement("td");
					tdObj.align='center';
					tdObj.valign='top';
					tdObj.width='89%';
					tdObj.innerHTML=embedText;
					trObj.appendChild(tdObj);
					tabObj.appendChild(trObj);
				}
				else
				{
					run_span.innerHTML=embedText;
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
		document.getElementById("run_span").innerHTML="";
		var table_new  = document.createElement("table");
		table_new.width="100%";
		table_new.height="10%";
		//table_new.border='1';
		var tbody_new=document.createElement("tbody");
		var tr_new = document.createElement("tr");
		tr_new.vAlign='top';
		var td_new=document.createElement("td");
		td_new.vAlign='top';
		td_new.align='right';
		td_new.innerHTML="<a href='#' filePath='"+url+"' onclick='gotoDownload(this)'>Download</a>";
		td_new.className='tablebold';
		tr_new.appendChild(td_new);
		tbody_new.appendChild(tr_new);
		table_new.appendChild(tbody_new);

		var ifr = document.createElement("iframe");
		ifr.id = "videoplayer";
		ifr.src = url;

		ifr.width = "100%";
		ifr.height = "400";
		document.getElementById("run_span").appendChild(table_new);
		document.getElementById("run_span").appendChild(ifr);
	}
}

function presentation(obj)
{
	var filePath = obj.getAttribute("filepath");
	var logid = obj.getAttribute("logid");
	var comsubid = obj.getAttribute("comsubid");
	//alert("presentationview.jsp?filePath="+filePath+"&commonsubjectid="+comsubid+"&coursename="+document.listform.coursename.value+"&logid="+logid+"&userid="+document.listform.userid.value);
	document.listform.action = "presentationview.jsp?filePath="+filePath+"&commonsubjectid="+comsubid+"&coursename="+document.listform.coursename.value+"&logid="+logid+"&userid="+document.listform.userid.value;
	document.listform.submit();

}

function callRetrive()
{
	
	if(document.getElementById("tab_pre_first").style.display=="none")
	{
		document.getElementById("run_span").innerHTML="";

		document.getElementById("tab_pre_first").style.display = "block";
		document.getElementById("tab_aud_first").style.display = "block";
		document.getElementById("tab_vid_first").style.display = "block";

		document.getElementById("div_pre").style.height = "300px";
		document.getElementById("div_aud").style.height = "300px";
		document.getElementById("div_vid").style.height = "300px";
	}
}

	function loadAssesment(obj){
		
		document.listform.subjectscheduleid.value	= obj.getAttribute("subjectid");
		document.listform.action = "SelfAssesment.jsp";
		document.listform.submit();
	
	}

</script>
</HEAD>

<BODY LINK="#0000FF"  VLINK="#800080" TEXT="#000000" TOPMARGIN="0" LEFTMARGIN="0" MARGINWIDTH=0 MARGINHEIGHT=0>
<form name="listform" method="post">

<input type="hidden" name="subjectscheduleid" value=""/>



<%

ContentViewQry contentview_query =new ContentViewQry();
ContentQurey content_query =new ContentQurey();

ResourceBundle bundle =null;
try{
 bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
}
catch(Exception e)
{
	e.printStackTrace();
}
%>

<%
System.out.println("=================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	String submitmode 		= "";
	String dbsubjectid 		= "";
	String lessonid 		= "";
	String logstatus		= "";
	String lessonNamehid	= "";
	String fileName="";
	
	
	HashMap fileTypeMap 	= new HashMap();

	fileTypeMap.put("jpg", "jpgimageicon.png");
	fileTypeMap.put("JPG", "jpgimageicon.png");
	fileTypeMap.put("gif", "gifimageicon.png");
	fileTypeMap.put("bmp", "bmpimageicon.png");
	fileTypeMap.put("bmp", "bmpimageicon.png");
	fileTypeMap.put("png", "pngimageicon.png");
	fileTypeMap.put("tif", "tifimageicon.png");

	fileTypeMap.put("pdf", "pdficon.png");
	fileTypeMap.put("doc", "wordicon.png");
    fileTypeMap.put("xls", "excelicon2.png");

	fileTypeMap.put("htm", "ieicon.png");
	fileTypeMap.put("html", "ieicon.png");
	fileTypeMap.put("ppt", "powerpointicon.png");

	fileTypeMap.put("mp3", "audioicon.png");
	fileTypeMap.put("mpg", "videoicon.png");
	fileTypeMap.put("mp4", "videoicon.png");
	fileTypeMap.put("wmv", "videoicon.png");
	fileTypeMap.put("avi", "videoicon.png");
	fileTypeMap.put("mkv", "videoicon.png");

	String userid 		= (String)session.getValue("userid");
	String usercategory = (String)session.getValue("usercategory");
	String subjectId	= request.getParameter("SubjectList");
	//String subjectId	= request.getParameter("SubjectIdNew");	
	String subjectname	= request.getParameter("subjectname1");
	String coursename	= request.getParameter("coursename");
	String semestername	= request.getParameter("semestername");
	



	if(request.getParameter("submitmode") != null)
	{
		submitmode = request.getParameter("submitmode");
	}

	if(request.getParameter("lessonid") != null)
	{
		lessonid = request.getParameter("lessonid");
		lessonNamehid = request.getParameter("lessonName");
	}
%>

<!-- BODY CONTENT TABLE START -->

<TABLE align="center" width="100%" height="100%" border="0" cellspacing="0" cellpadding="8">
	&nbsp; &nbsp; &nbsp;<a  style="cursor:hand" class="nvlink"  onclick="increaseFrame()"><font color='blue'><b><img id='img_MenuOP' name="img_MenuOP"   border="0" src="../View/TreeReport/content_images/aleft.gif"></font></a>
	<TR height="15%">
		<TD valign="top" colspan="3">
			<table width="100%" align="center" cellpadding="5" cellspacing=0 border="1" class="table">
			<%
				String requestValue = request.getParameter("value");
				ArrayList subjectList = new ArrayList();
				HashMap subjectMap = new HashMap();
				
				subjectList = contentview_query.getLearningSubjectDetail(subjectId);
				String subjectName=null;
				String subjectCode=null;
				String internalMarks=null;
				String creditHours=null;
				String logid		= null;
				String filePath=null;
				String subjectName1=null;

				for(int j=0;j<subjectList.size();j++)
				{
					subjectMap=(HashMap)subjectList.get(j);
					subjectName1=(String)subjectMap.get("subjectname");
					dbsubjectid=(String)subjectMap.get("subjectid");
					subjectCode=(String)subjectMap.get("subjectcode");
					creditHours=(String)subjectMap.get("credithours");
				}
				subjectname = subjectName;
				if(subjectname != null &&  subjectname.indexOf("+")!=-1)
				{
					subjectname = subjectname.replace("+","%2B");
				}

				String staffName = contentview_query.getSubjectsStaff(dbsubjectid);
			%>
				<tr>
					<td class='tablehead' width="20%"><%=bundle.getString("label.Content.SubjectName")%></td>
					<td colspan=3 class='tablebold' width="80%"><%=subjectName1%></td>
				</tr>
				<tr>
					<td class='tablehead' width="20%"><%=bundle.getString("label.Content.SubjectCode")%></td>
					<td colspan=3  class='tablebold' width="80%"><%=subjectCode%></td>
				</tr> 
				<!-- <tr>
					<td class='tablehead' width="20%"><%=bundle.getString("label.Content.CreditHours")%></td>
					<td colspan=3  class='tablebold' width="80%"><%=creditHours%></td>
				</tr> -->
				<tr>
					<td colspan=4  class='tablebold' width="100%" align='right'>
						<a href='#cls' subjectid='<%=subjectId%>' onclick='loadAssesment(this)'>Self Assesment</a>
					</td>
				</tr>
			</table>

		

	<TR valign="top" style="height=5;">
		<TD colspan=3 align='center'>
			<hr>
		</TD>
	</TR>

	<TR valign="top" style="height=10;">
		<TD colspan=3 align='center'>
			<span id='run_span' height="10"></span>
		</TD>
	</TR>
<%
	if(submitmode.equals("lesson"))
	{
%>
    <TR valign="top" style="height=50;">
		<TD width="33%" valign="top">
			<div id="div_pre" style="border:2px solid #EEEEEE;height:300px;width:240px;overflow-y:auto">
			<table id="tab_pre" cellspacing="0" bordercolor="#EEEEEE" height="90%" cellpadding="0" border="0" valign="top" width="100%">
				<tr>
					<td height="20" class="tablehead">
						&nbsp;<a href="#" style="text-decoration:none" onClick="callRetrive()"><font color="black">Presentation Content</font></a>
					</td>
				</tr>
				<tr>
				<td valign="top">
				   <table id="tab_pre_first" cellspacing="0" cellpadding="0" border="0" valign="top" width="100%">
					<tr>
						<td class="tablebold" valign="top" align="left">
						<table class="tablelight">
				<%
					ArrayList contentList=new ArrayList();
					HashMap contentMap=new HashMap();
					String lessonScheduleid = request.getParameter("lessonScheduleid");
					//contentList=content_query.LoadDeployedContentLessonList(lessonid,subjectId,"A","pdf','ppt','doc");
					contentList=content_query.LoadDeployedContentLessonList(lessonid,lessonScheduleid,"A","txt','jpeg','jpg','gif','png','bmp','doc','docx','ppt','pptx','swf','pdf");
					
					if(contentList!=null &&  contentList.size()>0)
					{
						for(int j=0;j<contentList.size();j++)
						{
							contentMap=(HashMap)contentList.get(j);
							fileName=(String)contentMap.get("filename");
							filePath=(String)contentMap.get("filepath");
							String filetype=(String)contentMap.get("type");
							String lessonName=lessonNamehid;

							//out.println("<tr class='tablelight'><td  class='tablelight'>"+(j+1)+".</td><td  class='tablelight'><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filePath+"' title='"+fileName+"'>");
							out.println("<tr class='tablelight'><td  class='tablelight'>"+(j+1)+".</td><td  class='tablelight'><a href='./presentationview.jsp?filePath="+filePath+"&commonsubjectid="+dbsubjectid+"&userid="+userid+"&fileName="+fileName+"&contentNotes="+contentMap.get("contentnotes")+"&lessonName="+lessonName+"&cmscontentid="+contentMap.get("cmscontentid")+"' title='"+fileName+"'>");
							
							if(fileName.length()>20)
								out.println(fileName.substring(0,20)+"...");
							else
								out.println(fileName);
							out.println("</a></td></tr>");
						}
					}
					
					else
					{
						out.println("<tr><td> File Not Found..</td></tr>");
					}
					
					%>
			  </table>
											  	</td>
					</tr>
			   </table>
			</td></tr></table>
		  	</div>
		</TD>

           <TD width="33%">
			<div id="div_aud" style="border:2px solid #EEEEEE;height:300px;width:240px;overflow-y:auto">

           <table id="tab_aud"  cellspacing="0" bordercolor="#EEEEEE" height="90%" cellpadding="0" border="0" valign="top" width="100%">
			<tr>
				<td height="20" class="tablehead">
					&nbsp;<a href="#" style="text-decoration:none" onClick="callRetrive()"><font color="black">Audio Content</font></a>
 				</td>
			</tr>

			<tr><td valign="top">
              <table id="tab_aud_first"  cellspacing="0" cellpadding="0" border="0" valign="top" width="100%">
				<tr>
					<td class="tablebold">
					<table class="tablelight">
				<%
					ArrayList audioList=new ArrayList();
					HashMap audioMap=new HashMap();
					//audioList=content_query.LoadDeployedContentLessonList(lessonid,subjectId,"A","mp3','wav");
					audioList=content_query.LoadDeployedContentLessonList(lessonid,lessonScheduleid,"A","wav','mp3','wma");
					if(audioList!=null &&  audioList.size()>0)
					{
						for(int j=0;j<audioList.size();j++)
						{
							audioMap=(HashMap)audioList.get(j);
							fileName=(String)audioMap.get("filename");
							filePath=(String)audioMap.get("filepath");
							String filetype=(String)audioMap.get("type");
							out.println("<tr class='tablelight'><td  class='tablelight'>"+(j+1)+".</td><td  class='tablelight'><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filePath+"' title='"+fileName+"'>");
							if(fileName.length()>20)
								out.println(fileName.substring(0,20)+"...");
							else
								out.println(fileName);
							out.println("</a></td></tr>");
						}
					}
					
					else
					{
						out.println("<tr><td> File Not Found..</td></tr>");
					}
					
					%>
			  </table>
                     </td>
                   </tr>
              </table>
             </td></tr></table>
             </div>
           </TD>

		   <TD width="33%">
		   	<div id="div_vid" style="border:2px solid #EEEEEE;height:300px;width:240px;overflow-y:auto">

		   <table id="tab_vid" cellspacing="0" bordercolor="#EEEEEE" height="90%" cellpadding="0" border="0" valign="top" width="100%">
			<tr>
				<td height="20" class="tablehead">
					&nbsp;<a href="#" style="text-decoration:none" onClick="callRetrive()"><font color="black">Video Content</font></a>

				</td>
			</tr>

			<tr><td valign="top">
			  <table  id="tab_vid_first" cellspacing="0" cellpadding="0" border="0" valign="top" width="100%">
				<tr><td class="tablebold">
				<table class="tablelight">
				<%
					ArrayList videoList=new ArrayList();
					HashMap videoMap=new HashMap();
					//videoList=contentview_query.getLessonContent(subjectId, lessonid,"Video");
					//videoList=content_query.LoadDeployedContentLessonList(lessonid,subjectId,"A","flv','mp4");
					videoList=content_query.LoadDeployedContentLessonList(lessonid,lessonScheduleid,"A","flv','mpeg','mp4','wmv','avi','3gp");
					//videoList=content_query.LoadDeployedContentLessonList("66","86","A","flv','mp4");
					if(videoList!=null &&  videoList.size()>0)
					{
						for(int j=0;j<videoList.size();j++)
						{
							videoMap=(HashMap)videoList.get(j);
							fileName=(String)videoMap.get("filename");
							filePath=(String)videoMap.get("filepath");
							String filetype=(String)videoMap.get("type");
							//String contentnote=(String)videoMap.get("contentnotes");
							String lessonName=lessonNamehid;
							String contentid=(String)videoMap.get("cmscontentid");
							out.println("<tr class='tablelight'><td  class='tablelight'>"+(j+1)+".</td><td  class='tablelight'><a href='"+request.getContextPath()+"/jsp/ContentManagement/View/presentationview.jsp?filePath="+filePath+"&commonsubjectid="+dbsubjectid+"&userid="+userid+"&logid="+logid+"&fileName="+fileName+"&contentNotes="+java.net.URLEncoder.encode((String)videoMap.get("contentnotes"))+"&lessonName="+lessonName+"&cmscontentid="+contentid+"'>");
																																																
							//out.println("<tr class='tablelight'><td  class='tablelight'>"+(j+1)+".</td><td  class='tablelight'><a href='"+request.getContextPath()+"/jsp/ContentManagement/View/presentationview.jsp?filePath="+filePath+"' title='"+fileName+"'>");
							if(fileName.length()>20)
								out.println(fileName.substring(0,20)+"...");
							else
								out.println(fileName);
							out.println("</a></td></tr>");
						}
					}
					
					else
					{
						out.println("<tr><td> File Not Found..</td></tr>");
					}
					out.println("</td>");
					out.println("</tr>");
					%>
			  </table>
			  </td></tr></table>
			  </div>
		   </TD>
        </TR>
		<%
		}
		else if(submitmode.equals("subject"))
		{
			ArrayList lessList = contentview_query.getAllocatedLessons(subjectId);
		%>
			<tr valign="top" height="30%">
				<TD colspan="3">
				<table>
				<tr>
						<td class="tablebold" colspan="2"><%=bundle.getString("label.Content.lessonlist")%></td>
				   	</tr>
				   	</table>
				<table cellspacing="0" cellpadding="5" border="1" valign="top" width="100%">
					
				   	<tr class=tablehead>
						<td  width='8%'><%=bundle.getString("label.Content.slno")%></td>
						<td  width='50%'><%=bundle.getString("label.Content.lessonname")%></td>
				   	</tr>
				   	<%
				   		if(lessList != null &&  lessList.size()>0)
				   		{
							HashMap listMap = null;
							int inc = 1;
							for(int lessInc=0;lessInc<lessList.size();lessInc++)
							{
								listMap = (HashMap)lessList.get(lessInc);
								String lessid = (String)listMap.get("lessonid");
								String lessname = (String)listMap.get("lessonname");
								out.println("<tr>");
								out.println("<td align='left' class='tablelight'>"+inc+" </td>");
								out.println("<td class='tablelight'>"+lessname+"</td>");
								out.println("</tr>");
								inc++;
							}
							
						}
				   		else
				   		{
				   	
				   			out.println("<tr><td align=center class=mandatory>Data Not Found</td></tr>");
				   	
				   		}
					
				   	%>
				   	
				   	
				   	</table>
				 </td>
			</tr>
		<%
		}
		%>
      </TABLE>



<input type="hidden" name="coursename"   value="<%=coursename%>">
<input type="hidden" name="semestername" value="<%=semestername%>">
<input type="hidden" name="SubjectList" value="<%=subjectId%>">
<input type="hidden" name="subjectname"  value="<%=subjectname%>">
<input type="hidden" name="lessonid"  value="<%=lessonid%>">
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="lessonNamehid"  value="<%=lessonNamehid%>">
<input type="hidden" name="fileName" value="<%=fileName%>">



</form>
</BODY>
</HTML>
