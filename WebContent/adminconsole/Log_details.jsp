<html>
<head>
	<link rel="stylesheet" href="/kalam/css/themes.css">
	<link rel="stylesheet" href="/kalam/css/website.css">
	<link rel="stylesheet" href="/kalam/css/kalamIndexCss.css">

<script language="javascript">
function submitfun()
{
if(confirm("Do you want to update the settings...?"))
{
f1.action="dynamicsetting_submitkyc_test.jsp";
f1.submit();
}
else
{
return false;
}
}
function download(obj)
	{
	var attachment=obj.getAttribute("filepath");
	
	document.getElementById("filedownload").src="<%=request.getContextPath()%>/OpenDocument?r1=loggerpath&r2="+attachment+"&r3=download";
	}
</script>
</head>
<body>
<form name=f1 method="post">
<%@ page import="java.io.*,java.util.ResourceBundle,java.util.*"%>
<%
ResourceBundle rb = ResourceBundle.getBundle("resources.serversetup");
String storagepath=rb.getString("loggerpath");
String path=storagepath;
File f =new File(path);
%>
<center><h2>KYC PORTAL Log Detail</h2></center>
		<table border=1 cellpadding=5 cellspacing=0 align=center width="80%" bgcolor="fcfcfc" cellspacing=0 cellpadding=8>
		<tr class=titlehead bgcolor=lightgrey><td>Sl.No</td><td>File Name</td><td>Download</td></tr>
		<%
		int filecounter		= 0;
			if(f != null && f.exists()){
				File paths[]	= f.listFiles();
				for(int y=0;y<paths.length;y++){
					     
					if(paths[y] != null && paths[y].isFile()){
						filecounter++;
						out.print("<tr class=tablelight><td>"+filecounter+"</td><td>"+paths[y].getName()+"</td><td><a href='#' filepath='/logs/"+paths[y].getName()+"' onclick=download(this)>Download</a></td></tr>");
					}
					
				}
			}
		%>
		</table>
<iframe src="" width=0 height=0 id="filedownload"></iframe>
</form>
</body>
</html>


