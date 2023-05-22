// 로드 밸런서 
resource "openstack_lb_loadbalancer_v2" "tf_loadbalancer_01" {
  name           = "tf_loadbalancer_01"
  description    = "create loadbalancer by terraform."
  vip_subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  vip_address    = "192.168.0.90"
  admin_state_up = true
}


// 로드 밸런서 플로팅 IP (콘솔 수동 연결)
resource "openstack_compute_floatingip_v2" "lb_fip" {
  pool = "Public Network"
}


// 로드 밸런서 리스너 
resource "openstack_lb_listener_v2" "tf_listener_http_01" {
  name        = "tf_listener_01"
  description = "create listener by terraform."

  // 리스너 프로토콜 (TCP, HTTP, HTTPS, TERMINATED_HTTPS)
  protocol               = "HTTP"
  protocol_port          = 80                                                 // 리스너 포트
  loadbalancer_id        = openstack_lb_loadbalancer_v2.tf_loadbalancer_01.id // 리스너가 연결할 로드밸런서 ID
  default_pool_id        = ""                                                 // 리스너에 연결될 기본 풀 ID
  connection_limit       = 2000                                               // ms 리스너에 허용되는 최대 연결 수 
  timeout_client_data    = 5000                                               // ms 클라이언트 비활동 시 타임아웃 설정 
  timeout_member_connect = 5000                                               // ms 멤버 연결 시 타임아웃 설정
  timeout_member_data    = 5000                                               // ms 멤버 비활동 시 타임아웃 시간 설정 
  timeout_tcp_inspect    = 5000                                               // ms 콘텐츠 검사를 위해 TCP 패킷을 기다리는 시간
  admin_state_up         = true                                               // 관리자 제어 상태
}

// 로드 밸런서 풀 생성 
// NHN Cloud는 풀 생성 시에 loadbalancer_id 지정을 지원하지 않습니다.
resource "openstack_lb_pool_v2" "tf_pool_01" {
  name        = "tf_pool_01"
  description = "create pool by terraform."

  // TCP, HTTP, HTTPS, PROXY
  protocol    = "HTTP"
  listener_id = openstack_lb_listener_v2.tf_listener_http_01.id // 생성할 풀이 연결될 리스너 ID

  // ROUND_ROBIN, LEAST_CONNECTIONS, SOURCE_IP 
  lb_method = "LEAST_CONNECTIONS" // 풀의 트래픽을 멤버에게 분배하는 로드 밸런싱 방식

  persistence { // 생성할 풀의 세션 지속성
    // 세션 지속성 타입: SOURCE_IP, HTTP_COOKIE, APP_COOKIE
    // ! 위 lb_method가 SOURCE_IP인 경우 사용 불가
    // ! 프로토콜이 HTTPS이거나 TCP인 경우 HTTP_COOKIE와 APP_COOKIE를 사용 불가
    type = "APP_COOKIE"

    // 쿠키 이름, 세션 지속성 타입이 APP_COOKIE인 경우에만 사용 가능
    cookie_name = "testCookie"
  }
  admin_state_up = true
}


// 로드 밸런서 헬스모니터 생성 
resource "openstack_lb_monitor_v2" "tf_monitor_01" {
  name    = "tf_monitor_01"
  pool_id = openstack_lb_pool_v2.tf_pool_01.id

  // TCP, HTTP, HTTPS 
  type        = "HTTP"
  delay       = 20    // 상태 확인 간격 
  timeout     = 10    // 상태 확인 응답 대기 시간 (초)
  max_retries = 5     // 최대 재시도 횟수 (1 ~ 10 사이의 값)
  url_path    = "/"   // 상태 확인 요청 URL 
  http_method = "GET" // 상태 확인에 사용할 HTTP 메서드 (기본값 GET)

  // expected_codes는 목록 (200, 201, 202)이나 범위 지정 (200-202)도 가능 
  expected_codes = "200-202" // 정상 상태로 간주할 멤버의 HTTP(S) 응답 코드
  admin_state_up = true
}


// 로드 밸런서 인스턴스 연결 추가
resource "openstack_lb_member_v2" "tf_member_01" {
  pool_id   = openstack_lb_pool_v2.tf_pool_01.id
  subnet_id = data.openstack_networking_subnet_v2.subnet.id


  // 로드밸런서에서 트래픽을 수신할 인스턴스의 IP 주소
  address        = openstack_compute_instance_v2.vm["server-1"].access_ip_v4
  protocol_port  = 8080 // 트래픽을 수신할 인스턴스의 포트 
  weight         = 4    // 풀에서 받아야 하는 트래픽의 가중치, 높을수록 트래픽을 많이 받음
  admin_state_up = true
}

