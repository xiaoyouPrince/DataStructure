//
//  XYStack.m
//  栈
//
//  Created by 渠晓友 on 2017/12/21.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYStack.h"

@implementation XYStack
@end


/**栈的初始化*/
void init(PSTACK pS){
    
    pS->pTop = (PNODE)malloc(sizeof(NODE));
    if (pS->pTop == NULL) {
        printf("内存分配失败退出");
        return;
    }else
    {
        pS->pBottom = pS->pTop;
        pS->pTop->pNext = NULL;
    }
}


/**遍历打印栈*/
void traverse(PSTACK pS){
    
    // 只要不是空栈，就一直输出
    //    while (pS->pTop != pS->pBottom) {
    //        printf("%d   ",pS->pTop->data);
    //
    //        pS->pTop = pS->pTop->pNext;  // 把top的下一个节点付给top，继续遍历
    //    }
    //    printf("\n");
    //
    //    为什么不用上面这个方法？
    //    因为直接使用 pTop 指针进行遍历的错过中，一直对它进行赋值，直接导致它改变了不在指向顶部，而是遍历完成之后最后指向底部了，所以要用一个临时指针测试一下就好。
    
    // 只要不是空栈，就一直输出
    PNODE p = pS->pTop;
    while (p != pS->pBottom) {
        printf("%d   ",p->data);
        
        p = p->pNext;  // 把top的下一个节点付给top，继续遍历
    }
    printf("\n");
}

/**是否为空栈*/
int isEmpty(PSTACK pS)
{
    if (pS->pTop == pS->pBottom) {
        return 1;
    }else
    {
        return 0;
    }
}

/**
 压栈
 
 @param pS 执行压栈的栈指针
 @param val 被压栈的值
 */
void push(PSTACK pS,int val){
    
    // 创建新节点，放到栈顶
    
    PNODE pNew = (PNODE)malloc(sizeof(NODE));
    pNew->data = val;
    pNew->pNext = pS->pTop;
    
    pS->pTop = pNew;    // 栈顶指针指向新元素
}

/**
 出栈
 
 @param pS 执行出栈的栈地址
 @param val 出栈值的地址
 @return 是否出栈成功
 */
int pop(PSTACK pS , int *val){
    
    if (isEmpty(pS)) {
        printf(" 空栈 ，出栈失败");
        return 0;
    }else
    {
        PNODE p = pS->pTop;
        pS->pTop = p->pNext;
        
        if (val != NULL) {
            *val = p->data;
        }
        free(p);                // 释放原来top内存
        p = NULL;
        return 1;
    }
}

/**清空栈*/
void clearStack(PSTACK pS){
    
    if (isEmpty(pS)) {
        return;
    }else{
        PNODE p = pS->pTop;
        PNODE q = NULL;
        
        while (p!=pS->pBottom) {
            q = p->pNext;
            free(p);
            p = q;
        }
        pS->pTop = pS->pBottom;
    }
    
    
    //    偷懒的做法
    //    while (!isEmpty(pS)) {
    //        pop(pS, NULL);
    //    }
}

#pragma mark -- 栈的应用举例

/**
 进位制转换
 */
void conversion(void){
    
    // 创建栈
    STACK S;
    init(&S);
    
    // 用户输入十进制数
    int N;
    printf("请输入非负十进制正整数:\n");
    scanf("%d",&N);
    
    // 可以做一些对数字的合法性验证
    if (N <= 0) {
        return;  //输入有误
    }
    
    // 放入栈中
    while (N) {
        push(&S, N % 8);
        N = N / 8;
    }
    
    
    // 打印出来
    printf("对应八进制数字为:");
    int a;
    while (!isEmpty(&S)) {
        pop(&S, &a);
        printf("%d",a);
    }
    printf("\n");
    
    return; // 程序结束
}


/**
 检测括号(本实例用数字代替括号)
 
 [ ]    -->    1 , 2
 ( )    -->    3 , 4
 
 */
void checkBracelet(void)
{
    // 创建栈
    STACK S;
    init(&S);
    
    // 用户输入括号
    int N;
    printf("请输入对应的括号(end结束):\n");
    scanf("%d",&N);
    
    if (isEmpty(&S)) {
        push(&S, N);
        printf("第一个括号输入\n");
        traverse(&S);       // 打印此时栈内容
    }
    
    while (!isEmpty(&S)) {

        // 用户输入括号
        int N;
        printf("请输入对应的括号(0结束):\n");
        scanf("%d",&N);
        
        if (N == 0) {
            break;
        }
        
        // 判断当前栈顶是否符合标准，
        if (S.pTop->data == N) {
            printf("消除一对\n");
            pop(&S, NULL);
            traverse(&S);       // 打印此时栈内容
        }else
        {
            printf("未消除\n");
            push(&S, N);
            traverse(&S);       // 打印此时栈内容
        }
    }
}


