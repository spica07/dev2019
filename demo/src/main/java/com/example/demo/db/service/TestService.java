package com.example.demo.db.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.db.dto.Test;
import com.example.demo.db.mapper.TestMapper;

@Service
public class TestService {
 
    @Autowired
    TestMapper testMapper;
    
    public List<Test> getAll() throws Exception{
        return testMapper.getAll();
    }
}