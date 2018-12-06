package org.clever.simple.shop;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.ApplicationContext;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.TimeZone;

/**
 * 应用启动类
 * Created by lzw on 2017/2/25.
 */
@Slf4j
@EnableDiscoveryClient
//@EnableFeignClients(basePackages = {"org.clever.security.client"})
//@EnableRedisHttpSession(
//        cleanupCron = "0/5 * * * * *",
//        maxInactiveIntervalInSeconds = 60 * 60,
//        redisNamespace = "spring:session:clever-quartz",
//        redisFlushMode = RedisFlushMode.ON_SAVE
//)
//@MapperScan("org.clever.quartz.mapper")
@EnableTransactionManagement
@SpringBootApplication(scanBasePackages = {"org.clever"})
public class StartApp {
    public static void main(String[] args) {
        TimeZone.setDefault(TimeZone.getTimeZone("GMT+8"));
        ApplicationContext ctx = SpringApplication.run(StartApp.class, args);
        log.info("### 服务启动完成 === " + ctx);
    }
}
