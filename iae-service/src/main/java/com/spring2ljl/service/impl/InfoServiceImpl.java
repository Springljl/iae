package com.spring2ljl.service.impl;

import com.github.pagehelper.PageHelper;
import com.spring2ljl.mapper.InfoMApper;
import com.spring2ljl.pojo.Info;
import com.spring2ljl.service.InfoService;
import com.spring2ljl.utils.DateUtil;
import com.spring2ljl.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.math.BigDecimal;
import java.util.*;

@Service
public class InfoServiceImpl implements InfoService {
    @Autowired
    private InfoMApper infoMApper;
    @Override
    public Page<Info> page(Integer page, Integer limit) {
        Example example = new Example.Builder(Info.class).orderByDesc("time").build();
        int count = infoMApper.selectCountByExample(example);
        Page<Info> infoPage = new Page<Info>(page,limit,count);
        PageHelper.startPage(infoPage.getPageNo(),infoPage.getPageSize());
        List<Info> infos = infoMApper.selectByExample(example);
        infoPage.setData(infos);
        return infoPage;
    }

    @Override
    public void deleteByIds(List<Integer> ids) {
        Example example = new Example(Info.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andIn("id",ids);
        infoMApper.deleteByExample(example);
    }

    @Override
    public void update(Info info) {
        if (info.getId()!=null){
            infoMApper.updateByPrimaryKeySelective(info);
        }else{
            Date date = new Date();
            info.setTime(date.getTime());
            info.setTimeFormat(DateUtil.format(date));
            info.setYear(DateUtil.formaty(date));
            infoMApper.insert(info);
        }
    }

    @Override
    public Map all(String v) {
        Map<String, BigDecimal> map = new HashMap<>();
        map.put("m_in",new BigDecimal(0));
        map.put("m_out",new BigDecimal(0));
        map.put("m_all",new BigDecimal(0));
        map.put("y_in",new BigDecimal(0));
        map.put("y_out",new BigDecimal(0));
        map.put("y_all",new BigDecimal(0));
        Example example = new Example(Info.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("year",v.split("-")[0]);
        List<Info> infoList = infoMApper.selectByExample(example);
        for (Info info : infoList) {
            if(info.getTimeFormat().equals(v)){
                if(info.getType().equals(0)){
                    map.put("m_out",map.get("m_out").add(info.getAmount()));
                }else{
                    map.put("m_in",map.get("m_in").add(info.getAmount()));
                }
            }
            if(info.getType()==0){
                map.put("y_out",map.get("y_out").add(info.getAmount()));
            }else{
                map.put("y_in",map.get("y_in").add(info.getAmount()));
            }
        }
        map.put("y_all",map.get("y_in").subtract(map.get("y_out")));
        map.put("m_all",map.get("m_in").subtract(map.get("m_out")));
        return map;
    }

    @Override
    public Map charts() {
        Map<String,Object> map=new HashMap<>();
        Map<String,BigDecimal> mapin = new TreeMap<>(new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareTo(o2);
            }
        });
        Map<String,BigDecimal> mapout=new TreeMap<>(new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareTo(o2);
            }
        });
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        List<String> years=new ArrayList<>();
        for (int i=1;i<=12;i++){
            years.add(year+"-"+(i>=10?i:"0"+i));
            mapin.put((i>=10?i+"":"0"+i),new BigDecimal(0));
            mapout.put((i>=10?i+"":"0"+i),new BigDecimal(0));
        }
        map.put("years",years);
        Example example = new Example(Info.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("year",year);
        List<Info> infoList = infoMApper.selectByExample(example);
        for (Info info : infoList) {
            String s = info.getTimeFormat().split("-")[1];
            if(info.getType().equals(0)){
                mapout.put(s,mapout.get(s).add(info.getAmount()));
            }else{
                mapin.put(s,mapin.get(s).add(info.getAmount()));
            }
        }

        List<BigDecimal> list1 = new ArrayList<>();
        mapin.forEach((k,v)->{
            list1.add(v);
        });
        List<BigDecimal> list2 = new ArrayList<>();
        mapout.forEach((k,v)->{
            list2.add(v);
        });
        map.put("in",list1);
        map.put("out",list2);
        return map;
    }
}
