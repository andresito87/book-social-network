package com.andres.book.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class RegistrationRequest {
    
    @NotEmpty(message = "Firstname is required")
    @NotBlank(message = "Firstname can't be blank")
    private String firstName;
    @NotEmpty(message = "Lastname is required")
    @NotBlank(message = "Lastname can't be blank")
    private String lastName;
    @Email(message = "Email is not formatted correctly")
    @NotEmpty(message = "Email is required")
    @NotBlank(message = "Email can't be blank")
    private String email;
    @NotEmpty(message = "Password is required")
    @NotBlank(message = "Password can't be blank")
    @Size(min = 8, message = "Password must be at least 6 characters long minimum")
    private String password;
    
    
}