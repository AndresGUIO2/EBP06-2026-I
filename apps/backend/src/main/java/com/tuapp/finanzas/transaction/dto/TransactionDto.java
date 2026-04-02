package com.tuapp.finanzas.transaction.dto;

import java.math.BigDecimal;

public class TransactionDto {
    private Long id;
    private BigDecimal amount;
    private String description;
    private Long categoryId;
    private Long userId;

    public TransactionDto() {}

    public TransactionDto(Long id, BigDecimal amount, String description, Long categoryId, Long userId) {
        this.id = id;
        this.amount = amount;
        this.description = description;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
