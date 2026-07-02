package com.skeetpro.dao;

import com.skeetpro.model.Admin;

public interface AdminDAO {
    Admin login(String username, String password);
}
