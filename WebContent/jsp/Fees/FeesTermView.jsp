<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feestermview.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardList.jsp";
	document.standardForm.submit();
}
function goSubject(obj)
{

	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.reqstandardname.value = obj.getAttribute("standardname");
	document.standardForm.reqgroupstatus.value = obj.getAttribute("groupstatus");
	document.standardForm.action="../Subject/SubjectCreation.jsp";
	document.standardForm.submit();
	

}

function fessTermEdit(obj)
{
if(confirm("Do you want to Update the Fees Term...?"))
{
var termid=obj.getAttribute("termid");
var termname=obj.getAttribute("termname");


	document.standardForm.termid.value=termid;
	document.standardForm.termname.value=termname;
document.standardForm.action="fessTermEdit.jsp";
	document.standardForm.submit();
} 
else
{}
}
function fessTermTrash(obj)
{
				url = "../StudentPromotion/getAction.jsp?Action=getFeesTerm&termid="+obj.getAttribute("termid");
	
				var req=null;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  //alert(req)
				
						req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkNumber");
											var cNode_1=rootObj[0].childNodes.length;
											var username=null;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

											if(finalValue=="1")
											{
												alert("Fees Structure alloted using this Fees Term. You cant Trash")
											}
											else
											{
												if(confirm("Do you want to Trash the Fees Term...?"))
												{
												var feesheadid=obj.getAttribute("termid");
												var feesheadname=obj.getAttribute("termname");
												
												document.standardForm.feesheadid_temp.value=feesheadid;
												document.standardForm.feesheadname_temp.value=feesheadname;
												document.standardForm.action="FeestermAction.jsp?mode_of_operation=updatestatus";
												document.standardForm.submit();											
												} 
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);
}  
function TrashListview()
{
document.standardForm.action="feestermTrashList.jsp";
	document.standardForm.submit();       
}
function DeactiveView()
{
document.standardForm.action="feestermDeactiveList.jsp";
	document.standardForm.submit();       
} 
function fessTermDeactive(obj)
{

				url = "../StudentPromotion/getAction.jsp?Action=getFeesTerm&termid="+obj.getAttribute("termid");
	
				var req=null;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  //alert(req)
				
						req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkNumber");
											var cNode_1=rootObj[0].childNodes.length;
											var username=null;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

											if(finalValue=="1")
											{
												alert("Fees Structure alloted using this Fees Term. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to Deactivate the Fees Term...?"))
												{
												var feesheadid=obj.getAttribute("termid");
												var feesheadname=obj.getAttribute("termname");
												
												document.standardForm.feesheadid_temp.value=feesheadid;
												document.standardForm.feesheadname_temp.value=feesheadname;
												document.standardForm.action="FeestermAction.jsp?mode_of_operation=deactiveststus";
												document.standardForm.submit();											
												} 
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);

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

    <h2><%=bundle.getString("label.feestermview.rootpath")%> </h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%

     com.iGrandee.Fees.FeesTermQuery  feestermQuery = new com.iGrandee.Fees.FeesTermQuery();     String instituteid = null;
     ArrayList feestermList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  feestermList = feestermQuery.listFeesTerm(instituteid,"A");
     
    }catch(Exception e){}
    
    %>
    
    


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.feestermview.SL.No")%></th>
            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.feestermview.FeesTermName")%></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.feestermview.Dateofcreation")%></th>
              <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.feestermview.Edit")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.feestermview.Trash")%></th>
             <%-- <th scope="col" class="rounded-q4" colspan="1" width="10%"><%=bundle.getString("label.feestermview.Deactive")%></th> --%> 
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     try
     {
    	 
    	 if(feestermList!=null && feestermList.size()>0)
			{
		 	for (int i = 0, j = 1; i < feestermList.size(); i++) {
			
				HashMap feestermListMap=(HashMap)feestermList.get(i);
				String termid     = (String)feestermListMap.get("termid");
				String termname      = (String)feestermListMap.get("termname");
				String termcreationdate      = (String)feestermListMap.get("termcreationdate");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=termname %></td>
				<td><%= termcreationdate %></td>
				<td><a href="#" onclick="fessTermEdit(this)" termid="<%=termid %>" termname="<%=termname %>"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
            <td><a href="#" class="ask" onclick="fessTermTrash(this)"  termid="<%=termid %>" termname="<%=termname %>"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
<%-- 			 <td><a href="#" class="ask" onclick="fessTermDeactive(this)"  termid="<%=termid %>" termname="<%=termname %>"><%=bundle.getString("label.feestermview.Deactive")%></a></td> 
 --%>				</tr>
				<%
		 }
			}
		 	else
		 	{
		 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		 	//out.println("<tr><td colspan=5 align=center>Data not found</td></tr>");
		 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table> 
<input type="hidden" name="feesheadid_temp" value="">
<input type="hidden" name="feesheadname_temp" value="">
<input type="hidden" name="termid" value="">
<input type="hidden" name="termname" value="">

	<a href="./FeesTerm.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feestermview.Addnewitem")%></strong><span class="bt_green_r"></span></a>
<%-- 		<a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feestermview.DeactiveList")%> </strong><span class="bt_blue_r"></span></a> 
 --%>		
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.feestermview.TrashList")%> </strong><span class="bt_red_r"></span></a>
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

