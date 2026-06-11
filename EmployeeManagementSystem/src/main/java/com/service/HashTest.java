package com.service;

import org.mindrot.jbcrypt.BCrypt;

public class HashTest {
    public static void main(String[] args) {
    	 String password = "admin123";   // IMPORTANT
         String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));

         System.out.println(hash);
    }
}