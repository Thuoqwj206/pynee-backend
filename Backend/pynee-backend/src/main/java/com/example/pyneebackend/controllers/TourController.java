package com.example.pyneebackend.controllers;

import com.example.pyneebackend.entities.Tour;
import com.example.pyneebackend.entities.TourStatus;
import com.example.pyneebackend.services.imp.TourService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/tour")
public class TourController {
     private final TourService service;

    @Autowired
    public TourController(TourService tourService) {
        this.service= tourService;
    }
    @GetMapping("")
    public ResponseEntity<List<Tour>> findAllTour(){
       List<Tour> tours = service.findAllTour();
       return new ResponseEntity<>(tours, HttpStatus.OK);
    }

    @GetMapping("/{status}")
    public ResponseEntity<List<Tour>> findAllTourByStatus(@PathVariable String status) {
        TourStatus tourStatus = TourStatus.valueOf(status.toUpperCase());
        List<Tour> tours = service.findAllTourByStatus(tourStatus);
        return new ResponseEntity<>(tours,HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<String> addTour(@RequestBody Tour tour) {
        service.addTour(tour);
        return new ResponseEntity<>("Tour Created Successfully",HttpStatus.CREATED);
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateTour(@RequestBody Tour tour){
        if (service.updateTour(tour)==null) {
            return new ResponseEntity<>("Invalid Tour ID", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>("Updated Successfully",HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteTour(@PathVariable int id){
        if (service.deleteTour(id) == null) {
            return new ResponseEntity<>("Invalid Tour ID", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>("Deleted Successfully",HttpStatus.OK);
    }
}
