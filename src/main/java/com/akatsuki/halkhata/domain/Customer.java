package com.akatsuki.halkhata.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class Customer extends CommonProperties {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(length = 50, nullable = false)
    @NotBlank
    @Size(max = 50)
    private String firstName;

    @Column(length = 50, nullable = false)
    @NotBlank
    @Size(max = 50)
    private String lastName;

    @Column(length = 11)
    @Size(max = 11)
    private String contactNo;


}
