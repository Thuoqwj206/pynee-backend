package com.example.pyneebackend.services.imp;

import com.example.pyneebackend.entities.Tour;
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
    public Tour deleteTour(int tourId) {
        List<Tour> tourList = findAllTourByStatus(TourStatus.AVAILABLE);
        if (tourList.contains(repository.getById(tourId))) {
            repository.getById(tourId).setStatus(TourStatus.UNAVAILABLE);
           return repository.getById(tourId);
        }
        return null;
    }
}
