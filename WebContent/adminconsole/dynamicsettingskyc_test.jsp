<html>
<head>
<LINK rel=stylesheet href="<%=request.getContextPath() %>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/kycpanel/style.css" />

<script language="javascript">
function submitfun()
{

if(confirm("Do you want to update the dynamic setting...?"))
{
f1.action="dynamicsetting_submitkyc_test.jsp";
f1.submit();
}
else
{
return false;
}
}
</script>
</head>
<body>
<form name=f1 method="post">
<%@ page import="java.io.*,java.util.ResourceBundle,java.util.*"%>

<%
ResourceBundle rbss=null;
rbss=ResourceBundle.getBundle("resources.serversetup");
String storagepath   =(String)rbss.getString("storagepath");
String path   =(String)rbss.getString("path");
String kycjndi   =(String)rbss.getString("kycjndi");
String loggerpath   =(String)rbss.getString("loggerpath");
String smsipaddress   =(String)rbss.getString("label.smsipaddress.smsipaddress");
String port   =(String)rbss.getString("label.smsipaddress.port");
String code   =(String)rbss.getString("code");
String language   =(String)rbss.getString("language");
/*
out.println("storagepath"+storagepath);  
String spls=request.getRealPath("/");
System.out.println("spls"+spls);
String[] spliting=spls.split("kycportal");
String halfpath="kycportal/resources/serversetup.properties";    
String fullpath=spliting[0]+halfpath;
String fullpath=storagelocation+halfpath;
File f=new File(fullpath);
if(!f.exists())
	f.mkdirs();
File f=new File(fullpath);
if(!f.exists())
	f.mkdirs();
Properties pro = new Properties();
FileInputStream rbss = new FileInputStream(fullpath);
pro.load(rbss);
String storagepath   =(String)pro.get("storagepath");
String path   =(String)pro.get("path");
String kycjndi   =(String)pro.get("kycjndi");
*/
%>
<center><h2>KYC</h2></center>


<fieldset  width="80%" align=center>
		<legend class=tablebold>Storage Path</legend>
		<table border=0 cellpadding=5 cellspacing=0 align=left width="80%" bgcolor="fcfcfc" cellspacing=0 cellpadding=8>
			<tr><td class=tablebold>Content Storage Location</td><td><input class=tablelight type=text size='70' name="storagepath" value='<%=storagepath%>'></td></tr>
			<tr><td class=tablebold>path</td><td><input class=tablelight size='70' type=text name="path" value='<%=storagepath%>'></td></tr>
			<tr><td class=tablebold>kycjndi</td><td><input class=tablelight size='70' type=text name="kycjndi" value='<%=kycjndi%>'></td></tr>
            <tr><td class=tablebold>Log Path </td><td><input class=tablelight type=text size='70' name="loggerpath" value='<%=loggerpath%>'></td></tr>
			<tr><td class=tablebold>SMS Ipaddress</td><td><input class=tablelight size='15' type=text name="smsipaddress" value='<%=smsipaddress%>'></td></tr>
			<tr><td class=tablebold>SMS port</td><td><input class=tablelight size='4' type=text name="port" value='<%=port%>'></td></tr>
			<tr><td class=tablebold>Language</td><td><label class=tablelight><%=language%></label></td></tr>
			<tr><td class=tablebold>Code</td><td>
			<select name=code class=tablelight>
			<option value="US">US</option>
			<option value="IN">IN</option>
			</select>
			</td></tr>
		</table>
	</fieldset>

<center class=tablelight><input type=button name=but value="Submit" onclick=submitfun()></center>
</form>
</body>
</html>


