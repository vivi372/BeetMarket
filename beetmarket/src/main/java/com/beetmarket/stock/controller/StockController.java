package com.beetmarket.stock.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.stock.service.StockService;
import com.beetmarket.stock.vo.StockVO;

import lombok.extern.log4j.Log4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;



/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/stock")
@Log4j
public class StockController {
	
	TokenController tc = new TokenController();
    private final String APP_KEY = "PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq"; // 실제 키로 교체 필요
    private final String APP_SECRET = "5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo="; // 실제 키로 교체 필요
    
	// 자동 DI 
	@Autowired 
	@Qualifier("StockServiceImpl")
	private StockService stockService;

	@GetMapping("/stockMain.do")
	public String stockMain(Model model) {
		
		model.addAttribute("stockList", stockService.stockList());
		
		return "stock/stockMain";
	}
	
	@GetMapping("/stockList.do")
	public String stockList(Model model) {
		
		
		return "stock/stockList";
	}
    
    // 주식 정보 가져오기
    @GetMapping(value = "/getStockInfoData.do",
			produces = "text/plain; charset=UTF-8") 
    public ResponseEntity<String> getStockInfoData(StockVO vo, HttpSession session) {
    	tc.getTokenP(session);
        
        log.info("@@@@@@@@@@@@@@@@@ ="+ vo);
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        String token = (String) session.getAttribute("token");
        log.info("@@@@@@@@@@@@@@@@@ token: " + token);
        Request request = new Request.Builder()
            .url("https://openapivts.koreainvestment.com:29443/uapi/domestic-stock/v1/quotations/inquire-price?"
            	+ "fid_cond_mrkt_div_code=J"
            	+ "&fid_input_iscd="+vo.getCompany_code()
            )
            .get()
            .addHeader("authorization", "Bearer " + token)
            .addHeader("appkey", APP_KEY)
            .addHeader("appsecret", APP_SECRET)
            .addHeader("tr_id", "FHKST01010100")
            .build();

        try {
            Response response = client.newCall(request).execute();
            String responseBody = response.body().string();  // ResponseBody를 변수에 저장
            log.info("@@@@@@@@@@@@@@@@@ ="+ responseBody);
            if (response.isSuccessful()) {
                return new ResponseEntity<String>(responseBody, HttpStatus.OK);  // 성공 시 JSON 반환
            } else {
                return new ResponseEntity<String>("", HttpStatus.OK);
            }
            
        } catch (IOException e) {
            return new ResponseEntity<String>(e.getMessage(), HttpStatus.OK);
        }
    } 
	
}
