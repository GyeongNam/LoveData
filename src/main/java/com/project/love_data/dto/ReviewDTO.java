package com.project.love_data.dto;

import lombok.*;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDTO {
    private Long revNo;
    private String revContent;
    private Long userNo;
    private Long corNo;
    private String userName;

    @Builder.Default
    private Long revIdx = 0L;
    @Builder.Default
    private float sc_total = 0f;
    @Builder.Default
    private int sc_move = 0;
    @Builder.Default
    private int sc_loc = 0;
    @Builder.Default
    private int sc_time = 0;
    @Builder.Default
    private int sc_revisit = 0;
    @Builder.Default
    private boolean is_deleted = false;
    @Builder.Default
    private boolean is_modified = false;
    @Builder.Default
    private Long reported_count = 0L;
    @Builder.Default
    private String revUuid = UUID.randomUUID().toString();
    @Builder.Default
    private int rev_like = 0;
    @Builder.Default
    private int rev_dislike = 0;
    @Builder.Default
    private Long view_count = 0L;
    @Builder.Default
    private LocalDateTime regDate = LocalDateTime.now();
    @Builder.Default
    private LocalDateTime modDate = LocalDateTime.now();
}
