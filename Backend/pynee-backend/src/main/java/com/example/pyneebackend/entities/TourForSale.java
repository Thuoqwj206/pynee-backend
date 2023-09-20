package com.example.pyneebackend.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "tour_for_sale")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TourForSale {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tour_for_sale_id")
    private int tourForSaleId;

    @ManyToOne
    @JoinColumn(name = "tour_id")
    private Tour tour;

    private double price;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date departureDate;
    private int quantity;

    @Enumerated(EnumType.STRING)
    private TourForSaleStatus status;
}
