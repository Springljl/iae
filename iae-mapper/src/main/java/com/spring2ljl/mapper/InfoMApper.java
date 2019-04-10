package com.spring2ljl.mapper;


import com.spring2ljl.pojo.Info;
import org.mybatis.spring.annotation.MapperScan;
import tk.mybatis.mapper.common.Mapper;
@MapperScan
public interface InfoMApper extends Mapper<Info> { }
