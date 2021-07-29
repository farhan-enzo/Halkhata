package com.akatsuki.halkhata.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

@Repository
public class AnalyticsService {

    @Autowired
    private EntityManager em;

    public double getCurrentMonthSaleByUser(int userId) {
        String query = "select sum(it.selling_price * it.ordered_quantity) " +
                " from invoice iv " +
                " join item it on it.invoice_id = iv.id " +
                " where year(iv.created) = year(current_date()) " +
                " and month(iv.created) = month(current_date()) " +
                " and iv.user_id = :userId";

        double totalSale = (Double) em.createNativeQuery(query)
                .setParameter("userId", userId)
                .getSingleResult();

        return totalSale;
    }

    public double getCurrentMonthProfitByUser(int userId) {
        String query = " select (sum(it.selling_price * it.ordered_quantity) - sum(p.buying_price * it.ordered_quantity)) " +
                " from invoice iv " +
                " join item it on it.invoice_id = iv.id " +
                " join product p on p.id = it.product_id " +
                " where year(iv.created) = year(current_date()) " +
                " and month(iv.created) = month(current_date()) " +
                " and iv.user_id = :userId ";

        double totalProfit = (Double) em.createNativeQuery(query)
                .setParameter("userId", userId)
                .getSingleResult();

        return totalProfit;
    }
}
