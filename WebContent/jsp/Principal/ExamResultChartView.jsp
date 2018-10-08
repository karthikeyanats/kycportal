<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/highcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/gray.js"></script>
<script type="text/javascript" src="../js/modules/exporting.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery"%>

       		
      <%
      PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
		StringBuffer head=new StringBuffer();
		
		String sessionid=session.getValue("sessionid")+"";
		
		String courseid=request.getParameter("course");
				
		String secSchedId=request.getParameter("sectionpubid");
				
		ArrayList registeredList= null;
		ArrayList GradeList= null;
		//registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentList(secSchedId);
	   
			String examname="";

HashMap markvalue=new HashMap();
int count =0;
ArrayList ExamList = null;

		    try{

				com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
				ExamList=registrationQuery.loadAllotedExamforSession(sessionid);
				if(ExamList!=null && ExamList.size()>0)
				{
					String tempexam="";
					for(int x=0,xx=0;x<ExamList.size();x++)
					{
						
										HashMap exammap=(HashMap)ExamList.get(x);
										String examnameid=exammap.get("examnameid")+"";
										if(!tempexam.equals(examnameid))
										{
										String totalmark="";
									    int rangetotal []=null;
									    int rangecount []=null;
							    		registeredList	=	(ArrayList)examAllotmentQuery.LoadExamMarkForChart(examnameid,courseid,secSchedId);
							    		
							    		if(registeredList.size()!=0)
										{
									    	examname +=exammap.get("examname")+"','";
												for(int i=0,s=1;i<registeredList.size();i++)
													{
														HashMap map=(HashMap)registeredList.get(i);
														String total=map.get("total")+"";
														totalmark=map.get("totalmark")+"";
														if(count<(Integer.parseInt(totalmark)/100))
														count=Integer.parseInt(totalmark)/100;
													}
												rangecount=new int [(Integer.parseInt(totalmark)/100)];
												rangetotal=new int [(Integer.parseInt(totalmark)/100)];
												for(int i=0;i<rangetotal.length;i++)
												{
													rangecount[i]=0;
												}
												for(int i=0;i<rangetotal.length;i++)
												{
													if(i==0)
													rangetotal[i]=0+100;
													else
													rangetotal[i]=rangetotal[i-1]+100;
							
												}
											}
										int testtotal=0;
							
									   	if(registeredList.size()!=0)
										{
							
											for(int i=0;i<registeredList.size();i++)
												{			
													testtotal++;
													HashMap map=(HashMap)registeredList.get(i);
													int total=Integer.parseInt(map.get("total")+"");
													for(int j=0;j<rangetotal.length;j++)
													{
														if(((rangetotal[j]-100)<=total) && (total<=rangetotal[j]))
														{
															rangecount[j]++;  
														}
													}
												}
										markvalue.put("exam"+xx,rangecount);
										xx++;

										}
										tempexam=examnameid;
								}
					}
					/*for(int i=0;i<count;i++)
					{
						String totalno="";
						out.println("{name: '"+i+"01 - "+(i+1)+"00',data: [");
						for(int y=0;y<markvalue.size();y++)
						{
							int [] innerarray=(int [])markvalue.get("exam"+y);
							try{
								totalno +=innerarray[i]+",";
								}
							catch(Exception e)
							{			
								totalno +="0,"; 
							}
						}
						totalno=totalno.substring(0,totalno.lastIndexOf(","));
						if(i!=count-1)
						out.println(totalno+"]},");
						else
							out.println(totalno+"]}");
					}*/
		    }
		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
		  %>
		 		<script type="text/javascript">

			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						defaultSeriesType: 'column'
					},
					title: {
						text: 'Stacked Bar Chart'
					},
					xAxis: {
						categories: ['<%=examname%>']
					},
					yAxis: {
						min: 0,
						title: {
							text: 'Total No of Student'
						},
						stackLabels: {
							enabled: true,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						}
					},
					legend: {
						align: 'right',
						x: -100,
						verticalAlign: 'top',
						y: 20,
						floating: true,
						backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
						borderColor: '#CCC',
						borderWidth: 1,
						shadow: false
					},
					tooltip: {
						formatter: function() {
							return '<b>'+ this.x +'</b><br/>'+
								 this.series.name +': '+ this.y +'<br/>'+
								 'Total: '+ this.point.stackTotal;
						}
					},
					plotOptions: {
						column: {
							stacking: 'normal',
							dataLabels: {
								enabled: true,
								color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
							}
						}
					},
				    series: [
				    <%
				    for(int i=0;i<count;i++)
					{
						String totalno="";
						if(i==0)
							out.println("{name: '"+i+" - "+(i+1)+"00',data: [");
						else
							out.println("{name: '"+i+"01 - "+(i+1)+"00',data: [");

						
						for(int y=0;y<markvalue.size();y++)
						{
							int [] innerarray=(int [])markvalue.get("exam"+y);
							try{
								totalno +=innerarray[i]+",";
								}
							catch(Exception e)
							{			
								totalno +="0,"; 
							}
						}
						totalno=totalno.substring(0,totalno.lastIndexOf(","));
						if(i!=count-1)
						out.println(totalno+"]},");
						else
							out.println(totalno+"]}");
					}
%>
					]
				});


			});

		</script>
		</head>
		<body topmargin="0" bottommargin="0">
		<%if(ExamList.size()!=0)
		{ %>
		<div id="container" style="width: 675px; height: 380px; margin: 0 auto"></div>
		<%}
		else
		{
			out.println("<center class=tablebold><font color=red>Data Not Found</font></center>");
		}%>
</body>
</html>
       	