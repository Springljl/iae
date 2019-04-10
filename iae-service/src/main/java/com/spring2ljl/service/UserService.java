package com.spring2ljl.service;

import com.spring2ljl.pojo.User;

public interface UserService {
    User auth(User user);

    void update(User user);
}
