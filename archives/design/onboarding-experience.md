[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")


Android Design in Action —— 初期体验
====================================

2013 年十二月 11 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [ADiA](http://www.phonekr.com/tag/adia-2/), [初始界面](http://www.phonekr.com/tag/%e5%88%9d%e5%a7%8b%e7%95%8c%e9%9d%a2/), [登陆](http://www.phonekr.com/tag/%e7%99%bb%e9%99%86/)

[![slides.001](http://www.phonekr.com/wp-content/uploads/2013/10/slides.0011-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.0011.png)

我们知道, 很多时候, 如果不是非常必须的应用话, 一个应用被安装到用户手机上的头几分钟对于这个应用而言可以说是生死存亡的关键时刻 —— 有相当大数量的应用就在这几分钟被用户丢进了垃圾桶 (有些”负责”的用户还会去 Play Store 给个一星). 那么, 作为开发者/设计师, 如何让你的应用挺过这关键的几分钟, 得以在用户的手机里活下去? 这就是我们将要在这期 ADiA 中讨论的话题 —— 登录体验/初期体验.

如果你想要让你的应用熬过那至关重要的几分钟而得以存活, 那么营造一个良好的初期体验就是不二法门.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.003-810x607.png "slides.003")

不知道你还记不记得[十大常见 Android UX 错误](http://www.phonekr.com/10-common-ux-issues/ "Android Design in Action —— 十大常见 Android UX 错误")中提到的第二大 UX 错误, 即贫弱的首屏交互? 这里的首屏交互很大程度上指的就是初期体验. 之所以把这一点单独拎出来写一篇新文章, 是因为首屏交互和初期体验实在是太重要了.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.004-810x607.png "slides.004")

首先, 不要显示启动画面. 这里的启动画面尤其指的是比如一个硕大的应用 Logo 或者广告什么的, 比如新浪微博, 比如微信, 比如 QQ… 记住, 内容第一, 而前面提到的那些应用的启动画面并不是内容. 彰显品牌是很重要, 但正确的方式是用 Action Bar 图标和颜色来做这种事情. 比如在 Google Play 中, 几个应用和分类都采用了不同的 Action Bar 图标和颜色来彰显品牌.

很多人认为启动画面的很重要的作用是提供加载时间. 但是, 就算你真的需要一个画面来缓冲加载时间, 你也应该至少显示出你的应用的框架 (比如 Action Bar 和 Fixed Tabs), 或者一个自制的, 动态的 Loading Spinner (比如[布卡漫画](http://zh.moegirl.org/%E5%B8%83%E5%8D%A1%E5%A8%98 "布卡娘")的[布卡娘](http://static.mengniang.org/7/74/%E5%B8%83%E5%8D%A1%E5%A8%98loading%E5%9B%BE.gif "布卡娘 Loading 图")… 可惜的是布卡漫画自己有个 Splash Screen). 这样的话用户至少可以进入设置, 查看你的应用的不同的区域, 甚至开启 Drawer 看看里面有什么东西… 这些都能够更好的减轻用户的焦虑感. 当然, 如果是用户第一次打开这个应用 (刚刚安装完), 是可以显示一个欢迎画面的. 比起显示启动画面更糟糕的是显示**全屏**的启动画面, 那就是错上加错了 —— 要不咱再来个启动音乐和不识别按键操作凑齐三件套得了?

讲完了启动画面, 我们来说说引导界面.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.005-810x607.png "slides.005")

对于一般的应用而言, 绝大多数情况下在用户第一次打开它的时候都应该给出一个引导界面以告知用户这个应用是干嘛的, 该怎么用, 是不是需要登录, 等等.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.006-810x607.png "slides.006")

\*上面图片中的内容参见 [Android Design](https://developer.android.com/design/patterns/help.html "Help").

Android Design 中提到”不要显示用户不需要的帮助信息, 除非事不得已”, 引导界面就是一种事不得已的情况.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.007-810x540.png "slides.007")

尽量避免强制打断的引导界面. 实际上, 比起使用专门的引导界面, 在应用内的引导 (也就是行内式) 是我们更推荐的. 行内式的引导界面就像是图中 Google Play Movies 中显示的那样, 引导作为一张内容卡片存在, 可以很容易的被消除掉, 也可以在显示引导的同时显示内容 (只要往下卷动就行了). 这样, 用户就能很清晰的认识到这个应用能做什么. 而且, 这个卡片中提供了最初始的操作 —— 购买影片, 可以说是这个应用里最初始的操作 (你需要先购买影片才能在影片库里浏览).

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.008-810x540.png "slides.008")

上图就是一个典型的强制打断式引导界面. 可以看出, 这个引导界面和应用几乎是两个东西, 游离于应用本身之外. 除非你的应用有非常非常非常重要的东西一定要让用户全部看完 (即使他们之前已经用过这个应用了), 否则尽量提供一个快速跳过引导的按钮.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.009-810x607.png "slides.009")

当然, 除了应用本身, 别忘了利用好 Google Play —— Play 提供了给你展示视频和截图的机会, 你可以好好利用视频和截图介绍你的应用. 而且这些介绍都是在用户把应用拿到手之前做的, 不会影响到用户的使用. 不过, 这毕竟是 Play Store, 不是引导画面, 所以尽量选择一些对用户而言有吸引力, 能展现应用价值的画面/截屏吧. 当然, 别忘了提供应用在不同尺寸设备上的截图. (Play Store 会根据截图把你的应用加上平板适配的标签…)

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.010-810x607.png "slides.010")

还有一种不错的引导方式就是通过列表的空状态进行引导. 空白状态是个非常好的告诉用户该干什么的机会. 这样做的好处就是当列表不再是空状态的时候这些引导就很自然的不存在了, 而且这也属于一种行内式的引导.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.011-810x607.png "slides.011")

还有一种引导方式就是提供预载内容. 对于很多需要展示内容的应用而言, 在初次启动的时候就展示一些预先添加好的内容, 比如上图股票应用中的那些默认的股票, 能很好的帮助用户认识的应用的作用与样貌.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.012-810x607.png "slides.012")

大多数时候你都会需要你的用户注册或者登录你的应用.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.013-810x607.png "slides.013")

但是实际上, 你应该尽量延缓用户的登录操作 —— 如非必须, 允许用户在非登录状态下浏览你的应用, 等到登录能带来必要而明确的好处时, 再询问用户是否登录. 事实上, 用户宁愿等到他们**完全明白**自己为什么需要登录之后, 再进行登录操作. 不要一打开应用就劈头让用户登录. 很好的一个例子是 Tumblr, 在你打开 Tumblr 之后, 它会先展示一些默认的优质内容, 你可以随意浏览, 当你点到个人账户 Tab 或者点击 Like 或者 Reblog 的时候, 他才会问你是不是需要登录 (没登录的话这个 Tab 和操作就是没用的). 同样的, 国内的一些应用比如 Bilibili 动画, 也不会强行要求用户登录.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.014-810x607.png "slides.014")

输入用户名/邮箱/手机号和密码总是一件很麻烦的事情, 如果你能提供更快更方便的登录方法那就再好不过了. Android 的很大好处就是可以通过接入第三方帐号来进行方便的登录, 比如在国外应用上非常常见的通过 Facebook, Twitter 和 Google+ SDK 登录, 只要用户有安装这三个应用在他们的设备上, 就可以不需要输入用户名密码, 直接授权登录, 极大的简化了登录流程. 当然, 在国内的应用恐怕就没法用的这三个方便的登录方式了, 不过我们有微博…

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.015-810x607.png "slides.015")

对于 Google+, 还有一个独特的好处就是, 如果你提供了 Google+ 登录的话, Play Store 能够提供 OTA 登录的能力, 特就是说当你的应用被安装到用户的手机上时, 就已经登录好了他的帐号, 而无需用户再去登录一遍.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.016-810x607.png "slides.016")

当然, 你最好也提供一个注册的功能. 但是, 尽量把注册流程弄得简单易懂, 毕竟, 在手机上输入复杂的密码还是一件很痛苦的事情的. 打开一个网页也是不建议的.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.017-810x607.png "slides.017")

简化后的注册画面大概是像上图那样, 只留下 Email 地址栏和密码栏, 因为只有这两个是最重要的, 其他都可以推迟. 这样用户就不会在看到注册画面的时候被一大堆需要填的文本栏给吓到.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.018-810x607.png "slides.018")

Google Play Service 提供了让你读取用户账户登录的邮箱的 SDK. 好好利用这个功能, 因为往往用户在手机上登录的邮箱就是他打算用来注册这个服务的邮箱. 提供邮箱建议可以让用户省去输入邮箱的麻烦, 你也可以采取自动补全的方式来补完用户的邮箱 (@ 后面的东西, .com 之类的, 就像在第一次登录 Android 上的 Google 账户时你完全不需要输入 @gmail.com 因为这会自动补齐), 毕竟输入邮箱是一件挺麻烦的事儿.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.019-810x607.png "slides.019")

你甚至可以把密码作为可选项, 因为用户总是可以在以后重置密码的, 当然你也可以替用户生成一个密码, 反正不会有用户没事就登出 – 登录玩儿的. 用户自己设置的密码也不一定就是很好的密码, 很多用户用相同的一套密码在不同的账户上, 也许是很简单的密码, 但是如果你强行要求用户在密码里加入符号和大写字母的话, 他们又会觉得很烦.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.020-810x607.png "slides.020")

这样, 用户就只需要输入邮箱 (的前几个字母!) 就可以点击注册了, 多棒\~ 最后, 你也可以把键盘上的 Done/Next/回车变成注册键, 最大程度的简化用户的操作. 另外, 在 ICS 以及之后的版本中, 系统可以提供用户的姓名和头像, 这些信息都可以被你调用, 能够省下让用户在输入/设置一遍的麻烦.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.021-810x607.png "slides.021")

最后要提到的是屏幕覆盖叠加层.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.022-810x607.png "slides.022")

关于覆盖叠加层, 总体而言就是一句话: 尽量避免 (笑). 有些东西其实是完全不需要提示的, 比如 Drawer 或者 Action Bar, 你不需要**一再**告诉用户这些东西该怎么用. 当然, 你可以在第一次打开应用时[展开 Drawer](http://www.phonekr.com/introduce-navigation-drawer/ "Android Design 趋势——Navigation Drawer") 告诉用户他们的存在.

![](http://www.phonekr.com/wp-content/uploads/2013/12/slides.023-810x607.png "slides.023")

当然, 有些自定义手势还是有必要告诉用户一下的. 比如在新版 YouTube 中, 在视频最小化的状态下有两个自定义手势操作 (关闭和最大化), 这对于大多数用户而言都是未知的, 所以在这里告诉用户该怎么做就是很有必要的了.

 

> 以上就是这期 Android Design in Action 的内容了, 希望它能帮助你改进你的初期体验\~ 一如既往的大力感谢 Android Developers Relation Team 的 [+Roman Nurik](https://plus.google.com/u/0/113735310430199015092), 和 [+Nick Butcher](https://plus.google.com/u/0/118292708268361843293) 的 [Android Design in Action](http://www.youtube.com/watch?v=r6jMnYwjftk "Android Design in Action: Collection") 活动. 最后依然感谢结画的题图 (onboarding, 哈哈)\~
