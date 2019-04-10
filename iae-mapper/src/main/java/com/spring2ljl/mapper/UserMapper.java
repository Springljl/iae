package com.spring2ljl.mapper;

import com.spring2ljl.pojo.User;
import org.mybatis.spring.annotation.MapperScan;
import tk.mybatis.mapper.common.Mapper;
@MapperScan
public interface UserMapper extends Mapper<User> {
}
