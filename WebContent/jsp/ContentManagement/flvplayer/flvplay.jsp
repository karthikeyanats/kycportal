<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <meta name="author" content="gddflvplayer">
<title>gddflvplayer </title>
<script language='javascript'>



</script>
</head>
<body style="margin: 10px;background-color: #2b2b2b;" >
<%@ page language="java" %>
<%@ page import="java.util.ResourceBundle" %>
<%
	//ResourceBundle bundle1 =null;
	//bundle1 = ResourceBundle.getBundle("resources.serversetup");
	String request_url = request.getParameter("txtval");
	String requestr2= request.getParameter("r2");
//System.out.println(requestr2);
request_url=request_url+"&r2="+requestr2;
//System.out.println(request_url+"<<<<<<<<<<");

//request_url = "http://192.168.1.20:8080/VirtualKMS/VIDEO_KM/26-Dec-2008 12-11-19 AM.flv";


	//String fullpath=bundle1.getString("protocol")+bundle1.getString("hostname")+bundle1.getString("port")+"digitallibrary/Open?r1=serverpath&r2="+request_url;


%>

<center>
<!-- START gddflvplayer code -->
<div id="gddflvplayer"></div>
<script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript">
// <![CDATA[
var so = new SWFObject("gddflvplayer.swf", "gddflvplayer", "400", "345", "9", "#000000"); //change the player size as you want (now:500x360)
	so.addParam("scale", "noscale");
	so.addParam("quality", "best");
	so.addParam("allowScriptAccess", "always");
	so.addParam("allowFullScreen", 'true');
	//VIDEO PARAMS
	so.addVariable("vdo", escape("<%=request_url%>")); //video file
	//so.addVariable("desc", escape('Copyright @ i-Grandee Software Technolgies Pvt Ltd')); //  movie title
	so.addVariable("autoplay", 'false'); // autoplay: true or false  | default: false
	so.addVariable("sound", '70'); // sound volume 0-100
	// ADVERTISING/INTRO VIDEO, (controls temporarily disabled) REMOVE NEXT 2 LINES IF NONE
	//so.addVariable("advert", escape('get_video4.flv')); //video file
	//so.addVariable("advertdesc", escape(' i-Grandee Software Technologies  ')); // description text

	// YOUR CUSTOM LOGO, remove the next line if none
	//so.addVariable("mylogo", escape('logo.png')); // PNG, JPG, GIF,SWF, we recommend PNG for transparency
	//TRACKER LINK URL (goes active on play)
	//so.addVariable("tracker", escape('your_tracker_link.php')); // TRACKER LINK | vars sent by POST
	//BUFFER SIZE (preloads x seconds of the movie before play)
	so.addVariable("buffer", 2); // buffer time in seconds; default 2sec if missing
	// START
  so.write("gddflvplayer");
	// ]]>



</script>
<!-- END gddflvplayer code -->

</center>
<form name='frm'>
<input type='hidden' name='test' value=<%=request_url%>>
</form>
</body>
</html>
