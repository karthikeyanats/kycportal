<%@page import="com.iGrandee.TransportFees.FeesSettings"%>
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	FeesSettingsAction  FeesSettings = new FeesSettingsAction();
	
	String transportfeestypeid = null;
	String sessionid= null;
	String userid = null;
	String op=null;
	String return_file=null;
	int result = 0;
try
{
	//instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	sessionid = request.getParameter("sessionid");
	transportfeestypeid = request.getParameter("feestypename");
	//out.println("sessionid>>>>"+sessionid);
	//out.println("transportfeestypeid>>>>"+transportfeestypeid); 
	String institutetransporttypeid = request.getParameter("institutetransporttypeid");	
	//out.println("institutetransporttypeid>>>>"+institutetransporttypeid); 
	/* FeesSettingsBean.setTransportfeestypeid(transportfeestypeid);
	FeesSettingsBean.setSessionid(sessionid);
	FeesSettingsBean.setCreatedby(userid);
	FeesSettingsBean.setInstitutetransporttypestatus("A"); */ 
	result = FeesSettings.updatetransportfeestype(institutetransporttypeid,transportfeestypeid,sessionid,userid); 
 
	if(result==1000)
		op="Type Name already Exists";
	else if(result>0)
		op="Fees Type Successfully Updated";
	else
		op="Fees Type Updation Failed"; 

	return_file = request.getContextPath()+"/jsp/TransportFees/Transportyearview.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}	
	
	
%>