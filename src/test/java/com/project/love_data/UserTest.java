package com.project.love_data;

import com.project.love_data.repository.UserRepository;
import com.project.love_data.model.User;
import com.project.love_data.security.model.UserRole;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.IntStream;

@SpringBootTest
public class UserTest {
    @Autowired
    private UserRepository repository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    public void insertDummies() {
        IntStream.rangeClosed(1, 100).forEach(i -> {
            User user = new User();
            user.setUser_email("User" + StringUtils.leftPad(Integer.toString(i), 4, '0') + "@lovedata.com");
            user.setUser_pw(passwordEncoder.encode("0000"));
            user.setUser_nic("User" + StringUtils.leftPad(Integer.toString(i), 4, '0'));
            user.setUser_name("User" + StringUtils.leftPad(Integer.toString(i), 4, '0'));
            user.setUser_phone("010-0000-0000");
            user.setUser_birth("");
            user.setUser_gen("");
            user.setUser_time(LocalDateTime.now());
            user.setUser_Activation("1");
            user.setUser_social(false);
//            user.setUser_userRole(UserRole.USER);
            user.addUserRole(UserRole.USER);

            repository.save(user);
        });

        User user = new User();
        user.setUser_email("User" + StringUtils.leftPad(Integer.toString(101), 4, '0') + "@lovedata.com");
        user.setUser_pw(passwordEncoder.encode("0000"));
        user.setUser_nic("User" + StringUtils.leftPad(Integer.toString(101), 4, '0'));
        user.setUser_name("User" + StringUtils.leftPad(Integer.toString(101), 4, '0'));
        user.setUser_phone("010-0000-0000");
        user.setUser_birth("");
        user.setUser_gen("");
        user.setUser_time(LocalDateTime.now());
        user.setUser_Activation("1");
        user.setUser_social(true);
//        user.setUser_userRole(UserRole.ADMIN);
        user.addUserRole(UserRole.ADMIN);
        user.addUserRole(UserRole.USER);

        User user1 = new User();
        user1.setUser_email("mon0mon@naver.com");
        user1.setUser_pw(passwordEncoder.encode("1111"));
        user1.setUser_nic("mon0mon");
        user1.setUser_name("이민기");
        user1.setUser_phone("010-0000-0000");
        user1.setUser_birth("");
        user1.setUser_gen("");
        user1.setUser_time(LocalDateTime.now());
        user1.setUser_Activation("1");
        user1.setUser_social(true);
        user1.addUserRole(UserRole.ADMIN);
        user1.addUserRole(UserRole.USER);

        repository.save(user);
        repository.save(user1);
    }

    @Test
    public void testRead_email_Success() {
        String given_email = "User0100@lovedata.com";
        Optional<User> result = repository.findUserByEmail(given_email);

        // 유저 정보를 가져오지 못한 경우
        if (!result.isPresent()) {
            System.out.println("########################################");
            System.out.println("testRead()");
            System.out.println("주어진 email : " + given_email + "에 부합하는 유저정보를 찾지 못했습니다.");
            System.out.println("Failed");
            System.out.println("########################################");
        } else {
            User temp = result.get();
            System.out.println("########################################");
            System.out.println("no : " + temp.getUser_no());
            System.out.println("email : " + temp.getUser_email());
            System.out.println("pw : " + temp.getUser_pw());
            System.out.println("name : " + temp.getUser_name());
            System.out.println("nickname : " + temp.getUser_nic());
            System.out.println("phone : " + temp.getUser_phone());
            System.out.println("birth : " + temp.getUser_birth());
            System.out.println("gender : " + temp.getUser_gen());
            System.out.println("registered date : " + temp.getUser_time());
            System.out.println("Complete");
            System.out.println("########################################");
        }
    }

    @Test
    public void testUserRole_Read(){
        Optional<User> result = repository.findUserByEmail_Privilege("User0101@lovedata.com");

        User temp = result.get();

//        System.out.println(temp);
        System.out.println(temp.getRoleSet());
    }

    @Test
    public void testRead_email_Fail() {
        String given_email = "User1100@lovedata.com";
        Optional<User> result = repository.findUserByEmail(given_email);

        // 유저 정보를 가져오지 못한 경우
        if (!result.isPresent()) {
            System.out.println("########################################");
            System.out.println("testRead()");
            System.out.println("주어진 email : " + given_email + "에 부합하는 유저정보를 찾지 못했습니다.");
            System.out.println("Failed");
            System.out.println("########################################");
        } else {
            User temp = result.get();
            System.out.println("########################################");
            System.out.println("no : " + temp.getUser_no());
            System.out.println("email : " + temp.getUser_email());
            System.out.println("pw : " + temp.getUser_pw());
            System.out.println("name : " + temp.getUser_name());
            System.out.println("nickname : " + temp.getUser_nic());
            System.out.println("phone : " + temp.getUser_phone());
            System.out.println("birth : " + temp.getUser_birth());
            System.out.println("gender : " + temp.getUser_gen());
            System.out.println("registered date : " + temp.getUser_time());
            System.out.println("Complete");
            System.out.println("########################################");
        }
    }

    @Test
    public void testRead_emailSocial_Success() {
        String given_email = "User0100@lovedata.com";
        Boolean social = false;
        Optional<User> result = repository.findUserByEmail_Social(given_email,  social);

        // 유저 정보를 가져오지 못한 경우
        if (!result.isPresent()) {
            System.out.println("########################################");
            System.out.println("testRead()");
            System.out.println("주어진 email : " + given_email + "에 부합하는 유저정보를 찾지 못했습니다.");
            System.out.println("Failed");
            System.out.println("########################################");
        }
        else {
            User temp = result.get();
            System.out.println("########################################");
            System.out.println("no : " + temp.getUser_no());
            System.out.println("email : " + temp.getUser_email());
            System.out.println("pw : " + temp.getUser_pw());
            System.out.println("social : " + temp.isUser_social());
            System.out.println("name : " + temp.getUser_name());
            System.out.println("nickname : " + temp.getUser_nic());
            System.out.println("phone : " + temp.getUser_phone());
            System.out.println("birth : " + temp.getUser_birth());
            System.out.println("gender : " + temp.getUser_gen());
            System.out.println("registered date : " + temp.getUser_time());
            System.out.println("Complete");
            System.out.println("########################################");
        }

        given_email = "User0101@lovedata.com";
        social = true;
        result = repository.findUserByEmail_Social(given_email,  social);

        if (!result.isPresent()) {
            System.out.println("########################################");
            System.out.println("testRead()");
            System.out.println("주어진 email : " + given_email + "에 부합하는 유저정보를 찾지 못했습니다.");
            System.out.println("Failed");
            System.out.println("########################################");
        }
        else {
            User temp = result.get();
            System.out.println("########################################");
            System.out.println("no : " + temp.getUser_no());
            System.out.println("email : " + temp.getUser_email());
            System.out.println("pw : " + temp.getUser_pw());
            System.out.println("social : " + temp.isUser_social());
            System.out.println("name : " + temp.getUser_name());
            System.out.println("nickname : " + temp.getUser_nic());
            System.out.println("phone : " + temp.getUser_phone());
            System.out.println("birth : " + temp.getUser_birth());
            System.out.println("gender : " + temp.getUser_gen());
            System.out.println("registered date : " + temp.getUser_time());
            System.out.println("Complete");
            System.out.println("########################################");
        }
    }
}