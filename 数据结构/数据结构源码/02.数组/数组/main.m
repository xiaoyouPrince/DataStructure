//
//  main.m
//  数组
//
//  Created by 渠晓友 on 2017/12/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义个数组
typedef struct Array {
    int length; // 数组长度
    int count;  // 数组当前元素数 count
    int *pBase; // 数组的首字节地址
}* PMyArray,MyArray; //两个别名，PMyArray 类似java中类名，定义的对象不带 * , MyArray类似于OC中的类型，定义的对象带 * 。

/** 初始化数组*/
void init_Arr(MyArray *pArr, int len);
/** 追加数组*/
bool append_Arr(MyArray *pArr, int value);
/** 插入数组*/
bool insert_Arr(MyArray *pArr, int index , int value);
/** 删除数组*/
bool delete_Arr(MyArray *pArr, int index , int * pVal);
/** 是否满载*/
bool is_full(MyArray *pArr);
/** 是否为空*/
bool is_empty(MyArray *pArr);
/** 排序数组*/
void sort_Arr(MyArray *pArr);
/** 展示数组*/
void show_Arr(MyArray *pArr);
/** 倒序数组*/
void inversion_Arr(MyArray *pArr);

/** 获取一个默认初始化的数组*/
MyArray * get_Arr(void);


int main(void) {

    
    MyArray arr;        // 声明
    int len = 6;        // 定义数组长度
    init_Arr(&arr,len);     // 初始化
    
    // 添加元素
    int time = 0;
    while (time < len) {
        append_Arr(&arr, 100 + time);
        time++;
    }

    
    insert_Arr(&arr, 6, 200);  // 插入元素
    insert_Arr(&arr, 7, 300);
    insert_Arr(&arr, arr.count, 400);
    insert_Arr(&arr, 0, 500);
    insert_Arr(&arr, 3, 600);

    show_Arr(&arr);         // 打印数组元素
    
    int val;
    //delete_Arr(&arr, 3 ,NULL);    // 删除第三个元素
    delete_Arr(&arr, 3 ,&val);
    printf("被删除的元素是 %d \n",val);
    
    
    show_Arr(&arr);         // 打印数组元素
    
    inversion_Arr(&arr);    // 倒序排列一下
    
    show_Arr(&arr);         // 打印数组元素
    
    sort_Arr(&arr);         // 排序数组
    
    show_Arr(&arr);         // 打印数组元素
    
    
    
#pragma mark -- OOP
    
    MyArray * array = get_Arr();
    
    printf("打印一个自己实现的模拟面向对象的方式\n");
    show_Arr(array);         // 打印数组元素


    int val1 = array->pBase[array->count] ;
    int val2 = array->pBase[array->count - 1];
    printf("val1 = %d  val2 = %d\n",val1,val2);
    
    
    MyArray * array2 = get_Arr();
    
    printf("打印一个自己实现的模拟面向对象的方式\n");
    show_Arr(array2);         // 打印数组元素
    append_Arr(array2, 20);
    append_Arr(array2, 30);
    insert_Arr(array2, 0, 20);
    insert_Arr(array2, 1, 30);
    
    
    show_Arr(array2);
    
    
    
    int val3 = array->pBase[array2->count] ;
    int val4 = array->pBase[array2->count - 1];
    printf("val3 = %d  val4 = %d\n",val3,val4);
    
    
    printf("array1 address is %p\n",array);
    printf("array1 address is %p\n",&array);
    printf("array2 address is %p\n",array2);
    printf("array2 address is %p\n",&array2);
    
    
    // 类似于 OC 中的面向对象用法
    MyArray * array3 = get_Arr();
    printf("array3 address is %p\n",array3);
    printf("array3 address is %p\n",&array3);
    show_Arr(array3);


    // 类似于 java 中的面向对象用法
    PMyArray myArray4 = get_Arr();
    printf("array4 address is %p\n",myArray4);
    printf("array4 address is %p\n",&myArray4);
    show_Arr(myArray4);

//    NSMutableArray *arrayM = [NSMutableArray array];
//    int time = 0;
//    while (time < 10) {
//        [arrayM addObject:@(time + 100)];
//        time++;
//    }
//
//    [arrayM insertObject:@"你好" atIndex:4];
//
//    NSLog(@"arrayM = %@",arrayM);
    
    
    return 0;
}


/**
 初始化数组

 @param pArr 要初始化的数组指针
 @param len 初始化的数组长度
 */
void init_Arr(MyArray *pArr,int len){
    
    (*pArr).pBase = (int *)malloc(sizeof(int) * len); //  先分配一段内存空间，长度为 len * int长度。
    if(pArr->pBase == NULL)
    {
        printf("内存分配失败，初始化失败\n");
        exit(-1); // 终止程序
    }else
    {
        pArr->length = len;
        pArr->count = 0;
    }
    
    return;
}

/**
 往数组尾部添加元素

 @param pArr 数组指针
 @param value 要添加的元素值
 @return 添加成功/失败
 */
bool append_Arr(MyArray *pArr,int value){
    
    if (!is_full(pArr)) {
        // 数组未满，添加
        pArr->pBase[pArr->count] = value;
        pArr->count++;
        return true;
        
    }else{
        printf("数组已经满了,无法从尾部追加元素，请尝试从前面插入\n");
        return false;
    }
    
}


/**
 实现数组插入
 
 1. 判断插入下标是否越界
 2. 如果插入前数组已经满了，就增大一个长度，重新插入
 3. 如果插入前数组未满
     3.1 当插入位置小于最大元素下标，先把要插入目标点后面的元素往后移动一个单位。 如在{1，2，4，5}中第3个位置插入3，结果为{1，2，3，4，5}
     3.2 当插入位置大于等于最大元素下标，直接在原来数组后面add最后一个元素。 如在{1，2}中第5个位置插入 3 结果为{1，2，3}

 @param pArr 要操作的数组的指针
 @param index 要插入的index 即下标
 @param value 要插入的值
 @return 返回插入成功/失败
 */
bool insert_Arr(MyArray *pArr, int index , int value){
    
    if (index > pArr->length || index < 0) {
        printf("数组插入位置越界\n");
        return false;
    }
    
    if (is_full(pArr)) {
        
        // 如果满了就长度+1，然后执行未满的情况（这里成了递归了就）
        pArr->length ++;
        return insert_Arr(pArr, index, value);
        
    }else
    {
        // 未满可以插入
        if (index < pArr->count) {
            // 1. 原来元素先往后移
            for (int i = 0 ; i < (pArr->count - index); i++) {
                pArr->pBase[pArr->count - i] = pArr->pBase[pArr->count - i - 1];
            }
            
            // 2. 插入的元素直接插入对应位置
            pArr->pBase[index] = value;
            pArr->count ++;
        }else
        {
            // 插入到最后面即可
            append_Arr(pArr, value);
        }
        
        return true;
    }
}

/**
 实现数组删除某个元素
 并可以从外部获得被删除元素的值
 
 1. 判断删除下标是否越界
 2. 判断原数组是否为空
 3. 如果删除前先保存对应 index 的值赋值给外部变量
    把要删除目标点后面的元素往前移动一个单位。 如在{1，2，3，4，5}中第3个位置删除3，结果为{1，2，4，5}
 
 @param pArr 要操作的数组的指针
 @param index 要伤处的index 即下标
 @param pVal 要删除值的地址
 @return 返回删除成功/失败
 */
bool delete_Arr(MyArray *pArr , int index ,int *pVal)
{
    if (is_empty(pArr)) {
        return false;
    }
    
    if (index < 0 || index >= pArr->count) {
        printf("要删除的位置下边越界\n");
        return false;
    }
    
    
    if (pVal == NULL) {
        // 这里是用户没传要接收被删除元素的数组，直接过
    }else
    {
        *pVal = pArr->pBase[index];  // 要删除的值，赋值给外部的变量，通知外部
    }
    
    
    // 所有后面的元素，均向前移动一个单位
    //        int time = pArr->count - index - 1;
    //        for (int i = 0; i < time; i++) {
    //            pArr->pBase[index + i] = pArr->pBase[index + i + 1];
    //        }
    //        pArr->count --;
    
    // 同上两个算法思路，实质相同，都是后面的元素前移动一个单位
    for (int i = index; i <= pArr->count - 1; i++) {
        pArr->pBase[i] = pArr->pBase[i + 1];
    }
    pArr->count --;
    
    return true;
}

/**
 判断数组是否为空
 
 @param pArr 数组指针
 @return 结果值
 */
bool is_empty(MyArray *pArr){
    
    if (pArr->count == 0) {
        return true;
    }else
    {
        return false;
    }
}

/**
 判断数组是否为满载

 @param pArr 数组指针
 @return 结果值
 */
bool is_full(MyArray *pArr){
    
    if (pArr->count < pArr->length) {
        return false;
    }else
    {
        return true;
    }
}



/**
 打印有效数组元素

 @param pArr 数组指针
 */
void show_Arr(MyArray *pArr){
    
    if (is_empty(pArr)) {
        // 数组为空
        printf("此数组为空数组\n");
    }else {
        // printf("base = %p,\nlength = %d,\ncount = %d\n",pArr->pBase,pArr->length,pArr->count);
        // 打印所有数据
        for (int i = 0; i < pArr->count; i++) { // 只打印有效的元素
            printf("%d  ",pArr->pBase[i]); // 数组对应的元素
        }
        printf("\n");
    }
}

/**
 倒序排列数组

 @param pArr 要被倒序的数组指针
 */
void inversion_Arr(MyArray *pArr){
    
    if (pArr->count <= 1) return;

//    int time = 0;
//    if (pArr->count % 2 == 0) {
//        // 偶数数组
//       time  = pArr->count / 2; // 交换次数
//    }else{
//        // 奇数数组
//        time = pArr->count / 2;
//    }
    
    // 这里直接取商就行
    int time = pArr->count / 2;
    for (int i = 0 ; i < time; i++) {
        
        int temp = pArr->pBase[i];
        pArr->pBase[i] = pArr->pBase[pArr->count - 1 - i];
        pArr->pBase[pArr->count - 1 - i] = temp;
    }
}


/**
 排序数组（降序）

 如果升序可以直接重新调用一次 inversion_Arr 函数
 
 @param pArr 要被排序的数组指针
 */
void sort_Arr(MyArray *pArr){
    
    int i , j , temp;
    
    for (i = 0; i < pArr->count; i++) {
        for (j = i + 1; j < pArr->count; j++) {
            if (pArr->pBase[i] < pArr->pBase[j]) {
                temp = pArr->pBase[i];
                pArr->pBase[i] = pArr->pBase[j];
                pArr->pBase[j] = temp;
            }
        }
    }
}


MyArray * get_Arr(void){
    
    static MyArray arr;
    int length = 1;
    init_Arr(&arr, length);
    
    append_Arr(&arr, 10);
    
    
    // Address of stack memory associated with local variable 'arr' returned
    // 这里的意思是在变量在栈区建立的变量地址,当这个函数执行完，整个这个函数的内存就会被释放，
    // 所以本来返回的地址在被销毁之前能正常使用，函数调用完成内存被释放之后就变成了一个不知所指向的地址了。
    // 所以在外部是访问不到
    // 解决办法：
    // 可以使用 static 关键字，创建一块全局空间供全局使用(但全局都只有一个了，这样也不利于随意创建对象)
    
    return &arr;

}
