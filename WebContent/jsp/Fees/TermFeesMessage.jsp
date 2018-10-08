<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.termmessage.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>


<script type="text/javascript">


function gobackfun()
{
	document.updatetermfeesform.action="./UpdateTermFees.jsp";
	document.updatetermfeesform.submit();
}
function trashfun()
{
confirm("Do you want to trash this term fees?")
{
	document.updatetermfeesform.opmode.value = "trashtermfees";

	document.updatetermfeesform.action="./StandardTermStructureAllotment.jsp";
	document.updatetermfeesform.submit();
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

    <h2><%=bundle1.getString("label.termmessage.rootpath")%></h2>
<form name="updatetermfeesform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle1.getString("label.termmessage.FeesStructure-Selection")%></th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.Common.DateTime"%>

     <%
 
     com.iGrandee.Fees.FeesSchedule  feesschedule = new com.iGrandee.Fees.FeesSchedule();  

     String instituteid = null;
     boolean termfeesflag=false ;
     String yearofsessionname = null;
     String yearofsessionid = null;
     String boardid = null;
     String boardname = null;
     String standardname = null;
     String standardscheduleid = null;
     String totalamount = null;
     String formattedCurrency = null;
     //Locale localcurrency = new Locale("en", "IN");
     
     ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
     String reqtermfeesid		= null;
     try
     {
    	
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionid = request.getParameter("yearofsessionid");
    	  
    	  yearofsessionname = request.getParameter("yearofsessionname");
    	  
    	  boardid = request.getParameter("boardid");
    	  boardname = request.getParameter("boardname");
    	  
    	  standardscheduleid = request.getParameter("standardscheduleid");
    	  standardname = request.getParameter("standardname");
    	  reqtermfeesid = request.getParameter("reqtermfeesid");
    	  
    	  
    	  termfeesflag = feesschedule.checkTermFeesAllocaiton(reqtermfeesid);
    	  
    	  totalamount = feesschedule.loadFeesAmount(standardscheduleid);
    	  if(totalamount == null)
    	  {
    		  totalamount = "0";
    	  }
    	
    	    Long lObj2 = Long.valueOf(totalamount);
    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
    	    formattedCurrency = format.format(lObj2);
  
    }catch(Exception e){}
    
    %>
    <tr><td><td><table id="rounded-corner1" width="100%">
    	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termmessage.AcdamicSession")%></td><td class=tablelight><%= yearofsessionname %></td>
        <td class=tablebold><%=bundle1.getString("label.termmessage.Board-Medium")%> </td><td class=tablelight><%=boardname %></td>
    </tr>
     	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termmessage.StandardName")%></td><td class=tablelight><%= standardname %></td>
    	<td class=tablebold><%=bundle1.getString("label.termmessage.TotalAmount")%></td><td class=tablelight><%=formattedCurrency %></td>
    	
    </tr>	
     
    </table></td><td></td></tr>
    </tbody>
</table>
<br/><br/>
 <br><br>

   	<%
   		if(termfeesflag)
   		{
   			%>
   				<div class="warning_box"><%=bundle1.getString("label.termmessage.message")%></div>
   		<% }
   	%>
           <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.termmessage.Back")%></strong><span class="bt_blue_r"></span></a>
   	  <%if(!termfeesflag)
 		{ %>
   	  <a href="#" class="bt_blue" onclick="trashfun()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.termmessage.Trash")%></strong><span class="bt_blue_r"></span></a>
   	  <%} %>
   	  
   
        
 		<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" value="<%=standardname%>"/>   
    	<input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/>
    	    	<input type="hidden" name="reqtermfeesid" value="<%=reqtermfeesid%>"/>  
    	<input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	<input type="hidden" name="boardname" value="<%=boardname%>"/>
    		<input type='hidden' name='opmode'/>
    		
    	
  </form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>