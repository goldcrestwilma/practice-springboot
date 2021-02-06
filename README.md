# springboot-with-AWS

spring-boot: 2.1.7  
gradle: 4.10.2  
jdk: 1.8  

---
<img width="787" alt="스크린샷 2021-01-20 00 10 06" src="https://user-images.githubusercontent.com/61505386/105054433-56656c80-5ab5-11eb-9bab-aaf664bd2db3.png">
<img width="421" alt="스크린샷 2021-01-20 00 10 18" src="https://user-images.githubusercontent.com/61505386/105054513-71d07780-5ab5-11eb-8185-28be13e69196.png">

---
## JPA Auditing

생성날짜와 수정날짜 자동으로 업데이트

<img width="1205" alt="Screenshot 2021-01-26 at 21 28 16" src="https://user-images.githubusercontent.com/61505386/105845141-a5635280-601d-11eb-8a11-6b8a6638e20c.png">

---
## 머스테치 (https://mustache.github.io/)

장점
 - 문법이 다른 템플릿 엔진보다 심플하다.
 - 로직 코드를 사용할 수 없어 View 의 역할과 서버의 역할이 명확하게 분리된다.
 - Mustache.js 와 Mustache.java 2가지가 다 있어, 하나의 문법으로 클라이언트/서버 템플릿을 모두 사용 가능하다.

---
## 스프링 시큐리티와 OAUth 2.0으로 로그인 기능 구현

### Google
<img width="728" alt="Screenshot 2021-01-28 at 1 32 07" src="https://user-images.githubusercontent.com/61505386/106022178-e8e6bb00-6108-11eb-8013-66384a382f05.png">
<img width="718" alt="Screenshot 2021-01-28 at 1 32 32" src="https://user-images.githubusercontent.com/61505386/106022177-e84e2480-6108-11eb-8755-2723b13716c7.png">
<img width="624" alt="Screenshot 2021-01-28 at 1 33 45" src="https://user-images.githubusercontent.com/61505386/106022167-e5ebca80-6108-11eb-960b-b79d12d155d1.png">

### Naver
<img width="704" alt="Screenshot 2021-01-28 at 22 48 42" src="https://user-images.githubusercontent.com/61505386/106147282-06745d00-61bb-11eb-86a5-75e5f9e0606a.png">
<img width="706" alt="Screenshot 2021-01-28 at 22 48 52" src="https://user-images.githubusercontent.com/61505386/106147269-04aa9980-61bb-11eb-9f93-fd099974eca7.png">


---
 - Infrastructure as a Service(IaaS, 아이에스, 이에스)
    - 기존 물리 장비를 미들웨어와 함께 묶어둔 추상화 서비스
    - 가산머신, 스토리지, 네트워크, 운영체제 등의 IT 인프라를 대여해 주는 서비스
    - AWS 의 EC2, S3 등
    
 - Platform as a Service (Paas, 파스)
   - 앞에서 언급한 IaaS에서 한 번 더 추상화한 서비스
   - 한 번 더 추상화했기 때문에 많은 기능이 자동화되어 있음
   - AWS 의 Beanstalk, Heroku 등
   
 - Software as a Service (SaaS, 사스)
   - 소프트웨어 서비스
   - 구글 드라이브, 드랍박스, 와탭 등
---
# AWS EC2(Elastic Compute Cloud)
### EC2 인스턴스 생성
 - 리전 확인
 - EC2 검색
 - AMI 선택
 - 인스턴스 유형 선택
 - 인스턴스 세부정보 구성
 - 스토리지 구성(30GB)
 - 태그 추가
 - 보안 그룹 추가(ssh - 내 IP)
 - 인스턴스 검토(키 페어 생성 pem)

인스턴스 생성 후
 - EIP(Elastic IP) 할당
 - 주소 연결

### EC2 서버 접속
 - ssh -i pem 키 위치 EC2의 탄역적 IP 주소

pem 파일을 ~/.ssh/ 복사
> chmod 600 ~/.ssh/pem키이름

> vi ~/.ssh/config
 
```
Host ec2
        HostName XXX.XXX.XXX.XXX
        User ec2-user
        IdentityFile ~/.ssh/XXX.pem
```

> chmod 700 ~/.ssh/config

### EC2 서버 설정
 - java8 설치
 - 타임존 변경
> sudo rm /etc/localtime
> sudo ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

 - Hostname 변경
> sudo vim /etc/sysconfig/network
 
HOSTNAME=XXX 추가
> sudo reboot


# AWS RDS
### RDS 인스턴스 생성
 - MariaDB
 - 사용사례(프리 티어)
 - 스토리지(20GB)
 - 네트워크 및 보안(퍼블릭 액세스 가능: 예)

### RDS 운영환경에 맞는 파라미터 설정
 - 타임존
 - Character Set
 - Max Connection

### EC2에서 RDS 접근확인
> sudo yum install mysql
> mysql -u 계정 -p -h host주소

# EC2 서버에 프로젝트 배포
EC2 접속 후
> sudo yum install git

> git --version

> mkdir -p ~/app/step1

> cd ~/app/step1

> git clone 주소

> ./gradlew test

> chmod +x ./gradlew

### 배포 스크립트
> vi ~/app/step1/deploy.sh

> chmod +x ./deploy.sh

### 외부 Security 파일 등록
> vim /home/ec2-user/app/application-oauth.properties

### EC2에서 소셜 로그인하기
 - AWS 보안 그룹 변경
 - EC2 퍼블릭 DNS
 - 구글에 EC2 주소 등록
 - 네이버에 EC2 주소 등록

# Travis CI 배포 자동화
https://travis-ci.com/ 계정생성 후 Settings Github 저장소 활성화

CI: Continuous Integration  
CD: Continuous Deployment

### 프로젝트 설
 - .travis.yml 작성
 - 마스터 브랜치 커밋 & 푸시   
 - Travis CI 자동 실행
 - Travis 결과 수신

### Travis CI 와 AWS S3 연동
S3(Simple Storage Service): AWS 에서 제공하는 일종의 파일 서버, 이미지 파일을 비롯한 정적 파일들을 관리하거나 배포 파일들을 관리하는 기능 지원
AWS CodeDeploy: 실제 배포

S3 에 jar 파일 전달 후 CodeDeploy 가 S3에서 jar 파일 가져와서 배포

### AWS key 발급
 - 접근 가능한 권한을 가진 key 생성
 - IAM(Identity and Access Management)
 - Travis CI 에 키 등록
   - AWS_ACCESS_KEY
   - AWS_SECRET_KEY
   
### S3 버킷 생성

## Travis CI, AWS S3, CodeDeploy 연동
### EC2 에 IAM 역할 추가
 - 역할
   - AWS 서비스에만 할당할 수 있는 권한
   - EC2, CodeDeploy, SQS 등
   
 - 사용자
   - AWS 서비스 외에 사용할 수 있는 권한
   - 로컬 PC, IDC 서버 등
   
### CodeDeploy Agent 설치
EC2 접속 후
> aws s3 cp s3://aws-codedeploy-ap-northeast-2/latest/install . --region ap-northeast-2

> chmod +x ./install

> sudo ./install auto

> sudo service codedeploy-agent status

> The AWS CodeDeploy agent is running as PID xxx

### CodeDeploy 를 위한 권한 생성

### CodeDeploy 생성
 - 애플리케이션 생성
 - 이름, 플랫폼 선택
 - 배포 그룹 생성
 - 환경 선택
 - 배포 설정

### 연동

S3에서 넘겨줄 zip 파일을 저장할 디렉토리 생성

EC2 접속
> mkdir -p ~/app/step2/zip

Travis CI 의 `Build` 가 끝나면 S3 에 `zip` 파일이 전송되고,  
이 `zip`파일은 `/home/ec2-user/app/step2/zip` 로 복사되어 압축을 풀 예정

AWS CodeDeploy 설정 `appspec.yml`

### 배포 자동화 구성
jar 파일 배포하여 실행








