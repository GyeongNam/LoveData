package com.project.love_data.config;

import com.project.love_data.security.service.AuthenticationFailure;
import com.project.love_data.security.service.UserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.regex.Pattern;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
    @Autowired
    private UserDetailsService userDetailsService;
    private AuthenticationFailure authenticationFailure;

    @Override
  protected void configure(HttpSecurity http) throws Exception {
      http.authorizeRequests()
              .antMatchers("/member").hasRole("USER")
              .antMatchers("/admin").hasRole("ADMIN")
              .antMatchers("/all").permitAll()
              .and()
              .csrf().ignoringAntMatchers("/service/**");
//              .csrf().requireCsrfProtectionMatcher(new AllExceptUrlsStartedWith("/service/loc_registration"));

//        http.csrf().disable();

      //로그인 화면 비활성화
      http.httpBasic().disable();
      http.rememberMe().tokenValiditySeconds(60 * 60 * 24 * 7).userDetailsService(userDetailsService);
      http.formLogin().loginPage("/login");
      http.logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/");
      http.formLogin().failureHandler(authenticationFailure);
      http.formLogin().failureUrl("/login");
  }

  @Bean
  public PasswordEncoder passwordEncoder(){
      return new BCryptPasswordEncoder();
  }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}

class AllExceptUrlsStartedWith implements RequestMatcher {

    private static final String[] ALLOWED_METHODS =
            new String[]{"GET", "HEAD", "TRACE", "OPTIONS"};

    private final String[] allowedUrls;

    public AllExceptUrlsStartedWith(String... allowedUrls) {
        this.allowedUrls = allowedUrls;
    }

    @Override
    public boolean matches(HttpServletRequest request) {
        // replicate default behavior (see CsrfFilter.DefaultRequiresCsrfMatcher class)
        String method = request.getMethod();
        for (String allowedMethod : ALLOWED_METHODS) {
            if (allowedMethod.equals(method)) {
                return false;
            }
        }

        // apply our own exceptions
        String uri = request.getRequestURI();
        for (String allowedUrl : allowedUrls) {
            if (uri.startsWith(allowedUrl)) {
                return false;
            }
        }

        return true;
    }
}


