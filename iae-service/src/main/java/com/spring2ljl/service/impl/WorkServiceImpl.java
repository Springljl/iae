package com.spring2ljl.service.impl;

import com.github.pagehelper.PageHelper;
import com.spring2ljl.mapper.WorkMapper;
import com.spring2ljl.pojo.Work;
import com.spring2ljl.service.WorkService;
import com.spring2ljl.utils.DateUtil;
import com.spring2ljl.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import tk.mybatis.mapper.entity.Example;

import java.util.Date;
import java.util.List;

/**
 * @author spring2ljl
 * @date 2019/4/13
 */
@Service
public class WorkServiceImpl implements WorkService {
    @Autowired
    private WorkMapper workMapper;
    @Override
    public Page<Work> page(Integer page, Integer limit) {
        Example example = new Example.Builder(Work.class).orderByDesc("time").build();
        int count = workMapper.selectCountByExample(example);
        Page<Work> workPage = new Page<Work>(page, limit, count);
        PageHelper.startPage(workPage.getPageNo(), workPage.getPageSize());
        List<Work> works = workMapper.selectByExample(example);
        workPage.setData(works);
        return workPage;
    }

    @Override
    public void deleteByIds(List<Integer> ids) {
        Example example = new Example(Work.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andIn("id",ids);
        workMapper.deleteByExample(example);
    }

    @Override
    public void update(Work work) {
        if(work.getType().equals("全天")){
            work.setCount(1f);
        }else{
            work.setCount(0.5f);
        }
        if (work.getId()!=null){
            workMapper.updateByPrimaryKeySelective(work);
        }else{
            Date date = new Date();
            work.setYmd(DateUtil.formatymd(date));
            work.setTime(date.getTime());
            work.setYear(DateUtil.formaty(date));
            work.setMonth(DateUtil.formatm(date));
            workMapper.insert(work);
        }
    }

    @Override
    public void getMap(Model model) {
        float monthday=0;
        float yearday=0;
        float allday=0;
        Date date = new Date();
        String month = DateUtil.formatm(date);
        String year = DateUtil.formaty(date);
        List<Work> works = workMapper.selectAll();
        for (Work work : works) {
            allday+=work.getCount();
            if (month.equals(work.getMonth())){
                monthday+=work.getCount();
            }
            if (year.equals(work.getYear())){
                yearday+=work.getCount();
            }
        }
        model.addAttribute("monthday",monthday);
        model.addAttribute("yearday",yearday);
        model.addAttribute("allday",allday);
    }
}
