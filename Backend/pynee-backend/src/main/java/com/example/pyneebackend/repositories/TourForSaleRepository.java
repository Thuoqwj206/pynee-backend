package com.example.pyneebackend.repositories;

import com.example.pyneebackend.entities.TourForSale;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TourForSaleRepository extends JpaRepository<TourForSale,Integer> {
}
