package com.server.eureka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class EurekaApplication {

  //mvn spring-boot:run
  public static void main(String[] args) {
    SpringApplication.run(EurekaApplication.class, args);
  }
}
