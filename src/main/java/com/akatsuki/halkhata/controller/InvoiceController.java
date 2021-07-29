package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.domain.Invoice;
import com.akatsuki.halkhata.domain.Item;
import com.akatsuki.halkhata.domain.Product;
import com.akatsuki.halkhata.service.InvoiceService;
import com.akatsuki.halkhata.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/invoice")
@SessionAttributes("invoice")
public class InvoiceController {

    private static final String INVOICE_CREATE_PAGE = "invoice/create";
    private static final String INVOICE_SHOW_PAGE = "invoice/show";
    private static final String INVOICE_LIST_PAGE = "invoice/list";

    @Autowired
    private ProductService productService;

    @Autowired
    private ContextInfo contextInfo;

    @Autowired
    private InvoiceService invoiceService;

    @GetMapping(value = "/show")
    public String show(@RequestParam("id") int id, ModelMap model) {

        Invoice invoice = invoiceService.findById(id);

        model.put("invoice", invoice);
        model.put("grandTotal", invoice.getGrandTotal());

        return INVOICE_SHOW_PAGE;
    }

    @GetMapping(value = "/list")
    public String list(ModelMap model) {

        List<Invoice> invoices = invoiceService.getAllByUser(contextInfo.getLoggedInUser());

        model.put("invoices", invoices);

        return INVOICE_LIST_PAGE;
    }

    @GetMapping(value = "/create")
    public String invoice(@RequestParam(value = "status", required = false, defaultValue = "") String status,
                          ModelMap model, HttpSession session) {

        List<Product> products = productService.getAllProducts(contextInfo.getLoggedInUser());

        Invoice invoice;

        if (Objects.isNull(session.getAttribute("invoice")) || !status.equals("inProgress")) {

            invoice = new Invoice();
            invoice.setDate(new Date());
            invoice.setInvoiceNo(UUID.randomUUID().toString());
            invoice.setUser(contextInfo.getLoggedInUser());
            invoice.setProfile(contextInfo.getLoggedInProfile());

            model.put("invoice", invoice);
        } else {
            invoice = (Invoice) model.getAttribute("invoice");
        }

        model.put("products", products);
        model.put("grandTotal", invoice.getGrandTotal());

        return INVOICE_CREATE_PAGE;
    }

    @PostMapping(value = "/create")
    public String save(@ModelAttribute("invoice") Invoice invoice,
                       ModelMap model) {

        if (CollectionUtils.isEmpty(invoice.getItems())) {
            List<Product> products = productService.getAllProducts(contextInfo.getLoggedInUser());
            model.put("products", products);

            return INVOICE_CREATE_PAGE;
        }

        Invoice invoice1 = invoiceService.save(invoice);

        for (Item item : invoice.getItems()) {
            Product product = item.getProduct();
            product.setQuantity(product.getQuantity() - item.getOrderedQuantity());

            productService.save(product);
        }

        return "redirect:/invoice/show?id=" + invoice1.getId();
    }

    @ResponseBody
    @GetMapping(value = "/addItem")
    public String addItem(@RequestParam("id") int id, HttpSession session) {
        Product product = productService.getById(id);
        Item item = new Item(product, 1, product.getSellingPrice(), contextInfo.getLoggedInUser());

        Invoice invoice = (Invoice) session.getAttribute("invoice");

        if (itemExists(invoice.getItems(), product)) {
            incrementItemQuantity(invoice.getItems(), product.getId());
        } else {
            invoice.getItems().add(item);
        }

        return "success";
    }

    @ResponseBody
    @GetMapping(value = "/plusItem")
    public String plusItem(@RequestParam("id") int id, HttpSession session) {

        Invoice invoice = (Invoice) session.getAttribute("invoice");

        incrementItemQuantity(invoice.getItems(), id);

        return "success";
    }

    @ResponseBody
    @GetMapping(value = "/minusItem")
    public String minusItem(@RequestParam("id") int id, HttpSession session) {
        Invoice invoice = (Invoice) session.getAttribute("invoice");

        for (Item item : invoice.getItems()) {
            if (item.getProduct().getId() == id) {
                item.setOrderedQuantity(item.getOrderedQuantity() - 1);
            }
        }

        return "success";
    }

    @ResponseBody
    @GetMapping(value = "/dropItem")
    public String dropItem(@RequestParam("id") int id, HttpSession session) {
        Invoice invoice = (Invoice) session.getAttribute("invoice");

        Set<Item> items = invoice.getItems();

        for (Item item : items) {
            if (item.getProduct().getId() == id) {
                items.remove(item);
            }
        }

        return "success";
    }

    private void incrementItemQuantity(Set<Item> items, int id) {
        for (Item item : items) {
            if (item.getProduct().getId() == id) {
                item.setOrderedQuantity(item.getOrderedQuantity() + 1);
            }
        }
    }

    private boolean itemExists(Set<Item> items, Product product) {
        for (Item item : items) {
            if (item.getProduct().getName().equals(product.getName())) {
                return true;
            }
        }

        return false;
    }
}
