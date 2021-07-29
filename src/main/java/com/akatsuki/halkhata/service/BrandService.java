package com.akatsuki.halkhata.service;

import com.akatsuki.halkhata.domain.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.repository.BrandRepository;

import java.util.List;

@Service
public class BrandService {

    @Autowired
    private BrandRepository brandRepository;

    @Transactional
    public void save(Brand brand) {
        brandRepository.save(brand);
    }

    public List<Brand> getAllBrands(User user) {
        return brandRepository.getAllByUser(user);
    }

    public Brand getById(int id) {
        return brandRepository.findById(id)
                .orElse(null);
    }

    @Transactional
    public void delete(Brand brand) {
        brandRepository.delete(brand);
    }
}
