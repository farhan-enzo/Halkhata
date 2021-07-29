package com.akatsuki.halkhata.repository;

import com.akatsuki.halkhata.domain.Invoice;
import com.akatsuki.halkhata.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InvoiceRepository extends JpaRepository<Invoice, Integer> {
    List<Invoice> getAllByUser(User user);

    Invoice findById(int id);
}
