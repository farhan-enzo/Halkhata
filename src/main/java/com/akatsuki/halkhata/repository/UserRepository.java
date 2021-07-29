package com.akatsuki.halkhata.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.akatsuki.halkhata.domain.User;

public interface UserRepository extends JpaRepository<User, Integer> {

    User findByUsername(String username);
}
