package com.example.pyneebackend.services;

import com.example.pyneebackend.entities.Tour;
import com.example.pyneebackend.entities.TourForSale;
import com.example.pyneebackend.entities.TourForSaleStatus;
import com.example.pyneebackend.entities.TourStatus;

import java.util.List;

public interface ITourForSaleService {
    List<TourForSale> findAllTourForSale();
    List<TourForSale> findAllTourForSaleByStatus(TourForSaleStatus status);
    void addTourForSale(TourForSale tour);
    TourForSale updateTourForSale(TourForSale tour);
    boolean deleteTour(int tourForSaleId);
}
