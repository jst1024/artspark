package com.kh.artspark.kakao.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.kh.artspark.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class KakaoService {
	
	@Value("${kakao.id}") 
	private String kakaoLogin;
	
public String getToken(String code)throws IOException, ParseException{
		
		String tokenUrl ="https://kauth.kakao.com/oauth/token";
		URL url = new URL(tokenUrl);
		HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
		
	
		
		
		urlConnection.setRequestMethod("POST");
		urlConnection.setDoOutput(true);
		
		BufferedWriter bw= new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
		
		StringBuilder sb = new StringBuilder();
		sb.append("client_id="+kakaoLogin);
		sb.append("&grant_type=authorization_code");
		sb.append("&redirect_uri=http://localhost/artspark/oauth");
		sb.append("&code=");
		sb.append(code);
		
		bw.write(sb.toString());
		bw.flush();
		
		//System.out.println(urlConnection.getResponseCode());
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String line= "";
		String responseData ="";
		
		while((line = br.readLine()) != null){
			responseData += line;
		}
		
		//System.out.println(responseData);
		
		JSONParser parser = new JSONParser();
		JSONObject element = (JSONObject)parser.parse(responseData);
		
		String accessToken = element.get("access_token").toString();
		//System.out.println(accessToken); 토큰 잘받음
		
		br.close();
		bw.close();
		
		return accessToken;
	}
public void logout(String accessToken) {
	
	String logoutUrl ="https://kapi_kakao.com/v1/user/logout";
	URL url;
	HttpURLConnection conn;
	
	try {
		url = new URL(logoutUrl);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		String responseData ="";
		String line ="";
		while((line= br.readLine()) != null) {
			responseData = line;
		}
		System.out.println(responseData);
	}catch (IOException e){
		e.printStackTrace();
	}

	
}
	
public Member getUserInfo(String accessToken) throws ParseException {
		
		String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
		Member member = null;
		try {
			URL url = new URL(userInfoUrl);
			HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
			urlConnection.setRequestMethod("GET");
			urlConnection.setRequestProperty("Authorization","Bearer " + accessToken);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
			
			String responseData =br.readLine();
			
			//System.out.println(responseData);
			
			JSONObject responseObj = (JSONObject)new JSONParser().parse(responseData);
			System.out.println(responseObj);
			JSONObject propObj = (JSONObject)responseObj.get("properties");
			
			//long id = Integer.parseInt(responseObj.get("id");
			
			member = new Member();
			member.setMemId(responseObj.get("id").toString());
			member.setMemNickname(propObj.get("nickname").toString());
			System.out.println(responseObj);
			
			//sm.setThumbnailImg(propObj.get("thumnail_image").toString());
			
		}catch(MalformedURLException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return member;
	}

}
