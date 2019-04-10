package com.spring2ljl.service.impl;

import com.spring2ljl.mapper.UserMapper;
import com.spring2ljl.pojo.User;
import com.spring2ljl.service.UserService;
import com.spring2ljl.utils.Md5Util;
import com.spring2ljl.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.weekend.WeekendSqls;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User auth(User user) {
        Example example = new Example(User.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("userName",user.getUserName());
        List<User> users = userMapper.selectByExample(example);
        if (users.size()==0){
            return null;
        }else{
            User user1 = users.get(0);
            String news = Md5Util.string2MD5(user.getPassword() + user1.getSalt());
            if (!news.equals(user1.getPassword())){
                return null;
            }
            else{
                user1.setPassword(null);
                return user1;
            }
        }
    }

    @Override
    public void update(User user) {
        String stirng = StringUtil.randomStirng(32);
        user.setPassword(Md5Util.string2MD5(user.getPassword()+stirng));
        user.setSalt(stirng);
        userMapper.updateByPrimaryKey(user);
    }
}
