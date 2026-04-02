package com.tuapp.finanzas.budget.dto;

import java.math.BigDecimal;

public class BudgetDto {
    private Long id;
    private String name;
    private BigDecimal limitAmount;

    public BudgetDto() {}

    public BudgetDto(Long id, String name, BigDecimal limitAmount) {
        this.id = id;
        this.name = name;
        this.limitAmount = limitAmount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public java.math.BigDecimal getLimitAmount() {
        return limitAmount;
    }

    public void setLimitAmount(java.math.BigDecimal limitAmount) {
        this.limitAmount = limitAmount;
    }
}
