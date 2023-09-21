package com.example.pyneebackend.services.imp;

import com.example.pyneebackend.entities.Tour;
import com.example.pyneebackend.entities.TourForSale;
import com.example.pyneebackend.entities.TourForSaleStatus;
import com.example.pyneebackend.entities.TourStatus;
import com.example.pyneebackend.repositories.TourRepository;
import com.example.pyneebackend.services.ITourService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TourService implements ITourService {

    TourRepository repository;

    @Autowired
    public TourService(TourRepository tourRepository) {
        this.repository = tourRepository;
    }

    @Override
    public List<Tour> findAllTour() {
        return repository.findAll();
    }

    @Override
    public List<Tour> findAllTourByStatus(TourStatus status) {
        return repository.findAllByStatus(status);
    }

    @Override
    public void addTour(Tour tour) {
        repository.save(tour);
    }

    @Override
    public Tour updateTour(Tour tour) {
        Optional<Tour>optionalTour = repository.findById(tour.getTourId());
        if (optionalTour.isPresent()) {
            return repository.save(tour);
        }
        return null;
    }

    @Override
    @Transactional
    public boolean deleteTour(int tourId) {
        Optional<Tour> optionalTour = repository.findById(tourId);
        if (optionalTour.isPresent()) {
            Tour tour = optionalTour.get();
            if (tour.getStatus() == TourStatus.AVAILABLE) {
                tour.setStatus(TourStatus.UNAVAILABLE);
                return true;
            } else if (tour.getStatus() == TourStatus.UNAVAILABLE) {
                repository.delete(tour);
                return true;
            }
        }
        return false;
    }
}
