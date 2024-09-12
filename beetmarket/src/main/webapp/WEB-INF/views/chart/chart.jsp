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
    function getChartData(period_div_code) {
        let company_code = "000660";  // 회사 ID 설정
        
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

    // 라디오 버튼이 클릭될 때마다 차트 종류에 따라 작동
    $('input[name="optradio"]').change(function() {
        let period_div_code = $(this).val();  // 선택된 값(D, W, M)
        getChartData(period_div_code);  // 차트 데이터 가져오기
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
        var stockData = $(this).data('stock'); // data-stock 속성에서 주식 데이터 가져오기
        $('#stockName').text("종목명: " + stockData.name);
        $('#stockPrice').text(stockData.price);
        $('#stockPer').text(stockData.per);
        $('#stockPbr').text(stockData.pbr);
        $('#stockMarketCap').text(stockData.marketCap.toLocaleString());

        // 종목 정보를 표시하고 매수/매도 폼도 보이게 함
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
        <li class="list-group-item d-flex justify-content-between align-items-center ">
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
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="optradio" value="D" id="dayChart">일봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="optradio" value="W" id="weekChart">주봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="optradio" value="M" id="monthChart">월봉
                    </label>
                </div>
            </div>

            <!-- Right: Trade Form -->
            <div class="col-md-4">
                <!-- 종목 정보 표시 -->
                <div class="stock-info">
                    <h4 id="stockName">종목명: 삼성전자</h4>
                    <p>주가: <span id="stockPrice">70,000</span></p>
                    <p>PER: <span id="stockPer">12.5</span></p>
                    <p>PBR: <span id="stockPbr">1.2</span></p>
                    <p>주가 총액: <span id="stockMarketCap">500,000,000,000</span></p>
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
