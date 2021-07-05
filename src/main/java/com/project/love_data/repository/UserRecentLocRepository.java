package com.project.love_data.repository;

import com.project.love_data.model.service.UserRecentLoc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

public interface UserRecentLocRepository extends JpaRepository<UserRecentLoc, Long> {
    @Query(value = "select distinct * from User_Recent_Loc url where  url.loc_no = :loc_no", nativeQuery = true)
    public Optional<List <UserRecentLoc>> findByLoc_no(@Param("loc_no") Long locNo);

    @Query(value = "select distinct * from User_Recent_Loc url where  url.user_no = :user_no", nativeQuery = true)
    public Optional<List <UserRecentLoc>> findByUser_no(@Param("user_no") Long userNo);

    @Query(value = "select * from User_Recent_Loc url where  url.loc_no = :loc_no AND url.user_no = :user_no", nativeQuery = true)
    public Optional<UserRecentLoc> findByLoc_noAndUser_no(@Param("loc_no") Long locNo, @Param("user_no") Long userNo);

    @Query(value = "select * from User_Recent_Loc url where  url.uuid Like :uuid", nativeQuery = true)
    public Optional<UserRecentLoc> findByUuid(@Param("uuid") String uuid);

    @Modifying
    @Query(value = "DELETE FROM User_Recent_Loc WHERE user_no = :user_no AND loc_no = :loc_no", nativeQuery = true)
    @Transactional
    void deleteByLoc_noAndUser_no(@Param("loc_no") Long loc_no, @Param("user_no") Long user_no);
}