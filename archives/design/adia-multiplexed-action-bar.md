[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")


Android Design in Action —— Multiplexed Action Bar
==================================================

2013 年十一月 25 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [Google](http://www.phonekr.com/tag/google/), [Redesign](http://www.phonekr.com/tag/redesign/)

![](http://www.phonekr.com/wp-content/uploads/2013/11/Screenshot-66-810x455.png "Screenshot (66)")

我想锋客网的读者们应该对 Google+ Android 客户端都不陌生吧. 这个应用算是一个非常中规中矩的 Android 展示应用. 这次我就以 Google+ 个人资料页面作为范例, 展示一下 Multiplexed Action Bar 的一般用法. 关于 Multiplexed Action Bar, 即复合式 Action Bar, 可以参看我之前写过的[一篇文章](http://www.phonekr.com/we-still-have-lot-to-do-with-android-design/ "Android Design, 玩法还有很多").

![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-13.14.28_framed-400x667.png "2013-11-22 13.14.28_framed")![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-13.14.59_framed-400x667.png "2013-11-22 13.14.59_framed")

这是 Google+ 原先的模样. 非常标准的 Action Bar, 非常标准的 Image View, 下面是头像, 名字, 圈子, 最简单的一些信息, 然后是 Sticky Header Fixed Tabs. 在用户向下卷动这个列表之后, Fixed Tabs 会和 Action Bar 一起停留在顶部.

在早些时候, Google+ 上的用户 Greg Hesp 对 Google+ 进行了[一番 Redesign](https://plus.google.com/u/0/photos/+GregHesp/albums/5948772374308536385?sqi=116667001535376136065&sqsi=50918fd5-d2ce-49ad-9645-a8c3d670848e "Google+ Redesign, inc. graphical action bar"). 但是他的重设计并没有很好的利用到 Android 4.4 提供的 Translucent Bar, 很多地方的度量不够严谨, 而且变更也仅仅是停留在了表面. 于是我打算自己做一个重设计.

![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup_framed-400x667.png "G+ Profile Mockup_framed")![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-scrolled_framed-400x667.png "G+ Profile Mockup scrolled_framed")

在还没经过仔细思考的情况下, 我就开始了我的第一次尝试. 我做的改动主要有:

> 套用了 Android 4.4 的 Translucent Bar;
>
> 采用 Multiplexed Action Bar 把  Action Bar, Cover Page 和 Fixed Tabs 整合在一起;
>
> Fixed Tabs 文字的颜色在激活时是白色, 未激活的话是 \#eeeeee, 并且有 1dp drop shadow 作为背景防护;
>
> 在卷动之后的状态下, cover photo 会变暗 50% 以免白色图片影响文字阅读;
>
> 去掉了圈子和简要信息, 我认为这两个东西只要在 About Tab 里显示就足够了.

这两张图发到社区之后, 反响平平. [+Oscar Mark](https://plus.google.com/114711755267249705050 "Google+ Profile") 认为我应该把 Hangout 按钮放在头像旁边. 于是我做了另一个尝试.

![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-2_framed-400x667.png "G+ Profile Mockup 2_framed")

我做的改动:

> 把圈子加了回来, 放在头像左侧;
>
> 把 Hangout 按钮移动到头像右侧;
>
> 将底部 Nav Bar 换成透明的;
>
> 规范 Fixed Tabs 栏的高度 (48dp).

等等, 似乎有什么不对劲的地方 (那个 typo 请无视)… 按照 Oscar Mark 的想法, 圈子按钮和 Hangout 按钮应该要移动到 Action Bar 上, 但是头像要移到 App Icon 的位置… 很不妙啊这个动画. 于是我又打开了 Photoshop.

![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-3_framed-400x667.png "G+ Profile Mockup 3_framed")![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-scrolled-_framed-400x667.png "G+ Profile Mockup scrolled _framed")

嗯, 这样看起来就好多了, 至少不会出现”交叉”的动画效果了. 我做的改动:

> 把头像移到左侧三分线处;
>
> 把两个按钮移到头像右侧;
>
> 增大按钮的字体, 加入 1dp drop shadow 作为背景防护;
>
> 在卷动之后, Hangout 和圈子按钮会并入 Action Bar.

到这一步的时候其实就已经差不多了. 但是在 Play Newsstand 里面, Fixed Tabs 是没有分割线的. 另外, +[Hugo BALLESTER](https://plus.google.com/116926306669543174765) 觉得, Hangout 按钮和圈子按钮应该直接用白色的. 于是…

![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-Final_framed-400x667.png "G+ Profile Mockup Final_framed")![](http://www.phonekr.com/wp-content/uploads/2013/11/G+-Profile-Mockup-scrolled-Final_framed-400x667.png "G+ Profile Mockup scrolled Final_framed")

只剩下一些小细节的调整了 (迷之声: 而且你终于修复了 typo, 妹得大喜):

> 图标的颜色改成标准 Android 样式, \#ffffff, 80% 不透明;
>
> 把 Action Bar 上图标的大小统一;
>
> 去掉了 Tabs 之间的分割线.

做到这里, 基本上就可以算是完成了. 上对比图:

![](http://www.phonekr.com/wp-content/uploads/2013/11/1-810x678.png "1")

明显可以注意到, 原先的个人资料页下, 完全没法看到一篇帖子/任何个人资料, 我认为这是一个非常脑残的设计. 重设计之后, 至少可以看到第一篇帖子的大部分了.

![](http://www.phonekr.com/wp-content/uploads/2013/11/2-810x678.png "2")

卷动之后的状态下, 新设计的资料页的 Action Bar 可以实现更多功能, 当用户向上卷动列表的时候也不会被时不时弹出来的 Hangout 大黑条给烦到.

另外还有一些需要注意的地方.

![](http://www.phonekr.com/wp-content/uploads/2013/11/Up.png "Up")

![](http://www.phonekr.com/wp-content/uploads/2013/11/Tabs.png "Tabs")

仔细观察 Up 被按下时的高亮区域和 Tabs 的 overscroll 特效高亮区域, 你会发现, 这个 84 dp 高的 Multiplexed Action Bar (收起状态) 中间有一小片区域 (12dp) 是 Action Bar 和 Tabs 共用的. 但有趣儿的地方是, 当你在这”公用区”点击时, 触发的操作是 Up 而不是切换 Tabs. 也就是说, 在逻辑上, Action Bar 依然是覆盖在 Tabs 上的 —— 你可以把 Action Bar 看成是一个完全透明的覆盖层.

既然 Action Bar 是一个透明的覆盖层, 我们就可以放心的往它下面塞图片了. 比如我在上面的重设计中, 把头像放到了 Action Bar 下面.

 

还有一句不得不提的话: 任何设计样式都不是万能的, 有其适用与不适用的地方. 千万不要为了设计而设计, 在不该套用 Multiplexed Action Bar 的地方套用它.

另外, 我毫不怀疑 Google 能拿出更好的设计来打我的脸, 所以欢迎打脸\~
