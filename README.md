# DownloadManager。

downloader没有写完不想写了，因为剩下的就跟界面高度耦合了，大家看DownloadManager自己写界面吧。

1.其实下载功能用afnetworking实现很简单，大家可以看看代码，重新封装下，结合自己的界面把需要的数据通过协议代理或者block回调出去。

2.想要多任务同时下载就用不同的url和id多初始化就好（线程方面apple做好了，我们只要控制任务数就好）。

3.想要实现多任务管理，推荐使用gcd任务组和信号量控制，等我有时间了写个demo。
