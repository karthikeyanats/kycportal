
<HTML>
<Head>
<script language='javascript'>
	function goBack()
	{
		var stat=document.frm.status.value;
		if(stat==1)
			alert("Successfully Updated");
		else
			alert("Failuire Updatation");

		document.frm.action="dynamicsettingskyc_test.jsp";
		document.frm.submit();
	}
</script>
</Head>

<Body onload='goBack()'>
<form name='frm' method='post' action=''>
<%@ page language="java" import="java.util.ResourceBundle,java.util.Properties,java.io.File,java.io.FileInputStream,java.io.FileNotFoundException,java.io.IOException,java.io.FileOutputStream" %>
<%
int status=0;
	String storagepath      = null;
	String path = null;
	String kycjndi  = null;
	



	storagepath   = request.getParameter("storagepath");
	path 		  = request.getParameter("path");
	kycjndi  	  = request.getParameter("kycjndi");
	String loggerpath   = request.getParameter("loggerpath");
	String smsipaddress 		  = request.getParameter("smsipaddress");
	String language  	  = request.getParameter("language");
	String smsport 		  = request.getParameter("port");
	String code  	  = request.getParameter("code");

if(storagepath!=null && path!=null && kycjndi!=null )
{


	ResourceBundle rbssobj=null;
	rbssobj=ResourceBundle.getBundle("resources.serversetup");
	String storagelocation   =(String)rbssobj.getString("storagepath");
	
	
	String spls=request.getRealPath("/");
	
	String[] spliting=spls.split("kycportal");
	
	String halfpathsave="kycportal/resources/serversetup_test.properties";
	
	String halfpathtemp="kycportal/resources/";
	
	
	//String fullpathsave=spliting[0]+halfpathsave;
	String fullpathsave=storagelocation+halfpathsave;
	File f=new File(storagelocation+halfpathtemp);
	if(f.exists())
	{
		
	}
	else
	{
		f.mkdirs();
	}

	try
	{
		String mainn=("storagepath="+storagepath+"\n\n"+"path="+path+"\n\n"+"kycjndi="+kycjndi+"\n\n"+"#for jboss enable following"+"\n\n"+"#kycjndi=java:jdbc/kycportal"+"\n\n"+"#for tomcat enable following");
		mainn+="\n\nloggerpath="+loggerpath+"\n\n"+"label.smsipaddress.smsipaddress="+smsipaddress+"\n\n"+"label.smsipaddress.port="+smsport+"\n\n"+"language=en\n\n"+"code="+code;
		byte b[]=mainn.getBytes();
		FileOutputStream foutnew=new FileOutputStream(fullpathsave);
		foutnew.write(b);
		status=1;
	}
	catch(Exception Ex)
	{
		status=0;
		out.println("[IGST-EXCEPTION] From["+this.getClass().getName()+"].services()Action File Write Ex :"+Ex);
	}




	
	
}

%>
<input type='hidden' name='status' value='<%=status%>'>
</form>
</BODY>
</HTML>
