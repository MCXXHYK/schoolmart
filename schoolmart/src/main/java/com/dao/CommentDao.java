package com.dao;


import com.pojo.Comment_info;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("commentDao")
@Mapper
public interface CommentDao {

    int InsertIntoComment(Comment_info comment);

    List<Comment_info> queryComment(String bname);

    List pageComments(Comment_info comment_info);

    int pageCommentsTotal(Comment_info comment_info);

    int deleteComment(Comment_info comment_info);

    Integer count();
}
