package com.spring2ljl.pojo;

import lombok.Data;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "user")
public class User {
    @Id
    private Integer id;
    private String userName;
    private String password;
    private String salt;
}
