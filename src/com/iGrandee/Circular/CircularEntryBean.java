// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 6/13/2011 6:06:51 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   CircularEntryBean.java

package com.iGrandee.Circular;

import java.io.PrintStream;

public class CircularEntryBean
{

    public CircularEntryBean()
    {
    }

    public void setOperation(String s)
    {
        operation = s;
    }

    public String getOperation()
    {
        return operation;
    }

    public void setNoticeId(String s)
    {
        noticeid = s;
    }

    public String getNoticdId()
    {
        return noticeid;
    }

    public void setInstituteId(String s)
    {
        stdname = s;
    }

    public void setSentBy(String s)
    {
        sentbys = s;
    }

    public String getSentBy()
    {
        return sentbys;
    }

    public String getInstituteId()
    {
        return stdname;
    }

    public void setSubject(String s)
    {
        subject = s;
    }

    public String getSubject()
    {
        return subject;
    }

    public void setIssuedBy(String s)
    {
        sendby = s;
    }

    public String getIssuedBy()
    {
        return sendby;
    }

    public void setContent(String s)
    {
        description = s;
    }

    public String getContent()
    {
        return description;
    }

    public void setConcerned(String s)
    {
        towhom = s;
    }

    public String getConcerned()
    {
        return towhom;
    }

    public void setNoticeDate(String s)
    {
        c_date = s;
    }

    public String getNoticeDate()
    {
        return c_date;
    }

    public void setEndDate(String s)
    {
        edate = s;
    }

    public String getEndDate()
    {
        return edate;
    }

    public void setStatus(String s)
    {
        status = s;
    }

    public String getStatus()
    {
        return status;
    }
    private static String circularid = null;

    private static String operation = null;
    private static String noticeid = null;
    private static String towhom = null;
    private static String stdname = null;
    private static String description = null;
    private static String c_date = null;
     static String startdate = null;

    private static String edate = null;
    private static String sendby = null;
    private static String status = null;
    private static String subject = null;
    private static String sentbys = null;
     static String attachfile = null;
     static String receiverid = null;
     static String createdby = null;
     static String ipaddress = null;
     static String mode = null;


	public static String getAttachfile() {
		return attachfile;
	}

	public static void setAttachfile(String attachfile) {
		CircularEntryBean.attachfile = attachfile;
	}

	public static String getStartdate() {
		return startdate;
	}

	public static void setStartdate(String startdate) {
		CircularEntryBean.startdate = startdate;
	}

	public static String getReceiverid() {
		return receiverid;
	}

	public static void setReceiverid(String receiverid) {
		CircularEntryBean.receiverid = receiverid;
	}

	public static String getCreatedby() {
		return createdby;
	}

	public static void setCreatedby(String createdby) {
		CircularEntryBean.createdby = createdby;
	}

	public static String getIpaddress() {
		return ipaddress;
	}

	public static void setIpaddress(String ipaddress) {
		CircularEntryBean.ipaddress = ipaddress;
	}

	public static String getMode() {
		return mode;
	}

	public static void setMode(String mode) {
		CircularEntryBean.mode = mode;
	}

	public static String getCircularid() {
		return circularid;
	}

	public static void setCircularid(String circularid) {
		CircularEntryBean.circularid = circularid;
	}

	
}