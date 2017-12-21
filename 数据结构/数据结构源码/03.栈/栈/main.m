//
//  main.m
//  栈
//
//  Created by 渠晓友 on 2017/12/15.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYStack.h"

int main(void){
    
    // 栈的基本使用
//    STACK stack;  // 声明一个栈
//    init(&stack);   // 初始化
//    
//    // 压栈
//    push(&stack, 10);
//    push(&stack, 20);
//    push(&stack, 30);
//    push(&stack, 40);
//    push(&stack, 50);
//    
//    traverse(&stack);   // 遍历打印栈
//    
//    int val;
//    int isPopSuccess = pop(&stack,&val);
//    if (isPopSuccess) {
//        printf("pop 的值为 %d\n",val);
//    }
//    
//    traverse(&stack);
//    
//    clearStack(&stack);   // 清空栈
//    traverse(&stack);
//    
    
    // 栈的应用
    
    conversion();
    
    checkBracelet();
   
    return 0;
    
}






#pragma mark -- 引入栈↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

//typedef struct Student{
//
//    int age;  // 年龄
//    char *name; // 姓名
//    float height;  // 身高
//
//}*pStudent,Student;
//
//void func(void){
//
//    // 变量 p 在栈区分配内存，  ---  (int)malloc(sizeof(int));在堆区分配了 int 类型大小的内存空间
//    int p = (int)malloc(sizeof(int));
//        p = 10;
//}
//
//int main(void) {
//
//    // 声明创建局部变量 --- 栈内存 ,,, 10，“xiaoming”，1.73 这些都是系统常量区的内容
//    int      age = 10;
//    char   *name = "xiaoming";
//    float height = 1.73;
//
//    // 创建结构体变量  xiaoming 作为机构体变量分配在栈区
//    // (pStudent)malloc(sizeof(Student)); 这句代码则是在堆区动态分配内存空间创建了一个结构体变量
//    pStudent xiaoming = (pStudent)malloc(sizeof(Student));
//
//    xiaoming->age     = age;
//    xiaoming->name    = name;
//    xiaoming->height  = height;
//    return 0;
//}

