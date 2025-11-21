package com.example.myapp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Welcome to my Spring Boot App!";
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hello World!";
    }
}

