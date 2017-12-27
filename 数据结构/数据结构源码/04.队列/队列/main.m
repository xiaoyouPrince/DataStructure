//
//  main.m
//  队列
//
//  Created by 渠晓友 on 2017/12/27.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  静态队列 -- 假设最大长度为 6

#import <Foundation/Foundation.h>


#define kQueueMaxLength 6   // 假设最大长度为 6

typedef struct Queue{
    int * pBase;    // 队列中操作的数组
    int front;      // 队头
    int rear;       // 对尾
}QUEUE;



/**
 初始化队列
 @param pQueue 要被初始化队列地址
 */
void init_queue(QUEUE *pQueue);


/**
 入队

 @param pQueue 要入队的队列地址
 @param val 入队元素的值
 @return 入队成功/失败
 */
bool en_queue(QUEUE *pQueue , int val);

/**
 出队

 @param pQueue 要出队队列地址
 @param val 被出队元素地址
 @return 出队成功/失败
 */
bool de_queue(QUEUE *pQueue , int *val);

/**
 遍历队列

 @param pQueue 要遍历的队列的地址
 */
void tranverce_queue(QUEUE *pQueue);


/**
 判断队列是否已满

 @param pQueue 被判断队列
 @return 是否已满
 */
bool full_queue(QUEUE *pQueue);

/**
 判断队列是否为空
 
 @param pQueue 被判断队列
 @return 是否为空
 */
bool empty_queue(QUEUE *pQueue);



int main() {
    
    
    QUEUE q;            // 声明队列q
    init_queue(&q);     // 初始化队列q
    
    en_queue(&q, 2);    // 插入元素
    en_queue(&q, 21);    // 插入元素
    en_queue(&q, 3);    // 插入元素
    en_queue(&q, 4);    // 插入元素
    en_queue(&q, 5);    // 插入元素
    en_queue(&q, 6);    // 插入元素
    en_queue(&q, 7);    // 插入元素
    en_queue(&q, 8);    // 插入元素
    
    tranverce_queue(&q);    //遍历队列
    
    int i;
    bool b;
    b = de_queue(&q, &i);   // 出队
    printf("出队%s,元素为 %d\n",b?"成功":"失败",i);
    
    b = de_queue(&q, &i);   // 出队
    printf("出队%s,元素为 %d\n",b?"成功":"失败",i);
    
    b = de_queue(&q, &i);   // 出队
    printf("出队%s,元素为 %d\n",b?"成功":"失败",i);
    
    tranverce_queue(&q);    //遍历队列
    
    return 0;
}

void init_queue(QUEUE *pQueue){
    
    pQueue->pBase = (int *)malloc(sizeof(int) * kQueueMaxLength); // 初始化，pBase指向长度6的 int* 数组
    pQueue->front = pQueue->rear = 0;
    
}

bool full_queue(QUEUE *pQueue){
    
    // 判断是否已满，用第二种方式：少用数组中一个元素，f 和 r 的关系为  f == (r + 1) % maxLenght
    if ((pQueue->rear + 1) % kQueueMaxLength == pQueue->front){
        return true;
    }else
    {
        return false;
    }
    
}

bool empty_queue(QUEUE *pQueue){
    
    // 队列为空即: f = r
    
    if (pQueue->front == pQueue->rear) {
        return true;
    }else
    {
        return false;
    }
}

bool en_queue(QUEUE *pQueue , int val){
    
    if (full_queue(pQueue)) { // 队列已满，直接返回入队失败
        return false;
    }else
    {   // 队列未满，执行入队操作
        
        // 1.元素插入数组中
        pQueue->pBase[pQueue->rear] = val;
        // 2.队头队尾的表示
        pQueue->rear = (pQueue->rear + 1) % kQueueMaxLength;
        
        return true;
    }
}

bool de_queue(QUEUE *pQueue , int *val){
    
    if (empty_queue(pQueue)) {  // 如果是空队列，直接出队失败
        return false;
    }else
    {
        // 出队->保存被出队元素的值
        *val = pQueue->pBase[pQueue->front];
        // 修改队头位置
        pQueue->front = (pQueue->front + 1) % kQueueMaxLength;
        
    }
    return true;
}

void tranverce_queue(QUEUE *pQueue){
    
    int i = pQueue->front;
    int lenght = 0;
    while (i != pQueue->rear) {
        lenght ++;
        i = (i + 1) % kQueueMaxLength;
    }
    printf("队列中共有 %d 个元素\n",lenght);
    
    i = pQueue->front;
    while (i != pQueue->rear) {
        
        printf("第 %d 个元素为 %d\n",i + 1,pQueue->pBase[i]);
        i = (i + 1) % kQueueMaxLength;
    }
}
