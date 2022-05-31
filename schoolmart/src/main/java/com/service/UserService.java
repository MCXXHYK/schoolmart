package com.service;

import com.pojo.User;
import java.util.List;

public interface UserService {

    User login(User user);

    int registeruser(User user);

    User selectUserInfo(Integer id);

    List<User> selectAllUser();

    int updateadmin(User user);

    void delete(Integer id);

    User selectUserByEmail(String uemail);

    boolean UpdatePassword(Integer uid, String password, String newPassword);

}
