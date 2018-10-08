// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:39 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   IGSTNonFatalException.java

package com.iGrandee.Common.util;


public class IGSTNonFatalException extends Exception
{

    public IGSTNonFatalException(String message, int errorCode)
    {
        super(message);
        mErrorCode = 0;
        mAdditionalMessage = "";
        mErrorCode = errorCode;
    }

    public IGSTNonFatalException(String message, int errorCode, String additionalMesg)
    {
        super(message);
        mErrorCode = 0;
        mAdditionalMessage = "";
        mErrorCode = errorCode;
        mAdditionalMessage = additionalMesg;
    }

    public String additionalMessage()
    {
        return mAdditionalMessage;
    }

    public int errorCode()
    {
        return mErrorCode;
    }

    private int mErrorCode;
    private String mAdditionalMessage;
}