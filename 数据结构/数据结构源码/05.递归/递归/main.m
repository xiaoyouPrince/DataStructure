//
//  main.m
//  递归
//
//  Created by 渠晓友 on 2019/8/18.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - 函数相互调用

void a(void);
void b(void);
void c(void);


void a(){
    printf("aaaa\n");
    b();
    printf("1111\n");
}

void b(){
    printf("bbbb\n");
    c();
    printf("2222\n");
}

void c(){
    printf("cccc\n");
//    a();
    printf("3333\n");
}

#pragma mark - 函数自己调用自己

void func(int num);

void func(int num){
    if (num == 1){
        printf("执行目标代码\n");
    }
    else
    {
        printf("递归自己\n");
        func(num - 1);
    }
}

#pragma 递归实例 阶乘 求和

/// 求一个数字的阶乘
unsigned long getFactorial(int num){
    
    
    // 0 验证入参为大于0的整数
    if (num<1) {
        return 0;
    }
    
    
    unsigned long result = num;
    
    // 1. for 循环求解
//    for( int i = num-1; i >= 1; i--){
//        result = i * result;
//    }
    
    // 2. 递归求解
    if (num == 1) {
        return 1;
    }else
    {
        return result * getFactorial(num-1);
    }
    
    return result;
    
}

/// 求一个数字的累加和
unsigned long getSum(int num){
    
    
    // 0 验证入参为大于0的整数
    if (num<1) {
        return 0;
    }
    
    
    unsigned long result = num;
    
    // 1. for 循环求解
    for( int i = num-1; i >= 1; i--){
        result = i + result;
    }
    
    // 2. 递归求解
//    if (num == 1) {
//        return 1;
//    }else
//    {
//        return result + getSum(num-1);
//    }
    
    return result;
    
}


/**
 汉诺塔问题

 @param n 需要移动几个盘子
 @param A 柱子A，最初盘子所在的柱子
 @param B 柱子B，中间缓冲区的柱子
 @param C 柱子C，最终要将盘子移到的柱子
 */
void hannuota(unsigned int n, char A, char B, char C){
    
    if( n == 1){
        printf("将编号为 %d 的盘子直接从 %c 移动到 %c\n",n,A,C);
    }else
    {
        /*
         1. 将前(n-1)个盘子，通过C移动到B
         2. 将最后一个盘子从A移动到C
         3. 最后将B上面的(n-1)个盘子通过A移动到C
         */
        
        hannuota(n-1, A, C, B);
        printf("将编号为 %d 的盘子直接从 %c 移动到 %c\n",n,A,C);
        hannuota(n-1, B, A, C);
        
    }
    
}


int main() {
    
    hannuota(3, 'A', 'B', 'C');
    
    
    return EXIT_SUCCESS;
}
