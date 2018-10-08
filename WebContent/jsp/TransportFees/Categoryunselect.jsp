<%@page import="com.iGrandee.TransportFees.FeesSettings"%>
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	FeesSettingsAction  FeesSettings = new FeesSettingsAction();
	FeesSettings     FeesSettingsBean= new FeesSettings();
	
	String transportcategoryid = null;	
	String op=null;String operation=null;
	String return_file=null;
	int result = 0; 
try
{
	//instituteid = (String)session.getValue("instituteid");
if(request.getParameter("operation")!=null){
		operation=request.getParameter("operation");
		if(operation.equals("monthwise")){
		transportcategoryid = request.getParameter("equalsmonth"); 
		String institutetransporttypeid = request.getParameter("ittid");
		System.out.println("categoryname>>>>"+transportcategoryid);
		System.out.println("institutetransporttypeid>>>>"+institutetransporttypeid);
		String transportcategoryname = 	FeesSettings.getmonthname(transportcategoryid);
		out.print(transportcategoryname);	
		
				FeesSettingsBean.setTransportcategoryname(transportcategoryname);
				FeesSettingsBean.setTransportcategorystatus("D");
				FeesSettingsBean.setInstitutetransporttypeid(institutetransporttypeid); 
				result = FeesSettings.updatetransportcategory(FeesSettingsBean,transportcategoryid);
	
		
		if(result==1000)
			op="Category already Exists";
		else if(result>0)
			op="Category Deallocated Successfully"; 
		else
			op="Category Deallocation Failed";
		
		return_file = request.getContextPath()+"/jsp/TransportFees/categorytype.jsp";
		}
		if(operation.equals("termwise")){
			transportcategoryid = request.getParameter("equalsmonth"); 
			String institutetransporttypeid = request.getParameter("ittid");
			System.out.println("categoryname>>>>"+transportcategoryid);
			System.out.println("institutetransporttypeid>>>>"+institutetransporttypeid);
			String transportcategoryname = 	FeesSettings.getmonthname(transportcategoryid);
			out.print(transportcategoryname);	
			
					FeesSettingsBean.setTransportcategoryname(transportcategoryname);
					FeesSettingsBean.setTransportcategorystatus("D");
					FeesSettingsBean.setInstitutetransporttypeid(institutetransporttypeid); 
				result = FeesSettings.updatetransportcategory(FeesSettingsBean,transportcategoryid);

			if(result==1000)
				op="Category already Exists";
			else if(result>0)
				op="Category Deallocated Successfully";
			else
				op="Category Deallocation Failed";
			
			//return_file = request.getContextPath()+"/jsp/TransportFees/TransportTermview.jsp";
			return_file = request.getContextPath()+"/jsp/TransportFees/TportTermview.jsp";
			}	
		
		if(operation.equals("yearwise")){
			transportcategoryid = request.getParameter("equalsmonth"); 
			String institutetransporttypeid = request.getParameter("ittid");
			System.out.println("categoryname>>>>"+transportcategoryid);
			System.out.println("institutetransporttypeid>>>>"+institutetransporttypeid);
			String transportcategoryname = 	FeesSettings.getmonthname(transportcategoryid);
			out.print(transportcategoryname);	
			
					FeesSettingsBean.setTransportcategoryname(transportcategoryname);
					FeesSettingsBean.setTransportcategorystatus("D");
					FeesSettingsBean.setInstitutetransporttypeid(institutetransporttypeid); 
					result = FeesSettings.updatetransportcategory(FeesSettingsBean,transportcategoryid);
		
			
		 
			if(result==1000)
				op="Category already Exists";
			else if(result>0)
				op="Category Deallocated Successfully"; 
			else
				op="Category Deallocation Failed";
			
			return_file = request.getContextPath()+"/jsp/TransportFees/Yearview.jsp";
			}	
		
	//response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}

}catch(Exception e){
	
}	
	
%>
<html> 
<head>
<script type="text/javascript">
function go()
{
	document.cat_form.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.cat_form.submit();
}

</script>	
</head>
<body onload="go()">
<form name="cat_form" method="post">
	<input type="hidden" name="message" value="<%=op%>"/> 
	<input type="hidden" name="result" value="<%=result%>"/>
	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
	<input type="hidden" name="sessionid" value="<%=request.getParameter("sessionid")%>"/>
	<input type="hidden" name="ittid" value="<%=request.getParameter("ittid")%>"/>
	<%

if(request.getParameter("transportfeestypeid")!=null){
	out.println("<input type='hidden' name='transportfeestypeid' value='"+request.getParameter("transportfeestypeid")+"'/>");
	
}
	
	if(request.getParameter("transportfeestypename")!=null){
		
		out.println("<input type='hidden' name='transportfeestypename' value='"+request.getParameter("transportfeestypename")+"'/>");
	}
%>	
</form>
</body>

</html>