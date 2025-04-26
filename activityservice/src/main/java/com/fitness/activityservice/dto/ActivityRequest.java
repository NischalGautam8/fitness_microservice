package com.fitness.activityservice.dto;

import com.fitness.activityservice.model.ActivityType;
import java.time.LocalDateTime;
import java.util.Map;
import lombok.Data;

@Data
public class ActivityRequest {

  // created at and updated at request ma pathairaknu pardaina
  private String userId;
  private ActivityType type;
  private Integer duration;
  private Integer caloriesBurned;
  private LocalDateTime startTime;
  private Map<String, Object> additionalMetrics;
}
