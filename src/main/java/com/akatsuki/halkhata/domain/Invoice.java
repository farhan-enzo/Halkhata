package com.akatsuki.halkhata.domain;

import javax.persistence.*;
import java.util.*;

@Entity
@Table
public class Invoice extends CommonProperties {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(length = 50)
    private String invoiceNo;

    @Temporal(TemporalType.TIMESTAMP)
    private Date date;

    //private Customer customer;

    @ManyToOne
    private User user;

    @ManyToOne
    private Profile profile;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "invoice_id")
    private Set<Item> items;

    public Invoice() {
        items = new LinkedHashSet<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInvoiceNo() {
        return invoiceNo;
    }

    public void setInvoiceNo(String invoiceNo) {
        this.invoiceNo = invoiceNo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public Set<Item> getItems() {
        return items;
    }

    public void setItems(Set<Item> items) {
        this.items = items;
    }

    public double getGrandTotal() {
        double grandTotal = 0;

        for (Item item : getItems()) {
            grandTotal = grandTotal + (item.getOrderedQuantity() * item.getSellingPrice());
        }

        return grandTotal;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "id=" + id +
                ", invoiceNo='" + invoiceNo + '\'' +
                ", date=" + date +
                ", user=" + user +
                ", profile=" + profile +
                ", items=" + items +
                '}';
    }
}
