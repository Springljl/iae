package com.spring2ljl.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    public static String format(Date date){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
        return format.format(date);
    }
    public static String formaty(Date date){
        SimpleDateFormat format = new SimpleDateFormat("yyyy");
        return format.format(date);
    }
}
