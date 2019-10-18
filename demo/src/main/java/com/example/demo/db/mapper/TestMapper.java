package com.example.demo.db.mapper;

import java.util.List;

import com.example.demo.db.dto.Test;

public interface TestMapper {
	 
    public List<Test> getAll() throws Exception;
    
}