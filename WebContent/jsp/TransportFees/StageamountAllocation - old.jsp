<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  


var validflag  =false;

function checkfun(obj)
{
	alert("Calling");
	chkid = obj.getAttribute("chkid");
	transportstageid = obj.getAttribute("transportstageid");
	transportcategoryid = obj.getAttribute("transportcategoryid");
	alert("transportcategoryid===>>>"+transportcategoryid);
	alert("transportstageid===>>>"+transportstageid);
	alert("chkid===>>"+chkid);
	if(obj.checked)
	{	
		if(document.stageamountform.amountallot[chkid].value == "")
		{
		alert("Amount should not be empty");
		document.stageamountform.amountallot[chkid].focus();
		document.stageamountform.checkamount[chkid].checked=false;
		return false;
		} 
	}
}


/* function submitFun(){	
	
	if(check_ForParticularElements(document.feestypeform.chkname,"radio"))
	{
		var Flag=false;
		var chklength = document.feestypeform.chkname.length;
		//alert("chklength ===>>>"+chklength);

		if(chklength==undefined)
		{ 
			
			if(document.feestypeform.chkname.checked==true) 
			{

				Flag=true;
			}	
			
		}
		else 
		{
			for(var i=0;i<chklength;i++){
				
				if(document.feestypeform.chkname[i].checked==true)
				{

					Flag=true;
				}	
			}
			
		}  		
		
		if(Flag)
		{
			if("Do you want to submit the Category?")
			{	
			document.feestypeform.action="./CategorySubmit.jsp";
			document.feestypeform.submit();
			}
			
		} 
		else 
		{
			alert("Select any one checkbox");
			return false;
			
		}
		
	} 
} */


function addFeesAmount(obj)
{	
	var amount= [];
	transportstageid = obj.getAttribute("transportstageid");
	transportcategoryid = obj.getAttribute("transportcategoryid");
	alert("transportcategoryid===>>>"+transportcategoryid);
	alert("transportstageid===>>>"+transportstageid);
	alert("document.stageamountform.checkamount.length===>>"+document.stageamountform.checkamount.length); 
	if(check_ForParticularElements(document.stageamountform.checkamount,"radio"))
	{
	
	if(document.stageamountform.checkamount.length !="undefined")
	{ 
	for(var k=0;k<document.stageamountform.checkamount.length;k++)
		{
					if(document.stageamountform.checkamount[k].checked)
					{
						amount = document.stageamountform.amountallot[k].value;
						alert("amount===>>>"+amount);						
					}					
		} 
		
	} 
	
	else
	{     
	//alert("select any one of the Stage Amount");
	amount = document.stageamountform.amountallot.value;
	alert("amount===>>>"+amount);
	}  
	
	document.stageamountform.action="stageallotamountsubmit.jsp?transportcategoryid="+transportcategoryid+"&transportstageid="+transportstageid+"&amount="+amount;
	document.stageamountform.submit();
	}
}

</script>

</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../include/header.jsp" %>
 

    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Transport Fees / </h2>
    
<form name="stageamountform" action="" method="post">

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
<%

String transportstageid = null;
String transportfeestypeid = null;
transportfeestypeid = request.getParameter("transportfeestypeid");
out.println("transportcategoryid===>>>"+transportfeestypeid);


%>


    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="35%">Stages</th>
            <th scope="col" class="rounded" width="35%">Amount</th>
            <th scope="col" class="rounded-q4" width="35%">Select</th>
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td> 
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> --> 
    
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

     		<!-- Sindhu -->
     		
     		 <%
			     FeesSettingsAction  stageforamounallotment = new FeesSettingsAction();
			     String instituteid = null;
			     ArrayList Loadstageforamounallotment = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  Loadstageforamounallotment = stageforamounallotment.getstageforamounallotment();
    	 

					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(Loadstageforamounallotment!=null && Loadstageforamounallotment.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadstageforamounallotment.size(); i++) {
								
									HashMap SessionListMap=(HashMap)Loadstageforamounallotment.get(i);
									
									transportstageid        = (String)SessionListMap.get("transportstageid");
									String transportstagename   	= (String)SessionListMap.get("transportstagename");
									
		 
				%>  
				
					<tr>
						<td><%=j++ %>.</td>
						<td><%=transportstagename %></td>
						<td><input type='text' name=amountallot value='' /></td>
						<td><input type="checkbox" name="checkamount" value='' chkid="<%=i%>" transportcategoryid=<%=transportfeestypeid %> transportstageid="<%=transportstageid %>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
						
					</tr>				 
				
				<%					  
								
						    		 }					    		 
					    		 		
									}
			     }catch(Exception e){}
			          
			     %>
     		
     		
    	
    </tbody>
</table>


	

	<a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

		<a href="#" transportcategoryid=<%=transportfeestypeid %> transportstageid="<%=transportstageid %>" onClick="addFeesAmount(this)" class="bt_green"><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>

	<%-- <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

<input type='text' name="transportstageid" value="" />
    
    </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>