package com.spring2ljl.pojo;

import lombok.Data;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;

@Data
@Table(name = "work")
public class Work {
    @Id
    private Integer id;
    private Long time;
    private String type;
    private String ymd;
    private String year;
    private String month;
    private String description;
    private Float count;
}
