package com.example.keycloakspringbootexample.infrastructure.api.rest.controllers;

import java.security.Principal;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("example")
public class ExampleController {

  @GetMapping("/public")
  public ResponseEntity<String> publc() {
    return ResponseEntity.ok("public");
  }

  @GetMapping("/public/{name}")
  public ResponseEntity<String> publcWithName(@PathVariable String name) {
    return ResponseEntity.ok("public " + name);
  }

  @GetMapping("/admin")
  public ResponseEntity<String> admin(Principal principal) {
    JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
    String userName = (String) token.getTokenAttributes().get("name");
    String userEmail = (String) token.getTokenAttributes().get("email");
    String name = token.getName();
    return ResponseEntity.ok("admin " + userEmail + " " + userName + " " + name);
  }

  @GetMapping("/others")
  public ResponseEntity<String> other(Principal principal) {
    JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
    String userName = (String) token.getTokenAttributes().get("name");
    String userEmail = (String) token.getTokenAttributes().get("email");
    String name = token.getName();
    return ResponseEntity.ok("other " + userEmail + " " + userName + " " + name);
  }

}
