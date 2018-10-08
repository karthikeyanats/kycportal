
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
String username_bundle="";
username_bundle=bundle.getString("adminconsole.username");
String password_bundle="";
password_bundle=bundle.getString("adminconsole.password");
%>

	
<%
StringBuffer buffer=new StringBuffer();
String username = request.getParameter("username");
String password=request.getParameter("password");

try
{ 
	boolean username_status=false;
	boolean password_status=false;
	if(username_bundle.equals(username))
	{
		username_status=true;
		if(password_bundle.equals(password))
		{
			password_status=true;
		}
	}
	
	

					    buffer.append("<result>");
						buffer.append("<actiondate>"+username_status+"</actiondate>");
						buffer.append("<actiondate>"+password_status+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><checkUnamePsw>"+buffer.toString()+"</checkUnamePsw>");
	
   

}	

catch(Exception e)
{
	//System.out.println("propactionerror"+e);
}
%>



