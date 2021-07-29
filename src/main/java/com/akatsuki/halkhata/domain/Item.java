package com.akatsuki.halkhata.domain;

import javax.persistence.*;
import javax.validation.constraints.Min;

@Entity
@Table
public class Item extends CommonProperties {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Min(1)
    private int orderedQuantity;

    private double sellingPrice;

    @ManyToOne
    private Product product;

    @ManyToOne
    private User user;

    public Item() {
    }

    public Item(Product product, int orderedQuantity, double sellingPrice, User user) {
        this();

        this.product = product;
        this.orderedQuantity = orderedQuantity;
        this.sellingPrice = sellingPrice;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderedQuantity() {
        return orderedQuantity;
    }

    public void setOrderedQuantity(int orderedQuantity) {
        this.orderedQuantity = orderedQuantity;
    }

    public double getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", orderedQuantity=" + orderedQuantity +
                ", sellingPrice=" + sellingPrice +
                ", product=" + product +
                ", user=" + user +
                '}';
    }
}
