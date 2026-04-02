package model;

import java.math.BigDecimal;

public class CustomerStatisticDTO {
    private customer customerInfo;
    private int totalBookingCount;
    private BigDecimal totalRevenue;

    public CustomerStatisticDTO() {
    }

    public CustomerStatisticDTO(customer customerInfo, int totalBookingCount, BigDecimal totalRevenue) {
        this.customerInfo = customerInfo;
        this.totalBookingCount = totalBookingCount;
        this.totalRevenue = totalRevenue;
    }

    // Getters and Setters
    public customer getCustomerInfo() { return customerInfo; }
    public void setCustomerInfo(customer customerInfo) { this.customerInfo = customerInfo; }

    public int getTotalBookingCount() { return totalBookingCount; }
    public void setTotalBookingCount(int totalBookingCount) { this.totalBookingCount = totalBookingCount; }

    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }
}