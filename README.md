# ParseConf

很多时候，我们安装一些软件，都可以通过改一些软件的配置文件来修改程序的运行性能，如Tomcat修改端口号，访问数据库时一些固定的参数等等。


## ParseConf做了什么

从配置文件中取出键值对(keyvalue)，以链表的方式存放，并提供一系列方便使用的方法。

## 解析示例
* 假如配置文件中的内容 

```
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
```

* 测试函数
```C
    void testParseConf(int argc, char* argv[]){
        //传入需要被解析的文件
        if(argc < 2){
            printf("    Usage:\n\r        ./parseConf <configure file> \n\n");
            return ;
        }
    
        /**
         * 获取键值对,键值对头节点保存在keyValues中
         */
        kvpair* keyValues;
        getkvpairs(argv[1], &keyValues);
        printf("\n\033[32m\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\033[36mDemo\033[32m/////////////////\033[0m\n");
    
        /**
         * 将配置文件中的内容打印出来
         */
        int fd = open(argv[1], O_RDONLY);
        if(-1 == fd){
            perror("open file error");
        }
    
        char buffer[1024] = {0};
        read(fd, buffer, 1024);
        printf("%s\n", buffer);
    
        close(fd);
    
        /**
         * 将当前的所有的键值对打印出来
         */
        printkvpairs(keyValues);
        /**
         * 通过key获取value值
         */
        char* key = "rows";
        printf("\033[32mgetValueBykey:key = %s; value = %s\033[0m\n", key, key2val(key, keyValues));
        /**
         * 通过value获取key值
         */
        char* value = "24";
        printf("\033[32mgetKeyByValue:value = %s; key = %s\033[0m\n", value, val2key(value, keyValues));
        printf("\033[32m--------------------------------------\033[0m\n");
        /**
         * 释放keyValues链表
         */
        if(freekvpairs(keyValues) == 0){
            printf("\033[32m Memory of keyValues linked has freed\033[0m\n");
            printf("\033[32m--------------------------------------\033[0m\n");
        }
    }
```

* 解析配置文件结果

```
    \\\\\\\\\\\\\\\\\Demo/////////////////
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
    
    --------------------------------------
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
    --------------------------------------
    getValueBykey:key = rows; value = 24
    getKeyByValue:value = 24; key = rows
    --------------------------------------
     Memory of keyValues linked has freed
    --------------------------------------
```

## 配置文件的书写规范:
1. 键值对(keyvalue)以key=value的形式存在，等号两边可以出现空格;
2. 对于不能构成键值对(keyvalue)的key或value都会被忽略;
3. '#'为行注释符，目前只支持单行注释，不提供多行注释;  :)
4. 如果解析中发现键值对中key相同，那么取最后那次的键值对为最终键值对;

## valgrind内存泄露检查:
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

## Author:

[曾剑锋](http://www.cnblogs.com/zengjfgit/)
