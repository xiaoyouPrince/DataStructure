//
//  main.m
//  链表
//
//  Created by 渠晓友 on 2017/12/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct Node{    // 声明链表
    int data;     //数据域
    struct Node *pNext;     // 指针域
}*PNODE,NODE;  // PNODE 等价于 struct Node * ， NODE 等价于 struct Node


/** 创建链表*/
PNODE creatate_list(void);
/** 遍历链表*/
void traverse_list(PNODE pHead);
/** 判断是否为空链表*/
bool isEmpty_list(PNODE pHead);
/** 求链表长度*/
int length_list(PNODE pHead);
/** 链表排序*/
void sort_list(PNODE pHead);
/** 链表插入某个元素*/
bool insert_list(PNODE pHead , int pos , int val);
/** 链表删除某个元素
 当pos <= 1 则删除第一个元素，当pos > 链表长度则返回false，并报告原因
 */
bool delete_list(PNODE pHead , int pos , int * val);


int main(void) {

    PNODE pHead = NULL; //栈区定义一个链表
    
    pHead = creatate_list();    // 创建链表（这次的内存在堆取，所以需要手动最后释放内存）
    traverse_list(pHead);   // 遍历打印链表
    
//    bool isEmpty = isEmpty_list(pHead);  // 判断是否为空链表
//    int len = length_list(pHead);        // 计算链表长度
//    printf("pHead %s an empty list, its length is %d\n",isEmpty ? "is" : "is not",len);
//
//    sort_list(pHead);       // 排序
//    traverse_list(pHead);   // 遍历打印链表
//
//    insert_list(pHead, 10, 100);    // 插入链表
//    traverse_list(pHead);   // 遍历打印链表
    
    int i;
    delete_list(pHead, 0, &i);    // 删除链表
    printf("被删除的节点的值为 %d\n",i);
    traverse_list(pHead);   // 遍历打印链表
    
    delete_list(pHead, 1, &i);    // 删除链表
    printf("被删除的节点的值为 %d\n",i);
    traverse_list(pHead);   // 遍历打印链表
    
    delete_list(pHead, 10, &i);    // 删除链表
    printf("被删除的节点的值为 %d\n",i);
    traverse_list(pHead);   // 遍历打印链表
    
    return 0;
}


/** 创建列表*/
PNODE creatate_list(void){
    
    // 创建一个值域为空的头结点,给头指针分配内存
    PNODE pHead = (PNODE)malloc(sizeof(PNODE)); // 头指针
    
    if (pHead->pNext == NULL) {
        printf("头指针内存分配失败，程序退出\n");
        exit(0);
    }
    
    PNODE pTail = pHead; // 站位尾节点,直接赋值给 pTail,这是栈内存分配；
    pTail->pNext = NULL;
    
    // 创建对应的节点
    int len = 0;
    int val = 0;
    printf("请输入要创建链表的长度：\n");
    scanf("%d",&len);
    for (int i = 0;  i < len; i++) {
        // 根据用户输入的长度创建对应个数的节点
        PNODE pNew = (PNODE)malloc(sizeof(NODE));
        
        if (pNew == NULL) {
            printf("节点分配失败，程序退出\n");
            exit(0);
        }
        
        printf("请输入第 %d 个节点的值",i + 1);
        scanf("%d",&val);
        
        /*
         创建新节点
         新节点赋值给当前最尾节点 pNext
         站位尾节点再次指向新节点
         */
        
        // 1.保存值和指针，变成完整新节点
        pNew->data = val;
        pNew->pNext = NULL;
        // 2.当前新节点追加到原来尾节点后面
        pTail->pNext = pNew;
        // 3.新节点变成原来尾节点
        pTail = pNew;

        // 从这也能看出堆和栈的区别。堆是一块内存区，里面的内存不会被释放，需要主动过去分配内存和释放，PNODE pTail = (PNODE)malloc(sizeof(PNODE));
        // 栈就是程序里面直接使用的可以不用分配内存就能用的，  int a = 20;
 
    }
    
    return pHead; // 返回头节点
}


/** 遍历列表*/
void traverse_list(PNODE pHead){
    
    // 通过头节点遍历后面节点
    PNODE p = pHead->pNext; //获得首节点
    while (p != NULL) {
        printf("data = %d \n",p->data);
        p = p->pNext;
    }
    
    printf("遍历完毕，退出\n");
    return;
}

/** 判断是否为空链表*/
bool isEmpty_list(PNODE pHead)
{
    if ((*pHead).pNext != NULL) {
        return false;
    }else{
        return true;
    }
}

/** 求链表长度*/
int length_list(PNODE pHead)
{
    PNODE p = pHead->pNext;
    int len = 0;
    while (p!= NULL) {
        len++;
        p = p->pNext;
    }
    return len;
}


/** 链表排序*/
void sort_list(PNODE pHead)
{

    // 数组的排序算法 <-> 链表排序互相对比更好学习排序
//    for (i = 0 ; i < len - 1; i++) {  // 外围的排序次数 ，没执行完以此只能确定某一最大或最小值
//        for (j = i + 1; j < len; j++) { // 内循环的排序次数 ，执行完一次把 n 个元素，对比 n-1 次并换位置
//            
//            if ( a[i] < a[j]) {
//                 t = a[i];
//                a[i] = a[j];
//                a[j] = t;
//            }
//        }
//    }
    
    // 排序的算法有很多种
    int len = length_list(pHead);
    int i , j , t;
    PNODE p , q;
    
    for (i = 0 , p = pHead->pNext; i < len - 1; i++ , p = p->pNext) {  // 外围的排序次数 ，没执行完以此只能确定某一最大或最小值
        for (j = i + 1 , q = p->pNext; j < len; j++ , q = q->pNext) { // 内循环的排序次数 ，执行完一次把 n 个元素，对比 n-1 次并换位置
            
            if (p->data > q->data) {  // 比较两个节点数值，并换位置
                t = p->data;
                p->data = q->data;
                q->data = t;
            }
        }
    }
    
    return;
    
    
}


/**
 链表在某个位置插入某个元素
 @param pHead 要被插入的链表
 @param pos 要插入的位置
 @param val 要插入的值
 @return 返回是否插入成功
 */
bool insert_list(PNODE pHead , int pos , int val){
    
    // 判断位置是否合法
    PNODE q = pHead;   // 要插入的位置，如果是 <= 0,则直接插到最前面，如果是 pos = 1 就插入第一个后面,pos = n,就插到第 n 个后面
    int i = 0;
    while (i < pos) {
        if (q->pNext == NULL) {
            printf("要插入的位置不合法;大于链表长度\n");
            break;
        }else{
            q = q->pNext; //要被插入的节点
            i++;
        }
    }
    
    
    // 插入操作
    PNODE p = (PNODE)malloc(sizeof(NODE));
    if (p == NULL) {
        printf("动态分配内存失败\n");
        exit(0);
    }
    p->data = val;
    
    // 前一个节点为q， 直接添加到 q 后面。
    p->pNext = q->pNext;
    q->pNext = p;
    
    return true;
}


/**
 链表删除某个元素
 
 

 @param pHead 要操作的链表
 @param pos 要被删除的节点的位置，当pos <= 1 则删除第一个元素，当pos > 链表长度则返回false，并报告原因
 @param val 被删除节点的值
 @return 是否成功
 */
bool delete_list(PNODE pHead , int pos , int * val){
    
    // 找到要被删除的元素保存起来
    PNODE p = pHead;
    int i = 0;
    while (i < pos - 1) { // 找到被删除节点的前一个节点
        
        if (p->pNext == NULL) {
            break;
        }
        p = p->pNext;
        i++;
    }
    
    if (i < pos && p->pNext == NULL) {
        printf("你要删除的位置非法，此位置不在链表长度范围之内\n");
        return false;
    }
    
    // 找到了要被删除的那个节点
    PNODE t = p->pNext;;
    *val = t->data;     // 把被删除节点的值传给外面
    
    p->pNext = t->pNext;  // 直接指向后面一个节点
    free(t);    // 释放被删除节点内存，防止内存泄漏
    
    return true;
}
