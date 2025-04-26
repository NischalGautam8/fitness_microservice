package com.fitness.activityservice.controller;

import com.fitness.activityservice.dto.ActivityRequest;
import com.fitness.activityservice.dto.ActivityResponse;
import com.fitness.activityservice.service.ActivityService;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequestMapping("/api/activities")
@AllArgsConstructor
public class ActivityController {

  private ActivityService activityService;

  ///////////////toddo track activity
  ///
  //   @PostMapping
  //   public ResponseEntity<ActivityResponse> trackActivity(ActivityRequest){

  //   }
  @GetMapping("/hello")
  public ResponseEntity<String> hello() {
    return ResponseEntity.ok("Hello World");
  }

  @GetMapping
  public ResponseEntity<List<ActivityResponse>> getUserActivities(
    @RequestHeader("X-User-ID") String userId
  ) {
    return ResponseEntity.ok(activityService.getUserActivities(userId));
  }

  @GetMapping("/{activityId}")
  public ResponseEntity<ActivityResponse> getActivity(
    @PathVariable String activityId
  ) {
    return ResponseEntity.ok(activityService.getActivityById(activityId));
  }
}
