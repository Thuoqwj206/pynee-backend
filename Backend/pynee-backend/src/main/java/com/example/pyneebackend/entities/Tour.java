package com.example.pyneebackend.entities;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "tour")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tour {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tour_id")
    private int tourId;
    private String name;
    private String description;

//    @ManyToOne
//    @JoinColumn(name = "touroperator_id")
//    private TourOperator tourOperator;

    @Enumerated(EnumType.STRING)
    private TourStatus status;

}
