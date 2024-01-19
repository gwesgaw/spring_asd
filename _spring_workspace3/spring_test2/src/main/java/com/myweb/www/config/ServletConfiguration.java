package com.myweb.www.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc

//배열로도 가능, 전체 스캔: basePackages = "com.myweb.www"
@ComponentScan(basePackages = {"com.myweb.www.controller", "com.myweb.www.handler"}) 
public class ServletConfiguration implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// resources 경로 설정 / 나중에 파일 업로드 경로 설정 추가
		registry.addResourceHandler("/resources/**") // 들어오는 경로
				.addResourceLocations("/resources"); // 찾는 경로
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// 뷰 경로 설정
		// 생성자로도 설정 가능
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/"); // jsp파일의 위치경로
		viewResolver.setSuffix(".jsp"); // jsp확장자를 설정하여 표기하지않도록 한다
		viewResolver.setViewClass(JstlView.class); // JSTL을 사용할수있도록 한다.
		
		registry.viewResolver(viewResolver);
	}

}