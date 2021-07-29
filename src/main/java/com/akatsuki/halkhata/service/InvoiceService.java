package com.akatsuki.halkhata.service;

import com.akatsuki.halkhata.domain.Invoice;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.repository.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class InvoiceService {

    @Autowired
    private InvoiceRepository invoiceRepository;

    @Transactional
    public Invoice save(Invoice invoice) {
        return invoiceRepository.save(invoice);
    }

    public Invoice findById(int id) {
        return invoiceRepository.findById(id);
    }

    public List<Invoice> getAllByUser(User user) {
        return invoiceRepository.getAllByUser(user);
    }
}
