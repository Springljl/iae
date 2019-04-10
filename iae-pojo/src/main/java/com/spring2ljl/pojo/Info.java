package com.spring2ljl.pojo;

import lombok.Data;

import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;

@Data
@Table(name = "info")
public class Info {
    @Id
    private Integer id;
    private Long time;
    private Integer type;
    private BigDecimal amount;
    private String description;
    private String timeFormat;
    private String year;
}
