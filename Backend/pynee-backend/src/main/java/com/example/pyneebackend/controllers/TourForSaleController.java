package com.example.pyneebackend.controllers;

import com.example.pyneebackend.entities.TourForSale;
import com.example.pyneebackend.entities.TourForSaleStatus;
import com.example.pyneebackend.services.imp.TourForSaleService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/tour-for-sale")
public class TourForSaleController {
    private final TourForSaleService service;

    @Autowired
    public TourForSaleController(TourForSaleService service) {
        this.service = service;
    }

    @GetMapping("")
    public ResponseEntity<List<TourForSale>> findAllTourForSale() {
        List<TourForSale> tours = service.findAllTourForSale();
        return new ResponseEntity<>(tours, HttpStatus.OK);
    }

    @GetMapping("/{status}")
    public ResponseEntity<List<TourForSale>> findAllTourForSaleByStatus(@PathVariable String status) {
        TourForSaleStatus saleStatus = TourForSaleStatus.valueOf(status.toUpperCase());
        List<TourForSale> tours = service.findAllTourForSaleByStatus(saleStatus);
        return new ResponseEntity<>(tours, HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<String> addTourForSale(@RequestBody TourForSale tour) {
        service.addTourForSale(tour);
        return new ResponseEntity<>("Added Successfully", HttpStatus.OK);
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateTourForSale(@RequestBody TourForSale tour) {
        if (service.updateTourForSale(tour) == null) {
            return new ResponseEntity<>("Invalid TourID",HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>("Updated Successfully",HttpStatus.OK);
    }

    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteTourForSale(@RequestParam(name = "id") int id) {
        if (!service.deleteTour(id)) {
            return new ResponseEntity<>("Invalid TourID",HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>("Deleted Successfully",HttpStatus.OK);
    }
}
