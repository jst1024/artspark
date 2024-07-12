package com.kh.artspark.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	/*
	 * Interceptor(정확히 HandlerInterceptor) 
	 * 
	 * handle()을 호출하기 전, 인터셉터가 가로채서 실행할 내용을 작성할 수 있음
	 * 
	 * preHandle(전 처리) : Hnadler 호출 전 낚아챔
	 * postHandle(후 처리) : 요청 처리 후 낚아챔 
	 * 
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// true 반환		=> 기존 요청 호출대로 Handler를 정상 수행 ==> Controller에 있는 메소드 호출 
		// false 반환		=> Handler호출 안하고 return
		
		// 로그인이 되어있다면 => true 반환
		// 로그인이 되어있지 않다면 => false 반환
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") != null) {
			
			return true;
			
		} else {
			
			session.setAttribute("alertMsg", "로그인하고오셈");
			
			response.sendRedirect(request.getContextPath());
			
			return false;
			
		}
		
	}
	
}
