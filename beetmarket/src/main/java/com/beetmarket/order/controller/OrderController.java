package com.beetmarket.order.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.order.service.OrderService;

import com.beetmarket.order.vo.OrderOptVO;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {
	
	@Autowired
	@Qualifier("OrderServiceImpl")
	OrderService service;
	
	String id = "test";
	
	@GetMapping("/list.do")
	public String list(SearchVO searchVO,HttpServletRequest request,Model model,RedirectAttributes rttr) throws Exception {
				
		//날짜 검색에 아무것도 입력 안 됐을때 처리
		if(searchVO.getMaxDate() == null && searchVO.getMinDate() == null) {
			LocalDate today = LocalDate.now();			
			LocalDate minDate = today.minusYears(5);
			
			searchVO.setMaxDate(today);
			searchVO.setMinDate(minDate);
		}
		
		log.info(searchVO);
		
		//페이지와 검색을 위해 페이지 오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);
		//아이디를 페이지 오브젝트에 넣기
		pageObject.setAccepter(id);
		//DB에서 데이터 가져와 담기
		List<OrderVO> list = service.orderList(pageObject,searchVO);
		
		
		//데이터 담기
		model.addAttribute("list", list);		
		model.addAttribute("pageObject", pageObject);
		model.addAttribute("searchVO", searchVO);
		
		return "order/list";
	}
	
	@PostMapping("/writeForm.do")
	public String writeForm(Long[] goodsNo, Long[] optNo,Long[] amount,Long[] basketNo,Model model) {
		log.info("goodsNo : "+ Arrays.toString(goodsNo));
		log.info("optNo : "+Arrays.toString(optNo));
		log.info("amount : "+Arrays.toString(amount));
		
		Map<String, Object> map = service.writeFrom(goodsNo, optNo);
		
		@SuppressWarnings("unchecked")
		List<OrderOptVO> optList = (List<OrderOptVO>) map.get("optList");
		

		
		for(int i=0;i<goodsNo.length;i++) {
			OrderOptVO optVO = null;
			try {
				//옵션이 없으면 옵션 리스트의 길이가 상품 번호 배열의 길이보다 적어 예외 발생
				optVO = optList.get(i);					
			} catch (Exception e) {
				optVO = new OrderOptVO();
			}
			if(optVO.getGoodsNo() == goodsNo[i])
				optVO.setAmount(amount[i]);
			else {
				optVO.setAmount(amount[i]);
				optVO.setGoodsNo(goodsNo[i]);
				optList.add(i,optVO);
			}
		}
		
		
		log.info(map.get("goodsList"));
		log.info(optList);
		
		model.addAttribute("goodsList", map.get("goodsList"));
		model.addAttribute("optList", optList);
		model.addAttribute("basketNo", basketNo);


		
		return "order/writeForm";
	}
	
	@GetMapping("/write.do")
	public String write(String query,String orderId,String amount,String paymentKey,RedirectAttributes rttr) throws Exception  {
		JSONObject toss = tossPayment(orderId,amount,paymentKey);
		log.info(toss);
		query = query.replaceAll("\\s+", "");		
	
		byte[] decodedBytes = Base64.getDecoder().decode(query);
		String queryDecode = new String(decodedBytes,"utf-8");
		
		JSONParser parser = new JSONParser();
		JSONObject queryObj = (JSONObject) parser.parse(queryDecode);
		
		log.info(queryObj);
		
		List<OrderVO> list = null;
		JSONArray jsonArray = (JSONArray) queryObj.get("items");		
		for(int i=0;i<jsonArray.size();i++ ) {
			if(list == null) list = new ArrayList<OrderVO>();
			OrderVO vo = new OrderVO();
			JSONObject json = (JSONObject) jsonArray.get(i);
			
			vo.setDlvyAddrNo(Long.parseLong((String) queryObj.get("dlvyAddrNo")));
					
			
			vo.setDlvyMemo((String) json.get("dlvyMemo"));
			vo.setOrderPrice(Long.parseLong((String) json.get("orderPrice")));
			vo.setDlvyCharge(Long.parseLong((String) json.get("dlvyCharge")));
			vo.setGoodsNo(Long.parseLong((String) json.get("goodsNo")));
			vo.setOptNo(Long.parseLong((String) json.get("optNo")));
			vo.setAmount(Long.parseLong((String) json.get("amount")));
			
			vo.setPayWay((String) toss.get("method"));
			vo.setPayDetail((String) ((JSONObject)toss.get("card")).get("number"));
			vo.setPaymentKey(paymentKey);
			
			vo.setId(id);
			
			list.add(vo);
		}
		
		log.info(list);
		
		int result = service.write(list);
		
		rttr.addFlashAttribute("msg", "주문 "+result+"건이 정상적으로 결제되었습니다.");
		
		return "redirect:/order/list.do";
	}
	
	
	@SuppressWarnings("unchecked")
	private JSONObject tossPayment(String orderId,String amount,String paymentKey) throws Exception {
		
		JSONParser parser = new JSONParser();
		
		JSONObject json = new JSONObject();
		json.put("orderId",orderId);
		json.put("amount",amount);
		json.put("paymentKey",paymentKey);
		
		// 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);
        
        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        
        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(json.toString().getBytes("UTF-8"));

        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;
        

        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject toss = (JSONObject) parser.parse(reader);
        responseStream.close();
        
        
		return toss;
	}

}
