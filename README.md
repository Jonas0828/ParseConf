# ParseConf
                          parseConf(配置文件解析器)

    1. 很多时候,我们安装一些软件,都可以通过改一些软件的配置文件来修改程序的
        运行性能,如Tomcat修改端口号,访问数据库时一些固定的参数等等;
    2. 本Demo就是干着这么一件事,从properties.conf文件中取出键值对(keyvalue),
        实现更大程度提高代码的可利用性,通用性;    
    3. 以下是我们要解析的properties.conf文件中的内容:
        #title = charMaps
              t    itle = c   harMaps
            #jfdalj    lasdfjl jflds
        jfdsljf
        =fjldsfsjd
        up     = looking
                rows = 24    #jals    djfaldjfals
                r ows = 25    #jals    djfaldjfals
        c    ols =       8    0
        
            =    fsdfa
        
        c    ols =       88   0
        jsflsjfd
        jfsldjaf
        tadjfsldjf=
        
        cols=88   0
        cols=888  0
        interval    = 1   0000
        version = 11.0
           lkjk  ng     =    i  an   f  n  ig
           test = 100000000     
    4. 这是我们使用本parseConf程序解析出来的结果:
        001: t    itle=c   harMaps
        002: up=looking
        003: rows=24
        004: r ows=25
        005: c    ols=88   0
        006: cols=888  0
        007: interval=1   0000
        008: version=11.0
        009: lkjk  ng=i  an   f  n  ig
        010: test=100000000
    5. 配置文件的书写规范:
        1. 键值对(keyvalue)以key=value的形式存在,等号两边可以出现空格;
        2. 对于不能构成键值对(keyvalue)的key或value都会被忽略;
        3. '#'为行注释符,目前只支持单行注释,不提供多行注释;  :)
        4. 如果解析中发现键值对中key相同,那么取最后那次的键值对为最终键值对;
    6. 使用valgrind对程序进行内存释放检查结果,不会造成内存泄露:
        [user@localhost parseConf]$ valgrind ./parseConf properties.conf 
        ==6325== Memcheck, a memory error detector
        ==6325== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
        ==6325== Using Valgrind-3.5.0 and LibVEX; rerun with -h for copyright info
        ==6325== Command: ./parseConf properties.conf
        ==6325== 
          ...  //省略程序运行时的输出内容
        ==6325== 
        ==6325== HEAP SUMMARY:
        ==6325==     in use at exit: 0 bytes in 0 blocks
        ==6325==   total heap usage: 39 allocs, 39 frees, 9,092 bytes allocated
        ==6325== 
        ==6325== All heap blocks were freed -- no leaks are possible
        ==6325== 
        ==6325== For counts of detected and suppressed errors, rerun with: -v
        ==6325== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 12 from 8)

