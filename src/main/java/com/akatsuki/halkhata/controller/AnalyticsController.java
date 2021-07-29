package com.akatsuki.halkhata.controller;

import com.akatsuki.halkhata.common.ContextInfo;
import com.akatsuki.halkhata.service.AnalyticsService;
import com.akatsuki.halkhata.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/analytics")
public class AnalyticsController {

    private static final String ANALYTICS_SHOW_PAGE = "analytics/show";

    @Autowired
    private AnalyticsService analyticsService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ContextInfo contextInfo;

    @GetMapping(value = "/show")
    public String show(ModelMap model) {

        int loggedInUserId = contextInfo.getLoggedInUser().getId();

        model.put("currentMonthTotalSale", analyticsService.getCurrentMonthSaleByUser(loggedInUserId));
        model.put("currentMonthTotalProfit", analyticsService.getCurrentMonthProfitByUser(loggedInUserId));
        model.put("nearStockOutProducts", productService.getAllByQuantityLessThanEqual(20));

        return ANALYTICS_SHOW_PAGE;
    }
}
