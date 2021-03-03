package com.example.capstone.Model;

public class User {
    private String uid;
    private String email;
    private String username;

    public User(String uid, String email, String username) {
        this.uid = uid;
        this.email = email;
        this.username = username;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsenName() {
        return username;
    }

    public void setUsenName(String username) {
        this.username = username;
    }


}
