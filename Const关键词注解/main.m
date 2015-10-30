//
//  main.m
//  Const关键词注解
//
//  Created by HelloWorld on 15/10/29.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kCorpName @"MemoryWarning"

/********************************************************************************
 *                               const 相比于 define                             *
 *                                                                              *
 *  1、const定义的常量在程序运行过程中只有一份拷贝，而define定义的常量在内存中有若干份拷贝。 *
 *                                                                              *
 *  2、define宏是在预处理阶段展开。const常量是编译运行阶段使用                          *
 *                                                                              *
 *  3、const常量有数据类型，而宏常量没有数据类型。编译器可以对const进行类型安全检查。而对宏  *
 *  只进行字符替换，没有类型安全检查。                                                *
 *                                                                              *
 *  4、编译器通常不为普通const常量分配存储空间，而将它们保存在符号表中，使得它成为一个编译期  *
 *  间的常量，没有了存储与读内存的操作，使得它的效率也很高.                              *
 *    const修饰全局变量存储在只读数据段，编译期最初将其保存在符号表中，第一次使用时为其分配  *
 *  内存，在程序结束时释放。const局部变量存储在栈中，代码块结束时释放。                   *
 *                                                                              *
 ********************************************************************************/

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /*
         1.const修饰基本数据类型
        */
        const int a = 1;    //正常
        //a = 2; //error
        int const b = 1;    //靠， const位置还可以换
        //b = 2;  //error
        //const int const c = 1; //warning 这种是没有的，你会说当然没有。（为的是和下面的指针类型对比）
        
        
        /*
         2.const修饰指针类型 (在此以假定你对指针有一定理解)
         这里讨论两种格式：(Type->类型， ver->变量名)
            1). const Type * var:       可以改变指针的指向，不能改变指针指向的内容。
            2). Type * const var:       不能改变指针的指向，可以改变指针指向的内容，
            3). const Type * const var: 不能改变指针的指向，不能改变指针指向的内容。
         */
        //例子:
        //1)
        NSString * const kMyNmae = @"HelloWorld";   //①
        //kMyNmae = @"0000";  //error，呵呵，意料之中吧
        
        //2)
        const NSString *kMyJob = @"Developer";  //②
        kMyJob = @"酱油"; //OK, 竟然不做？？？？ 先不要疑惑
        
        //3)
        const NSString * const kMyAdress = @"Screct";   //③
        //kMyAdress = @"0000";   //error, 还有这种写法？会不会写错了？ 废话，当热不会。
        
                                /*先澄清一个问题---指向和指向的内容*/
        /********************************************************************************///
        int age = 10;                                                                    ///
        int height = 10;
        int *p = &age;
        
        // p是指针变量，p指向age（也可说p指向age的地址）。p指针指向的内容是10，也就是*p的内容是10。
        // 所以说两个（指向和指向的内容）是不一样的。
            //如:1. *p = 8;只改变了指向的内容, p仍指向age
            //   2. p = &height; 改变了指针指向，使得指针指向height，不在指向age了

        /********************************************************************************///

        /*拨开心中的瘴雾：
        
         const只修饰其后的变量(切记)，至于const放在类型前还是类型后并没有区别。
            如：const int a和int const a都是修饰a为const。
         
         const修饰变量时对“*”的处理：const仅把“*”当做操作符来处理（切记）
            int const *p、 const int *p; (注，一定要对这个“*了解”， 本文不再次多述)
                注"*"不是一种类型，int *p 在声明的时候为(*)声明符, （*p = 2）此时的*是操作符（即运算符）。
         
            “*”对const关键字来说是仅仅只是一个操作运算符，这样就很容易的理解了吧（有没有感觉一下特简单了）
         
         
        例子解释：------------------------------------------------
         
        ① NSString * const kMyNmae = @"HelloWorld";
            kMyNmae被const修饰、kMyNmae不可变，但内容是可变的，就相当p本来指向age,后来指向height一样
        
        ② const NSString *kMyJob = @"Developer";
            *kMyJob被const修饰、（*kMyJob）不可变，即（*kMyJob）所指向的内容不可变，但kMyJob是可变的，就相当*p是10,后来变成8
        
        ③ const NSString * const kMyAdress = @"Screct";
            两个const
            第一个修饰 *kMyAdress 不可变
            第二个修饰 kMyAdress 不可变
         
        =======例子不太具有代表性，NSString本事是不可变的。
        解释完毕：------------------------------------------------
         
         一个简单的判断方法：指针运算符"*"，是从右到左，那么如：char const * pContent，可以理解为char const (* pContent)，即* pContent为const，而pContent则是可变的。
         
         const在*的左边，则指针指向的变量的值不可直接通过指针改变（可以通过其他途径改变）；在*的右边，则指针的指向不可变。简记为“左定值，右定向”。
         
         */
        
        NSLog(@"kMyNmae:%@", kMyNmae);
        NSLog(@"kMyJob:%@", kMyJob);
        NSLog(@"kMyAdress:%@", kMyAdress);
    
    }
    return 0;
}
