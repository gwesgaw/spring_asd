package com.myweb.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.myweb.www.security.LoginFailureHandler;
import com.myweb.www.security.LoginSuccessHandler;
import com.myweb.www.security.CustomAuthMemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	//WebSecurityConfigurerAdapter 상속 받아 환경설정
	//WebConfig에 SecurityConfig.class 등록.
	
	//비밀번호 암호화 객체 PasswordEncoder 빈 생성
	@Bean
	public PasswordEncoder bcPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//SuccessHandler => 사용자 커스텀 생성
	@Bean
	public AuthenticationSuccessHandler authSuccessHandler() {
		return new LoginSuccessHandler(); //아직 생성안함.
	}
	
	//FailureHandler => 사용자 커스텀 생성
	@Bean
	public AuthenticationFailureHandler authFailureHandler() {
		return new LoginFailureHandler(); //아직 생성안함.
	}
	
	//UserDetail => 사용자 커스텀 생성
	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemberService(); //아직 생성안함.
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//인증 죄는 객체 설정
		auth.userDetailsService(customUserService())
		.passwordEncoder(bcPasswordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//화면에 설정되는 권한에 따른 주소 맵핑 설정
		http.csrf().disable();
		
		// 승인 요청
		//antMatchers : 접근을 허용하는 값
		// permitAll() : 누구나 접근을 가능하는 경로
		// authenticated() : 인증된 사용자만 가능
		http.authorizeRequests()
		.antMatchers("/member,list").hasRole("ADMIN")
		.antMatchers("/","/board/list","/board/detail","/comment/**","/upload/**","/resources/**","/member/register","/member/login").permitAll()
		.anyRequest().authenticated();
		
		//커스텀 로그인 페이지를 구성
		//controller에 주소요청 맵핑이 같이 있어야 함.(필수)
		http.formLogin()
		.usernameParameter("email")
		.passwordParameter("pwd")
		.loginPage("/member/login")
		.successHandler(authSuccessHandler())
		.failureHandler(authFailureHandler());
		
		//로그아웃 페이지 구성
		//반드시 method = "post"
		http.logout()
		.logoutUrl("/member/logout")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.logoutSuccessUrl("/");
		
	}
	
	@Override
	protected UserDetailsService userDetailsService() {
		// TODO Auto-generated method stub
		return super.userDetailsService();
	}


	
	
}
