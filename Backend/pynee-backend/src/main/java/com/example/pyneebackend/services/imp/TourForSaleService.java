package com.example.pyneebackend.services.imp;
import com.example.pyneebackend.entities.TourForSale;
import com.example.pyneebackend.entities.TourForSaleStatus;
import com.example.pyneebackend.repositories.TourForSaleRepository;
import com.example.pyneebackend.services.ITourForSaleService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TourForSaleService implements ITourForSaleService {
    private final TourForSaleRepository repository;

    @Autowired
    public TourForSaleService(TourForSaleRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<TourForSale> findAllTourForSale() {
        return repository.findAll();
    }

    @Override
    public List<TourForSale> findAllTourForSaleByStatus(TourForSaleStatus status) {
        return repository.findAllByStatus(status);
    }

    @Override
    public void addTourForSale(TourForSale tour) {
        repository.save(tour);
    }

    @Override
    public TourForSale updateTourForSale(TourForSale tour) {
        Optional<TourForSale> optionalTourForSale = repository.findById(tour.getTourForSaleId());
        if (optionalTourForSale.isPresent()) {
           return repository.save(tour);
        }
        return null;
    }

    @Override
    @Transactional
    public TourForSale deleteTour(int tourForSaleId) {
        TourForSale tour = repository.getById(tourForSaleId);
        if (repository.existsByTourForSaleId(tour) || tour.getStatus().equals(TourForSaleStatus.ACTIVE)) {
             tour.setStatus(TourForSaleStatus.CANCELLED);
             return tour;
        }
        return null;
    }
}
