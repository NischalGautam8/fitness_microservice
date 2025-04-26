package com.fitness.userservice.controller;

import com.fitness.userservice.dto.RegisterRequest;
import com.fitness.userservice.dto.UserResponse;
import com.fitness.userservice.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// controller -> userservice -->repository
@RestController
@RequestMapping("/api/users")
@AllArgsConstructor
@Slf4j
public class UserController {

  private UserService userService;

  //simple hello world
  @GetMapping("/hello")
  public ResponseEntity<String> hello() {
    log.info("Hello endpoint called");
    return ResponseEntity.ok("Hello World");
  }

  @GetMapping("/{userId}")
  public ResponseEntity<UserResponse> getUserProfile(
    @PathVariable String userId
  ) {
    return ResponseEntity.ok(userService.getUserProfile(userId));
  }

  @PostMapping("/register")
  public ResponseEntity<UserResponse> register(
    @Valid @RequestBody RegisterRequest request
  ) {
    return ResponseEntity.ok(userService.register(request));
  }

  @GetMapping("/{userId}/validate")
  public ResponseEntity<Boolean> validateUser(@PathVariable String userId) {
    return ResponseEntity.ok(userService.existByUserId(userId));
  }
}
