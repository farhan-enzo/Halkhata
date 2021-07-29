package com.akatsuki.halkhata.repository;

import com.akatsuki.halkhata.domain.Profile;
import com.akatsuki.halkhata.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {
    Profile getByIdAndPassword(int id, String password);

    Profile getByIdAndUser(int id, User user);

    List<Profile> getAllByUser(User user);
}
