package com.myweb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BoardVO {
	
	private long bno;
	private String title;
	private String writer;
	private String content;
	private String reg_a;
	private String mod_at;
	private int read_count;
	private int cmt_qty;
	private int has_file;

}
