package com.kh.artspark.buy.model.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class PortoneService {

	@Value("${portone.apiKey}")
	private String apiKey;
	
	@Value("${portone.apiSecret}")
	private String apiSecret;
	
	// portone api를 요청하기 위한  accessToken 발급 메서드
	public String getAccessToken() throws IOException, InterruptedException{
		
		HttpRequest request = HttpRequest.newBuilder()
		    .uri(URI.create("https://api.iamport.kr/users/getToken"))
		    .header("Content-Type", "application/json")
		    .method("POST", HttpRequest.BodyPublishers.ofString(String.format("{\"imp_key\":\"%s\",\"imp_secret\":\"%s\"}", apiKey, apiSecret)))
		    .build();
		
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		System.out.println(response.body());
		
		JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
		
		return jsonResponse.get("response").getAsJsonObject().get("access_token").getAsString();
    }
	
	// 결제금액 사전 등록(결제금액 위변조시 결제 진행을 block하기 위함)
	public JsonObject setPreparePayment(String merchant_uid, int amount) throws IOException, InterruptedException {
		String accessToken = getAccessToken();
		
		HttpRequest request = HttpRequest.newBuilder()
		    .uri(URI.create("https://api.iamport.kr/payments/prepare"))
		    .header("Content-Type", "application/json")
		    .header("Authorization", accessToken)
		    .method("POST", HttpRequest.BodyPublishers.ofString(String.format("{\"merchant_uid\":\"%s\",\"amount\":%d}", merchant_uid, amount)))
		    .build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		System.out.println(response.body());
		
		JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
		
		return jsonResponse.get("response").getAsJsonObject();
	}
	
	// 결제내역 단건 조회 API
	public JsonObject getPaymentInfo(String impUid) throws IOException, InterruptedException {
        String accessToken = getAccessToken();

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://api.iamport.kr/payments/" + impUid))
            .header("Content-Type", "application/json")
            .header("Authorization", accessToken)
            .GET()
            .build();

        HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println(response.body());

        JsonObject jsonResponse = JsonParser.parseString(response.body()).getAsJsonObject();
        
        if (jsonResponse.has("response") && !jsonResponse.get("response").isJsonNull()) {
            return jsonResponse.get("response").getAsJsonObject();
        } else {
            return null;
        }
    }
}
