/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;

/**
 *
 * @author RAVI DESAI
 */
public class LeaveCat {
    private int catId;
    private String catName;
    private int allocatedDays;

    public LeaveCat(int catId, String catName, int allocatedDays) {
        this.catId = catId;
        this.catName = catName;
        this.allocatedDays = allocatedDays;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public int getAllocatedDays() {
        return allocatedDays;
    }

    public void setAllocatedDays(int allocatedDays) {
        this.allocatedDays = allocatedDays;
    }
    
}
