package com.zyc.aop;

import java.lang.annotation.*;

/**
 * 日志切面类
 * Created by YuChen Zhang on 17/10/26.
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogAop {
    String tableName() default "";
    CRDU CRDU() default CRDU.Select;
    String logRecord() default "";
}
