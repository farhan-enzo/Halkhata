package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.domain.Profile;
import com.akatsuki.halkhata.domain.Role;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.util.Objects;

import static java.util.Objects.isNull;

@Controller
@RequestMapping(value = "/auth")
public class AuthController {

    private static final String REGISTRATION_FORM = "auth/registration";
    private static final String LOGIN_FORM = "auth/login";
    private static final String PROFILE = "auth/profile";
    private static final String DASHBOARD = "dashboard";

    @Autowired
    private UserService userService;

    @Autowired
    private ContextInfo contextInfo;

    @GetMapping(value = "/dashboard")
    public String welcome(ModelMap model) {

        if (isNull(contextInfo.getLoggedInProfile())) {
            return "redirect:/auth/profile";
        }

        model.put("user", contextInfo.getLoggedInUser());
        model.put("profile", contextInfo.getLoggedInProfile());

        return DASHBOARD;
    }

    @GetMapping(value = "/profile")
    public String profile(ModelMap model) {
        model.put("user", contextInfo.getLoggedInUser());

        return PROFILE;
    }

    @GetMapping(value = "/registration")
    public String registration(ModelMap model) {
        model.put("user", new User());

        return REGISTRATION_FORM;
    }

    @PostMapping(value = "/registration")
    public String registration(@Valid @ModelAttribute("user") User user,
                               BindingResult bindingResult) {

        if (foundDuplicateUsername(user.getUsername())) {
            bindingResult.rejectValue("username", "", "This username has already been taken!");
        }

        if (bindingResult.hasErrors()) {
            return REGISTRATION_FORM;
        }

        //todo: move to a helper class method
        Profile profile = new Profile();
        profile.setName(Profile.ADMIN);
        profile.setPassword(Profile.PASSWORD);
        profile.setRole(Role.ADMIN);
        profile.setUser(user);

        user.getProfiles().add(profile);

        userService.save(user);

        return "redirect:/auth/dashboard";
    }

    @GetMapping(value = "/login")
    public String login(ModelMap model, String error, String logout) {

        if (error != null) {
            model.put("error", "Your username and password is invalid.");
        }

        if (logout != null) {
            model.put("logout", "You have been logged out successfully.");
        }

        model.put("user", new User());

        return LOGIN_FORM;
    }

    private boolean foundDuplicateUsername(String username) {
        User duplicateUser = userService.findByUsername(username);

        return Objects.nonNull(duplicateUser);
    }
}
