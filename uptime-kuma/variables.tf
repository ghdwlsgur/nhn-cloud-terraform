variable "provider_openstack" {
  type        = map(string)
  description = "nhn cloud account access info"

  // KR1 : 판교
  // KR2 : 평촌
  // JP1 : 일본 도쿄
  // US1 : 미국 캘리포니아 

  // 엔드포인트 (NHN Cloud API 사용 가이드)
  // https://docs.nhncloud.com/ko/Compute/Compute/ko/identity-api/
  default = {
    region    = "KR1"                                                      // NHN Cloud 리전 선택 KR1 판교     
    auth_url  = "https://api-identity.infrastructure.cloud.toast.com/v2.0" // 모든 리전 엔드포인트                                            // API 비밀번호
  }
}

// 가상머신 스펙
variable "machines" {
  type        = map(string)
  description = "nhn cloud vitrual machine spec"
  default = {
    name              = "consul-serv01"  // 인스턴스 이름
    availability_zone = "kr-pub-a"       // 가용성 영역     
    flavor_name       = "m2.c4m8"        // 인스턴스 타입
    key_pair          = "centos-keypair" // 키 페어 이름
    # flavor_name       = "t2.c1m1"        // 인스턴스 타입
  }
}
