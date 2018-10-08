<%@page import="com.iGrandee.TransportFees.StageAmountAllocation"%>
<%@page import="com.iGrandee.TransportFees.StageAmountAllocationAction"%>
<%@page import="com.iGrandee.TransportFees.FeesSettings"%>
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	StageAmountAllocationAction  stageamountallocation = new StageAmountAllocationAction();
	StageAmountAllocation     stageamountallocationBean= new StageAmountAllocation();
	
	String transportfeessettingsid = "";
	String[] transportstageid = null;
	String[] transportfeesheadid = null;
	String[] setttingheadid= null;
	String transportcategoryid="";
	String[] transportfeesamount = null;
	String userid = null;
	String op=null;
	String return_file=null;
	int result = 0;
try
{
	
	
	userid = (String)session.getValue("userid"); 
	transportfeesheadid = (String[])request.getParameterValues("transportfeesheadid");
	//System.out.println("transportfeesheadid===>>>"+transportfeesheadid.length);
	
	transportstageid = (String[])request.getParameterValues("transportstageid");
	//System.out.println("transportstageid===>>>"+transportstageid.length);
	
	transportcategoryid = request.getParameter("transportcategoryid");   
	
	transportfeesamount = (String[])request.getParameterValues("checkamount");
	//System.out.println("transportfeesamount===>>>"+transportfeesamount.length);
	
	String[] checkallotamountArray=(String[])request.getParameterValues("checkallotamount");
	
	String[] amountvalset2 = (String[])request.getParameterValues("amountvalset");
	
	if(checkallotamountArray!=null && checkallotamountArray.length!=0)
	{
		System.out.println("checkallotamountArray.length ===>"+checkallotamountArray.length);
		
		
		for(int i=0;i<checkallotamountArray.length;i++) 
		{			
			String totalValues=checkallotamountArray[i];
			System.out.println("totalValues ==>"+totalValues); 
			
			String[] totalvalueCollections=totalValues.split(";");
			
			String firstvalue=totalvalueCollections[0];
			String secondvalue=totalvalueCollections[1];
			String thirdvalue=totalvalueCollections[2];
			
			System.out.println("firstvalue ==>"+firstvalue); 
			System.out.println("secondvalue ==>"+secondvalue);
			System.out.println("thirdvalue ==>"+thirdvalue);
			
			stageamountallocationBean.setTransportcategoryid(transportcategoryid);
			
			System.out.println("transportstageid[i] --->"+transportstageid[i]);
			System.out.println("transportfeesamount[i].value ====>"+transportfeesamount[i]);
			
			stageamountallocationBean.setTransportstageid(thirdvalue);  
			stageamountallocationBean.setTransportfeesheadid(secondvalue);
			stageamountallocationBean.setAllocatedamount(firstvalue);
			stageamountallocationBean.setCreatedby(userid); 
			stageamountallocationBean.setTransportstageamountallocationstatus("A");
			result = stageamountallocation.inserttranspotamount(stageamountallocationBean); 

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