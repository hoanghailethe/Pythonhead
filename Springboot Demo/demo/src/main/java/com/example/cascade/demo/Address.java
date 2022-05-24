package com.example.cascade.demo;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column
    private String street;
    @Column
    private int houseNumber;
    @Column
    private String city;
    @Column
    private int zipCode;
    @ManyToOne(fetch = FetchType.LAZY)
    private User person;
}
