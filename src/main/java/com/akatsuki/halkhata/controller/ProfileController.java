package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.domain.Profile;
import com.akatsuki.halkhata.domain.Role;
import com.akatsuki.halkhata.service.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.xml.ws.WebServiceException;

@Controller
@RequestMapping("/profile")
@SessionAttributes("profile")
public class ProfileController {

    public static final String CREATE_PAGE = "profile/create";
    public static final String EDIT_PAGE = "profile/edit";
    public static final String LIST_PAGE = "profile/list";

    @Autowired
    private ContextInfo contextInfo;

    @Autowired
    private ProfileService profileService;

    @GetMapping(value = "/list")
    public String list(ModelMap model) {
        model.put("profiles", profileService.getAllByUser(contextInfo.getLoggedInUser()));

        return LIST_PAGE;
    }

    @GetMapping(value = "/create")
    public String create(ModelMap model) {
        Profile profile = new Profile();
        profile.setUser(contextInfo.getLoggedInUser());

        model.put("profile", profile);
        model.put("roles", Role.values());

        return CREATE_PAGE;
    }

    @PostMapping(value = "/create")
    public String save(@ModelAttribute("profile") Profile profile,
                       BindingResult result,
                       ModelMap model) {

        if (result.hasErrors()) {
            model.put("roles", Role.values());

            return CREATE_PAGE;
        }

        profileService.save(profile);

        return "redirect:/profile/list";
    }

    @GetMapping(value = "/edit")
    public String edit(@RequestParam("id") int id, ModelMap model) {
        Profile profile = profileService.getByIdAndUser(id, contextInfo.getLoggedInUser());

        model.put("profile", profile);
        model.put("roles", Role.values());

        return EDIT_PAGE;
    }

    @PostMapping(value = "/edit")
    public String update(@Valid @ModelAttribute("profile") Profile profile,
                       BindingResult result,
                       ModelMap model) {

        if (result.hasErrors()) {
            model.put("roles", Role.values());

            return EDIT_PAGE;
        }

        profileService.save(profile);

        return "redirect:/profile/list";
    }

    @ResponseBody
    @PostMapping(value = "/verify")
    public Profile verify(@RequestBody Profile profile, HttpSession session) {

        Profile profile1 = profileService.getByIdAndPassword(profile.getId(), profile.getPassword());

        if (profile.getId() != profile1.getId() || !profile.getPassword().equals(profile1.getPassword())) {
            throw new WebServiceException();
        }

        session.setAttribute("loggedInProfile", profile1);

        return profile;
    }
}
