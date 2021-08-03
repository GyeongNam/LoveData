package com.project.love_data.model.service;

import com.project.love_data.model.base.TimeEntity;
import lombok.*;
import lombok.extern.log4j.Log4j2;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "userRecentCor")
@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Log4j2
public class UserRecentCor extends TimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @Cascade(value = org.hibernate.annotations.CascadeType.ALL)
    private Long userRecentCor_no;

    @Column(name = "cor_no", nullable = false)
    private Long cor_no;

    @Column(name = "user_no", nullable = false)
    private Long user_no;

    @Column(name = "uuid", nullable = false, length = 45)
    @Builder.Default
    private String uuid = UUID.randomUUID().toString();
}