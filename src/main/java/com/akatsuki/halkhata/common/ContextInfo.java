package com.akatsuki.halkhata.common;

import com.akatsuki.halkhata.domain.Profile;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Component
public class ContextInfo {

    @Autowired
    private UserService userService;

    public User getLoggedInUser() {
        return userService.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
    }

    public Profile getLoggedInProfile() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();

        return (Profile) session.getAttribute("loggedInProfile");
    }
}
