package com.dao;

import java.sql.*;
import com.model.User;

public class UserDAO {

	public User getUserByUsername(String username) throws Exception {

	    Connection con = DBConnection.getConnection();

	    String sql = "SELECT * FROM users WHERE username=?";
	    PreparedStatement ps = con.prepareStatement(sql);

	    ps.setString(1, username);

	    ResultSet rs = ps.executeQuery();

	    User user = null;

	    if (rs.next()) {
	        user = new User();
	        user.setUserId(rs.getInt("user_id"));
	        user.setUsername(rs.getString("username"));
	        user.setPassword(rs.getString("password")); // IMPORTANT
	        user.setRole(rs.getString("role"));
	    }

	    con.close();
	    return user;
	}
}