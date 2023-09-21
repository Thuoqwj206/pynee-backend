package com.example.pyneebackend.services;

import com.example.pyneebackend.entities.Tour;
import com.example.pyneebackend.entities.TourStatus;

import java.util.List;

public interface ITourService {

   List<Tour> findAllTour();
   List<Tour> findAllTourByStatus(TourStatus status);
    void addTour(Tour tour);
    Tour updateTour(Tour tour);
    boolean deleteTour(int tourId);

}
