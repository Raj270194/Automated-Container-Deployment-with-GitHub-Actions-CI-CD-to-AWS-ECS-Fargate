package com.example.javaapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class JavaappApplication {

    public static void main(String[] args) {
        SpringApplication.run(JavaappApplication.class, args);
    }

    @GetMapping("/")
    public String home() {
        return "🔵 Up The Chels!  Java ECS App Deployed via Terraform & GitHub Actions (version 2)";
    }
}

