package com.service;

import com.dao.UserDao;
import com.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;


    @Override
    public User login(User user) {
        return userDao.login(user);
    }

    @Override
    public int registeruser(User user) {
        return userDao.registeruser(user);
    }

    @Override
    public User selectUserInfo(Integer id) {
        return userDao.selectUserInfo(id);
    }

    @Override
    public User selectUserByEmail(String uemail) {
        return userDao.selectUserByEmail(uemail);
    }

    @Override
    public boolean UpdatePassword(Integer uid, String password, String newPassword) {
        User user = userDao.selectUserInfo(uid);
        if (user.getUpwd().equals(password)) {
            user.setUpwd(newPassword);
            userDao.UpdatePassword(user.getUid(), user.getUpwd());
            return true;
        }
        return false;
    }


    @Override
    public int updateadmin(User user) {
        return userDao.updateadmin(user);
    }

    @Override
    public List<User> selectAllUser() {
        return userDao.selectAllUser();
    }

    @Override
    public void delete(Integer id) {
        userDao.delete(id);
    }

}
