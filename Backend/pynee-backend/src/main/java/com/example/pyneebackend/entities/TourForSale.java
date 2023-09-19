package com.example.pyneebackend.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "tour_for_sale")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TourForSale {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tour_for_sale_id")
    private Long tourForSaleId;

    @ManyToOne
    @JoinColumn(name = "tour_id")
    private Tour tour;

    private BigDecimal price;
    private Date departureDate;
    private Integer quantity;

    @Enumerated(EnumType.STRING)
    private TourForSaleStatus status;
}
