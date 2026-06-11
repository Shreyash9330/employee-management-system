package com.service;

import org.mindrot.jbcrypt.BCrypt;

import com.dao.UserDAO;
import com.model.User;

public class AuthService {

    UserDAO dao = new UserDAO();

    public User login(String username, String password) throws Exception {

        User user = dao.getUserByUsername(username);

        if (user == null) {
            System.out.println("User not found");
            return null;
        }

        System.out.println("Entered Password: " + password);
        System.out.println("DB Password: " + user.getPassword());

        boolean match = BCrypt.checkpw(password, user.getPassword());
        System.out.println("Password Match: " + match);

        if (match) {
            return user;
        }

        return null;

    
}
    
    public boolean checkPassword(String rawPassword, String hashedPassword) {
        return BCrypt.checkpw(rawPassword, hashedPassword);
    }
}
