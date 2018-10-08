// Decompiled by DJ v3.6.6.79 Copyright 2004 Atanas Neshkov  Date: 5/20/2007 12:47:37 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DateTime.java

package com.iGrandee.Common;

import java.util.Date;

import org.apache.log4j.Logger;

public class DateTime
{
	static Logger log = Logger.getLogger(DateTime.class);
    public DateTime()
    {
    }
    static String month[] 		= {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
    /**
     * This method is accessed from kycportal/jsp/StudentSearch/studentFees.jsp
     * Get Today Date       - prasanth
     * @param  s  that can be used to get current timestamp
       @return  String by which result can be printed on the screen
    */
    public static synchronized String showTime(String s)
        throws Exception
    {
    	//System.out.println("coming string==>"+s);
        if(s == null)
            return "-";
        Date date = new Date();
        String as[] = {
            "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "sep", "Oct",
            "Nov", "Dec"
        };
        int i = date.getDate();
        String s3 = as[date.getMonth()];
        int j = date.getMonth() + 1;
        int k = date.getYear() + 1900;
        int l = date.getHours();
        int i1 = date.getMinutes();
        int j1 = date.getSeconds();
        String s4 = date.toLocaleString();
        if(s4.indexOf("AM") != -1)
            s4 = s4.substring(s4.indexOf("AM"));
        else
        if(s4.indexOf("PM") != -1)
            s4 = s4.substring(s4.indexOf("PM"));
        else
            s4 = "AM";
        String s5 = "";
        if(s.equals("WithTime"))
            s5 = i + "-" + s3 + "-" + k + " " + l + ":" + i1 + ":" + j1;
        else
        if(s.equals("MySqlWithTime"))
            s5 = k + "-" + j+ "-" + i + " " + l + ":" + i1 + ":" + j1;
        else
        if(s.equals("WithMonthAsNo"))
            s5 = i + "-" + j + "-" + k + "-" + l + "-" + i1 + "-" + j1;
        else
        if(s.equals("WithMonthAsNoForRoute"))
            s5 = i + "-" + j + "-" + k + ":" + l + "-" + i1 + "-" + j1;
        else
        if(s.equals("DBChecker"))
            s5 = k + "-" + j + "-" + i;
        else
        if(s.equals("ForDatabase"))
            s5 = j + "/" + i + "/" + k + " " + l + ":" + i1 + ":" + j1;
        else
        if(s.equals("Time"))
            s5 = l + ":" + i1 + ":" + j1;
        else
        if(s.equals("TimeWith"))
            s5 = l + ":" + i1 + ":" + j1 + "/" + s4;
        else
        if(s.equals("for_secure"))
            s5 = s3 + i + k + l + i1 + j1;
        else
        if(s.equals("accesstoken"))
        {
            Integer integer = new Integer(k + j + i + l + i1 + j1);
            s5 = integer.toString();
        }
        else
		if(s.equals("calendar"))
		{
			s5 = i + "-" + as[j-1] + "-" + k ;
        }
		else if(s.equals("dd-mm-yyyy_hh_mm_ss"))
		{
			s5 = i + "-" + as[j-1] + "-" + k +"_"+ l + "_" + i1 + "_" + j1;
        }
     	else
        {
            s5 = k+ "/" + j + "/" + i;
        }
      //  System.out.println("return string s5==>"+s5);
        return s5;
    }
    public StringBuffer getMySQLFormat(String date_value) throws Exception
	{
		String singleValue=null;
		StringBuffer sb=new StringBuffer();
	//	20-May-2011
		log.info(date_value);
		try{
		if(date_value!=null)
		{
		  if(date_value.indexOf("-")!=-1)
		  {
			   int i=date_value.lastIndexOf("-");
			   if(i!=-1)
			   {
				 singleValue=date_value.substring(i+1,i+5);
				 sb.append(singleValue+"/");
			   }
			  int i1=date_value.indexOf("-");
			  int i2=date_value.indexOf(" ",i);
			  String timeValue=null;
			  if(i2!=-1)
			  {
				timeValue=date_value.substring(i2,date_value.length());
			  }
			  if(i1!=-1)
			  {
				singleValue=date_value.substring((i1+1),i);
				singleValue=getEquivMonth(singleValue);
				sb.append(singleValue+"/");
			  }
			  singleValue=date_value.substring(0,i1);
			  if(singleValue!=null)
			  {
				  if(singleValue.length()>0)
				  {
					  sb.append(singleValue);
				  }
				  else
				  {
					  sb.append("0"+singleValue);
				  }
			  }


			  if(i2!=-1 && i2!=0)
			  {
				sb.append(' '+timeValue);
			  }
		  }
	   }
		
		log.info("in datetime"+sb);
		}
		catch(Exception e){
			log.error(e);//e.printStackTrace();
		}
		  return sb;
	}
    
	public String getMySQLFormatSlash(String date_value) 
	{
		StringBuffer sb		= new StringBuffer();
		String temp[]		= null;
		try{
			
		
			if(date_value!=null)
			{
				temp		= date_value.split("/");
				
				if(temp != null && temp.length==3){
					
					if(temp[2] != null && temp.length>4)
						temp[2]	= temp[2].substring(0,4);
					
					sb.append(temp[2]+"-"+temp[1]+"-"+temp[0]+" 00:00:00");
				}
			}
		}
		catch(Exception e){
			
		}
		
		return sb.toString();
	}
    
    


	public StringBuffer getMySQLFormatHifen(String date_value) throws Exception
		{
			String singleValue=null;
			StringBuffer sb=new StringBuffer();
			if(date_value!=null)
			{
			  if(date_value.indexOf("-")!=-1)
			  {
				   int i=date_value.lastIndexOf("-");
				   if(i!=-1)
				   {
					 singleValue=date_value.substring(i+1,i+5);
					 sb.append(singleValue+"-");
				   }
				  int i1=date_value.indexOf("-");
				  int i2=date_value.indexOf(" ",i);
				  String timeValue=null;
				  if(i2!=-1)
				  {
					timeValue=date_value.substring(i2,date_value.length());
				  }
				  if(i1!=-1)
				  {
					singleValue=date_value.substring((i1+1),i);
					singleValue=getEquivMonth(singleValue);
					sb.append(singleValue+"-");
				  }
				  singleValue=date_value.substring(0,i1);
				  if(singleValue!=null)
				  {
					  if(singleValue.length()>0)
					  {
						  sb.append(singleValue);
					  }
					  else
					  {
						  sb.append("0"+singleValue);
					  }
				  }


				  if(i2!=-1 && i2!=0)
				  {
					sb.append(' '+timeValue);
				  }
			  }
		   }
			  return sb;
		}


	public String getEquivMonth(String s)
		throws Exception
	{
		//System.out.println("s>>>>>>"+s);
		if(s == null)
			s 	= "";
		
		String s1 = null;

		if(s.equalsIgnoreCase("Jan") || s.equalsIgnoreCase("January"))
			s1 = "01";
		else
		if(s.equalsIgnoreCase("Feb")  || s.equalsIgnoreCase("February"))
			s1 = "02";
		else
		if(s.equalsIgnoreCase("Mar") || s.equalsIgnoreCase("March"))
			s1 = "03";
		else
		if(s.equalsIgnoreCase("Apr") || s.equalsIgnoreCase("April"))
			s1 = "04";
		else
		if(s.equalsIgnoreCase("May") || s.equalsIgnoreCase("May"))
			s1 = "05";
		else
		if(s.equalsIgnoreCase("Jun") || s.equalsIgnoreCase("June"))
			s1 = "06";
		else
		if(s.equalsIgnoreCase("Jul") || s.equalsIgnoreCase("July"))
			s1 = "07";
		else
		if(s.equalsIgnoreCase("Aug") || s.equalsIgnoreCase("August"))
			s1 = "08";
		else
		if(s.equalsIgnoreCase("Sep") || s.equalsIgnoreCase("September"))
			s1 = "09";
		else
		if(s.equalsIgnoreCase("Oct") || s.equalsIgnoreCase("October"))
			s1 = "10";
		else
		if(s.equalsIgnoreCase("Nov") || s.equalsIgnoreCase("November"))
			s1 = "11";
		else
		if(s.equalsIgnoreCase("Dec") || s.equalsIgnoreCase("December"))
			s1 = "12";
		return s1;
	}

}