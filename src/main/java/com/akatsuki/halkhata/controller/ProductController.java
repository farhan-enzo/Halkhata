package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.domain.Product;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.service.BrandService;
import com.akatsuki.halkhata.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/product")
@SessionAttributes("product")
public class ProductController {

    private static final String PRODUCT_LIST_PAGE = "product/list";
    private static final String PRODUCT_CREATE_PAGE = "product/create";
    private static final String PRODUCT_EDIT_PAGE = "product/edit";

    @Autowired
    private ContextInfo contextInfo;

    @Autowired
    private ProductService productService;

    @Autowired
    private BrandService brandService;

    @GetMapping(value = "/list")
    public String list(ModelMap model) {
        List<Product> products = productService.getAllProducts(contextInfo.getLoggedInUser());

        model.put("products", products);

        return PRODUCT_LIST_PAGE;
    }

    @GetMapping(value = "/create")
    public String create(ModelMap model) {
        User loggedInUser = contextInfo.getLoggedInUser();

        Product product = new Product();
        product.setUser(loggedInUser);

        model.put("product", product);
        model.put("brands", brandService.getAllBrands(loggedInUser));

        return PRODUCT_CREATE_PAGE;
    }

    @PostMapping(value = "/create")
    public String save(@Valid @ModelAttribute("product") Product product,
                       BindingResult result,
                       ModelMap model) {

        if (result.hasErrors()) {
            model.put("brands", brandService.getAllBrands(contextInfo.getLoggedInUser()));

            return PRODUCT_CREATE_PAGE;
        }

        productService.save(product);

        return "redirect:/product/list";
    }

    @GetMapping(value = "/edit")
    public String edit(@RequestParam("id") int id, ModelMap model) {

        Product product = productService.getById(id);

        model.put("product", product);
        model.put("brands", brandService.getAllBrands(contextInfo.getLoggedInUser()));

        return PRODUCT_EDIT_PAGE;
    }

    @PostMapping(value = "/edit")
    public String update(@Valid @ModelAttribute("product") Product product,
                         BindingResult result,
                         ModelMap model) {

        if (result.hasErrors()) {
            model.put("brands", brandService.getAllBrands(contextInfo.getLoggedInUser()));
            return PRODUCT_EDIT_PAGE;
        }

        productService.save(product);

        return "redirect:/product/list";
    }

    @ResponseBody
    @DeleteMapping(value = "/delete")
    public String delete(@RequestParam("id") int id) {

        Product product = productService.getById(id);
        productService.delete(product);

        return "deleted";
    }
}
