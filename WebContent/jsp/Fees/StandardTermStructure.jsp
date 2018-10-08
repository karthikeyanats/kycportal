<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.termamountallocation.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
function checkNumber(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;  
if(code!=9 && code!=46 && code!=8 && code!=43&& code!=45 && code!=118 && code!=99 && code!=37 && code!=38 && code!=39 && code!=40)
{
var character = String.fromCharCode(code);
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
function updatetermFees()
{
	document.feesstructureloadstdform.action="./UpdateTermFees.jsp";
	document.feesstructureloadstdform.submit();
}
function allotFees(obj)
{
var sta=false;
	//document.feesstructureloadstdform.action="./StandardTermStructure.jsp";
	
	if(document.feesstructureloadstdform.chk!=undefined)
	{

		var len=document.feesstructureloadstdform.chk.length;
		if(len!=undefined)
		{
			for(var i=0;i<len;i++)
			{
				if(document.feesstructureloadstdform.chk[i].checked)
					{
						sta=true;
						document.feesstructureloadstdform.termfeesamount[i].disabled=false;
				        document.feesstructureloadstdform.duedate[i].disabled=false;
						document.feesstructureloadstdform.paidfeesamount[i].disabled=false;
						document.feesstructureloadstdform.termfeesid[i].disabled=false;
						document.feesstructureloadstdform.termid[i].disabled=false;
					}
					else
					{
						document.feesstructureloadstdform.termfeesamount[i].disabled=true;
				        document.feesstructureloadstdform.duedate[i].disabled=true; 
				        document.feesstructureloadstdform.paidfeesamount[i].disabled=true;
				        document.feesstructureloadstdform.termfeesid[i].disabled=true;
				        document.feesstructureloadstdform.termid[i].disabled=true; 
					}
			}
			if(sta)
			{
				var total=0;
				for(var i=0;i<document.feesstructureloadstdform.paidfeesamount.length;i++)
				{	
					var amount=document.feesstructureloadstdform.paidfeesamount[i].value;
						if(amount=="")
						amount=0;
						total +=parseInt(amount);
				}
				if(parseInt(document.feesstructureloadstdform.totalfeesamount.value)>total)
				{
					alert("Entered Amount Less Than Total Term  Amount");
					if(len!=undefined)
						{
							for(var i=0;i<len;i++)
							{
								document.feesstructureloadstdform.chk[i].checked=false;
							}
						}
						else
						{
								document.feesstructureloadstdform.chk.checked=false;
						}
							for(var i=0;i<len;i++)
							{
								document.feesstructureloadstdform.termfeesamount[i].disabled=false;
						        document.feesstructureloadstdform.duedate[i].disabled=false;
								document.feesstructureloadstdform.paidfeesamount[i].disabled=false;
								document.feesstructureloadstdform.termfeesid[i].disabled=false;
								document.feesstructureloadstdform.termid[i].disabled=false;				
							}					
					return false;
				}
				else  
				{
					document.feesstructureloadstdform.action="./StandardTermStructureAllotment.jsp";
					document.feesstructureloadstdform.submit();
				}
			}
			else
			{
				alert("Check Any One");
				for(var i=0;i<len;i++)
				{
					document.feesstructureloadstdform.termfeesamount[i].disabled=false;
			        document.feesstructureloadstdform.duedate[i].disabled=false;
					document.feesstructureloadstdform.paidfeesamount[i].disabled=false;
					document.feesstructureloadstdform.termfeesid[i].disabled=false;
					document.feesstructureloadstdform.termid[i].disabled=false;				
				}				
			}
		}
		else
		{
			if(document.feesstructureloadstdform.chk.checked)
				{
					sta=true;
					document.feesstructureloadstdform.termfeesamount.disabled=false;
					document.feesstructureloadstdform.duedate.disabled=false;
					document.feesstructureloadstdform.paidfeesamount.disabled=false;
					document.feesstructureloadstdform.termfeesid.disabled=false;
				    document.feesstructureloadstdform.termid.disabled=false;
				}
			if(sta)
			{
				var total=0;
				//alert(document.feesstructureloadstdform.paidfeesamount.value);
				if(document.feesstructureloadstdform.paidfeesamount.length==undefined){
					var amount=document.feesstructureloadstdform.paidfeesamount.value;
					if(amount=="")
						amount=0;
						total +=parseInt(amount);					
				}
				else{
				for(var i=0;i<document.feesstructureloadstdform.paidfeesamount.length;i++)
				{	
					var amount=document.feesstructureloadstdform.paidfeesamount[i].value;
					if(amount=="")
						amount=0;
					
						total +=parseInt(amount);
				}
				}
				//alert(document.feesstructureloadstdform.totalfeesamount.value+"<---->"+total);

				if(parseInt(document.feesstructureloadstdform.totalfeesamount.value)>total)
				{
					alert("Entered Amount Less Than Total Term  Amount");
					if(len!=undefined)
						{
							for(var i=0;i<len;i++)
							{
								document.feesstructureloadstdform.chk[i].checked=false;
							}
						}
						else
						{
								document.feesstructureloadstdform.chk.checked=false;
						}
						document.feesstructureloadstdform.termfeesamount.disabled=false;
						document.feesstructureloadstdform.duedate.disabled=false;
						document.feesstructureloadstdform.paidfeesamount.disabled=false;
						document.feesstructureloadstdform.termfeesid.disabled=false;
						document.feesstructureloadstdform.termid.disabled=false;
					return false;
				}
				else  
				{
					//alert("success");
					document.feesstructureloadstdform.action="./StandardTermStructureAllotment.jsp";
					document.feesstructureloadstdform.submit();
				}
			}
			else
			{
				alert("Check Any One");
			}

		}
	}

}
function gobackfun()
{
	document.feesstructureloadstdform.action="./FeesStructureLoadStandard.jsp";
	document.feesstructureloadstdform.submit();
}
function checkfun(obj)
{
	var sno=obj.getAttribute("sno");
	if(document.feesstructureloadstdform.chk.length!=undefined)
	{
		if(obj.checked)
		{
			if(!check_ForParticularElements(document.feesstructureloadstdform.termfeesamount[sno],"text",document.feesstructureloadstdform.duedate[sno],"text"))
			{
				obj.checked=false;
			}
			else
			{
				
				var val=document.feesstructureloadstdform.termfeesamount[sno].value;
				for(var i=0;i<val.length;i++)
				{
					var strval=parseInt(val.charAt(i));
					if(strval>=0 && strval<=9)
					{
					}
					else
					{
						alert("Numeric Only Allowed");
						obj.checked=false;
						document.feesstructureloadstdform.termfeesamount[sno].value="";
						document.feesstructureloadstdform.termfeesamount[sno].focus();
						return false;
					}
				}
				document.feesstructureloadstdform.termfeesamount[sno].disabled=true; 
				document.feesstructureloadstdform.duedate[sno].disabled=true;
				document.feesstructureloadstdform.termfeesid[sno].disabled=true;
				document.feesstructureloadstdform.termid[sno].disabled=true;
				
				
			}
		}
		else
		{
				document.feesstructureloadstdform.termfeesamount[sno].disabled=false;
				document.feesstructureloadstdform.duedate[sno].disabled=false;
				document.feesstructureloadstdform.termfeesid[sno].disabled=false;
				document.feesstructureloadstdform.termid[sno].disabled=false;  
		}
	}
	else
	{
		if(obj.checked)
		{
			if(!check_ForParticularElements(document.feesstructureloadstdform.termfeesamount,"text",document.feesstructureloadstdform.duedate,"text"))
			{
				obj.checked=false;
			}
			else
			{
				var val=document.feesstructureloadstdform.termfeesamount.value;
				for(var i=0;i<val.length;i++)
				{
					var strval=parseInt(val.charAt(i));
					if(strval>=0 && strval<=9)
					{
					}
					else
					{
						alert("Numeric Only Allowed");
						obj.checked=false;
						document.feesstructureloadstdform.termfeesamount.value="";
						document.feesstructureloadstdform.termfeesamount.focus();
						return false;
					}
				}
				document.feesstructureloadstdform.termfeesamount.disabled=true;
				document.feesstructureloadstdform.duedate.disabled=true;
				document.feesstructureloadstdform.termfeesid.disabled=true;
				document.feesstructureloadstdform.termid.disabled=true;
			}
		}
		else
		{
				document.feesstructureloadstdform.termfeesamount.disabled=false;
				document.feesstructureloadstdform.duedate.disabled=false; 
				document.feesstructureloadstdform.termfeesid.disabled=false;
				document.feesstructureloadstdform.termid.disabled=false; 
		}
	}
}


function calcamount(obj,count)
{
	//alert(obj+"--"+count);
	var fee=obj.value;
	//alert(document.feesstructureloadstdform.paidfeesamount.length+"--"+fee);


	var total=0;
	if(document.feesstructureloadstdform.paidfeesamount.length==undefined){
		document.feesstructureloadstdform.paidfeesamount.value=fee;
		var amount=document.feesstructureloadstdform.paidfeesamount.value;
		if(amount=="")
			amount=0;
			total +=parseInt(amount);
	}
	else
	{
		document.feesstructureloadstdform.paidfeesamount[count].value=fee;
	for(var i=0;i<document.feesstructureloadstdform.paidfeesamount.length;i++)
	{	
	var amount=document.feesstructureloadstdform.paidfeesamount[i].value;
	if(amount=="")
		amount=0;
		total +=parseInt(amount);
	}
	}
	//alert(document.feesstructureloadstdform.totalfeesamount.value+"--"+total);
	if(parseInt(document.feesstructureloadstdform.totalfeesamount.value)<total)
	{
	alert("Entered Amount Exceeds Than Total Amount");
	if(document.feesstructureloadstdform.paidfeesamount.length==undefined)
		document.feesstructureloadstdform.paidfeesamount.value="";
	else	
		document.feesstructureloadstdform.paidfeesamount[count].value="";
	
	obj.value="";
	obj.focus();   
	return false;
	}
	document.getElementById("totalamountspan").innerHTML=total;
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

    <h2><%=bundle1.getString("label.termamountallocation.rootpath")%></h2>
<form name="feesstructureloadstdform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.termamountallocation.FeesStructure-Selection")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>

        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.Common.DateTime"%>

     <%
     ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
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
     String formattedCurrency_term = null;
     String formattedCurrency_totamt = null;

    // Locale localcurrency = new Locale("en", "IN");
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
    	  feestermamountList = feesschedule.loadFeesTermDetails(standardscheduleid);
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
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termamountallocation.AcdamicSession")%></td><td class=tablebold>:</td><td class=tablelight><%= yearofsessionname %></td>
        <td class=tablebold><%=bundle1.getString("label.termamountallocation.Board-Medium")%> </td><td class=tablebold>:</td><td class=tablelight><%=boardname %></td>
    </tr>
     	<tr>
    	<td class=tablebold><%=bundle1.getString("label.termamountallocation.StandardName")%></td><td class=tablebold>:</td><td class=tablelight><%= standardname %></td>
    	<td class=tablebold><%=bundle1.getString("label.termamountallocation.TotalAmount")%></td><td class=tablebold>:</td><td class=tablelight><%=formattedCurrency %></td>

    </tr>
    <tr><td class=tablebold><%=bundle1.getString("label.termamountallocation.Remaining")%> </td><td class=tablebold>:</td><td class=tablelight>
    <%
    /* Long lObj25 = Long.valueOf("0");
    NumberFormat formatc = NumberFormat.getCurrencyInstance(localcurrency);
    formattedCurrency_term = formatc.format(lObj25); out.println(formattedCurrency_term.substring(0,1)); */
    
    %>
    Rs. <span id="remainingspan"></span></td></tr>
    </table></td></tr>
    </tbody>
</table>
<br/><br/>
 <br><br>
 <input type=hidden name="totalfeesamount" class=tablelight value="<%=totalamount %>"/>

<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle1.getString("label.termamountallocation.SL.No")%></th>
        	<th scope="col" class="rounded" ><%=bundle1.getString("label.termamountallocation.TermName")%></th>
        	<th scope="col" class="rounded" ><%=bundle1.getString("label.termamountallocation.TermAmount")%></th>
        	<th scope="col" class="rounded" ><%=bundle1.getString("label.termamountallocation.DueDate")%></th>
        	<th scope="col" class="rounded-q4" ><%=bundle1.getString("label.termamountallocation.Chk")%></th>

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
   int tot = 0; byte count=0;
   String opmode = null;
   try
   {
	   //Long lObj21;


   if(feestermamountList!=null && feestermamountList.size()>0)
	{ int inc = 1;
	    int chk = 0;
	 	for (int i1 = 0; i1 < feestermamountList.size(); i1++) {

		HashMap feestermamountListMap=(HashMap)feestermamountList.get(i1);
		String termfeesid     = (String)feestermamountListMap.get("termfeesid");
		String termid     = (String)feestermamountListMap.get("termid");
		String termname      = (String)feestermamountListMap.get("termname");
		String termfeesamount      = (String)feestermamountListMap.get("termfeesamount");
		String duedate      = (String)feestermamountListMap.get("duedate");
		try
		{
	    Long lObj21 = Long.valueOf(termfeesamount);
	    NumberFormat formatx = NumberFormat.getCurrencyInstance(localcurrency);
	    formattedCurrency_term = formatx.format(lObj21);
	    }
		catch(NumberFormatException es)
		{}

		if(duedate ==null)
			duedate = "";

		//lObj21 = Long.valueOf((String)feestermamountListMap.get("termfeesamount"));
		try
		{
		if(feestermamountListMap.get("termfeesamount") != null)
			tot += Integer.parseInt((String)feestermamountListMap.get("termfeesamount"));
		}catch(NumberFormatException e){tot = 0;}
	if(termfeesamount != null){
			opmode="update";
		%>
	<tr>
	<td><%= inc++ %></td>
	<td><%=termname %></td>
	<td><%=formattedCurrency_term%><input type=hidden name="paidfeesamount"     class=tablelight value="<%=termfeesamount%>"/></td>
	<td><%=duedate %></td>
<td>-</td>
	</tr>

	<% 	}
		else
		{
			opmode="insert";
			%>
			<tr>
	<td><%= inc++ %></td>
	<td><%=termname %></td>
	<td> 
	<input type=text name="termfeesamount" class=tablelight onchange="calcamount(this,'<%=i1%>')"  onkeypress="checkNumber(event);" /><input type="hidden" name="termfeesid" value="<%=termfeesid %>"/><input type="hidden" name="termid" value="<%=termid %>"/>	<input type=hidden name="paidfeesamount" class=tablelight value=""/>	
	</td>
	<td>
		<input type='text' name='duedate' id='duedate' size='11' validate='Due Date' onfocus='this.blur()'/><span id=calenid ><input type='button' value='^' onclick=Calendar_Fun("<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html",'feesstructureloadstdform.duedate[<%=count%>]','0',event,'Due_Date_Not_Less_Than_CurrentDate',document.feesstructureloadstdform.todaydate)></input></span><input type=hidden name="opmode" value="<%=opmode %>"/>
	</td>

	<td><input type=checkbox name=chk class=tablelight sno='<%=chk %>' onclick="checkfun(this)"/></td>
	</tr>
			<%		count++;
			chk++;

			}

	 }
	}
   }catch(Exception e){e.printStackTrace();}
   %>
   <script>
    if(document.feesstructureloadstdform.duedate!=undefined && document.feesstructureloadstdform.duedate.length==undefined)
    {
   	document.getElementById("calenid").innerHTML="<input type='button' value='^' onclick=Calendar_Fun('<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html','feesstructureloadstdform.duedate','0',event,'Not_Less_Than_CurrentDate',document.feesstructureloadstdform.todaydate)></input>";
   	}
   </script>
   <%
   if(feestermamountList!=null && feestermamountList.size()>0)
   {
   %>
      <tr><td></td><td align=right><%=bundle1.getString("label.termamountallocation.TotalAmount")%></td><td colspan='2'><span id="totalamountspan"><%=tot %></span></td><td></td></tr>
    <% }
    else
    {
    	out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	//out.println("<tr><td colspan=5 align=center class=tablebold>Data not found</td></tr>");
    }%>
	<script>
   	<%
    	out.println("document.getElementById('remainingspan').innerHTML="+(Integer.parseInt(totalamount)-tot)); %>
   </script>
   </tbody>
   </table>
        <a href="#" onclick="gobackfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.termamountallocation.Back")%></strong><span class="bt_blue_r"></span></a>
         <%
   if(feestermamountList!=null && feestermamountList.size()>0)
   {
   %>
   	    <a href="#" class="bt_green" onclick="updatetermFees()"><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.termamountallocation.UpdateTermAmount")%></strong><span class="bt_green_r"></span></a>
   	    <%} %>
	 	
        <a href="#" class="bt_green" onclick="allotFees()" id="submitbut"><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.termamountallocation.AllotAmount")%></strong><span class="bt_green_r"></span></a>
 		<script>
	    if(document.feesstructureloadstdform.duedate==undefined)
	    {
	   	document.getElementById("submitbut").style.display="none";
	   	}
	   </script>
 		<input type="hidden" name="standardscheduleid" 	value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" 		value="<%=standardname%>"/>
    	<input type="hidden" name="yearofsessionid" 	value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" 	value="<%=yearofsessionname%>"/>
    	<input type="hidden" name="boardid" 			value="<%=boardid%>"/>
    	<input type="hidden" name="boardname" 			value="<%=boardname%>"/>
   		<input type='hidden' name='todaydate' 			value='<%=today %>'/>
		<input type='hidden' name='opmode' 				value='insert'/>
  </form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>