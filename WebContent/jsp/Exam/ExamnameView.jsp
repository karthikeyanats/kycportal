<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script type="text/javascript">
function editExamname(obj)
{

	if(confirm("Do you want to Update the Exam Name ...?"))
	{
		document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");

		document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
		document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
		document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
		document.examnameviewform.action="ExamnameUpdate.jsp";
		document.examnameviewform.submit();
	}
}
function trashFun1(obj)
{
if(confirm("Do you want to Trash the Exam Name ...?"))
{
	document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
	document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examnameviewform.action= "ExamnameTrash.jsp";
	document.examnameviewform.submit();
}
else
{}
}

function trashFun(obj)
{

				url = "../StudentPromotion/getAction.jsp?Action=getExamNameSchedule&examnameid="+obj.getAttribute("examnameid");
	
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
												alert("This Exam Name is in Alloted List. You cant Trash")
											}
											else
											{
													if(confirm("Do you want to Trash the Exam Name ...?"))
													{
														document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
														//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
														document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
														document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
														document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
														document.examnameviewform.action= "ExamnameTrash.jsp";
														document.examnameviewform.submit();
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

function deactiveFun1(obj)
{
if(confirm("Do you want to Deactivate the Exam Name ...?"))
{
	document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
	document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examnameviewform.action= "ExamnameDeactivateList.jsp";
	document.examnameviewform.submit();
}
else
{}
}

function deactiveFun(obj)
{

				url = "../StudentPromotion/getAction.jsp?Action=getExamNameSchedule&examnameid="+obj.getAttribute("examnameid");
	
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
												alert("This Exam Name is in Alloted List. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to Deactivate the Exam Name ...?"))
												{
													document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
													//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
													document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
													document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
													document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
													document.examnameviewform.action= "ExamnameDeactivateList.jsp";
													document.examnameviewform.submit();
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

    <h2><%=bundle.getString("label.examnamelist.rootpathlist")%></h2>
<form name="examnameviewform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>


<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.examnamelist.examname")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.examnamelist.examremarks")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.examnamelist.dateofcreation")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examnamelist.Edit")%></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.examnamelist.Action")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.examnamelist.Trash")%></th>
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
     String instituteid = null;
     ArrayList LoadExamnameList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid"); 
    	  LoadExamnameList=examnameEntry.listExamname((String)session.getValue("sessionid"),instituteid);
    	 

    	ArrayList archivalDetails = new ArrayList();
    	 if(LoadExamnameList!=null && LoadExamnameList.size()>0)
			{
    		 for (int i = 0, j = 1; i < LoadExamnameList.size(); i++) {
			
				HashMap ExamnameListMap=(HashMap)LoadExamnameList.get(i);
				
				String examnameid       	= (String)ExamnameListMap.get("examnameid");
				String examname 		  	= (String)ExamnameListMap.get("examname");
				String examnameremarks  	= (String)ExamnameListMap.get("remarks");
				String dateofcreation      	= (String)ExamnameListMap.get("dateofcreation");
				String createdby      	= (String)ExamnameListMap.get("createdby");
		
				%>
				
				<tr>
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=examname %></td>
            <%
				if(examnameremarks.equals("-"))
				{
					//examnameremarks = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=examnameremarks+"";
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
						<%=(examnameremarks+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+examnameremarks+"</td>");

						}
						}
				%>
            <td valign=top><%=dateofcreation %></td>
            <td valign=top><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="editExamname(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="" border="0" /></a></td>
            <td valign=top><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="deactiveFun(this)" class="ask"><%=bundle.getString("hlink.examnamelist.deactivate")%></a></td>
            <td valign=top><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td>
            
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examnamelist.addnew")%></strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>