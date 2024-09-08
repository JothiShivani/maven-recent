package com.example.maven_poc;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
public class Controller {

    @GetMapping("/getmethod1")
    public static ResponseEntity<Map<String, String>> Hello(){
        Map<String,String> response = new HashMap<>();

        response.put("name","testData 1");
        response.put("age","15");
        response.put("dob","09-11-2009");

        return ResponseEntity.status(200).body(response);
    }

    @GetMapping("/getmethod2")
    public static ResponseEntity<Map<String, String>> Hello2(){
        Map<String,String> response = new HashMap<>();

        response.put("name","testData 2");
        response.put("age","21");
        response.put("dob","29-09-2003");

        return ResponseEntity.status(200).body(response);
    }

    @PostMapping("/postmapping")
    public static ResponseEntity<Object> post1(@RequestBody Object user){
        return ResponseEntity.status(200).body(user);
    }

}

