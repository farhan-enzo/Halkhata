package com.akatsuki.halkhata.service;

import com.akatsuki.halkhata.domain.Product;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Transactional
    public void save(Product product) {
        productRepository.save(product);
    }

    public List<Product> getAllProducts(User user) {
        return productRepository.getAllByUser(user);
    }

    public Product getById(int id) {
        return productRepository.findById(id).orElse(null);
    }

    public List<Product> getAllByQuantityLessThanEqual(int quantity) {
        return productRepository.getAllByQuantityLessThanEqual(quantity);
    }

    @Transactional
    public void delete(Product product) {
        productRepository.delete(product);
    }
}
