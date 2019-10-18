package com.example.demo.security;

import java.util.List;

import com.example.demo.security.domain.Member;

public interface UserMapper {
 
    public Member readUser(String username);
 
    public List<String> readAuthority(String username);
}