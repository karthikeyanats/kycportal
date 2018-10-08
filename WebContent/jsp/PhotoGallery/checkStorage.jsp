<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,java.io.File"%>
	
<%


try{
		

	ResourceBundle rbss=null;
	rbss=ResourceBundle.getBundle("resources.serversetup");
	String storagepath   =(String)rbss.getString("storagepath");
	String [] storagepath_temp=storagepath.split("/");
	boolean returnfile=false;
	System.out.println("storagepath_temp"+storagepath_temp);
	if(storagepath_temp != null && storagepath_temp.length>1)
	if(storagepath_temp[1] != null && !storagepath_temp[1].equals(""))
	{

		File f=new File(storagepath_temp[0]);
		{
			if(f.exists())
			{
				returnfile=true;
			 }
			else
			{

				returnfile=false;
				
			}

		}
		
		
	}
	

	
	response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails><result><actiondate>"+returnfile+"</actiondate></result></complaintdetails>");
		
}
	
		

catch(Exception e)
{
	System.out.println("propactionerror"+e);
}
%>



