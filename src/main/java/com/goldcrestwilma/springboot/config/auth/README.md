### @EnableWebSecurity
 - Spring Security 설정들을 활성화

### authorizeRequests  
 - URL 별 권한 관리를 설정하는 옵션의 시작점
 - authorizeRequests 가 선언되어야만 antMatchers 옵션을 사용할 수 있음

### antMatchers
 - 권한 관리 대상을 지정하는 옵션
 - URL, HTTP 메서드별로 관리가 가능
 - "/" 등 지정된 URL 들은 `permitAll()` 옵션을 통해 전체 열람 권한을 부여
 - "/api/v1/**" 주소를 가진 API 는 USER 권한을 가진 사람만 가능하도록 부여

### logout().logoutSuccessUrl("/")
 - 로그아웃 기능에 대한 여러 설정의 진입점
 - 로그아웃 성공 시 / 주소로 이동

### oauth2Login
 - OAuth2 로그인 기능에 대한 여러 설정의 진입점

### userInfoEndpoint
 - OAuth2 로그인 성공 이후 사용자 정보를 가져올 때의 설정들을 담당


