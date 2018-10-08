<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructureallocation.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function checkNnmerickey(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);

if(code!=9 && code!=46 && code!=8 && code!=118 && code!=99 && code!=37 && code!=38 && code!=39 && code!=40)
{
if (code==47||code<46||code>57)
{
	code=0;
	alert("Enter  Number only")

if(window.event != null)
{
	window.event.keyCode 	= 505;
	event.cancelBubble		= true;
	event.returnValue		= false;
}
else
{
	e.preventDefault();
}
	 return false;
}
}
}

function allotFees(obj)
{
	var sta=false;
	var leng=document.feesstructureloadstdform.feesscheduleamount.length;
	var collectionCount=parseInt(document.feesstructureloadstdform.collectionCount.value);
		
	if(collectionCount==0){
		if(leng==undefined)
		{
			if(document.feesstructureloadstdform.feesscheduleamount.value != "" )
			{
				if(numcheck(document.feesstructureloadstdform.feesscheduleamount)==true)
					sta=true;
					else
					{
						sta=false;
						return false;
					}
					
			}			
		}
		else
		{
			for(var i=0;i<leng;i++)
			{
				if(document.feesstructureloadstdform.feesscheduleamount[i].value != "" )
					{
						if(numcheck(document.feesstructureloadstdform.feesscheduleamount[i])==true)
							sta=true;
							else
							{
								sta=false;
								return false;
							}
							
					}
			}
		}
	}
	else{
			var totalEnteredamount=0;
			var totalAllotAmount=parseInt(document.feesstructureloadstdform.totalAllotAmount.value);
			
			if(leng==undefined)
				{
				if(document.feesstructureloadstdform.feesscheduleamount.value != "" )
					totalEnteredamount +=parseInt(document.feesstructureloadstdform.feesscheduleamount.value);
				}
			else{
			for(var i=0;i<leng;i++)
				{
				if(document.feesstructureloadstdform.feesscheduleamount[i].value != "" )
					totalEnteredamount +=parseInt(document.feesstructureloadstdform.feesscheduleamount[i].value);
				}
			}	
				if(totalEnteredamount<totalAllotAmount){
					alert("Fees Collected for this Standard.So you cant deduct the amount");
					return false;
				}
				else	
					sta=true;
	
	}
	
	
	if(sta)
	{
		document.feesstructureloadstdform.action="./StandardFeesStructureAllotment.jsp";
		document.feesstructureloadstdform.submit();
	}
	else
	{
		alert("Fees Amount should not be empty");
	}
}
function numcheck(obj)
{
var flag=false;
var val=obj.value;
			for(var i=0;i<val.length;i++)
				{
					var strval=parseInt(val.charAt(i));
					if(strval>=0 && strval<=9)
					{
						flag=true;
					}
					else
					{
						alert("Numeric Only Allowed");
						obj.value="";
						obj.focus();
						flag=false;
						return false;
					}
				}
				return flag;
}
function gobackfun()
{
	document.feesstructureloadstdform.action="./FeesStructureLoadStandard.jsp";
	document.feesstructureloadstdform.submit();
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

    <h2><%=bundle.getString("label.feesstructureallocation.rootpath")%></h2>
<form name="feesstructureloadstdform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.feesstructureallocation.FeesStructure-Selection")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>

     <%
     ResourceBundle bundle1 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();  
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     
     String instituteid = null;
     ArrayList feesHeadAmountList = null;
     String yearofsessionname = null;
     String yearofsessionid = null;
     String boardid = null;
     String boardname = null;
     String standardname = null;
     String standardscheduleid = null;
     
     int totalamount =0;
     String formattedCurrency = null;
   //  Locale localcurrency = new Locale("en", "IN");
     
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionid = request.getParameter("yearofsessionid");
    	  yearofsessionname = request.getParameter("yearofsessionname");
    	  
    	  boardid = request.getParameter("boardid");
    	  boardname = request.getParameter("boardname");
    	  
    	  standardscheduleid = request.getParameter("standardscheduleid");
    	  standardname = request.getParameter("standardname");
    	  
    	  feesHeadAmountList = feesheadQuery.loadFeesHead(standardscheduleid);
  
    }catch(Exception e){}
    
    %>
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td class=tablebold><%=bundle.getString("label.feesstructureallocation.AcademicSession")%></td><td class=tablebold>:</td><td class=tablelight><%= yearofsessionname %></td>
        <td class=tablebold><%=bundle.getString("label.feesstructureallocation.Board-Medium")%></td><td class=tablebold>:</td><td class=tablelight><%=boardname %></td>
    </tr>
     	<tr>
    	<td class=tablebold><%=bundle.getString("label.feesstructureallocation.StandardName")%></td><td class=tablebold>:</td><td class=tablelight><%= standardname %></td>
    </tr>	
     
    </table></td></tr>
    </tbody>
</table>
<br/><br/>
 <br><br>
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.feesstructureallocation.SL.No")%></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.feesstructureallocation.FeesHeadName")%></th>
        	<th scope="col" class="rounded-q4" ><%=bundle.getString("label.feesstructureallocation.AllotedHeadAmount")%></th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   String opmode = null;
   String collectionCount      = null;
   try
   {
	  
   if(feesHeadAmountList!=null && feesHeadAmountList.size()>0)
	{ int inc = 1;
	 	for (int i1 = 0; i1 < feesHeadAmountList.size(); i1++) {
	
		HashMap feesHeadAmountListMap=(HashMap)feesHeadAmountList.get(i1);
		String feesscheduleid     = (String)feesHeadAmountListMap.get("feesscheduleid");
		String feesheadid      = (String)feesHeadAmountListMap.get("feesheadid");
		//out.println(feesheadid);
		String feesheadname      = (String)feesHeadAmountListMap.get("feesheadname");
		String feesscheduleamount      = (String)feesHeadAmountListMap.get("feesscheduleamount");
		
		if(inc == 1)
			collectionCount      = (String)feesHeadAmountListMap.get("collectioncount");
		
		if(feesscheduleamount == null){
			feesscheduleamount= "";
			opmode="insert";
		}
		else
		{
			opmode="update";
			  totalamount +=Integer.parseInt(feesscheduleamount);
		}
		
		
		
  	    
  	    
  	  //  totalamounts= Integer.parseInt(termfeesamount);
  	   // out.println("initial ->"+totalamounts);
  	  
  	   
  	 
				
		
	%>
	<tr>
	<td><%= inc++ %></td>
	<td><%=feesheadname %></td>
	<td><input type=text name="feesscheduleamount" class=tablelight value="<%=feesscheduleamount%>" onkeypress="checkNnmerickey(event)"/><input type="hidden" name="feesscheduleid" value="<%=feesscheduleid %>"/><input type="hidden" name="feesheadid" value="<%=feesheadid %>"/><input type=hidden name="opmode" value="<%=opmode %>"/></td>
	</tr>
	<% 	
	
	 }
	 	 Long lObj2 = Long.valueOf(totalamount);
		    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedCurrency = format.format(lObj2);
		   out.println("<tr class=tablebold ><td colspan=2 align=right>Total Amount :</td><td>"+formattedCurrency+"</td></tr>");
	}
   }catch(Exception e){}
  
   %>
   </tbody>
   </table>
   	 <a href="#" class="bt_green" onclick="allotFees()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feesstructureallocation.AllotAmount")%></strong><span class="bt_green_r"></span></a>
   
        <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesstructureallocation.Back")%></strong><span class="bt_blue_r"></span></a>
 		<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" value="<%=standardname%>"/>   
    	<input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/> 
    	<input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	<input type="hidden" name="boardname" value="<%=boardname%>"/>
    	<input type="hidden" name="totalAllotAmount" value="<%=totalamount%>"/>
    	<input type='hidden' name='collectionCount' value='<%=collectionCount %>'/>
    	
  </form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>