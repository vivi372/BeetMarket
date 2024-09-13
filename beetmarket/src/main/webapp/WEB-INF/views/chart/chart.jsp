<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script
          src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script
          src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
          src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
     <!-- Custom CSS for layout -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }
        #main {
            width: 100%;
            height: 400px;
        }
        .chart-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .stock-list, .trade-form {
            border: 1px solid #ddd;
            padding: 20px;
            background-color: #f9f9f9;
            margin-top: 20px;
        }
        .stock-list h4, .trade-form h4 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .trade-form button {
            width: 100%;
        }
        .trade-form {
            display: none; /* 기본적으로 매수/매도 폼을 숨김 */
        }
        .stock-info {
            display: none; /* 기본적으로 상단 종목 정보를 숨김 */
        }
            .stock-info-container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   		}

	    .table {
	        margin-top: 20px;
	    }
	
	    .table-hover tbody tr:hover {
	        background-color: #f1f1f1;
	    }
	
	    .table th, .table td {
	        vertical-align: middle;
	    }
	
	    /* Highlight colors for stock changes */
	    .highlight-positive {
	        color: red;
	        font-weight: bold;
	    }
	
	    .highlight-negative {
	        color: blue;
	        font-weight: bold;
	    }
        
    </style>
 
<script type="text/javascript">
function drawChart(chartData) {
    // 종목 이름 설정
    const stockName = chartData.output1.hts_kor_isnm;

    // chartData를 확인
    console.log(chartData);
 	
    // 날짜 포맷팅 함수
    function formatDate(date) {
        if (date.length === 8) {  // 입력 값이 8자리인지 확인
            var year = date.substring(0, 4);  // 연도 추출
            var month = date.substring(4, 6); // 월 추출
            var day = date.substring(6, 8);   // 일 추출
            return `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
        } else {
            console.error("잘못된 날짜 형식입니다.");  // 날짜 형식 오류 시 로그 출력
            return null;
        }
    }

    // output2 데이터를 오래된 시간순으로 정렬
    chartData.output2.sort(function(a, b) {
        var timeA = a.stck_bsop_date; // 날짜로만 비교
        var timeB = b.stck_bsop_date;
        return timeA.localeCompare(timeB); // 오름차순 정렬
    });

    // chartData.output2 데이터를 이용해 차트를 그리기
    var rawData = chartData.output2.map(item => {
    	 
        return [
            formatDate(item.stck_bsop_date), // 날짜 포맷
            parseFloat(item.stck_oprc),
            parseFloat(item.stck_clpr),
            parseFloat(item.stck_lwpr),
            parseFloat(item.stck_hgpr),
            parseFloat(item.acml_vol) // 거래량을 사용
        ];
    });

    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);
    var option;

    const upColor = '#00da3c';
    const downColor = '#ec0000';

    function splitData(rawData) {
        let categoryData = [];
        let values = [];
        let volumes = [];
        for (let i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]); // 날짜 분리
            values.push(rawData[i]); // OHLC 데이터
            volumes.push([i, rawData[i][4], rawData[i][0] > rawData[i][1] ? 1 : -1]); // 거래량
        }
        return {
            categoryData: categoryData, // 날짜 데이터
            values: values, // OHLC 데이터
            volumes: volumes // 거래량 데이터
        };
    }

    function calculateMA(dayCount, data) {
        var result = [];
        for (var i = 0, len = data.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data.values[i - j][1]; // 종가 사용
            }
            result.push(+(sum / dayCount).toFixed(3));
        }
        return result;
    }

    var data = splitData(rawData);
    myChart.setOption(
        (option = {
            animation: false,
            legend: {
                bottom: 10,
                left: 'center',
                data: [stockName, 'MA5', 'MA10', 'MA20', 'MA30'] // 종목명을 동적으로 설정
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                },
                borderWidth: 1,
                borderColor: '#ccc',
                padding: 10,
                textStyle: {
                    color: '#000'
                },
                position: function (pos, params, el, elRect, size) {
                    const obj = {
                        top: 10
                    };
                    obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 30;
                    return obj;
                }
            },
            axisPointer: {
                link: [
                    {
                        xAxisIndex: 'all'
                    }
                ],
                label: {
                    backgroundColor: '#777'
                }
            },
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: false
                    },
                    brush: {
                        type: ['lineX', 'clear']
                    }
                }
            },
            brush: {
                xAxisIndex: 'all',
                brushLink: 'all',
                outOfBrush: {
                    colorAlpha: 0.1
                }
            },
            visualMap: {
                show: false,
                seriesIndex: 5,
                dimension: 2,
                pieces: [
                    {
                        value: 1,
                        color: downColor
                    },
                    {
                        value: -1,
                        color: upColor
                    }
                ]
            },
            grid: [
                {
                    left: '10%',
                    right: '8%',
                    height: '50%'
                },
                {
                    left: '10%',
                    right: '8%',
                    top: '63%',
                    height: '16%'
                }
            ],
            xAxis: [
                {
                    type: 'category',
                    data: data.categoryData, // 날짜 데이터 설정
                    boundaryGap: false,
                    axisLine: { onZero: false },
                    splitLine: { show: false },
                    min: 'dataMin',
                    max: 'dataMax',
                    axisPointer: {
                        z: 100
                    }
                },
                {
                    type: 'category',
                    gridIndex: 1,
                    data: data.categoryData,
                    boundaryGap: false,
                    axisLine: { onZero: false },
                    axisTick: { show: false },
                    splitLine: { show: false },
                    axisLabel: { show: false },
                    min: 'dataMin',
                    max: 'dataMax'
                }
            ],
            yAxis: [
                {
                    scale: true,
                    splitArea: {
                        show: true
                    }
                },
                {
                    scale: true,
                    gridIndex: 1,
                    splitNumber: 2,
                    axisLabel: { show: false },
                    axisLine: { show: false },
                    axisTick: { show: false },
                    splitLine: { show: false }
                }
            ],
            dataZoom: [
                {
                    type: 'inside',
                    xAxisIndex: [0, 1],
                    start: 1,
                    end: 100
                },
                {
                    show: true,
                    xAxisIndex: [0, 1],
                    type: 'slider',
                    top: '85%',
                    start: 98,
                    end: 100
                }
            ],
            series: [
                {
                    name: stockName, // 종목명으로 설정
                    type: 'candlestick',
                    data: data.values,
                    itemStyle: {
                        color: upColor,
                        color0: downColor,
                        borderColor: undefined,
                        borderColor0: undefined
                    }
                },
                {
                    name: 'MA5',
                    type: 'line',
                    data: calculateMA(5, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA10',
                    type: 'line',
                    data: calculateMA(10, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA20',
                    type: 'line',
                    data: calculateMA(20, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA30',
                    type: 'line',
                    data: calculateMA(30, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'Volume',
                    type: 'bar',
                    xAxisIndex: 1,
                    yAxisIndex: 1,
                    data: data.volumes
                }
            ]
        }),
        true
    );

    option && myChart.setOption(option);
}


</script>
          
          
<script type="text/javascript">
    
$(function() {
    // 차트 데이터를 가져오는 함수
    function getChartData(period_div_code, company_code) {
        
        // company_code가 0이거나 null이면 기본값 "삼성전자로"로 설정
        if (!company_code || company_code === 0) {
            company_code = "005930";
        }
        
        // period_div_code가 0이거나 null이면 기본값 "KOSPI"로 설정
        if (!period_div_code || period_div_code === 0) {
        	period_div_code = "M";
        }
        // 날짜 계산 (오늘 날짜와 10년 전 날짜)
        const today = new Date();
        const tenYearsAgo = new Date();
        tenYearsAgo.setFullYear(today.getFullYear() - 10);

        function formatDate(date) {
            let year = date.getFullYear();
            let month = ('0' + (date.getMonth() + 1)).slice(-2);
            let day = ('0' + date.getDate()).slice(-2);
            return year + month + day;
        }

        // 요청할 데이터
        let data = {
        	company_code: company_code,
            period_div_code: period_div_code,  // 일봉(D), 주봉(W), 월봉(M)
            startDate: formatDate(tenYearsAgo),
            endDate: formatDate(today)
        };

        console.log("Request data: ", data);

        // AJAX 요청으로 데이터 가져오기
        $.ajax({
            type: "post",  // POST 요청
            url: "/chart/getChartDate.do",  // 요청할 URL
            data: JSON.stringify(data),  // JSON 데이터 전송
            contentType: "application/json; charset=UTF-8",  // Content-Type 설정
            dataType: "json",  // 서버에서 반환되는 데이터를 JSON으로 파싱
            success: function(result) {
                console.log("Received data: ", result);  // 이미 JSON으로 파싱된 데이터를 출력
                drawChart(result);  // 파싱된 데이터를 사용하여 차트를 그리기
            },
            error: function(xhr, status, er) {
                console.error("Error: ", er);
                alert("요청 중 오류가 발생했습니다.");
            }
        });
    }
    
 
	// 주식 정보 불러오기
    function getStockInfo(company_code) {
        // 요청할 데이터 (쿼리 문자열로 변환)
        let url = "/stock/getStockInfoData.do?company_code=" + encodeURIComponent(company_code);

        console.log("Request URL: ", url);

        // AJAX 요청으로 데이터 가져오기 (GET 방식)
        $.ajax({
            type: "get",  // GET 요청
            url: url,     // 쿼리 문자열을 포함한 URL
            contentType: "application/json; charset=UTF-8",  // Content-Type 설정
            dataType: "json",  // 서버에서 반환되는 데이터를 JSON으로 파싱
            success: function(result) {
                console.log("@@@Received data: ", result);  // 이미 JSON으로 파싱된 데이터를 출력
                updateStockInfo(result);  // 성공적으로 데이터를 받으면 바로 updateStockInfo 함수 호출
            },
            error: function(xhr, status, er) {
                console.error("Error: ", er);
                alert("@@@요청 중 오류가 발생했습니다.");
            }
        });
    }
	
    function updateStockInfo(stockData) {
        // 주식 데이터를 UI에 반영
        console.log("@@updateStockInfo에 있는 stockData ", stockData);
        console.log("@@stockData.stck_prpr", stockData.output.stck_prpr);
        $('#stockPrice').text(stockData.output.stck_prpr.toLocaleString());
        $('#stockPer').text(stockData.output.per);
        $('#stockPbr').text(stockData.output.pbr);
        $('#stockEps').text(stockData.output.eps.toLocaleString()); // eps는 정수로 처리
        $('#stockBps').text(stockData.output.bps.toLocaleString()); // bps도 정수로 처리
        $('#acmlTrPbmn').text(stockData.output.acml_tr_pbmn.toLocaleString());
        $('#acmlVol').text(stockData.output.acml_vol.toLocaleString());
        $('#stockOpenPrice').text(stockData.output.stck_oprc.toLocaleString());
        $('#stockHighPrice').text(stockData.output.stck_hgpr.toLocaleString());
        $('#stockLowPrice').text(stockData.output.stck_lwpr.toLocaleString());
        $('#stockMaxPrice').text(stockData.output.stck_mxpr.toLocaleString());
        $('#stockMinPrice').text(stockData.output.stck_llam.toLocaleString());

        // 전일 대비와 전일 대비율 처리
        $('#stockChange').text(stockData.output.prdy_vrss > 0 ? "+" + stockData.output.prdy_vrss.toLocaleString() : stockData.output.prdy_vrss.toLocaleString());
        $('#stockChangeRate').text(stockData.output.prdy_ctrt);

        // 색상 변경 (양수면 빨간색, 음수면 파란색)
        if (stockData.prdy_vrss > 0) {
            $('#stockChange').addClass('highlight-positive').removeClass('highlight-negative');
            $('#stockChangeRate').addClass('highlight-positive').removeClass('highlight-negative');
        } else if (stockData.prdy_vrss < 0) {
            $('#stockChange').addClass('highlight-negative').removeClass('highlight-positive');
            $('#stockChangeRate').addClass('highlight-negative').removeClass('highlight-positive');
        } else {
            $('#stockChange').css('color', 'black');
            $('#stockChangeRate').css('color', 'black');
        }
    }

    // 라디오 버튼이 클릭될 때마다 차트 종류에 따라 작동
    $('input[name="optradio"]').change(function() {
        let period_div_code = $(this).val();  // 선택된 값(D, W, M)
        let company_code = $(this).closest('label').attr('data-company_code');
        
        getChartData(period_div_code, company_code);  // 차트 데이터 가져오기
    });
    
    $('.change-rate').each(function() {
        // data-rate 속성에서 값을 가져옴
        var rate = parseFloat($(this).data('rate'));

        // 수익률이 양수면 빨간색, 음수면 연한 파란색 적용
        if (rate > 0) {
            $(this).css('color', 'red');
        } else if (rate < 0) {
            $(this).css('color', 'blue');
        } else {
            $(this).css('color', 'black'); // 0%는 검정색
        }
    });
    
    
    // 주식 리스트에서 항목 클릭 시 종목 정보 표시
    $('.stock-item').on('click', function() {
        var company_code = $(this).data('company_code'); 
        var company_name = $(this).data('company_name'); 
        $('#stockName').text("종목명: " + company_name); // 'bstp_kor_isnm'이 '종목명'에 해당
        // 라디오 버튼의 data-company_no 속성에 해당 값 설정
        $('label[for="dayChart"]').attr('data-company_code', company_code);
        $('label[for="weekChart"]').attr('data-company_code', company_code);
        $('label[for="monthChart"]').attr('data-company_code', company_code);
        console.log("클릭 메소드 실행시 나오는 company_code: ", company_code);
        getChartData('M', company_code);  
        getStockInfo(company_code);// 주식 정보를 가져온 후 바로 업데이트
        $('.stock-info').show();
        $('.trade-form').show();
    });

    // 매수 버튼 클릭 시 처리
    $('#buyBtn').on('click', function() {
        var quantity = $('#quantity').val();
        var price = $('#price').val();

        if (!quantity || !price) {
            alert("수량과 가격을 입력해주세요.");
            return;
        }

        alert("매수를 진행합니다.");
        // 매수 로직 처리 (서버로 전송 등)
    });

    // 매도 버튼 클릭 시 처리
    $('#sellBtn').on('click', function() {
        var quantity = $('#quantity').val();
        var price = $('#price').val();

        if (!quantity || !price) {
            alert("수량과 가격을 입력해주세요.");
            return;
        }

        alert("매도를 진행합니다.");
        // 매도 로직 처리 (서버로 전송 등)
    });

});



</script>      
</head>


<body>

    <!-- Layout: Left (Stock List), Center (Chart), Right (Trade Form) -->
   
        <div class="row">
            <!-- Left: Stock List -->
			<div class="col-md-2 stock-list">
			    <h4>주식 리스트</h4>
			    <ul class="list-group">
			    	<c:forEach items="${stockList }" var="vo">
			        <li class="list-group-item d-flex justify-content-between align-items-center stock-item" data-company_code="${vo.company_code }" data-company_name="${vo.company_name }">
			            <div>
			                <strong>${vo.company_name }</strong><br>
			                <small class="text-muted">${vo.company_code }</small>  <!-- 주식 코드 -->
			            </div>
			            <div class="text-right">
			                <span class="d-block price">${vo.stck_prpr }</span> <!-- 현재가 -->
			                <small class="d-block change-rate" data-rate="${vo.prdy_ctrt }">${vo.prdy_ctrt }</small> <!-- 전일 대비 수익률 -->
			            </div>
			        </li>
			        </c:forEach>
			    </ul>
			</div>


            <!-- Center: Chart -->
            <div class="col-md-6">
                <div class="chart-container">
                    <div id="main"></div>
                </div>

                <!-- Chart Type Selection -->
                <div class="form-check">
                    <label class="form-check-label" for="dayChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="D" id="dayChart">일봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label" for="weekChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="W" id="weekChart">주봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label" for="monthChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="M" id="monthChart">월봉
                    </label>
                </div>
            </div>

            <!-- Right: Trade Form -->
            <div class="col-md-4">
                <!-- 종목 정보 표시 -->
                <div class="container stock-info-container">
				    <h4 class="text-center my-4" id="stockName">종목명: </h4>
				    <table class="table table-bordered table-hover table-striped text-center">
				        <thead class="thead-light">
				            <tr>
				                <th>항목</th>
				                <th>내용</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>주가</td>
				                <td><span id="stockPrice"></span> 원</td>
				            </tr>
				            <tr>
				                <td>PER</td>
				                <td><span id="stockPer"></span></td>
				            </tr>
				            <tr>
				                <td>PBR</td>
				                <td><span id="stockPbr"></span></td>
				            </tr>
				            <tr>
				                <td>EPS</td>
				                <td><span id="stockEps"></span></td>
				            </tr>
				            <tr>
				                <td>BPS</td>
				                <td><span id="stockBps"></span></td>
				            </tr>
				            <tr>
				                <td>전일 대비</td>
				                <td><span id="stockChange"></span></td>
				            </tr>
				            <tr>
				                <td>전일 대비율</td>
				                <td><span id="stockChangeRate"></span>%</td>
				            </tr>
				            <tr>
				                <td>누적 거래 대금</td>
				                <td><span id="acmlTrPbmn"></span> 원</td>
				            </tr>
				            <tr>
				                <td>누적 거래량</td>
				                <td><span id="acmlVol"></span></td>
				            </tr>
				            <tr>
				                <td>시가</td>
				                <td><span id="stockOpenPrice"></span> 원</td>
				            </tr>
				            <tr>
				                <td>고가</td>
				                <td><span id="stockHighPrice"></span> 원</td>
				            </tr>
				            <tr>
				                <td>저가</td>
				                <td><span id="stockLowPrice"></span> 원</td>
				            </tr>
				            <tr>
				                <td>최고가</td>
				                <td><span id="stockMaxPrice"></span> 원</td>
				            </tr>
				            <tr>
				                <td>최저가</td>
				                <td><span id="stockMinPrice"></span> 원</td>
				            </tr>
				        </tbody>
				    </table>
				</div>

                <!-- 매수 / 매도 폼 -->
                <div class="trade-form">
                    <h4>매수 / 매도</h4>
                    <form>
                        <div class="form-group">
                            <label for="quantity">수량</label>
                            <input type="number" class="form-control" id="quantity" placeholder="수량 입력">
                        </div>
                        <div class="form-group">
                            <label for="price">가격</label>
                            <input type="number" class="form-control" id="price" placeholder="가격 입력">
                        </div>
                        <button type="button" class="btn btn-success" id="buyBtn">매수</button>
                        <button type="button" class="btn btn-danger mt-2" id="sellBtn">매도</button>
                    </form>
                </div>
            </div>
           </div>
  

</body>
</html>
