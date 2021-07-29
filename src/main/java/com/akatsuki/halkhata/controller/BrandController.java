package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.domain.Brand;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/brand")
@SessionAttributes("brand")
public class BrandController {

    private static final String SHOW_PAGE = "brand/show";
    private static final String EDIT_PAGE = "brand/edit";

    @Autowired
    private ContextInfo contextInfo;

    @Autowired
    private BrandService brandService;

    @GetMapping(value = "/show")
    public String show(ModelMap model) {
        User loggedInUser = contextInfo.getLoggedInUser();

        model.put("brand", new Brand(loggedInUser));
        model.put("brandList", brandService.getAllBrands(loggedInUser));

        return SHOW_PAGE;
    }

    @PostMapping(value = "/show")
    public String show(@Valid @ModelAttribute("brand") Brand brand,
                       BindingResult result,
                       ModelMap model) {

        User loggedInUser = contextInfo.getLoggedInUser();

        if (result.hasErrors()) {
            model.put("brandList", brandService.getAllBrands(loggedInUser));

            return SHOW_PAGE;
        }

        brand.setUser(loggedInUser);
        brandService.save(brand);

        return "redirect:/brand/show";
    }

    @GetMapping(value = "/edit")
    public String edit(@RequestParam("id") int id,
                       ModelMap model) {

        model.put("brand", brandService.getById(id));

        return EDIT_PAGE;
    }

    @PostMapping(value = "/edit")
    public String update(@Valid @ModelAttribute("brand") Brand brand,
                         BindingResult result,
                         ModelMap model) {

        if (result.hasErrors()) {
            model.put("brand", brand);

            return EDIT_PAGE;
        }

        brandService.save(brand);

        return "redirect:/brand/show";
    }

    @ResponseBody
    @DeleteMapping(value = "/delete")
    public String delete(@RequestParam("id") int id) {
        brandService.delete(brandService.getById(id));

        return "deleted";
    }
}
