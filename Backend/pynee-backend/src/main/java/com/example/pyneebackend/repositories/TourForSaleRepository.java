package com.example.pyneebackend.repositories;

import com.example.pyneebackend.entities.TourForSale;
import com.example.pyneebackend.entities.TourForSaleStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TourForSaleRepository extends JpaRepository<TourForSale,Integer> {
    List<TourForSale> findAllByStatus(TourForSaleStatus status);
    boolean existsByTourForSaleId(TourForSale tour);
}
