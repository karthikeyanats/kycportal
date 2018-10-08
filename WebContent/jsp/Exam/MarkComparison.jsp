<html>
<head>
<script src="./ChartCSS/jquery.min.js" type="text/javascript"></script>
<script src="./ChartCSS/highcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="./ChartCSS/gray.js"></script>
<script type="text/javascript" src="../js/modules/exporting.js"></script>

<%@ page import="java.util.*"%> 
	<%@ page import="com.iGrandee.Exam.ExamnameEntry"%>
	<%
		String Examname = "";
		String date_str = "";
		ExamnameEntry Examquery = new ExamnameEntry(); 
		HashMap stdmap = null;
		HashMap secmap = null;
		ArrayList GradeList=new ArrayList();
		ArrayList LoadExamnameList=new ArrayList();
 		String standardscheduleid=session.getValue("standardscheduleid")+"";
 		String studentid=session.getValue("studentid")+"";
		String sessionid="";
		String alloted="";
		String groupname="";
       	int count=0;

		String sessionname="";
		String rollnumber = "";
		String prefix=session.getValue("prefix")+"";
		rollnumber=session.getValue("studentrollno")+"";
		if(session.getValue("studentrollno")==null)
			rollnumber = "Not yet Generated";
		ArrayList StudentList=new ArrayList();
		HashMap Yearofsessionarrmap=null;
		LoadExamnameList=Examquery.newStandardSubjectSchedule(standardscheduleid);
		ArrayList assd=Examquery.listStudentmark(standardscheduleid,studentid);
      %>
	<form name="f1" method="post" action="">

	
			       
			
			<%
	boolean flag 	= false;
	HashMap newhash=new HashMap();
	HashMap newhash2=new HashMap();
	HashMap newhash3=new HashMap();

	ArrayList tempList	= new ArrayList();
	ArrayList ResultList	=	(ArrayList)Examquery.LoadExamMarksForstudent(studentid,standardscheduleid);  
	%>
		    <%
		    int nodata=0;
		    try{
		    	String innermark="";
			    int total=0;

		    if(ResultList!=null && ResultList.size()!=0)
				{
		    	String examid="";
					for(int i=0,s=1;i<ResultList.size();i++)
						{
							HashMap map=(HashMap)ResultList.get(i);
							String examnameid=map.get("examnameid")+"";
							if(!examnameid.equals("null"))
							{
								if(!examnameid.equals(examid))
								{  
									Examname +=map.get("examname")+"','";
									examid=examnameid;
								}
							}
						}
					
				}
			
		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
		  %>
		  
<script language="javascript">
var chart1; // globally available
$(document).ready(function() {

      chart1 = new Highcharts.Chart({

         chart: {

            renderTo: 'container',

            type: 'bar'

         },

         title: {

            text: 'Mark Comparison'

         },

         xAxis: {

			 categories: ['<%=Examname%>']
         },

         yAxis: {

            title: {

               text: 'Mark Taken'

            }

         },
         series: [
<%
try{
String innermark="";
     	HashMap hashmap=null;
     	if(LoadExamnameList!=null && LoadExamnameList.size()>0 )
     	{
     		
			for(int y=0;y<LoadExamnameList.size();y++)
			{
				hashmap=(HashMap)LoadExamnameList.get(y);
				String subjectscheduleid1=hashmap.get("subjectscheduleid")+"";
				out.println("{name: '"+hashmap.get("subjectname")+"',data: [");
				for(int j=0;j<ResultList.size();j++)
				{
					HashMap map1=(HashMap)ResultList.get(j);
					String examnameid1=map1.get("examnameid")+"";
					String subjectscheduleid=map1.get("subjectscheduleid")+"";
					if(!examnameid1.equals("null"))
					{
						if(subjectscheduleid1.equals(subjectscheduleid))
						{  
							innermark=map1.get("marktaken")+"";
							int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
							if(!innermark.equals("null"))
							{
								out.println(innermark+",");
							}
						} 
					}
				} 
				out.println("]}");
				if(y!=LoadExamnameList.size()-1)
				out.println(",");
			}
		}
}
catch(Exception e)
{
	e.printStackTrace();
	}
		%>
         ]

      });

   });
</script>
<script language="javascript">
var chart1; // globally available
$(document).ready(function() {

      chart1 = new Highcharts.Chart({

         chart: {

            renderTo: 'linediv',

            type: 'line'

         },

         title: {

            text: 'Mark Comparison'

         },

         xAxis: {

			 categories: ['<%=Examname%>']
         },

         yAxis: {

            title: {

               text: 'Mark Taken'

            }

         },
         series: [
<%
try{
String innermark="";
     	HashMap hashmap=null;
     	if(LoadExamnameList!=null && LoadExamnameList.size()>0 )
     	{
     		
			for(int y=0;y<LoadExamnameList.size();y++)
			{
				hashmap=(HashMap)LoadExamnameList.get(y);
				String subjectscheduleid1=hashmap.get("subjectscheduleid")+"";
				out.println("{name: '"+hashmap.get("subjectname")+"',data: [");
				for(int j=0;j<ResultList.size();j++)
				{
					HashMap map1=(HashMap)ResultList.get(j);
					String examnameid1=map1.get("examnameid")+"";
					String subjectscheduleid=map1.get("subjectscheduleid")+"";
					if(!examnameid1.equals("null"))
					{
						if(subjectscheduleid1.equals(subjectscheduleid))
						{  
							innermark=map1.get("marktaken")+"";
							int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
							if(!innermark.equals("null"))
							{
								out.println(innermark+",");
							}
						} 
					}
				} 
				out.println("]}");
				if(y!=LoadExamnameList.size()-1)
				out.println(",");
			}
		}
      }
      catch(Exception e)
      {
      	e.printStackTrace();
      	}
		%>
         ]

      });

   });
</script>
</head>
<body>
<form name="f1">
<table width=100% border=0>  
<tr>
<td align=center width="100%"  class=tablebold>
Bar Chart</td>
<td align=center >
</td>
</tr>
<tr>
<td>
<div id="container" style="width: 98%; height: 500px"></div>
</td>
</tr>
<tr>
<td align=center class=tablebold>
Line Chart
</td>
</tr>
<tr>
<td>
<div id="linediv" style="width: 98%; height: 500px"></div>      
</td>
</tr>
</table>

</form>
</body>
</html>  