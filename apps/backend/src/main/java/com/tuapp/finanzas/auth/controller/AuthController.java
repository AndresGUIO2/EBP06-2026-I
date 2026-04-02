package com.tuapp.finanzas.auth.controller;

import com.tuapp.finanzas.auth.dto.AuthResponse;
import com.tuapp.finanzas.auth.dto.LoginRequest;
import com.tuapp.finanzas.user.dto.CreateUserRequest;
import com.tuapp.finanzas.user.dto.UserDto;
import com.tuapp.finanzas.user.repository.UserRepository;
import com.tuapp.finanzas.user.service.UserService;
import com.tuapp.finanzas.auth.service.JwtService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    public AuthController(UserService userService, UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.userService = userService;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
    }

    @GetMapping("/ping")
    public ResponseEntity<String> ping() {
        return ResponseEntity.ok("auth ok");
    }

    @PostMapping("/register")
    public ResponseEntity<UserDto> register(@Valid @RequestBody CreateUserRequest req) {
        logger.info("Register request body: {}", req);
        if (userRepository.findByUsername(req.getUsername()).isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
        UserDto created = userService.create(req);
        return ResponseEntity.ok(created);
    }

    // Debugging helper: echoes parsed body without validation
    @PostMapping("/echo")
    public ResponseEntity<CreateUserRequest> echo(@RequestBody CreateUserRequest req) {
        return ResponseEntity.ok(req);
    }

    // Debugging helper: return raw request body as text
    @PostMapping("/raw")
    public ResponseEntity<String> raw(@RequestBody String body) {
        try {
            logger.info("Raw body: {}", body);
            return ResponseEntity.ok(body);
        } catch (Exception ex) {
            logger.error("Error in raw endpoint", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest req) {
        var maybeUser = userRepository.findByUsername(req.getUsername());
        if (maybeUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        var user = maybeUser.get();
        if (!passwordEncoder.matches(req.getPassword(), user.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String token = jwtService.generateToken(user.getUsername());
        return ResponseEntity.ok(new AuthResponse(token));
    }
}
