[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")

Android Design, 玩法还有很多
============================

2013 年十一月 22 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章"), [杂谈](http://www.phonekr.com/category/%e6%9d%82%e8%b0%88/ "查看杂谈中的全部文章") | Tags: [Android Design](http://www.phonekr.com/tag/android-design/), [杂谈](http://www.phonekr.com/tag/%e6%9d%82%e8%b0%88/)

有一段时间, 我 (和很多其他研究 Android Design 的人一样) 一度觉得 Android Design 大概已经不会有什么新的玩法出现了. 这段时间里, [Juhani Lehtimäki](https://plus.google.com/102272971619910906878 "Google+") 写了那篇[《Google 应用看起来越来越平庸了 —— 不过这是件好事》](http://www.phonekr.com/google-android-apps-look-boring/ "Google 应用看起来越来越平庸了 —— 不过这是件好事"), 大家看过之后深以为然. 千篇一律的灰底黑字, 千篇一律的 Navigation Drawer, 千篇一律的卡片, 千篇一律的 Action Bar… Android Design 看起来确实变得越来越无聊了, 至少, Google 自家的应用是这样的. 而作为 Android 平台上应用设计的标杆, 第三方应用受到 Google 应用的影响, 也纷纷用上了千篇一律的 Navigation Drawer, 千篇一律的… (NovaDNG: 这句纯粹是为了骗字数吧!)

过了一段时间, Google 发布了 Android 4.4, Kit Kat. 新的版本并没有为 Design Guideline 带来太多变化 (如果你觉得蓝色高亮变成了灰色不算大变化的话…), 而 4.4 已经是连名字都改变的大版本了 (你看, 4.1, 4.2 和 4.3 都叫 Jelly Bean, 好像也就只有 3.X 有这么长时间的沿用同一个名字了 —— 咦? [原来 Android 有 3.X 版本啊?](http://www.phonekr.com/android-design-two-years/ "生而不凡: Android Design 的前世今生")), 于是更多人对 Android Design 已经发展到瓶颈的观点表示深信不疑.

就在大家纷纷表示 Android design 已经~~放弃治疗~~完全没什么花样可玩了的时候, 昨天, Google 更新了他们的 Google Translate 和 Google Play Magazine (现在改名叫做 Newsstand 了, 而且整合了 Currents).

Play Magazine 会变成 Newsstand 的消息在两个月之前就开始流传了, 所以当我们看到 Changelog 上写的 “Play Magazine is now Play Newsstand” 的时候, 丝毫不感到吃惊. 但是这份镇定也就只能保持到这个时候了. 更新完打开应用, 稍微浏览一下正文内容, 我的下巴就开始阖不上了…

#### Newsstand

(没法翻墙的同学可以从[网盘下载](http://pan.baidu.com/s/1gtRr "百度盘")) 之所以不传优酷是因为我忘记了我的优酷帐号密码了… \_(:3」∠)\_

在 Newsstand 中, Google 采用了一套新的 Action Bar 样式. 这套 Action Bar 样式还没有正式的名称, 我自己称它为复合式 Action Bar (Multiplexed Action Bar, 简称 MAB, 听起来是不是逼格很高…).

[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.26.30_framed-400x667.png "2013-11-22 07.26.30_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.26.30_framed.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.27.17_framed-400x667.png "2013-11-22 07.27.17_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.27.17_framed.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.41.10_framed-400x667.png "2013-11-22 07.41.10_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.41.10_framed.png)

这套复合式 Action Bar 在伸展状态下, 大概是相当于原先的 Action Bar + Viewpager + Fixed Tabs, 只不过中间没有任何分割, 背景用的是变换的图片. 当用户向上卷动的时候, 整个复合式 Action Bar 向上收缩, Fixed Tabs 和 Action Bar 之间的距离缩短, 图标向左上方移动. 等到卷动完成时, 原先 Action Bar + Viewpager + Fixed Tabs 的高度就只剩下了 Action Bar + 半个 Fixed Tabs 的高度, 但是他们的背景仍然是连在一起的, 而背景图像以 Viewpager 的方式变换.

比较可惜的地方是, 尽管是在 Android 4.4 上, Google 并没有在这里利用到 Translucent Bar 的特性 —— 如果 Status Bar 透明, 能留给图片的区域就更多了.

[![](http://www.phonekr.com/wp-content/uploads/2013/11/Nexus-7-2012-810x726.png "Nexus 7 2012")](http://www.phonekr.com/wp-content/uploads/2013/11/Nexus-7-2012.png)

而另一个有趣儿的地方是, 如果你进入横屏状态, 复合 Action Bar 会直接以折叠的方式呈现, 以避免原先的 viewpager 区域区域占去过大空间而无法直接呈现出内容.

[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.48.21_framed-810x539.png "2013-11-22 07.48.21_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.48.21_framed.png)

而 Play Magazine 依然保持了类似 Google Currents 的操作方式 —— 在主界面下, 横向滑动会切换分类, 而分类和 Navigation Drawer 中的内容保持顺序一致, 纵向滑动浏览该分类的内容. 在平板上也更好的利用了卡片式布局来呈现新闻与订阅源. (什么, 你说截图里的新闻? [啊哈哈, 佐祐里不知道呢\~](http://zh.moegirl.org/%E5%95%8A%E5%93%88%E5%93%88%EF%BC%8C%E4%BD%90%E7%A5%90%E7%90%86%E4%B8%8D%E7%9F%A5%E9%81%93 "あははーっ、佐祐理にはわかりません"))

而 MAB 的使用方式显然还有很多. Google+ 上的用户 [+Greg Hesp](https://plus.google.com/u/0/+GregHesp/about "Google+ Profile") 自己做了一个采用了 MAB 的 Google+ 资料页 [Mock Up](https://plus.google.com/u/0/+GregHesp/posts/PkYQpPvRDxe "Google+ redesign mock up"), 感兴趣的同学也可以自己试试在别的地方用用.

Newsstand 里作为原先 Magazine 的部分并没有什么变化, 这里略过不表.

#### Translate

(没法翻墙的同学可以从[网盘下载](http://pan.baidu.com/s/1ot3Qm "百度盘"))

在 Translate 3.0 出来之前, 很多人都固执的认为, Action Bar 只能是这样:

[![](http://www.phonekr.com/wp-content/uploads/2013/11/AB-Normal.png "AB Normal")](http://www.phonekr.com/wp-content/uploads/2013/11/AB-Normal.png)

最多还能变成这样:

[![](http://www.phonekr.com/wp-content/uploads/2013/11/Fading-AB.png "Fading AB")](http://www.phonekr.com/wp-content/uploads/2013/11/Fading-AB.png)

没想到, Newsstand 玩出了 MAB 这样的新花样. 不过复合 Action Bar 至少还算是切合之前的规范, 只是把已有的东西以他们想象不到的方式组合到一起了而已. 但是 Translate 3.0 的 Action Bar…

[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.30.44_framed-400x667.png "2013-11-22 07.30.44_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.30.44_framed.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.32.35_framed-400x667.png "2013-11-22 07.32.35_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.32.35_framed.png)

**整个 Action Bar 全部是可点击区域!** 原先在 Action Bar 下方的语言选择和调换栏直接被整合进了 Action Bar (而且还把 Spinner 提示给去掉了!), 而原先在 Action Bar Spinner 里面的功能切换则全部分散到了其他地方 —— 历史记录直接在输入框下方显示, 对话模式被整合进语音翻译中, 单词本则放进了右侧 Drawer 中…

而且等一下! 为什么保存到本地的[图示](https://developer.android.com/design/building-blocks/progress.html#custom-indicators "Progress & Activity")变了? 竖着的图钉 + 光线流动的动画根本就不能表现进度啊! 而且在设置里面查看离线语言包的地方为什么又变成原先的饼状? 不能接受啊不能接受!

[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-10-29-06.27.15_framed-400x667.png "2013-10-29 06.27.15_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-10-29-06.27.15_framed.png)[](http://www.phonekr.com/wp-content/uploads/2013/11/2013-10-29-06.27.15_framed1.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.33.31_framed-400x667.png "2013-11-22 07.33.31_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.33.31_framed.png)

最开始的时候不是你们先告诉我们”Drawer 只能已覆盖内容的形式出现在 Action Bar 下方, 其他形式的 Drawer 都是不规范的, [不推荐](http://www.phonekr.com/10-common-ux-issues/ "Android Design in Action —— 十大常见 Android UX 错误 #5")“的吗? 怎么这回自己搞成了这样? 说好的[不能遮住 Action Bar](http://www.phonekr.com/introduce-navigation-drawer/ "Android Design 趋势——Navigation Drawer") 呢? 自己打脸的速度也太忒么快了吧?

不过仔细想一想, 为什么原先在 ADiA 里, Roman Nurik 会提到不建议遮盖 Action Bar? 原因其实很简单, 因为那是 Navigation Drawer, 在 Drawer 开启的情况下, 用户有可能依然会用到 Action Bar 上的按钮. 而在这里, Action Bar 上已经没有按钮 (传统意义, 搜索和刷新在下方) 了. 就算把 Action Bar 遮盖, 也不会产生什么问题. 但是, 下方一排按钮, 左边时间和 a-z 两个按钮是排序方式, 而刷新和搜索是操作, 这两种性质不同的按钮放在一起居然没有分隔, 这样着实不妥. 在我看来, 排序方式的两个按钮的性质实际上是**开关**而不是按钮. 也许更合适的设计是, 把刷新和搜索放进顶部 (类似 Action Bar 的地方) —— 因为这两个按钮通常都是在右上角出现的.

[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.30.01_framed-400x667.png "2013-11-22 07.30.01_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.30.01_framed.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.31.22_framed-400x667.png "2013-11-22 07.31.22_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.31.22_framed.png)[![](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.31.41_framed-400x667.png "2013-11-22 07.31.41_framed")](http://www.phonekr.com/wp-content/uploads/2013/11/2013-11-22-07.31.41_framed.png)

新的翻译界面很有趣. 翻译的结果以卡片的形式呈现, 上面发音/语言那条除了最右侧的收藏区域之外都能点击发音, 而卡片整块区域点击都可以复制结果到剪贴板 (而不像旧版一样点击是反向翻译). 而新版的语音 (对话) 翻译模式也进行了全新设计, 看起来更加美观简洁, 去除了所有非必须的元素 (甚至包括 Action Bar). 手写翻译界面中, 手写区域的高度可以通过拖动右侧的轮辙按钮调整, 实用性很高.

最后, 我想预言一下, Google Earth, Voice, 各语言输入法, Authenticator, One Today 等还在用黑色 Action Bar 或者 Holo Dark 主题的 Google 应用, 总有一天会变成清一色的 Holo Light…

 

看完了这两个应用. 我觉得我的脸火辣辣的. 就在一个多月之前, 我的脑子里还想着, Android Design 大概已经发展到了一个瓶颈了, 我们没什么可研究的了. 但事实果然是, 我们依然[图样图森破, 上台拿衣服](http://zh.moegirl.org/%E5%9B%BE%E6%A0%B7%E5%9B%BE%E6%A3%AE%E7%A0%B4 "Too young too simple, sometimes naive. ").

> Google 在这时候及时的跳出来, 给了我一个响亮的耳光, 大声地说: “别傻了, 我还有好多花样没玩呢! 好好给我研究去!”
