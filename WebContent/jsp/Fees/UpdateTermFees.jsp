<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.termamountupdate.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">

var specialKeys = new Array();
specialKeys.push(8); //Backspace
function IsNumeric(e,pos) {
	//alert(pos);
    var keyCode = e.which ? e.which : e.keyCode
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
   // console.log(document.getElementById("error"+pos).style.display);
    document.getElementById("error"+pos).style.display = ret ? "none" : "inline";
    //console.log(termfeesamount)
    return ret;
}
function checkNnmerickey(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
alert(code);
if(code!=9 && code!=46 && code!=8)
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

var regex = /^[\d]*$/;
function updatetermFees()
{

var totalamount=0;
var collectionCount=parseInt(document.updatetermfeesform.collectionCount.value);
var totalamount1=parseInt(document.updatetermfeesform.totalamount.value);
//if(document.updatetermfeesform.termfeesamount.length)


	if(document.updatetermfeesform.termfeesamount.length != undefined)
	{ 
var leng=document.updatetermfeesform.termfeesamount.length;
//alert("leng===>>>"+leng);
console.log("leng "+leng);
var flag=new Boolean();

 flag=true;
	for(var i=0;i<leng;i++)
	{
		var val=document.updatetermfeesform.termfeesamount[i].value;
		console.log("lengvalue "+val);

		if(val==""){
			alert("Term Amount must not be empty")
			flag=false;
			document.updatetermfeesform.termfeesamount[i].focus();
			return false;
		}
		else{
		//	alert(parseFloat(document.updatetermfeesform.termfeesamount[i].value,10)+"< "+parseFloat(document.updatetermfeesform.extamount[i].value,10))
			//if(parseInt(document.updatetermfeesform.termcountvalue[i].value) > 0)
				
				if(!regex.test(document.updatetermfeesform.termfeesamount[i].value)){
					alert("Only Numeric Values");
				}
				
			if(document.updatetermfeesform.feescollectionid[i].value !="-" && (parseFloat(document.updatetermfeesform.termfeesamount[i].value,10) < parseFloat(document.updatetermfeesform.extamount[i].value,10)))
			{
				alert("the Term amount should not be less than the allocated amount");
				document.updatetermfeesform.termfeesamount[i].focus();
				flag=false;
				return false;				
			}
		
	}
	}
	
	if(flag){
		
		
		
		var tot=0;
		console.log(document.updatetermfeesform.termfeesamount.length);
		if(document.updatetermfeesform.termfeesamount.length !=undefined){
			//if(document.updatetermfeesform.termfeesamount){
			
			
		for(var k=0;k<document.updatetermfeesform.termfeesamount.length;k++){
		tot+=parseFloat(document.updatetermfeesform.termfeesamount[k].value,10);

		}
		if(document.updatetermfeesform.topay.value>=tot){
			
			document.updatetermfeesform.opmode.value="update";
			document.updatetermfeesform.action="./StandardTermStructureAllotment.jsp";
			document.updatetermfeesform.submit();
		}
		else{
				alert("Term Amount Exceeds the Total Amount");
				return false;
		}
		}
		
	
	}else{console.log("i am here");}
	}
else{
	console.log("big else>>>in ");
	//if(document.updatetermfeesform.termfeesamount){
		if(document.updatetermfeesform.termfeesamount.value==""){
			alert("Term Amount must not be empty")
			flag=false;
			document.updatetermfeesform.termfeesamount.focus();
			return false;
			
		}
		else{
				
			if(document.updatetermfeesform.feescollectionid.value !="-" && (parseFloat(document.updatetermfeesform.termfeesamount.value,10) < parseFloat(document.updatetermfeesform.extamount.value,10)))
			{
				alert("the Term amount should not be less than the allocated amount");
				document.updatetermfeesform.termfeesamount.focus();
				flag=false;
				return false;				
			}
			
				var tot=0;
			//	if(document.updatetermfeesform.termfeesamount.length){
					if(document.updatetermfeesform.termfeesamount){
				for(var k=0;k<document.updatetermfeesform.termfeesamount.length;k++){
				tot+=parseFloat(document.updatetermfeesform.termfeesamount[k].value,10);
		
				}
				if(document.updatetermfeesform.topay.value>=tot){
					document.updatetermfeesform.opmode.value="update";
					document.updatetermfeesform.action="./StandardTermStructureAllotment.jsp";
					document.updatetermfeesform.submit();
				}
				else{
				
					alert("Term Amount must not be empty")
					
					document.updatetermfeesform.termfeesamount.focus();
					return false;
				}
				}
				else{
				if(document.updatetermfeesform.topay.value>=document.updatetermfeesform.termfeesamount.value){
					document.updatetermfeesform.opmode.value="update";
					//document.updatetermfeesform.action="./StandardTermStructureAllotment.jsp";
					//document.updatetermfeesform.submit();
					
				}
				else{
						
					alert("Term Amount must not be empty")
					document.updatetermfeesform.termfeesamount.focus();
					return false;
				}
				}
		}
}
	
}

function gobackfun()
{
	document.updatetermfeesform.action="./FeesStructureLoadStandard.jsp";
	document.updatetermfeesform.submit();
}
function trashfun(obj)
{
if(confirm("Do you want to Trash the Fees Term...?"))
{
		document.updatetermfeesform.reqtermfeesid.value = obj.getAttribute("termfeesid");
		document.updatetermfeesform.opmode.value = "trashtermfees";
		document.updatetermfeesform.action="./TermFeesMessage.jsp";
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

<%!

Long lObj2 ;
%>
    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle1.getString("label.termamountupdate.rootpath")%></h2>
<form name="updatetermfeesform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle1.getString("label.termamountupdate.FeesStructure-Selection")%></th>        	<th scope="col" class="rounded-q4" width="10" ></th>
            
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
     ArrayList feestermamountList = null;
     String yearofsessionname = null;
     String yearofsessionid = null;
     String boardid = null;
     String boardname = null;
     String standardname = null;
     String standardscheduleid = null;
     String totalamount = null;
     String formattedCurrency = null;
    
    // Locale localcurrency = new Locale("en", "IN");
    ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
     String today		= null;
     try
     {
    	
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionid = request.getParameter("yearofsessionid");
    	  
    	  yearofsessionname = request.getParameter("yearofsessionname");
    	  
    	  boardid = request.getParameter("boardid");
    	  boardname = request.getParameter("boardname");
    	  
    	  standardscheduleid = request.getParameter("standardscheduleid");
    	  standardname = request.getParameter("standardname");
    	  today				= DateTime.showTime("calendar");
    	  //feestermamountList = feesschedule.loadFeesAllotedTermDetails(standardscheduleid);
    	  feestermamountList = feesschedule.loadFeesAllotedTermDetailsforUpdate(standardscheduleid);
    	  
    	  
    	  totalamount = feesschedule.loadFeesAmount(standardscheduleid);
    	  if(totalamount == null)
    	  {
    		  totalamount = "0";
    	  }
    	
    	     lObj2 = Long.valueOf(totalamount);
    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
    	    formattedCurrency = format.format(lObj2);
  			
    }catch(Exception e){}
    
    %>
    <tr><td><td><table id="rounded-corner1" width="100%">
    	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termamountupdate.AcdamicSession")%></td><td class=tablelight><%= yearofsessionname %></td>
        <td class=tablebold><%=bundle1.getString("label.termamountupdate.Board-Medium")%> </td><td class=tablelight><%=boardname %></td>
    </tr>
     	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termamountupdate.StandardName")%></td><td class=tablelight><%= standardname %></td>
    	<td class=tablebold><%=bundle1.getString("label.termamountupdate.TotalAmount")%></td><td class=tablelight><%=formattedCurrency %></td>
    	
    </tr>	
    <tr><td class=tablebold><%=bundle1.getString("label.termamountupdate.Remaining")%> </td><td class=tablelight>  Rs. <span id="remainingspan"></span></td></tr>
     
    </table></td><td></td></tr>
    </tbody>
</table>
<br/><br/>
 <br><br>
<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle1.getString("label.termamountupdate.SL.No")%></th>
        	<th scope="col" class="rounded"  width="30%" ><%=bundle1.getString("label.termamountupdate.TermName")%></th>
        	<th scope="col" class="rounded"  width="15%" >Allocated Amount</th>
        	<th scope="col" class="rounded"  width="15%"><%=bundle1.getString("label.termamountupdate.TermAmount")%></th>
        	<th scope="col" class="rounded" width="30%" ><%=bundle1.getString("label.termamountupdate.DueDate")%></th>
        	<th scope="col" class="rounded-q4" width="30%" ><%=bundle1.getString("label.termamountupdate.Action")%></th>
        </tr>  
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   int tot = 0; byte count=0;
   String opmode = null;
   String collectionCount      = null;
   String feescollectionid = null;
   try
   {
	   //Long lObj21; 
   if(feestermamountList!=null && feestermamountList.size()>0)
	{ int inc = 1;
	 	for (int i1 = 0; i1 < feestermamountList.size(); i1++) {
	
		HashMap feestermamountListMap=(HashMap)feestermamountList.get(i1);
		
		
		String termfeesid     = (String)feestermamountListMap.get("termfeesid");
		String termname      = (String)feestermamountListMap.get("termname");
		String termfeesamount      = (String)feestermamountListMap.get("termfeesamount");
		String duedate      = (String)feestermamountListMap.get("duedate");
		if(feestermamountListMap.get("feescollectionid") != null)
			 feescollectionid      = (String)feestermamountListMap.get("feescollectionid");
		else
			 feescollectionid      = "-";
		
		
		if(inc == 1)
			collectionCount      = (String)feestermamountListMap.get("collectioncount");
		
		if(feestermamountListMap.get("termfeesamount") != null)
			tot += Integer.parseInt((String)feestermamountListMap.get("termfeesamount"));
		
		 
			%>
			<tr>
	<td><%= inc++ %></td>
	<td><%=termname %></td>
	<td><%=termfeesamount %></td>
	<td><input type="hidden" name="feescollectionid" value="<%=feescollectionid %>"/><input type="hidden" name="extamount" value="<%=termfeesamount %>"/><input type=text name="termfeesamount" class=tablelight value="<%=termfeesamount %>"  onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event,<%=i1 %>);" maxlength="7" size="10"/>
	<span id="error<%=i1 %>" style="color: Red; display: none">
      * Input digits (0 - 9)
    </span>
     <input type=hidden name="termcountvalue" value="<%=(String)feestermamountListMap.get("collectioncount") %>"></input><input type="hidden" name="termfeesid" value="<%=termfeesid %>"/></td>
	<td><input type='text' name='duedate' size='11'  value="<%=duedate %>" validate='Due Date' onfocus='this.blur()'/><span id=calenid><input type='button' value='^' onclick=Calendar_Fun("<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html",'updatetermfeesform.duedate[<%= count%>]','0',event,'Due_Date_Not_Less_Than_CurrentDate',updatetermfeesform.todaydate)></input></span></td>
<td class=tablelight>	<% if(feescollectionid=="-"){%>
	<a href="#" termfeesid="<%=termfeesid %>" onclick="trashfun(this)" class=tablelight>
	<img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" />
	<%}
	else
	{%>
		
	Fees Collected
	<% }%>
	

	
	
	</a></td>
	</tr>
			<%		count++;}
	
	 }
   else
   {
	   out.println("<tr><td colspan=6>Data not found</td></tr>");
   }
	
   }catch(Exception e){}
   %>
      <tr><td></td><td align=right><%=bundle1.getString("label.termamountupdate.TotalAmount")%></td><td><%=tot %></td><td></td><td></td><td></td></tr>
      <script>
   	<%
    	out.println("document.getElementById('remainingspan').innerHTML="+(Integer.parseInt(totalamount)-tot)); %>
   </script>
   	 <script>
   if(document.updatetermfeesform.duedate!=undefined)
   	document.getElementById("calenid").innerHTML="<input type='button' value='^' onclick=Calendar_Fun('<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html','updatetermfeesform.duedate','0',event,'Not_Less_Than_CurrentDate',document.updatetermfeesform.todaydate)></input>";
   </script>
   </tbody>
   </table>
      <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.termamountupdate.Back")%></strong><span class="bt_blue_r"></span></a>
       <% if(feestermamountList!=null && feestermamountList.size()>0)
	{%>
   	  <a href="#" class="bt_blue" onclick="updatetermFees()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.termamountupdate.UpdateTermAmount")%></strong><span class="bt_blue_r"></span></a>
   	  <%} %>
   
        <input type="hidden" name="totalamount" value="<%=totalamount%>"/>
 		<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" value="<%=standardname%>"/>   
    	<input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/> 
    	<input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	<input type="hidden" name="boardname" value="<%=boardname%>"/>
   		<input type='hidden' name='todaydate' value='<%=today %>'/>
   		<input type='hidden' name='opmode'/>
   		<input type='hidden' name='reqtermfeesid'/>
    	<input type='hidden' name='collectionCount' value='<%=collectionCount %>'/>
    	<input type="hidden" name="totaltermfeesamount" value="<%=tot%>"/>	
    	<input type="hidden" name="topay" value="<%=Double.parseDouble(lObj2.toString())%>"/>
    	
    	 
  </form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>