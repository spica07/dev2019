package com.example.demo.jsp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.db.service.TestService;
 
@Controller
public class JspController {

    @Autowired
    TestService testService;

    @RequestMapping("/jsp")
    public String jsp() throws Exception {
        return "main";
    }
    
    @RequestMapping("/autoCompleteSample")
    public String autoCompleteSample() throws Exception {
        return "autocompleteSample";
    }

    @RequestMapping("/autoCompleteMain")
    public String autoCompleteMain() throws Exception {
        return "autocomplete";
    }
    
    @RequestMapping("/autoComplete")
    public @ResponseBody Map<String, Object> autoComplete(String  userName) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();

    	map.put("userList", testService.getUserList("%" + userName + "%"));
    	
    	return map;
    }
    
    @RequestMapping("/storageMain")
    public String storageMain() throws Exception {
        return "storage";
    }

    @RequestMapping("/test")
    public String abcd() throws Exception {
        return "test";
    }
    
    @RequestMapping("/abcd2")
    public @ResponseBody String abcd2() throws Exception {
        return "abcd2";
    }
    
    @RequestMapping("/mav")
    public ModelAndView mav() throws Exception{
        ModelAndView mav = new ModelAndView("mavSample");
        
        mav.addObject("key", "fruits");
        
        List<String> fruitList = new ArrayList<String>();
        
        fruitList.add("apple");
        fruitList.add("orange");
        fruitList.add("banana");
         
        mav.addObject("value", fruitList);
        
        return mav;
    }
}