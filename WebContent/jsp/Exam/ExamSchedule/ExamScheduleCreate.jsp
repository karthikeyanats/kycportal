<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examscheduleparent.entrytitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0;
	
	function loadBoard()
	{
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		//document.Schedule_Form.submit(); 
	}
	 
	function loadExam()
	{
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}

	function loadStandard()
	{
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}
	function loadSubjects()
	{
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
		document.Schedule_Form.submit();
	}
	

	
	
	
	function checkCount(obj)
	{
		var pos	= obj.getAttribute("pos");
		var durationId = 'durationid'+pos;
		var flag = true;
		var schedPosSplit;
		var betweenFlagVal;
		var fullFlagVal = true;

		if(document.Schedule_Form.checkstandard.length==undefined)
		{
			if(document.Schedule_Form.checkstandard.checked==true)
			{
				if(check_ForParticularElements(document.Schedule_Form.examdates,"text",document.Schedule_Form.starttime1,"text",document.Schedule_Form.starttime2,"text",document.Schedule_Form.endtime1,"text",document.Schedule_Form.endtime2,"text"))
				{

/////////////////////////////////
				var convStartHr = document.Schedule_Form.starttime1.value;
				var convEndHr = document.Schedule_Form.endtime1.value;
				if(document.Schedule_Form.ampm1.value == "pm"){
					if(parseInt(document.Schedule_Form.starttime1.value,10)<12)
						convStartHr = parseInt(document.Schedule_Form.starttime1.value,10) + 12;			
				}
				else{
					if(parseInt(document.Schedule_Form.starttime1.value,10)==12)
						convStartHr = "00";
				}
				
				if(document.Schedule_Form.ampm2.value == "pm"){
					if(parseInt(document.Schedule_Form.endtime1.value,10)<12)
						convEndHr = parseInt(document.Schedule_Form.endtime1.value,10) + 12;			
				}
				else{
					if(parseInt(document.Schedule_Form.endtime1.value,10)==12)
						convEndHr = "00";
				}		
		
		//alert(convStartHr+":"+startmin[pos].value)		
		
				document.Schedule_Form.starttime.value		= convStartHr+":"+document.Schedule_Form.starttime2.value	 
				document.Schedule_Form.endtime.value		= convEndHr+":"+document.Schedule_Form.endtime2.value
	
////////////////////////////////
				var validateStarttime		= document.Schedule_Form.starttime1.value+":"+document.Schedule_Form.starttime2.value	 
				var validateEndtime		= document.Schedule_Form.endtime1.value+":"+document.Schedule_Form.endtime2.value	
//alert(document.Schedule_Form.starttime.value+"--"+document.Schedule_Form.endtime.value)
				var starttime = validateHhMm(validateStarttime,"Start");
				if(starttime)
					var endtime = validateHhMm(validateEndtime,"End");
				if(endtime)
				var timeFlag = validateTimeEntry(document.Schedule_Form.starttime.value,document.Schedule_Form.endtime.value);
			
				if(timeFlag){
				var calculateStarttime		= document.Schedule_Form.starttime.value.split(":")[0];
				var calculateEndtime		= document.Schedule_Form.endtime.value.split(":")[0];
				document.Schedule_Form.duration.value 		= calculateDuration(calculateStarttime,document.Schedule_Form.starttime2.value,calculateEndtime,document.Schedule_Form.endtime2.value);
				document.Schedule_Form.examdates.disabled 	= true;
				document.Schedule_Form.calButton.disabled 	= true;						
				document.Schedule_Form.starttime1.disabled 	= true;
				document.Schedule_Form.starttime2.disabled 	= true;
				document.Schedule_Form.endtime1.disabled 	= true;
				document.Schedule_Form.endtime2.disabled 	= true;
				document.Schedule_Form.ampm1.disabled 		= true;
				document.Schedule_Form.ampm2.disabled 		= true;						
				
				
				//var starthhmm = document.Schedule_Form.starttime1.value+":"+startmin[pos].value;
				//var endhhmm = document.Schedule_Form.endtime1.value+":"+endmin[pos].value;				
				var spanvalue		= document.getElementById("durationid0");
				spanvalue.innerHTML = document.Schedule_Form.duration.value;
				}
				else
				{
					obj.checked = false;
				}
				}
				else
				{
					obj.checked = false;
				}			
			}
			else
			{
					document.Schedule_Form.examdates.disabled 		= false;
					document.Schedule_Form.calButton.disabled 		= false;						
					document.Schedule_Form.starttime1.disabled 		= false;
					document.Schedule_Form.starttime2.disabled 		= false;
					document.Schedule_Form.endtime1.disabled 		= false;
					document.Schedule_Form.endtime2.disabled 		= false;
					document.Schedule_Form.ampm1.disabled 			= false;
					document.Schedule_Form.ampm2.disabled 			= false;						
			
				//alert("Select CheckBox")
			}		
		}		
		else{
		//alert("pos-->"+pos);
		//var values=document.forms["Schedule_Form"].elements["examdates"];
		//alert("values-->"+values[pos].value);
		
		var startampm = document.forms["Schedule_Form"].elements["ampm1"];
		var endampm = document.forms["Schedule_Form"].elements["ampm2"];
				
		var starthour=document.forms["Schedule_Form"].elements["starttime1"];
	
		var startmin=document.forms["Schedule_Form"].elements["starttime2"];
		//alert("values-->"+startmin[pos].value);		

		var endhour=document.forms["Schedule_Form"].elements["endtime1"];
		//alert("values-->"+endhour[pos].value);
	
		var endmin=document.forms["Schedule_Form"].elements["endtime2"];
		//alert("values-->"+endmin[pos].value);
		
		//alert(parseInt(starthour[pos].value)+12);
		var convStartHr = starthour[pos].value;
		var convEndHr = endhour[pos].value;
		if(startampm[pos].value == "pm"){
			if(parseInt(starthour[pos].value,10)<12)
				convStartHr = parseInt(starthour[pos].value,10) + 12;			
		}
		else{
			if(parseInt(starthour[pos].value,10)==12)
				convStartHr = "00";
		}
		
		if(endampm[pos].value == "pm"){
			if(parseInt(endhour[pos].value,10)<12)
				convEndHr = parseInt(endhour[pos].value,10) + 12;			
		}
		else{
			if(parseInt(endhour[pos].value,10)==12)
				convEndHr = "00";
		}		

//alert(convStartHr+":"+startmin[pos].value)		

		
		var starthhmm = convStartHr+":"+startmin[pos].value;
		var endhhmm = convEndHr+":"+endmin[pos].value;		
		//var starthhmm = starthour[pos].value+":"+startmin[pos].value;
		//var endhhmm = endhour[pos].value+":"+endmin[pos].value;		
		//alert("starthhmm-->"+starthhmm+"endhhmm-->"+endhhmm);
		//validateHhMm(starthhmm,"Start");
		//validateHhMm(endhhmm,"End");
		//validateTimeEntry(starthhmm,endhhmm);
				
		if(obj.checked)
		{
		//alert(document.Schedule_Form.starttime[pos].value);
			if(check_ForParticularElements(document.Schedule_Form.examdates[pos],"text",document.Schedule_Form.starttime1[pos],"text",document.Schedule_Form.starttime2[pos],"text",document.Schedule_Form.endtime1[pos],"text",document.Schedule_Form.endtime2[pos],"text")){
			
		//var values=document.forms["Schedule_Form"].elements["examdates"];
		//alert("values-->"+values[pos].value);
		
		var starthour=document.forms["Schedule_Form"].elements["starttime1"];
		//alert("values-->"+starthour[pos].value);
	
		var startmin=document.forms["Schedule_Form"].elements["starttime2"];
		//alert("values-->"+startmin[pos].value);		

		var endhour=document.forms["Schedule_Form"].elements["endtime1"];
		//alert("values-->"+endhour[pos].value);
	
		var endmin=document.forms["Schedule_Form"].elements["endtime2"];
		//alert("values-->"+endmin[pos].value);
		
		var convStartHr = starthour[pos].value;
		var convEndHr = endhour[pos].value;
		if(startampm[pos].value == "pm"){
		//alert(parseInt(starthour[pos].value,10));
			if(parseInt(starthour[pos].value,10)<12)
				convStartHr = parseInt(starthour[pos].value,10) + 12;			
		}
		else{
			if(parseInt(starthour[pos].value,10)==12)
				convStartHr = "00";
		}
		
		if(endampm[pos].value == "pm"){
			if(parseInt(endhour[pos].value,10)<12)
				convEndHr = parseInt(endhour[pos].value,10) + 12;			
		}
		else{
			if(parseInt(endhour[pos].value,10)==12)
				convEndHr = "00";
		}		

//alert(convStartHr+":"+startmin[pos].value)		
//alert(convStartHr+"--"+convEndHr)
		
		var starthhmm = convStartHr+":"+startmin[pos].value;
		var endhhmm = convEndHr+":"+endmin[pos].value;		
		
		var starthhmm1 = starthour[pos].value+":"+startmin[pos].value;
		var endhhmm1 = endhour[pos].value+":"+endmin[pos].value;		
		//alert("starthhmm-->"+starthhmm+"endhhmm-->"+endhhmm);
			var starttime = validateHhMm(starthhmm1,"Start");
			if(starttime)
				var endtime = validateHhMm(endhhmm1,"End");
			if(endtime){
				var timeFlag = validateTimeEntry(starthhmm,endhhmm);
		
		
		if(timeFlag){

		var scheddateArr = document.Schedule_Form.schedDates.value.split("@");
		//alert(scheddateArr[1])
		//alert(document.Schedule_Form.schedPos.value)
		if(document.Schedule_Form.schedPos.value != ""){
			//alert(document.Schedule_Form.schedPos.value)
			var schedPosArr = document.Schedule_Form.schedPos.value.split("@");
		//alert(schedPosArr[1]);
		for(var schedPosCount=1;schedPosCount<=(schedPosArr.length-1);schedPosCount++)
		{
		//alert("schedPosCount-->"+schedPosCount)
			schedPosSplit  = schedPosArr[schedPosCount];
		//alert("schedPosSplit-->"+schedPosSplit)
		//alert(document.Schedule_Form.examdates[schedPosSplit].value.length+"=="+document.Schedule_Form.examdates[pos].value.length);

			if(document.Schedule_Form.examdates[schedPosSplit].value.length==10)
				document.Schedule_Form.examdates[schedPosSplit].value = "0"+document.Schedule_Form.examdates[schedPosSplit].value;	
			if(document.Schedule_Form.examdates[pos].value.length==10)
				document.Schedule_Form.examdates[pos].value = "0"+document.Schedule_Form.examdates[pos].value;	
				
			if(document.Schedule_Form.examdates[schedPosSplit].value==document.Schedule_Form.examdates[pos].value)
			{
				//alert("Already Scheduled for the Same Date");
					var betweenFlag = true;
					var starttimeFull = document.Schedule_Form.starttime1[schedPosSplit].value+document.Schedule_Form.starttime2[schedPosSplit].value;
					var endtimeFull = document.Schedule_Form.endtime1[schedPosSplit].value+document.Schedule_Form.endtime2[schedPosSplit].value;
////////////////////////////////////					
					//alert(document.Schedule_Form.ampm1[pos].value)
					//alert(document.Schedule_Form.ampm2[pos].value)
					
		var convStartHrCur = document.Schedule_Form.starttime1[pos].value;
		var convEndHrCur = document.Schedule_Form.endtime1[pos].value;
		
		if(document.Schedule_Form.ampm1[pos].value == "pm"){
			if(parseInt(document.Schedule_Form.starttime1[pos].value,10)<12)
				convStartHrCur = parseInt(document.Schedule_Form.starttime1[pos].value,10) + 12;			
		}
		else{
			if(parseInt(document.Schedule_Form.starttime1[pos].value,10)==12)
				convStartHrCur = "00";
		}
		
		if(document.Schedule_Form.ampm2[pos].value == "pm"){
			if(parseInt(document.Schedule_Form.endtime1[pos].value,10)<12)
				convEndHrCur = parseInt(document.Schedule_Form.endtime1[pos].value,10) + 12;			
		}
		else{
			if(parseInt(document.Schedule_Form.endtime1[pos].value,10)==12)
				convEndHrCur = "00";
		}
//////////////////////////////////////							
					var starttimeFullCur = convStartHrCur+document.Schedule_Form.starttime2[pos].value;
					var endtimeFullCur = convEndHrCur+document.Schedule_Form.endtime2[pos].value;
					//var starttimeFullCur = document.Schedule_Form.starttime1[pos].value+document.Schedule_Form.starttime2[pos].value;
					//var endtimeFullCur = document.Schedule_Form.endtime1[pos].value+document.Schedule_Form.endtime2[pos].value;

					//alert("starttimeFull-->"+starttimeFull+"endtimeFull-->"+endtimeFull);
					//alert("starttimeFullCur-->"+starttimeFullCur+"endtimeFullCur-->"+endtimeFullCur);

					//Number.prototype.between = function(parseInt(starttimeFull),parseInt(endtimeFull)){
    						//return (parseInt(starttimeFull) < parseInt(endtimeFull) ? parseInt(starttimeFullCur) >= parseInt(starttimeFull) && parseInt(starttimeFullCur) <= parseInt(endtimeFull) : parseInt(starttimeFullCur) >= parseInt(endtimeFull) && parseInt(starttimeFullCur) <= parseInt(starttimeFull));
					//}				
					Number.prototype.between = function(a,b){
    						return (this>=a&&this<=b)?false:true;
					}
					//alert(new Number(parseInt(starttimeFullCur)).between(parseInt(starttimeFull),parseInt(endtimeFull)));
					//alert(new Number(parseInt(endtimeFullCur)).between(parseInt(starttimeFull),parseInt(endtimeFull)));
					//alert(parseInt(endtimeFullCur)-parseInt(starttimeFullCur))

					for(var betCount=parseInt(starttimeFullCur,10);betCount<parseInt(endtimeFullCur,10);betCount++)
					{
							for(var betCount1=parseInt(starttimeFull,10);betCount1<parseInt(endtimeFull,10);betCount1++)
							{
									if(betCount==betCount1)
										betweenFlag = false;
							}
							
					}
			
					if(new Number(parseInt(starttimeFullCur,10)).between(parseInt(starttimeFull,10),parseInt(endtimeFull,10)) && new Number(parseInt(endtimeFullCur,10)).between(parseInt(starttimeFull,10),parseInt(endtimeFull,10)) && betweenFlag)
					{
							//alert("true");
							betweenFlagVal = true;
					}
					else
					{
							//alert("false");
							betweenFlagVal = false;
							obj.checked = false;
					}
//alert("betweenFlagVal-->"+betweenFlagVal)						
					if(!betweenFlagVal)
						fullFlagVal = 	false;
					count++;				
				//obj.checked = false;
				count++;
			}		
		}
		
		//alert("schedPosArr'len-->"+schedPosArr.length)
		}
		////////////////////////////////////////////////////////////////////////////////////////////////		
		for(var examDateCount=0;examDateCount<document.Schedule_Form.examdates.length;examDateCount++)
		{
		//alert("examDateCount-->"+examDateCount+"checked-->"+document.Schedule_Form.checkstandard[examDateCount].checked)
			if(examDateCount!=pos && document.Schedule_Form.examdates[examDateCount].value!=""){
			//alert("examDateCount1-->"+examDateCount+"document.Schedule_Form.examdates[examDateCount].checked-->"+document.Schedule_Form.examdates[examDateCount].checked);
				if(document.Schedule_Form.checkstandard[examDateCount].checked){
				
				if(document.Schedule_Form.examdates[examDateCount].value.length==10)
					document.Schedule_Form.examdates[examDateCount].value = "0"+document.Schedule_Form.examdates[examDateCount].value;	
				if(document.Schedule_Form.examdates[pos].value.length==10)
					document.Schedule_Form.examdates[pos].value = "0"+document.Schedule_Form.examdates[pos].value;
						
				//alert("examDateCountPos1-->"+examDateCount+"examDateCountFlag"+document.Schedule_Form.examdates[examDateCount].checked);
				//alert(document.Schedule_Form.examdates[examDateCount].value+"--"+document.Schedule_Form.examdates[pos].value)
				if(document.Schedule_Form.examdates[examDateCount].value==document.Schedule_Form.examdates[pos].value)
				{
					//alert("Already Checked for the Same Date");
					//alert(document.Schedule_Form.starttime1[examDateCount].value)
					//alert(document.Schedule_Form.starttime2[examDateCount].value)
					//alert(document.Schedule_Form.endtime1[examDateCount].value)
					//alert(document.Schedule_Form.endtime2[examDateCount].value)
					
					//alert(document.Schedule_Form.starttime1[pos].value)
					//alert(document.Schedule_Form.starttime2[pos].value)
					//alert(document.Schedule_Form.endtime1[pos].value)
					//alert(document.Schedule_Form.endtime2[pos].value)
					var betweenFlag = true;

					var convStartTimeFull = document.Schedule_Form.starttime1[examDateCount].value;
					var convEndTimeFull = document.Schedule_Form.endtime1[examDateCount].value;
					
					if(document.Schedule_Form.ampm1[examDateCount].value == "pm"){
						if(parseInt(document.Schedule_Form.starttime1[examDateCount].value,10)<12)
							convStartTimeFull = parseInt(document.Schedule_Form.starttime1[examDateCount].value,10) + 12;			
					}
					else{
						if(parseInt(document.Schedule_Form.starttime1[examDateCount].value,10)==12)
							convStartTimeFull = "00";
					}
					
					if(document.Schedule_Form.ampm2[examDateCount].value == "pm"){
						if(parseInt(document.Schedule_Form.endtime1[examDateCount].value,10)<12)
							convEndTimeFull = parseInt(document.Schedule_Form.endtime1[examDateCount].value,10) + 12;			
					}
					else{
						if(parseInt(document.Schedule_Form.endtime1[examDateCount].value,10)==12)
							convEndTimeFull = "00";
					}
					
					var starttimeFull = convStartTimeFull+document.Schedule_Form.starttime2[examDateCount].value;
					var endtimeFull = convEndTimeFull+document.Schedule_Form.endtime2[examDateCount].value;					
///////////////////////////////////////////////////

					//var starttimeFull = document.Schedule_Form.starttime1[examDateCount].value+document.Schedule_Form.starttime2[examDateCount].value;
					//var endtimeFull = document.Schedule_Form.endtime1[examDateCount].value+document.Schedule_Form.endtime2[examDateCount].value;
////////////////////////////////////
					//var starttimeFull = document.Schedule_Form.starttime1[examDateCount].value+document.Schedule_Form.starttime2[examDateCount].value;
					//var endtimeFull = document.Schedule_Form.endtime1[examDateCount].value+document.Schedule_Form.endtime2[examDateCount].value;
////////////////////////////////////					
					//alert(document.Schedule_Form.ampm1[pos].value)
					//alert(document.Schedule_Form.ampm2[pos].value)
					
		var convStartHrCur = document.Schedule_Form.starttime1[pos].value;
		var convEndHrCur = document.Schedule_Form.endtime1[pos].value;
		
		if(document.Schedule_Form.ampm1[pos].value == "pm"){
			if(parseInt(document.Schedule_Form.starttime1[pos].value,10)<12)
				convStartHrCur = parseInt(document.Schedule_Form.starttime1[pos].value,10) + 12;			
		}
		else{
			if(parseInt(document.Schedule_Form.starttime1[pos].value,10)==12)
				convStartHrCur = "00";
		}
		
		if(document.Schedule_Form.ampm2[pos].value == "pm"){
			if(parseInt(document.Schedule_Form.endtime1[pos].value,10)<12)
				convEndHrCur = parseInt(document.Schedule_Form.endtime1[pos].value,10) + 12;			
		}
		else{
			if(parseInt(document.Schedule_Form.endtime1[pos].value,10)==12)
				convEndHrCur = "00";
		}
//////////////////////////////////////							
					var starttimeFullCur = convStartHrCur+document.Schedule_Form.starttime2[pos].value;
					var endtimeFullCur = convEndHrCur+document.Schedule_Form.endtime2[pos].value;
					//alert("starttimeFull-->"+starttimeFull+"endtimeFull-->"+endtimeFull);
					//alert("starttimeFullCur-->"+starttimeFullCur+"endtimeFullCur-->"+endtimeFullCur);

					//Number.prototype.between = function(parseInt(starttimeFull),parseInt(endtimeFull)){
    						//return (parseInt(starttimeFull) < parseInt(endtimeFull) ? parseInt(starttimeFullCur) >= parseInt(starttimeFull) && parseInt(starttimeFullCur) <= parseInt(endtimeFull) : parseInt(starttimeFullCur) >= parseInt(endtimeFull) && parseInt(starttimeFullCur) <= parseInt(starttimeFull));
					//}				
					Number.prototype.between = function(a,b){
    						return (this>=a&&this<=b)?false:true;
					}
					//alert(new Number(parseInt(starttimeFullCur)).between(parseInt(starttimeFull),parseInt(endtimeFull)));
					//alert(new Number(parseInt(endtimeFullCur)).between(parseInt(starttimeFull),parseInt(endtimeFull)));
					//alert(parseInt(endtimeFullCur)-parseInt(starttimeFullCur))

					for(var betCount=parseInt(starttimeFullCur,10);betCount<parseInt(endtimeFullCur,10);betCount++)
					{
							for(var betCount1=parseInt(starttimeFull,10);betCount1<parseInt(endtimeFull,10);betCount1++)
							{
									if(betCount==betCount1)
										betweenFlag = false;
							}
							
					}
			
					if(new Number(parseInt(starttimeFullCur,10)).between(parseInt(starttimeFull,10),parseInt(endtimeFull,10)) && new Number(parseInt(endtimeFullCur,10)).between(parseInt(starttimeFull,10),parseInt(endtimeFull,10)) && betweenFlag)
					{
							//alert("true");
							betweenFlagVal = true;
					}
					else
					{
							//alert("false");
							betweenFlagVal = false;
							obj.checked = false;
					}
//alert("betweenFlagVal-->"+betweenFlagVal)						
					if(!betweenFlagVal)
						fullFlagVal = 	false;
					count++;
				}
				}
			}
		}
		//alert("fullFlagVal-->"+fullFlagVal)
		flag = fullFlagVal;
		}
		else
		{
		flag = false;
		}
				if(!timeFlag){
				obj.checked = false;
				}
				
				else if(flag){				
						document.Schedule_Form.examdates[pos].disabled 		= true;
						document.Schedule_Form.calButton[pos].disabled 		= true;						
						document.Schedule_Form.starttime1[pos].disabled 	= true;
						document.Schedule_Form.starttime2[pos].disabled 	= true;
						document.Schedule_Form.endtime1[pos].disabled 		= true;
						document.Schedule_Form.endtime2[pos].disabled 		= true;
						document.Schedule_Form.ampm1[pos].disabled 			= true;
						document.Schedule_Form.ampm2[pos].disabled 			= true;
						document.Schedule_Form.starttime[pos].value 		= starthhmm;
						document.Schedule_Form.endtime[pos].value 			= endhhmm;
						document.Schedule_Form.duration[pos].value 			= calculateDuration(starthhmm.split(":")[0],startmin[pos].value,endhhmm.split(":")[0],endmin[pos].value);
						//document.Schedule_Form.duration[pos].value 		= calculateDuration(starthour[pos].value,startmin[pos].value,endhour[pos].value,endmin[pos].value);
						
						var spanvalue		= document.getElementById(durationId);
						spanvalue.innerHTML = document.Schedule_Form.duration[pos].value;										
					count++;
					}
				else{
				alert("Exam Time conflicting with each other");
				obj.checked = false;				
				}	
			}
			else
			{
				obj.checked = false;
			}
			}
			else{

				obj.checked = false;
			}
		}
		else
		{
			document.Schedule_Form.examdates[pos].disabled 		= false;
			document.Schedule_Form.calButton[pos].disabled 		= false;						
			document.Schedule_Form.starttime1[pos].disabled 	= false;
			document.Schedule_Form.starttime2[pos].disabled 	= false;
			document.Schedule_Form.endtime1[pos].disabled 		= false;
			document.Schedule_Form.endtime2[pos].disabled 		= false;
			document.Schedule_Form.ampm1[pos].disabled 			= false;
			document.Schedule_Form.ampm2[pos].disabled 			= false;			
			count--;
		}
		//alert(count)
		}
	}
	
	function scheduleExam()
	{
	var checkCount = 0;
	
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
				{
					if(document.Schedule_Form.checkstandard[i].checked)
					{
					checkCount++;
					}
				}
		//if(count>0)
		if(document.Schedule_Form.checkstandard.length==undefined)
		{
			if(document.Schedule_Form.checkstandard.checked==true)
			{
				if(confirm("Are you sure want to schedule the Exam?"))
				{
						document.Schedule_Form.examdates.disabled 		= false;
						document.Schedule_Form.action = "ExamscheduleSubmit.jsp";
						document.Schedule_Form.submit();
				}
			}
			else
			{
				alert("Select CheckBox")
			}
		}

		else
		{
		if(checkCount>0)
			{
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
				{
					if(!document.Schedule_Form.checkstandard[i].checked)
					{
						document.Schedule_Form.examdates[i].disabled 	= true;
						document.Schedule_Form.starttime1[i].disabled 	= true;
						document.Schedule_Form.starttime2[i].disabled 	= true;
						document.Schedule_Form.endtime1[i].disabled 	= true;
						document.Schedule_Form.endtime2[i].disabled 	= true;
						document.Schedule_Form.duration[i].disabled 	= true;	
						//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
						
					}
					else
					{
						checkCount++;
					}

				}

					if(confirm("Are you sure want to schedule the Exam?")){
					
							//document.Schedule_Form.req_sessionid.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
							//document.Schedule_Form.req_sessionname.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
							document.Schedule_Form.req_boardid.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
							document.Schedule_Form.req_boardname.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
							document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
							document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
							document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
							document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
						
						for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
						{
							if(!document.Schedule_Form.checkstandard[i].checked)
							{
								document.Schedule_Form.examdates[i].disabled 	= true;
								document.Schedule_Form.starttime1[i].disabled 	= true;
								document.Schedule_Form.starttime2[i].disabled 	= true;
								document.Schedule_Form.endtime1[i].disabled 	= true;
								document.Schedule_Form.endtime2[i].disabled 	= true;
								document.Schedule_Form.duration[i].disabled 	= true;	
								//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
								
							}
							else
							{
								document.Schedule_Form.examdates[i].disabled 	= false;
								checkCount++;
							}
		
						}
						document.Schedule_Form.action = "ExamscheduleSubmit.jsp";
						document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Select Check Box");			
			}
		}
	}
	
	function selectallfun()
	{
		if(document.Schedule_Form.checkstandard.length == null)
			{
				document.Schedule_Form.checkstandard.checked=true;
			}
			else
			{
				for(var x=0;x<document.Schedule_Form.checkstandard.length;x++)
					{
						document.Schedule_Form.checkstandard[x].checked=true;
					}
			}
	}
	function deselectallfun()
	{
		if(document.Schedule_Form.checkstandard.length == null)
			{
				document.Schedule_Form.checkstandard.checked=false;
			}
		else
			{
				for(var x=0;x<document.Schedule_Form.checkstandard.length;x++)
					{
						document.Schedule_Form.checkstandard[x].checked=false;
					}
			}
	}
function validateTimeEntry1(start_time_entry,end_time_entry)
{
     setFlag = check_ForEmpty(start_time_entry.value);

      if(setFlag)
       {
	 setFlag = check_TimeEntry(start_time_entry.value,"Start");
	 if(setFlag)
	 {
           // for valid start time format

           setFlag = check_ForEmpty(end_time_entry.value);

           if(setFlag)
           {
               // for valid start time format and un checked endtime
	       setFlag = check_TimeEntry(end_time_entry.value,"End");

		 if(setFlag)
		 {

		    // for valid end time format
		    // to check if endtime > starttime
		    var stime_str=start_time_entry.value.toString();
		    var etime_str=end_time_entry.value.toString();
		    var stime=stime_str.split(":");
		    var etime=etime_str.split(":");
		    stime=new Number(stime[0]+stime[1]);
		    etime=new Number(etime[0]+etime[1]);


		    if(etime > stime)

		    {
		    // if the start time and end time is valid by all means
		      setDuration = true;
		      end_time_entry.disabled = true;
		      end_time_entry.className="tablehead_disabled"
		      start_time_entry.disabled = true;
		      start_time_entry.className="tablehead_disabled"
		    }
		    else
		        {
		        // if endtime < starttime

		           end_time_entry.focus();
		           end_time_entry.value = "";
		           setDuration = false;
		           alert(" The end time is not negotiable with the start time ! ");

		         }

		 }
		 else // if invalid time format
		 {
	       	     if(setFlag != 0)


	     	     end_time_entry.value = "";
	     	     end_time_entry.focus();
	             setDuration = false;
	             alert("Invalid time format");
		 }
	     }
	     else
	     {
		end_time_entry.focus();
		setDuration = false;
		alert("Empty end time is not allowed");
	     }
	 }
	 else
	 {
	     if(setFlag != 0)
	       alert("Invalid date format");

	     end_time_entry.value = "";
	     start_time_entry.value = "";
	     start_time_entry.focus();
	     setDuration = false;
	 }
     }
     else
     {
	 end_time_entry.value = "";
	 start_time_entry.focus();
	 setDuration = false;
	 alert("Empty start time is not allowed");
     }
   return setDuration;
}


function editSchedule()
{

		//document.Schedule_Form.req_sessionid.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		//document.Schedule_Form.req_sessionname.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	//if(confirm("Are you sure want to Edit the Scheduled Exam?"))
	{
		document.Schedule_Form.action = "ExamScheduleEdit.jsp";
		document.Schedule_Form.submit();
	}

}

function trashSchedule()
{
		if(check_ForParticularElements(document.Schedule_Form.boardname,"select",document.Schedule_Form.examname,"select",document.Schedule_Form.course,"select")){
		//document.Schedule_Form.req_sessionid.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		//document.Schedule_Form.req_sessionname.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	//if(confirm("Are you sure want to Trash the Scheduled Exam?"))
	{
		document.Schedule_Form.action = "ExamScheduleTrash.jsp";
		document.Schedule_Form.submit();
	}
	}

}

    function validateHhMm(inputField,timeVal) {
//alert(inputField)    
        //var isValid = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField);
        //var isValid = /^([0-1]?[0-2]|1[0-2]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField);
        var isValid = /^(1[012]|0[1-9]|[1-9]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField);


//alert(isValid)
        if (isValid) {
            //inputField.style.backgroundColor = '#bfa';
        } else {
        	alert("Invalid "+timeVal+" Time")
            //inputField.style.backgroundColor = '#fba';
        }

        return isValid;
    }

function validateTimeEntry(start_time_entry,end_time_entry)
{
//alert(start_time_entry+"---"+end_time_entry)
		var setFlag = true;
		var setDuration;
      if(setFlag)
       {
	 //setFlag = check_TimeEntry(start_time_entry.value,"Start");
	 if(setFlag)
	 {
           // for valid start time format

           //setFlag = check_ForEmpty(end_time_entry.value);

           if(setFlag)
           {
               // for valid start time format and un checked endtime
	       //setFlag = check_TimeEntry(end_time_entry.value,"End");

		 if(setFlag)
		 {

		    // for valid end time format
		    // to check if endtime > starttime
		    var stime_str=start_time_entry;
		    var etime_str=end_time_entry;
		    var stime=stime_str.split(":");
		    var etime=etime_str.split(":");
		    stime=new Number(stime[0]+stime[1]);
		    etime=new Number(etime[0]+etime[1]);


		    if(etime > stime)

		    {
		    //alert("OK")
		    // if the start time and end time is valid by all means
		      setDuration = true;
		      end_time_entry.disabled = true;
		      end_time_entry.className="tablehead_disabled"
		      start_time_entry.disabled = true;
		      start_time_entry.className="tablehead_disabled"
		    }
		    else
		        {
		        // if endtime < starttime
				//alert("endtime < starttime")	
		           //end_time_entry.focus();
		           //end_time_entry.value = "";
		           setDuration = false;
		           alert("End Time should be greater than Start Time!");

		         }

		 }
		 else // if invalid time format
		 {
	       	     if(setFlag != 0)

				alert("Invalid");
	     	     //end_time_entry.value = "";
	     	     //end_time_entry.focus();
	             setDuration = false;
	             alert("Invalid time format");
		 }
	     }
	     else
	     {
	     alert("Empty end time");
		//end_time_entry.focus();
		setDuration = false;
		alert("Empty end time is not allowed");
	     }
	 }
	 else
	 {
	     if(setFlag != 0)
	       alert("Invalid date format");

	     //end_time_entry.value = "";
	     //start_time_entry.value = "";
	     //start_time_entry.focus();
	     setDuration = false;
	 }
     }
     else
     {
	 //end_time_entry.value = "";
	 //start_time_entry.focus();
	 setDuration = false;
	 alert("Empty start time is not allowed");
     }
   return setDuration;
}	

// sub functon to calculate the the duration of exam

function calculateDuration(starthour,startmin,endhour,endmin)
{
//alert(starthour+":"+startmin+"--"+endhour+":"+endmin);
	 var e_suffix_hr = endhour;
	 var e_suffix_mn = endmin;
	 var s_suffix_hr = starthour;
	 var s_suffix_mn = startmin;

     if(e_suffix_hr.charAt(0) == "0")
         e_suffix_hr = e_suffix_hr.charAt(1);

     if(e_suffix_mn.charAt(0) == "0")
         e_suffix_mn = e_suffix_mn.charAt(1);

     if(s_suffix_hr.charAt(0) == "0")
         s_suffix_hr = s_suffix_hr.charAt(1);

     if(s_suffix_mn.charAt(0) == "0")
         s_suffix_mn = s_suffix_mn.charAt(1);

		 hrsdiff  = new Number(e_suffix_hr) - new Number(s_suffix_hr);
		 mindiff  = new Number(e_suffix_mn) - new Number(s_suffix_mn);
	
		 mindiff1 = hrsdiff*60;
		 total_dur_mins = mindiff1+mindiff;

         if(total_dur_mins >= 60)
         {
            dur_hr = Math.floor(total_dur_mins/60);
            if (dur_hr <10)
            {
                dur_hr = "0"+dur_hr;
            }
            dur_hr = dur_hr + ":";

            dur_min = Math.floor(total_dur_mins%60);
            if (dur_min<10)
	    	{
	        dur_min = "0"+dur_min;
            }
            dur = dur_hr + dur_min;

         }

         else
         {
            if (total_dur_mins<10)
	    	{
	       total_dur_mins = "0"+ total_dur_mins;
            }
           dur = "00:"+total_dur_mins;
         }
         return dur;
}

function checkLength(obj)
{
	//alert("pos-->"+obj.getAttribute("pos"))
	var pos = obj.getAttribute("timepos");
	var focusName = obj.getAttribute("name");
	var minVal = obj.value;
	//alert("minVal1-->"+minVal.length)
	if(minVal.length == 2){
	if(document.Schedule_Form.checkstandard.length==undefined)
	{
		if(focusName == "starttime1")
			document.Schedule_Form.starttime2.focus();
		if(focusName == "starttime2")
			document.Schedule_Form.endtime1.focus();
		if(focusName == "endtime1")
			document.Schedule_Form.endtime2.focus();
		//if(focusName == "endtime2")
			//document.Schedule_Form.starttime1[pos].focus();
	}
	else
	{
		if(focusName == "starttime1")
			document.Schedule_Form.starttime2[pos].focus();
		if(focusName == "starttime2")
			document.Schedule_Form.endtime1[pos].focus();
		if(focusName == "endtime1")
			document.Schedule_Form.endtime2[pos].focus();
		//if(focusName == "endtime2")
			//document.Schedule_Form.starttime1[pos].focus();
	}
	} 
	
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

    <h2><%=bundle.getString("label.examscheduleparent.entryheading")%></h2>
<form name="Schedule_Form" action="" method="post">
	<input type=hidden name=req_sessionid value=<%=session.getValue("sessionid")%>>
	<input type=hidden name=req_sessionname value="<%=session.getValue("sessionname")%>">
    <input type=hidden name=req_boardid />
    <input type=hidden name=req_boardname />
    <input type=hidden name=req_examnameid />
    <input type=hidden name=req_examname />
    <input type=hidden name=req_standardscheduleid />
    <input type=hidden name=standardnamegp />
 

<%@ page language="java" import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
		String instituteid = null;
		ArrayList BoardList=null;
		instituteid			= (String)session.getValue("instituteid");
		ArrayList academicList 		= examQuery.loadAcademicYear(instituteid);
	
		BoardList = examQuery.LoadBoardList(instituteid);
		
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		String req_subjectscheduleid="";
		ArrayList ExamList=null;
		ArrayList standardList=null;
		ArrayList subjectList=null;
		ArrayList subjectscheduleList=null;
		String standardscheduleid	= null;
		String subjectscheduleid=null;
		String stdschid="";
		String today	= DateTime.showTime("calendar");
		int count	= 0;
		//String reg_sessionid 	= null;
		String req_sessionid 	= null;
		//String reg_boardid=null;
		String req_boardid=null;
		//String reg_examid=null;
		String req_examnameid=null;
		String req_standardscheduleid=null;
		//String reg_standardschid=null;
		String examallotmentid=null;
try{
		if(request.getParameter("req_sessionid") == null)
		{
			
		}
		else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  )
		{
			//String req_coursepubid = request.getParameter("req_coursepubid_hidden"); 
			 req_sessionid = request.getParameter("req_sessionid");
			req_boardid = request.getParameter("req_boardid");
			req_examnameid = request.getParameter("req_examnameid");
			//standardList = examQuery.listStandard(req_sessionid,req_boardid);
			standardList = examQuery.listStandardforexam(req_sessionid,req_boardid,req_examnameid);
			//out.println("standardList>>>>"+standardList);
			ExamList=examQuery.LoadAllotedExamnameList(req_sessionid);
			//System.out.println("ExamList-->"+ExamList+"req_sessionid-->"+req_sessionid);
			
		}
				 			
	    else if(request.getParameter("req_standardscheduleid") != null)
	    {
	    	
			//System.out.println("subjectList>>>"+subjectList);
	    }
		
}catch(Exception e){}
			
%>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.examscheduleparent.ExamSchedule")%></th>
		            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font><%=bundle.getString("label.extracurricularactivity.mandatoryfields")%></th>        
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		
		<br>
		
		<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examscheduleparent.AcademicYear")%></td><td class=tablebold width="2%">:</td>
			<td>
			<%=session.getValue("sessionname")%>	
			</td>

				<td class=tablebold>Board<font color=red> *</font></td><td class=tablebold width="2%">:</td>
					<td>
						<select name=boardname validate='Board Name' class=tablelight onchange=loadExam()>
							<option value="00">-Select Board-</option>
							<%
						      	if(BoardList!=null && BoardList.size()>0)
								{
				  		 			for (int i = 0, j = 1; i < BoardList.size(); i++) 
				  		 			{
										HashMap boardListMap=(HashMap)BoardList.get(i);
										String boardId     = (String)boardListMap.get("boardid");
										String boardName      = (String)boardListMap.get("boardname");
										String mediumId      = (String)boardListMap.get("mediumid");
										String mediumName      = (String)boardListMap.get("mediumname");
										//System.out.println("BOARDID-->"+boardId+"<-->"+req_boardid);
										if(boardId.equals(req_boardid))
										{
											out.println("<option selected value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
										}
										else
										{
											out.println("<option value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
										}
										
										//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
							  		 }
								}
							%>
						</select>
					</td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examscheduleparent.ExamName")%><font color=red> *</font></td>
			<td class=tablebold width="2%">:</td>
							<td>
					<select name=examname validate='Exam Name' class=tablelight onchange=loadStandard() >
						<option value="00">-Select Exam Name-</option>
						<%
							
					      	if(ExamList!=null && ExamList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{
									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									//System.out.println("examId>>>>>>>>>>"+examId);
									String examName      = (String)ExamListMap.get("examname");
									//System.out.println("EXAM ID-->"+examId+"<-->"+req_examid);
																		
									if(examId.equals(req_examnameid))
									{
										out.println("<option selected value='"+examId+"' class=tablelight title='"+examName+"'>"+examName+"</option>");
									}
									else
									{
										out.println("<option value='"+examId+"' class=tablelight title='"+examName+"'>"+examName+"</option>");
									}
						  		 }
							}
						%>
					</select>
				</td>
		
				<td class=tablebold width="25%">Standard<font color=red> *</font></td>
				<td class=tablebold width="2%">:</td>
				<td><select name=course validate='Standard' class=tablelight onchange=loadSubjects() >
					<option value="00">-Select Standard-</option>
					<%
						if(standardList !=null && standardList.size() >0)
						{
							for(int s1=0;s1<standardList.size();s1++)
							{
								HashMap map1=(HashMap)standardList.get(s1);
								String standardid=(String)map1.get("standardid");
								String standardname=(String)map1.get("standardname");
								 standardscheduleid=(String)map1.get("standardscheduleid");
								String groupname=(String)map1.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								//System.out.println("standardscheduleid-->"+standardscheduleid);
								//System.out.println("req_coursepubid-->"+request.getParameter("req_coursepubid_hidden"));
								if(standardscheduleid.equals(request.getParameter("req_standardscheduleid")))
								{
									out.println("<option selected value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								else
								{
									out.println("<option value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								
								//out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
							}
						}
					%>
					</select>
				</td>
		
		</tr>
		</table>
		</td></tr>
		</table>
					
		<tfoot>
			<tr>
		   		<td colspan="4" class="rounded-foot-left"><em></em></td>
		   		<td class="rounded-foot-right">&nbsp;</td>
		  	</tr>
		</tfoot>	

	<!--  <table border=0 cellpadding=3 cellspacing=0 width="100%" align=center>
	<tr><td align=right>
	<a href="#" onclick=selectallfun() class=tablebold>Select All</a> &nbsp;
	<a href="#" onclick=deselectallfun() class=tablebold>Deselect All</a>
	</td></tr>
	</table>-->

		<table width='90%' align='center' border='0' >

			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="3%"><%=bundle.getString("label.examscheduleparent.SL.No")%></th>
					            <th scope="col" class="rounded" 		width="18%"><%=bundle.getString("label.examscheduleparent.SubjectName")%></th>
					            <th scope="col" class="rounded" 		width="21%"><%=bundle.getString("label.examscheduleparent.ExamDate")%></th>
					            <th scope="col" class="rounded" 		width="21%"><%=bundle.getString("label.examscheduleparent.StartTime")%><br>hh : mm(12 hrs)</th>
					            <th scope="col" class="rounded" 		width="21%"><%=bundle.getString("label.examscheduleparent.EndTime")%><br>hh : mm(12 hrs)</th>
					            <th scope="col" class="rounded" 		width="4%"><%=bundle.getString("label.exam.Duration")%><br>hh : mm</th>
					            <th scope="col" class="rounded" 		width="5%"><%=bundle.getString("label.exam.online")%></th>
					            <th scope="col" class="rounded-q4" 		width="7%">Check</th>
					        </tr>
					    </thead>
					    
				  <tfoot>
				    	<tr>
				        	<td colspan="7" class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
				    	</tfoot>					    
					        
		<%
			String scheduledExamDates = "";
			String scheduledExamPubDates = "";
			String scheduledExamPos = "";
			String examScheduleStatus = "";
			String examScheduleStatus1 = "";			
			String examScheduleHMStatus = "";
			String color="";
			
			String req_sessionname = null;
			int visibleCheck = 0;
			int editCount	= 0;
		
			req_standardscheduleid = request.getParameter("req_standardscheduleid");
    		//subjectList		= examQuery.loadScheduledStandardSubjects(req_standardscheduleid);
    		subjectList=examQuery.loadScheduledStandardSubjectsforexam(req_standardscheduleid,req_examnameid);
    	   
    		//int duration=0;
    		String duration=null;
    		String examtype=null;
    		
    		  req_sessionname = request.getParameter("req_sessionname");
    		  String name = req_sessionname;
    		  int totalCount = 0;
    		  
    		  
			  if(subjectList!=null && subjectList.size()>0)
			{
				
				  int inc = 1;

				 	for (int j1 = 0; j1 < subjectList.size(); j1++) {
				 		HashMap countMap=(HashMap)subjectList.get(j1);
				 		examScheduleStatus1 = (String)countMap.get("subjectid");
						if(examScheduleStatus1!=null)
							totalCount = totalCount+1;
				 	}
				  
			 	for (int i1 = 0; i1 < subjectList.size(); i1++) {
			
				HashMap subjectListMap=(HashMap)subjectList.get(i1);
				String examsubscheduleid     = (String)subjectListMap.get("examsubscheduleid");
				subjectscheduleid     = (String)subjectListMap.get("subjectscheduleid");
				String subjectname      = (String)subjectListMap.get("subjectname");
				String subjectid      = (String)subjectListMap.get("subjectid");
				String standardid      = (String)subjectListMap.get("standardid");
				String examdate      = (String)subjectListMap.get("examdate");
				String examtimein      = (String)subjectListMap.get("examtimein");
				String examtimeout      = (String)subjectListMap.get("examtimeout");
				String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
				String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
				duration 				= (String)subjectListMap.get("duration");
				examtype				= (String)subjectListMap.get("examtype");
				 examallotmentid      = (String)subjectListMap.get("examallotmentid");
				
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					//duration = examQuery.getHourMin(examtimein,examtimeout);
					//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				
		 		//out.println("duration>>>"+duration);
					
	if(examsubscheduleid != null)
	{
		examScheduleStatus = (String)subjectListMap.get("examschedulestatus");
		if(examScheduleStatus.equals("A")||examScheduleStatus.equals("R")){
			examScheduleHMStatus = "Published";
			color = "green";
			scheduledExamPubDates = scheduledExamPubDates+"@"+examdate;
		}
		else{
			color = "red";
			examScheduleHMStatus = "Waiting for Approval";
			editCount++;
		}
		
		out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' readonly name='examdates' validate='Exam Date' size='11' value='"+examdate+"' /><input type='button' name='calButton'  style=display:none><input type='text' name='ampm1'  style=display:none><input type='text' name='ampm2'  style=display:none></td><td>"+examtimeinampm+"<input type ='hidden' readonly  name='starttime1' value='"+examtimein.split(":")[0]+"' disabled/> <input type ='hidden' readonly  name='starttime2' value='"+examtimein.split(":")[1]+"' disabled/> <input type ='hidden' readonly name='starttime' maxlength='4' size='5' validate='Start Time' value='"+examtimein+"' /></td><td>"+examtimeoutampm+"<input type ='hidden' readonly  name='endtime1' value='"+examtimeout.split(":")[0]+"' disabled/><input type ='hidden' readonly  name='endtime2' value='"+examtimeout.split(":")[1]+"' disabled/><input type ='hidden' readonly name='endtime' maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td>"+duration+"<input type ='hidden' readonly size='5' validate='Duration' maxlength='2' name='duration' value='"+duration+"'/></td><td>"+examtype+"<input type ='hidden' readonly size='5' validate='Duration' maxlength='2' name='examtypename' value='"+examtype+"'/></td><td><br><font color="+color+">"+examScheduleHMStatus+"</font><input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' readonly name='examdates' validate='Exam Date' size='11' value='"+examdate+"' /><input type='button' name='calButton'  style=display:none></td><td>"+examtimein+"<input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value='"+examtimein+"' disabled/><input type ='hidden' readonly  name='starttime1' value='"+examtimein.split(":")[0]+"' disabled /><input type ='hidden' readonly  name='starttime2' value='"+examtimein.split(":")[1]+"' disabled/><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value='"+examtimein+"' disabled/></td><td>"+examtimeout+"<input type ='hidden' readonly  name='endtime1' value='"+examtimeout.split(":")[0]+"' disabled/><input type ='hidden' readonly  name='endtime2' value='"+examtimeout.split(":")[1]+"' disabled/><input type ='hidden' readonly name='endtime' maxlength='4' size='5' validate='End Time' value='"+examtimeout+"' disabled/></td><td>"+duration+"<input type ='hidden' readonly size='5' validate='Duration' maxlength='2' name='duration' value='"+duration+"'/></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimein+"</td><td>"+examtimeout+"</td><td>"+duration+"</td><td>-<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		scheduledExamDates = scheduledExamDates+"@"+examdate;
		scheduledExamPos  = scheduledExamPos+"@"+i1;
	}
	else
		{
		if(totalCount==1)
			out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='examdates' size='11' value='' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><select name=ampm1 class=tablelight><option value=am>AM</option><option value=pm>PM</option></select><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='text' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><select name=ampm2 class=tablelight><option value=am>AM</option><option value=pm>PM</option></select><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5'><span id='durationid"+count+"'></span></td><td><select name=examtypename class=tablelight><option value=offline>No</option><option value=online>Yes</option></select></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"@"+count+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		else	
			out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='examdates' size='11' value='' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><select name=ampm1 class=tablelight><option value=am>AM</option><option value=pm>PM</option></select><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='text' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><select name=ampm2 class=tablelight><option value=am>AM</option><option value=pm>PM</option></select><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5'><span id='durationid"+count+"'></span></td><td><select name=examtypename class=tablelight><option value=offline>No</option><option value=online>Yes</option></select></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"@"+count+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		
		visibleCheck++;																																																																																																																																																																	
		}
	count++;	
	}
		
		}
		  else
			  {
			  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
			  //out.println("<tr><td colspan=7 align=center>Data not found</td></tr>");    	 
		   	  }
		%>
		</table>
		</td>
		</tr>
		</table>
	
		<% 
		//out.print("visibleCheck-->"+visibleCheck+"subjectList.size()-->"+subjectList.size());
		if(editCount>0){
		%>

		<tr><td>
			<a class=tablebold>Note :</a>
			Approval should be given by Principal.
		</td></tr>		
		<a href="#" class="bt_blue" onclick='trashSchedule()'><span class="bt_blue_lft"></span><strong>View</strong><span class="bt_blue_r"></span></a>		

						<a href="#" class="bt_blue" onclick='editSchedule()'><span class="bt_blue_lft"></span><strong>Edit</strong><span class="bt_blue_r"></span></a>
		<%
		}
		if(visibleCheck>0){
		%>
		<a href="#" class="bt_green" onclick='scheduleExam()'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
		<%
		}
		%>
		<input type='hidden' name='todaydate' 					value='<%=today %>'/>
		<!--  <input type='hidden' name='examdates' 			disabled	value='<%=today %>'/>-->
		<input type='hidden' name='schedDates' value='<%=scheduledExamDates%>'/>
		<input type='hidden' name='schedPos' value='<%=scheduledExamPos%>'/>
		<input type='hidden' name='schedPubDates' value='<%=scheduledExamPubDates%>'/>

		
		<input type='hidden' name='req_instituteid1'/>
		
		<input type='hidden' name='req_sessionid1' />
		<input type='hidden' name='req_sessionname1' />
		<input type='hidden' name='req_boardid1' />
		<input type='hidden' name='req_boardname1' />
		<input type='hidden' name='req_examnameid1' />
		<input type='hidden' name='req_examname1' />
		<input type='hidden' name='req_standardscheduleid1' />
		<input type='hidden' name='standardnamegp1' />
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>