	var Date_Var;
	   	var Month;
	   	var Year;
	   	var Day;
	   	var totaldays;
	   	var monthstr;
var withFormName;
		
	  	function Load_Fun(storeForm)
	  		{
	  		 withFormName = storeForm;
	   		Date_Var = new Date();
	   		Month=Date_Var.getMonth();
	   		Year=Date_Var.getFullYear();
	   		Load_Combo_Month(Month);
	   		document.Calendar_Parent_Form.Year_Field.value=Year;
	   		TotalDays_Fun(Month,Year);
	   		Calendar_Parent_Fun(Year,Month);
//Assign_Fun();
	  		}

	  function Load_Combo_Month(Month)
		   	{
			   document.Calendar_Parent_Form.D1.options[0]=new Option('January');
			   document.Calendar_Parent_Form.D1.options[1]=new Option('February');
			   document.Calendar_Parent_Form.D1.options[2]=new Option('March');
			   document.Calendar_Parent_Form.D1.options[3]=new Option('April');
			   document.Calendar_Parent_Form.D1.options[4]=new Option('May');
			   document.Calendar_Parent_Form.D1.options[5]=new Option('June');
			   document.Calendar_Parent_Form.D1.options[6]=new Option('July');
			   document.Calendar_Parent_Form.D1.options[7]=new Option('August');
			   document.Calendar_Parent_Form.D1.options[8]=new Option('September');
			   document.Calendar_Parent_Form.D1.options[9]=new Option('October');
			   document.Calendar_Parent_Form.D1.options[10]=new Option('November');
			   document.Calendar_Parent_Form.D1.options[11]=new Option('December');
			   document.Calendar_Parent_Form.D1.options[Month].selected='true';
		   }

	function Choose_Fun(Month)
	  	{
	  	TotalDays_Fun(Month,Year);
	   	Calendar_Parent_Fun(Year,Month);
	   	}

	function Calendar_Parent_Fun(Year,Month)
		{
		var d =new Date();
		d.setFullYear(Year);
		d.setMonth(Month);
		d.setDate(1);
		Day=d.getDay();

		for(var i=0; i<=41; i++)
			{
			s_day[i].innerText=' ';
			}

		for(var i=1; i<=totaldays; i++)
			{
			if((i>=1) && (i<=9))
				date_str=i.toString();
			else date_str=i;
			if(navigator.appName == "Netscape")
				{
				document.anchors[Day].text=date_str;
				}
			else
				{
				s_day[Day].innerText=date_str;
				}
			Day++;
			}

		 }



	 function Check_Leap(Year)
	 	{
		if(Year%4==0) return 29;
		else return 28;
	 	}

	 function TotalDays_Fun(Month,Year)
		{
		switch(Month)
			{

		   case 0:
					monthstr="01";
					totaldays=31;
					break;
		   case 1:
					monthstr="02";
					totaldays=Check_Leap(Year);
					break;
		   case 2:
					monthstr="03";
					totaldays=31;
					break;
		   case 3:
					monthstr="04";
					totaldays=30;
					break;
		   case 4:
					monthstr="05";
					totaldays=31;
					break;
		   case 5:
					monthstr="06";
					totaldays=30;
					break;
		   case 6:
					monthstr="07";
					totaldays=31;
					break;
		   case 7:
					monthstr="08";
					totaldays=31;
					break;
		   case 8:
					monthstr="09";
					totaldays=30;
					break;
		   case 9:
					monthstr="10";
					totaldays=31;
					break;
		   case 10:
					monthstr="11";
					totaldays=30;
					break;
		   case 11:
					monthstr="12";
					totaldays=31;
					break;

		  default :  "Your information wrong"
		 }


	}

 	function getValue(value,id)
	 	{
		date_value=eval(value+"["+id+"].innerText");
	  	if(date_value==" "){return;}
	  	
		eval("document."+withFormName+".value=date_value+'/'+monthstr+'/'+Year");
	 	includeFile();
	 	}


	function Today_Function()
		{
	  	d = new Date();
	  	dated=d.getDate();	  	
	  	switch(dated)
	  	{
	  		case 1:
	  			dated='01'
	  			break;
	  		case 2:
	  			dated='02'
	  			break;
	  		case 3:
	  			dated='03'
	  			break;
	  		case 4:
	  			dated='04'
	  			break;
	  		case 5:
	  			dated='05'
	  			break;
	  		case 6:
	  			dated='06'
	  			break;
	  		case 7:
	  			dated='07'
	  			break;
	  		case 8:
	  			dated='08'
	  			break;
	  		case 9:
	  			dated='09'
	  			break;
	  	}

	  s=dated+"-"+d.getMonth()+"-"+d.getFullYear();
	  TotalDays_Fun(d.getMonth(),d.getYear());
	  
	  document.Calendar_Parent_Form.Date.value=dated+"/"+monthstr+"/"+d.getFullYear();

	  var Child_Field=document.Calendar_Parent_Form.ParentField.value;

	  	if(Child_Field=="date")
			{
	  		eval("document."+withFormName+".value = document.Calendar_Parent_Form.Date.value");
			}
	 	else
	    	{
	    	eval("document."+withFormName+".value = document.Calendar_Parent_Form.Date.value");
	    	}


        includeFile();
	}

	function OK_Function()
	{
		document.all.CALENDAR.style.visibility='hidden';		
	}




function Increment_Function()
	{
	Year=Year+1;
	if(Year==9999)Year=9999;
	document.Calendar_Parent_Form.Year_Field.value=Year;
	Month=document.Calendar_Parent_Form.D1.options.selectedIndex;
	TotalDays_Fun(Month,Year);
	Calendar_Parent_Fun(Year,Month);
	}

function Decrement_Function()
	{
	Year=Year-1;
	if(Year==1000)Year=1000;
	document.Calendar_Parent_Form.Year_Field.value=Year;
	Month=document.Calendar_Parent_Form.D1.options.selectedIndex;
	TotalDays_Fun(Month,Year);
	Calendar_Parent_Fun(Year,Month);
	}

function Key_Function()
	{
	var date_val=document.Calendar_Parent_Form.Year_Field.value;
	if(date_val.length==4)
		{
		if(!isNaN(date_val))
		 	{
			Year=document.Calendar_Parent_Form.Year_Field.value;
			Month=document.Calendar_Parent_Form.D1.options.selectedIndex;
			TotalDays_Fun(Month,Year);
			Calendar_Parent_Fun(Year,Month);
		  	}
		else
		  	{
			alert("Invalid value");
		  	}
	   	}
	}


var startDate,endDate;
var startDay,endDay;
var startMonth,endMonth;
var startYear,endYear;
var count;
function dateValid(start,end)
{
     count=0;
     if(start!='' && end!='')
     {
		startDate=start;
		endDate=end;
		

		
		var s=new Array();
		s=startDate.split('/');		
		startDay=parseInt(s[0]);				
		startMonth=parseInt(s[1]);		
		startYear=parseInt(s[2]);
		

		var s1=new Array();
		s1=endDate.split('/');
		endDay=parseInt(s1[0]);			
		endMonth=parseInt(s1[1]);
		endYear=parseInt(s1[2]);

		if(endYear==startYear)
		{
			if(endMonth==startMonth)
				{
				if(endDay<startDay)
				   {	
				      alert('Invalid Date Selection');
				      count=1;
				   }
				}
			else
				{
				if(endMonth<startMonth) 
				   {
				        alert('Invalid Date Selection');	
				        count=1;
				   }
				}
		}
		else if(endYear<startYear) 
		{
		      alert('Invalid Date Selection');
		      count=1;		     
		}			
 	}
 	
  return count;  	
}
