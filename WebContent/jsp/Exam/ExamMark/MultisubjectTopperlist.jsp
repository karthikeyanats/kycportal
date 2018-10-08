<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
 %>
 <html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <% 
    String optionsselect_temp="";
    optionsselect_temp=request.getParameter("optionsselect_temp");
    if(optionsselect_temp.equals("desc"))
    {
%>
<title>Know Your Child - <%=bundle.getString("label.subjectwisetopperweaker.TopperList") %>  | Powered by i-Grandee</title>
<%
    }
    else
    {
%>
<title>Know Your Child - <%=bundle.getString("label.subjectwisetopperweaker.WeakerList") %>  | Powered by i-Grandee</title>
<%
    }
%>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>        

<script type="text/javascript">
	
function goBack()
{
	document.Topper_Form.action="Multisubjecttopper.jsp";
	document.Topper_Form.submit();
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
    <% 
   

if(optionsselect_temp.equals("desc"))
{
	%>
    <h2><%=bundle.getString("label.subjectwisetopperweaker.entrytableheading1") %> </h2>
    <%
}
else
{
    %>
        <h2><%=bundle.getString("label.subjectwisetopperweaker.entrytableheading2") %> </h2>
    <%
    }
    %>
		<form name="Topper_Form" action="" method="post">
		
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10"></th>
		            	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.subjectwisetopperweaker.SelectedInformation") %></th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
<%
ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();

ArrayList studentList=null;
String req_sessionname="";
String req_sessionvalue="";
String req_boardname="";
String req_boardvalue="";
String req_examname="";
String req_examvalue="";
String req_coursename="";
String req_coursevalue="";
String req_subjectname="";
String req_subjectvalue="";
String req_students="";
req_sessionname=request.getParameter("req_sessionname");
req_sessionvalue=request.getParameter("req_sessionvalue");
req_boardname=request.getParameter("req_boardname");
req_boardvalue=request.getParameter("req_boardvalue");
req_examname=request.getParameter("req_examname");
req_examvalue=request.getParameter("req_examvalue");
req_coursename=request.getParameter("req_coursename");
req_coursevalue=request.getParameter("req_coursevalue");
//req_subjectname=request.getParameter("req_subjectname");
//req_subjectvalue=request.getParameter("req_subjectvalue");
req_students=request.getParameter("req_students");


String[] subjectidnew 				= request.getParameterValues("subject");
String[] subjectidnew1 				= request.getParameterValues("subject");

String subjectid_temp="";
int colspancount=0;

if(subjectidnew!=null) 
{ 
	for(int i=0;i<subjectidnew.length;i++)
	{
		subjectid_temp +=subjectidnew[i];
		if(i!=(subjectidnew.length)-1)
		{
			subjectid_temp +="','";
		}
	
	} 
}



if(req_sessionvalue != null && req_boardvalue != null  && req_examvalue != null && req_coursename != null && req_subjectvalue != null)
{
	if(optionsselect_temp.equals("desc"))
	{
	studentList			= examQuery.subjectTopperWeekerListMultisubject(req_coursevalue,req_examvalue,"desc",req_students,subjectid_temp);
	}
	else
	{
		studentList			= examQuery.subjectTopperWeekerListMultisubject(req_coursevalue,req_examvalue,"asc",req_students,subjectid_temp);
	
	}
}

HashMap subname =new HashMap();	
StringBuffer head=new StringBuffer();
ArrayList tempList	= new ArrayList();
ArrayList tempListsubject= new ArrayList();
String examallocationid="0";
String markpublishstatus="P";
String subjectscheduleID="";
int subjectcount=0;
try
{
	for(int i=0,s=1;i<studentList.size();i++)
	{
		HashMap map=(HashMap)studentList.get(i);
		String subjectname=map.get("subjectname")+"";
		String subjectscheduleid=map.get("subjectscheduleid")+"";

		
			
		if(!tempListsubject.contains(subjectname))
		{
			subjectname=subjectname.trim();
			subjectscheduleID=subjectscheduleid.trim();

			subjectcount++;  
			tempListsubject.add(subjectname);  
			s++;
			
			
		}
	}
	
if(studentList.size()!=0)
{
	for(int i=0,s=1;i<studentList.size();i++)
	{
		HashMap map=(HashMap)studentList.get(i);
		String subjectname=map.get("subjectname")+"";
		String subjectscheduleid=map.get("subjectscheduleid")+"";

		examallocationid=map.get("examallotmentid")+"";
		 String markpublishsta=map.get("markpublishstatus")+"";
			if(markpublishsta.equalsIgnoreCase("P"))   
			{
				markpublishstatus="yes";
			}
			
		if(!tempList.contains(subjectname))
		{
			subjectname=subjectname.trim();
			subjectscheduleID=subjectscheduleid.trim();

			head.append("<th width='100/"+subjectcount+"'>"+subjectname+"</th>");
			colspancount++;    
			subname.put("S"+s,subjectname);
			tempList.add(subjectname);  
			s++;
			
			
		}
	}
	for(int i=0,s=1;i<studentList.size();i++)
	{
		HashMap map=(HashMap)studentList.get(i);
		String subjectname=map.get("subjectname")+"";
		if(!tempList.contains(subjectname))
		{
			subjectname=subjectname.trim();
			head.append("<th>S"+s+"</th>");
			colspancount++;   
			subname.put("S"+s,subjectname);
			tempList.add(subjectname);
			s++;
		}
	}
}

}
catch(Exception e)
{
	e.printStackTrace();
}





%>
	
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'><%=bundle.getString("label.subjectwisetopperweaker.AcademicYear") %></td>
				<td class="tablebold" width="1%">:</td>
				<td>
						<%=req_sessionname%>
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.subjectwisetopperweaker.Board") %> </td>
								<td class="tablebold" width="1%">:</td>
				<td>
					<%=req_boardname%>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.subjectwisetopperweaker.Exam") %> </td>
								<td class="tablebold" width="1%">:</td>
				<td>
					<%=req_examname%>
				</td>
		
				<td class=tablebold><%=bundle.getString("label.subjectwisetopperweaker.Standard") %> </td>
								<td class="tablebold" width="1%">:</td>
				<td>
				<%=req_coursename%>
				</td>
			</tr>
					
		</table>
 		<tfoot>
	    	<tr>
	        	<td colspan="2" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot> 
    	
	<br>
	
	
	

		<table id="rounded-corner1" border=2  cellspacing=0 cellpadding=5  width="100%">
    		<thead>
    	    <tr class=tableheading  > 
        	<!--  <th scope="col" class="rounded-company" width="1%" rowspan=2>SL.No</th>   -->  
	        <% 	if(optionsselect_temp.equals("desc"))
			{%>
            <th scope="col" class="rounded"    colspan=<%=colspancount %>><%=bundle.getString("label.subjectwisetopperweaker.SubjectWiseTopper") %></th>  
            <%
			}
	        else
	        {
            %>    
             <th scope="col" class="rounded"   colspan=<%=colspancount %>><%=bundle.getString("label.subjectwisetopperweaker.SubjectWiseWeaker") %></th>  
            <%
	        }
            %>         
            <tr  bgcolor="#80BFFF">            
            
            <%=head%>  
       		 </tr>     
		    </thead>
      		<tfoot>
		    	  
		    </tfoot>
		    <tbody>
			    
					    <%
					    int datanotfound=0;
					    int rowcount=0;
						HashMap studentMap=new HashMap();  
		    			//out.print("<table border=0  width='100%' align='center'>");
		    			out.print("<tr  valign='top'>");	
		    			if(subjectidnew1!=null) 
		    			{  
				    	for(int k=0;k<subjectidnew1.length;k++)
		    			{
				    		if(optionsselect_temp.equals("desc"))
				    		{
			    			studentList			= examQuery.subjectTopperWeekerListMultisubjectIndividual(req_coursevalue,req_examvalue,"desc",req_students,subjectidnew1[k]);
				    		}
				    		else
				    		{
				    			studentList			= examQuery.subjectTopperWeekerListMultisubjectIndividual(req_coursevalue,req_examvalue,"asc",req_students,subjectidnew1[k]);

				    		}
		    			if(studentList != null && studentList.size()>0)
				    	{  out.print("<td>");	

		    				rowcount++;
		    				//if(rowcount==1)
		    				//{
			    			//out.print("<table border=1 width='100%' align='center' bgcolor='red' ><tr><td><div id='slno'></div></td></tr></table><td>");	
		    				//}
		    				out.print("<table border=1 width='100%' align='center' cellspacing=0 cellpadding=5 >");	

				    		for(int i=0;i<studentList.size();i++)
				    		{            	  
				    			String subjectscheduleid="";
				    			studentMap=(HashMap)studentList.get(i);
				    			String imagepath=studentMap.get("imagepath")+"";
				    			 subjectscheduleid=studentMap.get("subjectscheduleid")+"";
				    			 String rollno= studentMap.get("rollno")+"";
				    			 String marktaken= studentMap.get("marktaken")+"";   
				    			 String studentallocationid=studentMap.get("studentallocationid")+""; 
				    			 String examname=studentMap.get("examname")+"";
				    			 
				    			 

								if(rollno == null || rollno.equals("") || rollno.equals("-") || rollno.equalsIgnoreCase("null"))
								{
								
								rollno="<font size='1px' class='tablelight' ><i>Not Generated</i></font>";

								}    
								else
								{
									rollno=studentMap.get("rollno")+"";            

								}
								if(marktaken == null || marktaken.equals("") || marktaken.equals("-") || marktaken.equalsIgnoreCase("null"))
								{
									marktaken="<font size='1px' class='tablelight'  ><i>Not Entered</i></font>";
								}
								else
								{
									marktaken=studentMap.get("marktaken")+"";               
								}
				    			out.print("<tr valign='top'>");  
					    		if(rowcount==1)  
					    		{   
					    		%>
					    		<td width='10%'><%= (i+1)%></td><td  valign='top'><table border=0 align='center'  width='100%'><tr><td cellpadding='4' cellspacing='2' ><div><a href="./SingleStudentMarks.jsp?studentallocationid=<%=studentallocationid%>&standardid=<%=req_coursevalue %>&regexamid=<%=req_examvalue%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '<%= studentMap.get("studentname")%> <%= examname%> Marks', maincontentId: 'credits', align: 'center', width: 950, height: 200 } )"><%= studentMap.get("studentname")%></a></div></td><td  rowspan=4 valign='top' align="right"><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2=<%=imagepath%>' name='stphoto_img1' id=stphoto_img width=70 height=70></td></tr><tr><td cellpadding='4' cellspacing='2' class='tablelight'> <%=rollno %></td></tr><tr><td cellpadding='4' cellspacing='2' class='tablelight'><%= studentMap.get("sectionname")%></td></tr><tr><td><a  cellpadding='4' cellspacing='2' >Mark:<%=marktaken%></font></a></td></tr></table></td></tr>
						    	<%
					    		}
					    		 else          
					    		{%>            
					    		<td  valign='top'><table border=0 align='center'  width='100%'><tr><td cellpadding='4' cellspacing='2'><div><a href="./SingleStudentMarks.jsp?studentallocationid=<%=studentallocationid%>&standardid=<%=req_coursevalue %>&regexamid=<%=req_examvalue %>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: '<%= studentMap.get("studentname")%> <%= examname%> Marks', maincontentId: 'credits', align: 'center', width: 950, height: 200 } )"><%= studentMap.get("studentname")%></a></div></td><td  rowspan=4 valign='top' align="right"><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2=<%=imagepath%>' name='stphoto_img1' id=stphoto_img width=70 height=70></td></tr><tr><td cellpadding='4' cellspacing='2' class='tablelight'> <%=rollno %></td></tr><tr><td cellpadding='4' cellspacing='2' class='tablelight'><%= studentMap.get("sectionname")%></td></tr><tr><td><a  cellpadding='4' cellspacing='2' >Mark:<%=marktaken%></a></td></tr></table></td></tr>
				    			<%      
					    		}     
					    		out.print("</tr>");
				    		}
				    		out.print("</table>");
				    		out.print("</td>");
		    			}
		    			else
		    			{	
		    				datanotfound++;
		    				if(subjectidnew1.length==datanotfound){
		    					out.println("<tr align='center' class='tablebold'><td colspan='"+(colspancount+1)+"'><font color='red'>Data Not Found</font></td></tr>");
		    					//out.print("<tr><td align='center' colspan='"+(colspancount+1)+"'>Data Not Found</td></tr>");
		    				}

		    			}
		    			
		    			}
		    			}
		    			
		    			else
		    			{  
		    			} 
		    			out.print("</tr>");
		    			//out.print("</table>");
		

					    		
					    %>

					</table>
				</td>
			</tr>
		</table>
	</table>
	<br><br>
		
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subjectwisetopperweaker.Back") %> </strong><span class="bt_blue_r"></span></a>
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>