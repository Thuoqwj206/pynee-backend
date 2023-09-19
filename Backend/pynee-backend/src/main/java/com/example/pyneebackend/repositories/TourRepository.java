package com.example.pyneebackend.repositories;

import com.example.pyneebackend.entities.Tour;
import com.example.pyneebackend.entities.TourStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TourRepository extends JpaRepository<Tour,Integer> {

    List<Tour>findAllByStatus(TourStatus status);
}
