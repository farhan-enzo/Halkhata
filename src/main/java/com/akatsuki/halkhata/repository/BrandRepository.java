package com.akatsuki.halkhata.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.akatsuki.halkhata.domain.Brand;
import com.akatsuki.halkhata.domain.User;

import java.util.List;

public interface BrandRepository extends JpaRepository<Brand, Integer> {
    List<Brand> getAllByUser(User user);
}
