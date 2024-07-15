package com.kh.artspark.buy.model.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PortoneService {

	@Value("${portone.apiKey}")
	private String apiKey;
	
	@Value("${portone.apiSecret}")
	private String apiSecret;
	
	public String getAccessToken() throws IOException, InterruptedException{
		
		HttpRequest request = HttpRequest.newBuilder()
		    .uri(URI.create("https://api.iamport.kr/users/getToken"))
		    .header("Content-Type", "application/json")
		    .method("POST", HttpRequest.BodyPublishers.ofString(String.format("{\"imp_key\":\"%s\",\"imp_secret\":\"%s\"}", apiKey, apiSecret)))
		    .build();
		
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		System.out.println(response.body());
		
		return response.body();
    }
	
	public String getPaymentInfo(String impUid) throws IOException, InterruptedException {
        String accessToken = getAccessToken();

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://api.iamport.kr/payments/" + impUid))
            .header("Content-Type", "application/json")
            .header("Authorization", accessToken)
            .GET()
            .build();

        HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println(response.body());

        return response.body();
    }
}
