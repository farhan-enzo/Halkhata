package com.akatsuki.halkhata.repository;

import com.akatsuki.halkhata.domain.Product;
import com.akatsuki.halkhata.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> getAllByUser(User user);

    List<Product> getAllByQuantityLessThanEqual(int quantity);
}
