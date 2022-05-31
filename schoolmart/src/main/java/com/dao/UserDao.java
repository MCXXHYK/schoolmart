package com.dao;

import com.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("userDao")
@Mapper
public interface UserDao {

    User login(User user);

    int registeruser(User user);

    User selectUserInfo(Integer id);

    User selectUserByEmail(String uemail);

    List<User> selectAllUser();

    List pageUser(User user);

    int pageUserTotal(User user);

    int updateadmin(User user);

    void delete(Integer id);

    int UpdatePassword(@Param("uid") Integer uid, @Param("newPassword") String newPassword);

    boolean forgetupwd(@Param("uid") Integer uid, @Param("newPassword") String newPassword);

    Integer count();
}

