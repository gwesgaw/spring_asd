package com.myweb.www.config;

import javax.servlet.Filter;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.beans.propertyeditors.ClassArrayEditor;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	// 루트 설정 클래스를 반환하는 메서드로, 애플리케이션 전반의 설정을 담당
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] {RootConfig.class};
	}

	@Override
	// 서블릿 설정 클래스를 반환하는 메서드로, 웹 계층에 대한 설정을 담당
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] {ServletConfiguration.class};
	}

	@Override
	protected String[] getServletMappings() {
		// 처음 열렸을때 기본 경로
		// index.jsp
		return new String[] {"/"};
	}

	@Override
	// 한글이나 특수문자와같은 문자 데이터를 처리하기위한...
	protected Filter[] getServletFilters() { 
		// 필터 설정
		CharacterEncodingFilter encoding = new CharacterEncodingFilter();
		encoding.setEncoding("UTF-8"); // 문자 인코딩을 UTF-8로 설정
		encoding.setForceEncoding(true);// 외부로 나가는 데이터도 인코딩 설정
		return new Filter[] {encoding}; 
	}

	@Override
	protected void customizeRegistration(Dynamic registration) {
		// 그외기타 사용자 설정
		// 사용자 지정 익셉션 처리 지정
		super.customizeRegistration(registration);
	}

	
	
}