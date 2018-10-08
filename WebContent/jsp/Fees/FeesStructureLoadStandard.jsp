<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructureloadstandard.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function addStandard()
{
	if(document.feesstructureloadstdform.standardname.value == "")
	{
	alert("Standard Name should not be empty");
	document.feesstructureloadstdform.standardname.focus();
	return false;
	}
	if(check_ForParticularElements(document.feesstructureloadstdform.standardboard,"select"))
	{
		document.feesstructureloadstdform.action="StandardSubmit.jsp";
		document.feesstructureloadstdform.submit();
	}
}
function gofeesStructure(obj)
{
	standardscheduleid= obj.getAttribute("standardscheduleid");
	standardname= obj.getAttribute("standardname");
	funstate= obj.getAttribute("funstate");
	document.feesstructureloadstdform.standardscheduleid.value = standardscheduleid;
	document.feesstructureloadstdform.standardname.value = standardname;
	
	
	if(funstate == "feesstructure")
	{
		document.feesstructureloadstdform.action="./StandardFeesStructure.jsp";
		document.feesstructureloadstdform.submit();
	}
	
	else if(funstate=="termstructure")
	{
		totalamount= parseInt(obj.getAttribute("totalamount"));
		if(isNaN(totalamount))
		{
		alert("Allot Fees Structure first");
		return false;
		}
		if(totalamount <= 0)
		{
		alert("Allot Fees Structure first");
		return false;
		}
		
		document.feesstructureloadstdform.action="./StandardTermStructure.jsp";
		document.feesstructureloadstdform.submit();
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

    <h2><%=bundle.getString("label.feesstructureloadstandard.rootpath")%></h2>
<form name="feesstructureloadstdform" action="" method="post">
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>

<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.feesstructureloadstandard.FeesStructure-Selection")%></th>
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
     <%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();  
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();

     String instituteid = null;
     ArrayList standardList = null;
     String yearofsessionname = null;
     String yearofsessionid = null;
     String boardid = null;
     String boardname = null;
     String formattedCurrency = null;
 
     Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
     String totalamount =null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionid = request.getParameter("yearofsessionid");
    	  yearofsessionname = request.getParameter("yearofsessionname");
    	  
    	  boardid = request.getParameter("boardid");
    	  boardname = request.getParameter("boardname");
    	  standardList = feesheadQuery.loadStandard(yearofsessionid,boardid);
  
    }catch(Exception e){}
    
    %>
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td class=tablebold><%=bundle.getString("label.feesstructureloadstandard.AcademicSession")%> :</td><td class=tablelight> <%= yearofsessionname %></td>
        <td class=tablebold><%=bundle.getString("label.feesstructureloadstandard.Board-Medium")%>  :</td><td class=tablelight><%=boardname %></td>
    </tr>	
     
    </table></td></tr>
    </tbody>
</table>
<br/><br/>
 <br><br>
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company"><%=bundle.getString("label.feesstructureloadstandard.SL.No")%></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.feesstructureloadstandard.Standard")%> </th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.feesstructureloadstandard.FeesStructure")%> </th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feesstructureloadstandard.TermStructure")%></th>
        	<th scope="col" class="rounded-q4"><%=bundle.getString("label.feesstructureloadstandard.AllotedAmount")%></th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   if(standardList!=null && standardList.size()>0)
	{ int inc = 1;
	   ////subjectid, subjectname, subjecttypeid, subjectypename
	 	for (int i1 = 0; i1 < standardList.size(); i1++) {
	
		HashMap standardListMap=(HashMap)standardList.get(i1);
		String standardscheduleid     = (String)standardListMap.get("standardscheduleid");
		String standardname      = (String)standardListMap.get("standardname");
		String groupname      = (String)standardListMap.get("groupname");
		totalamount      = (String)standardListMap.get("totalamount");
		String stdgroup = "";
		if(groupname == null)
			groupname = "";
		
		stdgroup = standardname+" "+groupname;
		
    	  if(totalamount == null)
    	  {
    		  totalamount = "0";
    	  }
    	
    	    Long lObj2 = Long.valueOf(totalamount);
    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
    	    formattedCurrency = format.format(lObj2);
	%>
	<tr>
	<td><%= inc++ %></td>
	<td><%=stdgroup %></td>
	<td><a href="#" standardscheduleid="<%=standardscheduleid %>" standardname="<%=stdgroup %>" funstate='feesstructure' onclick="gofeesStructure(this)"><%=bundle.getString("label.feesstructureloadstandard.FeesStructure")%></a></td><td><a href="#" standardscheduleid="<%=standardscheduleid %>" standardname="<%=stdgroup %>" funstate='termstructure' totalamount="<%=totalamount %>" onclick="gofeesStructure(this)"><%=bundle.getString("label.feesstructureloadstandard.TermStructure")%></a></td>
	<td><%=formattedCurrency %></td>
	</tr>
	<% 	
	
	 }
	}
   else{
	   out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
   }
   
  
   %>
   </tbody>
   </table>
   
     <a href="./FeesStructureLoadSession.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesstructureloadstandard.Back")%></strong><span class="bt_blue_r"></span></a>
 		<input type="hidden" name="standardscheduleid"/>
		<input type="hidden" name="standardname"/>   
    	  <input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	  <input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/> 
    	  <input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	  <input type="hidden" name="boardname" value="<%=boardname%>"/>
  </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>