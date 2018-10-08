<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Report Index | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function Report()
{

	if(document.StdwiseBookForm.deptname.options[document.StdwiseBookForm.deptname.options.selectedIndex].value =="00")
	{
		alert("Select Department");
		document.StdwiseBookForm.deptname.focus();
		return false;
	}

	var status=false;
	for(var i=0;i<document.StdwiseBookForm.selectoption.length;i++)
	{
		if(document.StdwiseBookForm.selectoption[i].checked)
		{
		status=true;
		}
		
	}	

		if(status){
		document.StdwiseBookForm.req_deptid.value  =document.StdwiseBookForm.deptname.options[document.StdwiseBookForm.deptname.options.selectedIndex].value;
		document.StdwiseBookForm.req_deptname.value  =document.StdwiseBookForm.deptname.options[document.StdwiseBookForm.deptname.options.selectedIndex].text;
		document.StdwiseBookForm.req_sessionstatus.value  =document.StdwiseBookForm.deptname.options[document.StdwiseBookForm.deptname.options.selectedIndex].getAttribute("status");
	
		document.StdwiseBookForm.action="DeptwiseBookExceedDueList.jsp";
		document.StdwiseBookForm.submit();
		}
		else
		{
			
		alert("Select Book or Journal Option");
		return false;
		}					
}

	function optionselect(obj)
	{
	var flage_temp=obj.value;
	if(flage_temp=="Book")
	{
	
			document.StdwiseBookForm.flage_temp.value="Book";
	
	}
	else
	{
			document.StdwiseBookForm.flage_temp.value="Journal";
	
	}
	}
</script>
</head>
<body>
<form name="StdwiseBookForm" action="" method="post">
<input type=hidden name=req_deptid>
<input type=hidden name=req_deptname>
<input type=hidden name=req_sessionstatus>

<input type="hidden" name="flage_temp" value="">
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Report / Due Date Exceeded / Departmentwise Book Exceed Due date</h2>
   <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.ApplicationQuery,com.iGrandee.Registration.StaffRegistrationQuery"%>
	<%
    try
    {
    	StaffRegistrationQuery staffquery=new StaffRegistrationQuery();
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
	
	    String instituteid = null;
	    ArrayList BoardList = null;
	    ArrayList deptList = null;
	 		
			//String temp=applicationQuery.receiptNo();

	    	  instituteid = (String)session.getValue("instituteid");
	    	  //ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	    	  deptList =staffquery.departmentload(instituteid);
	    	  //BoardList = standardQuery.listBoard(instituteid);
	    
		//out.println("temp-->"+temp);
	%>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%" >Department wise Book/Journal Exceeded Due Date</th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.schedule.mandatory")%></th>
            
        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td class=tablebold colspan=2 align=center>
		Department :<font color=red>*</font>&nbsp;&nbsp;
		<select name=deptname class=tablelight>
			<option value="00">-Select Department-</option>
			<%
			if(deptList!=null && deptList.size()>0)
			{
		 		HashMap deptMap = null;
		 		for(int i=0;i<deptList.size();i++) {
		 			deptMap = (HashMap)deptList.get(i);
		 			String deptid = (String)deptMap.get("departmentid");
		    		String deptname = (String)deptMap.get("departmentname");
	 		   		out.println("<option value='"+deptid+"'>"+deptname+"</option>");
		 		}				
			}

			%>
		</select>

		</td>
		<% 
	     }catch(Exception e){}
		%>
		

	</tr>
 
 			<tr>
	   		 <td align="center" colspan=6>
	   
		    <input type="radio" name="selectoption" value="Book" onclick="optionselect(this)"><font size=3>Book</font>&nbsp;&nbsp;
		    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3>Journal</font>
   
		    </td>
		    </tr>			    	
    </tbody>
</table>


<a href="#" class="bt_green" onclick="Report()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.submit")%></strong><span class="bt_green_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>