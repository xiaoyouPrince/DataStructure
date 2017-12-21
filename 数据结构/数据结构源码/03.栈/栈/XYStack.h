//
//  XYStack.h
//  栈
//
//  Created by 渠晓友 on 2017/12/21.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYStack : NSObject
@end


#pragma mark --- 栈的定义和基本方法

typedef struct Node{    // 节点
    
    int data;
    struct Node *pNext;
    
}*PNODE,NODE;

typedef struct Stack{   // 栈
    
    PNODE pTop;
    PNODE pBottom;
    
}STACK,*PSTACK;

/**栈的初始化*/
void init(PSTACK);
/**压栈*/
void push(PSTACK,int);
/**出栈*/
int pop(PSTACK , int *);
/**遍历打印栈*/
void traverse(PSTACK);
/**是否为空栈*/
int isEmpty(PSTACK);
/**清空栈*/
void clearStack(PSTACK);


#pragma mark --- 栈的使用

/**
 进位制转换
 */
void conversion(void);

/**
 检测括号
 */
void checkBracelet(void);

