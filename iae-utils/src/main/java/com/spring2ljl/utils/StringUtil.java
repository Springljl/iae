package com.spring2ljl.utils;

import java.util.UUID;

public class StringUtil {
    public static String randomStirng(int length){
        return UUID.randomUUID().toString().replace("-","").substring(0,length);
    }
}
