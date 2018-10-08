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
					monthstr="1";
					totaldays=31;
					break;
		   case 1:
					monthstr="2";
					totaldays=Check_Leap(Year);
					break;
		   case 2:
					monthstr="3";
					totaldays=31;
					break;
		   case 3:
					monthstr="4";
					totaldays=30;
					break;
		   case 4:
					monthstr="5";
					totaldays=31;
					break;
		   case 5:
					monthstr="6";
					totaldays=30;
					break;
		   case 6:
					monthstr="7";
					totaldays=31;
					break;
		   case 7:
					monthstr="8";
					totaldays=31;
					break;
		   case 8:
					monthstr="9";
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
	  	monthstr1 = name_month(monthstr);
		dat.innerText=date_value+'-'+monthstr1+'-'+Year;
		document.all.CALENDAR.style.visibility='hidden';
		show_fun("button");
		
	 //	includeFile();
	 	}


	function Today_Function()
		{
	  	d = new Date();
	  	dated=d.getDate();
	  	switch(dated)
	  	{
	  		case 1:
	  			dated='1'
	  			break;
	  		case 2:
	  			dated='2'
	  			break;
	  		case 3:
	  			dated='3'
	  			break;
	  		case 4:
	  			dated='4'
	  			break;
	  		case 5:
	  			dated='5'
	  			break;
	  		case 6:
	  			dated='6'
	  			break;
	  		case 7:
	  			dated='7'
	  			break;
	  		case 8:
	  			dated='8'
	  			break;
	  		case 9:
	  			dated='9'
	  			break;
	  	}

	  s=dated+"-"+d.getMonth()+"-"+d.getFullYear();
	  TotalDays_Fun(d.getMonth(),d.getYear());
	  monthstr1 = name_month(monthstr);
	  document.Calendar_Parent_Form.Date.value=dated+"-"+monthstr1+"-"+d.getFullYear();

	  var Child_Field=document.Calendar_Parent_Form.ParentField.value;

	  	if(Child_Field=="date")
			{
			
	  		dat.innerText = document.Calendar_Parent_Form.Date.value;
	  	
			}
	 	else
	    	{
	    	dat.innerText = document.Calendar_Parent_Form.Date.value;
	    	
	    	}

		document.all.CALENDAR.style.visibility='hidden';
		show_fun()
       // includeFile();
	}

	function OK_Function()
	{
		document.all.CALENDAR.style.visibility='hidden';		
	}


function name_month(month)
{
	switch(month)
	{
		case "1":
			monthstr1="Jan";
			break;
			
		case "2":
			monthstr1="Feb";
			break;
		case "3":
			monthstr1="Mar";
			break;
		case "4":
			monthstr1="Apr";
			break;
		case "5":
			monthstr1="May";
			break;			
		case "6":
			monthstr1="Jun";
			break;
		case "7":
			monthstr1="Jul";
			break;
		case "8":
			monthstr1="Aug";
			break;
		case "9":
			monthstr1="Sep";
			break;
		case "10":
			monthstr1="Oct";
			break;
		case "11":
			monthstr1="Nov";
			break;
		case "12":
			monthstr1="Dec";
			break;	
	}
	return monthstr1;
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

function dateValid(start,end)
{
     var count=0;
     if(start!='' && end!='')
     {
		startDate=start;
		endDate=end;

		
		var s=new Array();
		s=startDate.split('/');		
		startDay=parseInt(s[1]);				
		startMonth=parseInt(s[0]);		
		startYear=parseInt(s[2]);
		

		var s1=new Array();
		s1=endDate.split('/');
		endDay=parseInt(s1[1]);			
		endMonth=parseInt(s1[0]);
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
