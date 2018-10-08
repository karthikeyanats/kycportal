<%@page import="com.iGrandee.TransportFees.FeesSettings"%>
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	FeesSettingsAction  FeesSettings = new FeesSettingsAction();
	FeesSettings     FeesSettingsBean= new FeesSettings();
	
	String transportfeessettingsid = "";
	String[] transportstageid= null;
	String transportcategoryid="";
	String transportfeesamount = "";
	String userid = null;
	String op=null;
	String return_file=null;
	int result = 0;
try
{
	
	transportstageid = (String[])request.getParameterValues("checkstage");
	userid = (String)session.getValue("userid"); 
	//transportstageid = request.getParameter("transportstageid");
	transportcategoryid = request.getParameter("transportcategoryid"); 
	transportfeesamount = request.getParameter("amount");	
	
	if(transportstageid!=null && transportstageid.length!=0)
	{
		for(int i=0;i<transportstageid.length;i++) 
		{
			System.out.println("transportstageid ===>"+transportstageid[i]);
			/* FeesSettingsBean.setTransportcategoryname(categoryname[i]); 
			FeesSettingsBean.setTransportcategorystatus("A");
			FeesSettingsBean.setInstitutetransporttypeid(institutetransporttypeid);
			result = FeesSettings.inserttransportcategory(FeesSettingsBean); */	
		
			FeesSettingsBean.setTransportfeessettingsid(transportfeessettingsid);
			FeesSettingsBean.setTransportstageid(transportstageid[i]);
			FeesSettingsBean.setTransportcategoryid(transportcategoryid);
			FeesSettingsBean.setTransportfeesamount(transportfeesamount);
			FeesSettingsBean.setCreatedby(userid);
			FeesSettingsBean.setTransportfeessettingstatus("A");	
			
			/* FeesSettingsBean.setTransportfeestypeid(transportfeestypeid);
			FeesSettingsBean.setSessionid(sessionid);
			FeesSettingsBean.setCreatedby(userid);
			FeesSettingsBean.setInstitutetransporttypestatus("A"); */
			result = FeesSettings.inserttransportamount(FeesSettingsBean);
			

		}
	}
	
	
 
	if(result==1000)
		op="Stage allot already Exists";
	else if(result>0)
		op="Stage Successfully alloted";
	else
		op="Stage alloted Failed";

	return_file = request.getContextPath()+"/jsp/TransportFees/Transportyearview.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}	
	
	
%>