# GYWy
用icarousel实现网易新闻标题跳转
====================

---------------------

![Alt text](/http://ww3.sinaimg.cn/bmiddle/bcd340f3gw1f1p7ytjb9oj208c198juw.jpg/to/img.jpg)




> ## GYNewsViewController中给GYNewsCarouselView提供标题数据
> 
> 这里直接用了Plist文件来提供标题的text和urlstring
> 
> 
> ：
> 
>   GYNewsTableView *tv = [[GYNewsTableView alloc]initWithFrame:CGRectMake(0, 0, carousel.width, carousel.height)];
       
        
        tv.title = self.tempListArray[index];
