<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
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
function fessHeadEdit(obj)
{
if(confirm("Do you want to Update the Fees Head...?"))
{
var feesheadid=obj.getAttribute("feesheadid");
var feesheadname=obj.getAttribute("feesheadname");


	document.standardForm.feesheadid.value=feesheadid;
	document.standardForm.feesheadname.value=feesheadname;
document.standardForm.action="fessHeadEdit.jsp";
	document.standardForm.submit();
} 
else
{}
}
function fessHeadTrash(obj)
{

				url = "../StudentPromotion/getAction.jsp?Action=getFeesHead&feesheadid="+obj.getAttribute("feesheadid");
	
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
												alert("Fees Structure alloted using this Fees Head. You cant Trash")
											}
											else
											{
												if(confirm("Do you want To Trash the Fees Head...?"))
												{
												var feesheadid=obj.getAttribute("feesheadid");
												var feesheadname=obj.getAttribute("feesheadname");
												
												document.standardForm.feesheadid_temp.value=feesheadid;
												document.standardForm.feesheadname_temp.value=feesheadname;
												document.standardForm.action="FeesAction.jsp?mode_of_operation=feesheadtrash";
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
function fessHeadDeactive(obj)
{
				url = "../StudentPromotion/getAction.jsp?Action=getFeesHead&feesheadid="+obj.getAttribute("feesheadid");
	
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
												alert("Fees Structure alloted using this Fees Head. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to  Deactivate the  Fees Head...?"))
												{
												var feesheadid=obj.getAttribute("feesheadid");
												var feesheadname=obj.getAttribute("feesheadname");
												
												document.standardForm.feesheadid_temp.value=feesheadid;
												document.standardForm.feesheadname_temp.value=feesheadname;
												document.standardForm.action="FeesAction.jsp?mode_of_operation=feesheaddeactive";
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
document.standardForm.action="feesheadTrashList.jsp"; 
	document.standardForm.submit();       
}
function DeactiveView()
{
document.standardForm.action="feesheadDeactiveList.jsp";
	document.standardForm.submit();       
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

    <h2><%=bundle.getString("label.feesheadview.rootpath")%></h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();     String instituteid = null;
     ArrayList feesheadList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  feesheadList = feesheadQuery.listFeesHead(instituteid,"A");
     
    }catch(Exception e){}
    
    %>
    
    


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.feeshead.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.feeshead.FeesHeadName")%></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.feeshead.Dateofcreation")%></th>
              <th scope="col" class="rounded"  width="15%" ><%=bundle.getString("label.feeshead.Edit")%></th>
              <th scope="col" class="rounded-q4"  width="15%" ><%=bundle.getString("label.feeshead.Trash")%></th>
              <%-- <th scope="col" class="rounded-q4"  width="10%" ><%=bundle.getString("label.feeshead.Deactive")%></th> --%>
            
            
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
    	 
    	 if(feesheadList!=null && feesheadList.size()>0)
			{
		 	for (int i = 0, j = 1; i < feesheadList.size(); i++) {
			
				HashMap feesheadListMap=(HashMap)feesheadList.get(i);
				String feesheadid     = (String)feesheadListMap.get("feesheadid");
				String feesheadname      = (String)feesheadListMap.get("feesheadname");
				String dateofcreation      = (String)feesheadListMap.get("dateofcreation");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=feesheadname %></td>
				<td><%= dateofcreation %></td>
				<td><a href="#" feesheadid="<%=feesheadid%>" feesheadname="<%=feesheadname%>" onclick="fessHeadEdit(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
            <td><a href="#" class="ask" feesheadid="<%=feesheadid%>" feesheadname="<%=feesheadname%>" onclick="fessHeadTrash(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
				            <%-- <td><a href="#" class="ask" feesheadid="<%=feesheadid%>" feesheadname="<%=feesheadname%>" onclick="fessHeadDeactive(this)">Deactivate</a></td> --%>
				
				</tr>
				<%
		 }
			}
		 	else
		 	{
		 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		 		//out.println("<tr><td colspan=6 align=center>Data not found</td></tr>");
		 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>
	<input type="hidden" name="feesheadid" value="">
		<input type="hidden" name="feesheadname" value="">
	
<input type="hidden" name="feesheadid_temp" value="">
		<input type="hidden" name="feesheadname_temp" value="">
	<a href="./FeesHead.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feeshead.Addnewitem")%></strong><span class="bt_green_r"></span></a>
<%-- <a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feeshead.DeactiveList")%> </strong><span class="bt_blue_r"></span></a> --%>
		
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.feeshead.TrashList")%> </strong><span class="bt_red_r"></span></a>

  
        
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

