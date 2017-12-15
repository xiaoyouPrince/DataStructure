//
//  main.m
//  CPointer
//
//  Created by 渠晓友 on 2017/12/10.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct Student{ // 使用 typedef 声明一个 struct Student 类型的结构体，别名为 myStudent
    int age;
    char * name;
    char name2[100];
    double height;
}myStudent;

// 直接传递 struct Student st 整个结构体数据，耗时 && 浪费内存空间
void func(struct Student st);
// 直接传递 只占用 4 byte 的指针，省时效率也高 <推荐用法>
void func2(struct Student * pst);
void test1(void);
#pragma mark -- 结构体和指针的使用 ……………………^^^^^^^^^^

void test2(void);

#pragma mark -- 动态内存的创建和释放 …………^^^^^^^^^^

myStudent * createStudent(void);
void showStudent(myStudent *);
void test3(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        

        //test1();
        
        //test2();
        
        test3();
        
    }
    return 0;
}


#pragma mark -- 结构体使用
void test1(void)
{
    //        struct Student s = {12,"xiaoyou",1.73};
    //
    //        printf(" age = %d \n name = %s \n height = %.2f \n",s.age,s.name,s.height);
    //
    //        s.age = 21;
    //        s.name = "xiaozhu";
    //        strcpy(s.name2, "zhangwangdsd");  // 字符串拷贝
    //        s.height = 1.70;
    //
    //        printf(" age = %d \n name = %s \n height = %.2f \n",s.age,s.name,s.height);
    //
    //        printf(" name2 = %s \n",s.name2);
    
    
    myStudent ss = {12,"xiaoyou",1.73};
    printf(" age = %d \n name = %s \n height = %.2f \n",ss.age,ss.name,ss.height);
    
    
    struct Student *pst = &ss;
    pst -> name = "my new name";
    
    printf(" name = %s\n",pst->name);
    printf(" name = %s\n",(*pst).name);
    
    // pst -> name 等价于 (*pst).name ,
    // 而(*pst).name 又等价于 ss.name
    // 所以 pst -> name 等价于 ss.name
    
    
    func(ss);
    
    func2(&ss);
}


// 直接传递 struct Student st 整个结构体数据，耗时 && 浪费内存空间
void func(struct Student st){
    
    printf("age = %d \n name = %s",st.age,st.name);
}

// 直接传递 只占用 4 byte 的指针，省时效率也高 <推荐用法>
void func2(struct Student * pst){
    
    printf("age = %d \n name = %s",(*pst).age,(*pst).name);
    printf("age = %d \n name = %s",pst->age,pst->name);
}

#pragma mark -- 动态内存的创建和释放

void test2(void)
{
    int len;
    printf("请输入你要动态创建的数组长度:");
    scanf("%d",&len);
    
    int *pArr = (int *)malloc(len); // 动态创建数组
    *pArr = 4;      // 相当于 a[0] = 4;  这里 pArr 就等于数组首地址，等于数组名
    pArr[2] = 5;    // 相当于 a[2] = 5;
    
    printf("pArr[0] = %d \npArr[2] = %d\n",pArr[0],pArr[2]);
    
    free(pArr);     // 使用完毕，释放对应的数组空间
}

#pragma mark -- 跨函数使用内存

myStudent * createStudent(void)
{
    myStudent *p = (myStudent *)malloc(sizeof(myStudent));
    p->age = 20;
    p->name = "xiaoyou";
    return p;
}
void showStudent(myStudent *p)
{
    printf("student.age = %d \nstudent.name = %s\n",p->age,p->name);
}
void test3(void)
{
    myStudent *p = createStudent();
    showStudent(p);
}


