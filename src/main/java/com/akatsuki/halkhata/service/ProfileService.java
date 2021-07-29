package com.akatsuki.halkhata.service;

import com.akatsuki.halkhata.domain.Profile;
import com.akatsuki.halkhata.domain.User;
import com.akatsuki.halkhata.repository.ProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProfileService {

    @Autowired
    private ProfileRepository  profileRepository;

    public Profile getByIdAndPassword(int id, String password) {
        return profileRepository.getByIdAndPassword(id, password);
    }

    public Profile getByIdAndUser(int id, User user) {
        return profileRepository.getByIdAndUser(id, user);
    }

    @Transactional
    public void save(Profile profile) {
        profileRepository.save(profile);
    }

    public List<Profile> getAllByUser(User user) {
        return profileRepository.getAllByUser(user);
    }
}
