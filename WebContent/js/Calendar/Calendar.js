var w_field;
var w_mode;
var l_mode;
var validate_date;
var server_date;

Calendar_ON=0;

	function Calendar_Fun(file,field,mode,evt,check,current_date_of_server,leave_mode){
	    var myBars		= "directories=no,location=no,menubar=no,status=no";
	    myBars			= myBars+",titlebar=no,toolbar=no";
	    var myOptions	= "scrollbars=no,width=250,height=250,top=335,left=500,resizable=no";
	    var myFeatures 	= myBars+ ',' +myOptions;
	    d				= open(file,"calendardfds",myFeatures);
	    Calendar_ON		= 1;
	    w_field 		= field;
	    w_mode 			= mode;
	    l_mode 			= leave_mode;
	    validate_date 	= check;
	    server_date 	= current_date_of_server;  
	}


	function Assign_Fun(){
	
	    d.document.Calendar_Parent_Form.ParentField.value=w_field;
	    d.document.Calendar_Parent_Form.Mode.value=w_mode;
	    d.document.Calendar_Parent_Form.Leave_Mode.value=l_mode;
	    d.document.Calendar_Parent_Form.Validate_Date.value=validate_date;
	    d.document.Calendar_Parent_Form.server_date.value=server_date.value;
	}


	function Focus_Function(field,mode){
	
	    if(Calendar_ON==1)
	    {
	    	d.document.Calendar_Parent_Form.ParentField.value=field;
	    	d.document.Calendar_Parent_Form.Mode.value=mode;
	    	d.focus();
	    }
	}
