<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.religion.alllisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script type="text/javascript">
function editFun(obj)
{
if(confirm("Do you want to Update the Religion...?"))
	{
	document.religionviewform.religionid_hidden.value = obj.getAttribute("religionid");
	document.religionviewform.religionname_hidden.value=obj.getAttribute("religionname");
	document.religionviewform.religiondescription_hidden.value=obj.getAttribute("religiondesc");
	document.religionviewform.action="ReligionUpdate.jsp";
	document.religionviewform.submit();
	}
}
function trashFun(obj)
{

				url = "../../StudentPromotion/getAction.jsp?Action=getReligion&religionid="+obj.getAttribute("religionid");
	
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
												alert("Students registered under this Religion. You cant Trash")
											}
											else
											{
												if(confirm("Do you want to trash the Religion Details..?"))
												{
													document.religionviewform.religionid_hidden.value = obj.getAttribute("religionid");
													//alert("relligionid:::>>>"+document.religionviewform.religionid_hidden.value);
													document.religionviewform.religionname_hidden.value=obj.getAttribute("religionname");
													document.religionviewform.religiondescription_hidden.value=obj.getAttribute("religiondesc");
													document.religionviewform.action= "ReligionTrash.jsp";
													document.religionviewform.submit();
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
function deactiveFun(obj)
{
				url = "../../StudentPromotion/getAction.jsp?Action=getReligion&religionid="+obj.getAttribute("religionid");
	
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
												alert("Students registered under this Religion. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to Deactivate the Religion Details..?"))
												{
													document.religionviewform.religionid_hidden.value = obj.getAttribute("religionid");
													//alert("religionid:::>>>"+document.religionviewform.religionid_hidden.value);
													document.religionviewform.religionname_hidden.value=obj.getAttribute("religionname");
													document.religionviewform.religiondescription_hidden.value=obj.getAttribute("religiondesc");
													document.religionviewform.action= "ReligionDeactivateList.jsp";
													document.religionviewform.submit();
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
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.religion.alllistrootpath") %></h2>

<form name="religionviewform" action="" method="post">
<input type=hidden name=religionid_hidden>
<input type=hidden name=religionname_hidden>
<input type=hidden name=religiondescription_hidden>
<table id="rounded-corner" border=0 summary="Religion List" width="100%" align="center">
     <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.religion.slno") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.religion.religionname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.religion.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.religion.dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.religion.edit") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.religion.deactive") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.religion.trash") %></th>
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Religion.ReligionBean"%>

     <%
     com.iGrandee.MasterEntries.Religion.ReligionQuery  religionQuery = new com.iGrandee.MasterEntries.Religion.ReligionQuery();
     String instituteid = null;
     ArrayList ReligionList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	 ReligionList = religionQuery.loadReligionList(instituteid);
    	
    	//scholarshipcategoryid,categoryname
    	ArrayList archivalDetails = new ArrayList();
    	 if(ReligionList!=null && ReligionList.size()>0)
			{
    		 for (int i = 0, j = 1; i < ReligionList.size(); i++) {
			
				HashMap ReligionListMap=(HashMap)ReligionList.get(i);

				String religionid      = (String)ReligionListMap.get("religionid");
				String religionname      = (String)ReligionListMap.get("religionname");
				String religiondesc      = (String)ReligionListMap.get("religiondescription");
				String dateofcreation      = (String)ReligionListMap.get("dateofcreation");
				
				%>
				
				<tr>
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=religionname %></td>
            <%
				if(religiondesc.equals(""))
				{
					//religiondesc = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=religiondesc+"";
					   count=des_temp.split(" ");
						if((count.length-1)>15)
						{
							out.print("<td class='tablelight' ");
							String des_tempnew="";
							for(int s=0;s<15;s++)
							{
								des_tempnew+=count[s]+" ";
							}%>					   
							<div>
							<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
						[<font color="red">More..</font>]
					</a>  
					<div class="highslide-maincontent">
						<h3></h3>
						<%=(religiondesc+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+religiondesc+"</td>");

						}
						}
				%>                

            <td valign=top><%=dateofcreation %> </td>
            <td valign=top><a href="#" ahrefname="religionhref=<%=i%>" religionid="<%=religionid%>" religionname="<%=religionname %>" religiondesc="<%=religiondesc %>" onclick="editFun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="" border="0" /></a></td>
            <td valign=top><a href="#" ahrefname="religionhref=<%=i%>" religionid="<%=religionid%>" religionname="<%=religionname %>" religiondesc="<%=religiondesc %>" onclick="deactiveFun(this)" class="ask"><%=bundle.getString("hlink.religion.deactive") %></a></td>
            <td valign=top><a href="#" ahrefname="religionhref=<%=i%>" religionid="<%=religionid%>" religionname="<%=religionname %>" religiondesc="<%=religiondesc %>" onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td>
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");	
     			//out.println("<tr><td colspan=7 align=center>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="./ReligionCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.religion.addnewitem") %></strong><span class="bt_green_r"></span></a>
     <a href="./ReligionDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.religion.deactivelist") %></strong><span class="bt_blue_r"></span></a>
     <a href="./ReligionTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.religion.trashlist") %></strong><span class="bt_red_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>