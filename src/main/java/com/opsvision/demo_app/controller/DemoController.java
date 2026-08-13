package com.opsvision.demo_app.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/")
    public String home() {
        return "Welcome to the Demo Application!";
    }

     @GetMapping("/health")
    public String health() {
        return "Healthy";
    }
    public record User(Long id, String name) {}
    @GetMapping("/users")
    
    public List<User> users() {
    return List.of(
        new User(1L, "Alice"),
        new User(2L, "Bob"),
        new User(3L, "Charlie")
    );
}
}