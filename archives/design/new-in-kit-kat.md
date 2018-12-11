[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")

Android Design in Action —— 一起来食 Kit Kat
============================================

2013 年十一月 1 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [ADiA](http://www.phonekr.com/tag/adia-2/), [Android 4.4](http://www.phonekr.com/tag/android-4-4/), [Kit Kat](http://www.phonekr.com/tag/kit-kat/)

[![design\_elements\_landing](http://www.phonekr.com/wp-content/uploads/2013/11/design_elements_landing.png)](http://www.phonekr.com/wp-content/uploads/2013/11/design_elements_landing.png)

就在今天, Google 悄然发布了 Nexus 5 和 Android 4.4. Android 4.4 虽然依然只是 0.1 的版本号升级, 但是却带来了非常巨量的区别. 这期 ADiA 的特别节目, 我们就来遍历一下在 Android 4.4 中, Android Design 有了哪些变化.

[![slides.003-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.003-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.003-001.png)

我们要提到的第一件事情就是今天随着 Android 4.4 一起发布的新设备 (等一下, 是不是反了?), Nexus 5. Nexus 5 作为新一代 Android 展示机, 它有着 5″ 大小, 1080p 的屏幕. 这里有些数据是你没法从配置表中看到的. Nexus 5 的屏幕对应着 640 x 360 dp, 和 Glalxy Nexus 是一样的, 而比 NexusNexus 4 略窄. 而它的屏幕 (逻辑) 密度 XXHDPI (480 dpi), 而不是 440 dpi (实际密度). 另外顺便提一句, 现在 1080p 的设备越来越多了, 且不说 HTC One 和 Galaxy S4, 国内的魅族和小米也一起跨进了 1080p 的大门, 所以当你开发应用时, 请无论如何准备好 XXHDPI 的资源.

[![slides.004-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.004-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.004-001.png)

在 Android 4.4 中, 系统 UI 变得更加的中性. 在之前的 Android (4.0-4.3) 上, 系统颜色是很显眼的蓝色. 触摸反馈和其他高亮颜色也都是这种高对比度的蓝色. 在很多情况下, 这样的蓝色会和应用中采用的个性化颜色产生强烈的冲突. 在 Android 4.4 中, 系统的颜色不在那么显眼, 而是更多的采用了中性的, 灰调的颜色以避免[和应用的颜色产生冲突](http://www.phonekr.com/google-android-apps-look-boring/ "Google 应用看起来越来越平庸了 —— 不过这是件好事"). 有了这样的铺垫, 你就可以更加放心的在你的应用上采用丰富的颜色了.

对了, 别忘了去看看 Android Design 的新章节 “[Your Branding](https://developer.android.com/design/style/branding.html "Your Branding | Android Desing")“, 在这个新章节中, Android Design 将教你如何更好的凸显你的品牌特色 —— 包括用色, Logo 和图标. 在这个方面, [Press](http://www.phonekr.com/press-android/ "非典型 Android Design——Press") 做得非常好.

[![slides.006-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.006-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.006-001.png)

在 Android Design 的 Your Branding 中, 特别提到了图标制作这一点. 在[之前的 ADiA 节目](http://www.phonekr.com/collection/ "Android Design in Action —— 编与集")和[文章](http://www.phonekr.com/android-design-cons/ "Android Design 的缺陷")中, 我们就强调过图标制作的重要性. 当你需要自己制作一套图标的时候, 请让这套图标的表意符合 Android 自带图标的表意. 这里举了个栗子, 比方说, 你想要在应用中使用 iOS 7 风格的图图标. OK, 这没问题. 但是, 请把 iOS 7 的分享图标换掉, 重新画一个相同风格, 但是近似 Android 中分享图标的新图标, 而不是直接把一整套 iOS 7 的图标给复制过来. 通过重新画这些表意不容的图标, 用户才不会在看到新图标的时候感到困惑 —— 说真的, 我第一次用新的 Safari on iOS 7 的时候, 完全不能理解那个图标的意思. 我一直以为, 那个图标要么是上传, 要么是关闭当前标签页.

[![slides.007-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.007-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.007-001.png)

正如先前提到过的, 在 Android 4.4 中, 整个系统的颜色都变得更加的中性. 原先个性强烈的 Holo 蓝色被大量替代为不那么显眼的颜色. 比如, 你会发现, 系统自带的按钮的”按下”指示高光从原先的 Holo 蓝色高亮 + 外圈变成了 10% 黑色遮罩. 当然, 当你在自己的应用中要用到按钮的时候, 把 10% 黑色遮罩换成你的应用品牌颜色的遮罩即可. 请参见 Android Design 中的[相关论述.](http://developer.android.com/design/style/touch-feedback.html "Touch Feedback | Android Design")

实际上, 10% 黑色遮罩在光线充足的环境下, 可见性是明显低于某种颜色的遮罩的. 所以尽量不要偷懒直接使用 10% 黑色遮罩, 而是用品牌颜色, 或者 Holo 蓝色 (如果你的应用没有强烈的品牌颜色的话) 遮罩来加强触摸反馈的效果.

[![slides.008-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.008-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.008-001.png)

在 Android 4.4 中, 沉浸式体验的重要性得到了再次强化. Android Design 中专门加入了[一个章节](http://developer.android.com/design/patterns/fullscreen.html "Full Screen | ANdroid Design")对新的全屏模式进行了论述. 在这个章节中, Android Design 详尽的描述了你的应用应该在什么时候, 以何种方式进入全屏模式.

全屏模式又分为两种, 一种叫后撤式 (Lean Back), 另一种叫做沉浸式 (Immersive). 后撤式已经在之前的系统中被广泛使用了 —— 当你在观看 YouTube 视频的时候, 大部分时间是不会去碰屏幕的. 这种情况下, 虚拟键和状态栏都会自动隐藏, 但当你触摸屏幕的时候, 它们又会出现.

[![slides.009-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.009-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.009-001.png)

而沉浸式则不太一样, 在沉浸式全屏状态下, 对屏幕的操作并不会唤出系统栏. 想要唤出系统栏, 你必须从屏幕的上/下边缘向屏幕内划入. 沉浸式的全屏状态更适合游戏和阅读这样的操作. 在你第一次进入一个应用的沉浸式全屏状态时, 系统会进行提示.

那么, 以前的低调模式 (Low-Profile Mode/Lights Out Mode) 怎么办? Google 的建议是, 在新系统上采用全屏模式, 在 4.3 和之前的系统中采用低调模式.

[![slides.010-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.010-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.010-001.png)

Android 4.4 另一个很重要的改变就是透明系统栏. 新的系统栏是渐变透明的, 可以最大限度的允许屏幕显示更多内容, 也可以让系统栏和 Action Bar 融为一体, 仅仅留下最低限度的背景保护以免通知通知栏内容和 Action Bar 文字/图标难以识别.

[![slides.011-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.011-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.011-001.png)

除了主屏幕, 你也可以在应用中利用到半透明的系统栏. 这里有一个地图应用的 Demo, 你可以看到, 地图扩展到了整个屏幕上. 还有一点很重要的事, 那就是注意使用背景防护. 背景防护一般是采用渐变黑色, 以保证和状态栏图标能够产生一定的对比度. 在这样的状态下, 尽量避免使用标准 Action Bar, 而是使用 Translucent Action Bar. 这方面的内容, 在以后的 ADiA 中会提到.

[![slides.012-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.012-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.012-001.png)

也许你已经注意到了, 在 Nexus 5 上, 启动器图标出奇的大.

在一般状况下, 启动器图标的大小是 48dp 的方型. 但是, 在 Nexus 5 上, 启动器图标比一般情况下大 25%, 达到了 60dp 大. 而 Nexus 5 是 XXHDPI 的设备, 所以 60dp 就相当于 180px. 这时候, 你就只能采用更高分辨率 —— 也就是 XXXHDPI, 640dpi (顺便我一直觉得这种叫法太脑残了, Adam Koush 自己在念的时候都忍不住笑了) 大小的图标. XXXHDPI 大小的图标对应长宽为 192px. 实际上, 这正是一般情况下平板 UI 的主屏上显示图标的方式. 所以, 你总是需要准备一个比素材更高分辨率的启动器图标以备不测…

而且, 千万别认为”反正 Nexus 5 也就那么几台, 大不了我不优化了”, 别忘了 Google 将会把 Nexus 5 使用的启动器**在 Play Store 发布**以供非 Nexus 机型使用… 到时候你就准备好哭去吧.

[![slides.013-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.013-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.013-001.png)

在 Android Design 的更新中, 两种新的手势被正式[归纳入麾下](https://developer.android.com/design/patterns/gestures.html "Gestures | Android Design"), 他们就是双击和双击拖动. 双击在一般情况下相当于自动缩放. 比如, 在 Chrome 中, 当你双击一个内容块的时候, Chrome 会将网页放大到使这个内容块与屏幕等宽的大小. 而当你再次双击的时候, Chrome 会返回原先的大小. 另外, 就像是在 Gmail 中一样, 双击放大原本就填充宽度的文字块之后, 应该尽可能的把这些内容进行重排以让它们符合屏幕的宽度, 而不是让用户去横向卷动以阅读完整行文字.

双击缩放, 有个很明显的问题就是, 有的时候你并不能确定双击之后到底是缩, 还是放. 这时候我们就引入了双击拖动这个手势. 在 Google Maps (和新版的 Chrome Beta) 中, 双击拖动能起到定向放大的作用 —— 当你双击向上拖动时, 就是放大, 向下拖动, 就是缩小.

比起双指缩放, 双击和双击拖动的好处就在于它们非常便于单手操作.

[![slides.014-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.014-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.014-001.png)

这个… 不需要我多说了吧? 虽然屏幕录像功能不会给你的设计或编程带来好处, 但是有很多别的优点, 非常实用, 你将不再需要花钱购买一个屏幕录制应用, 并且担心录像质量的问题了.  你也可以在开发者设置中打开显示触摸点功能, 这样就可以在屏幕录像中捕捉到触摸点了. 如下图. 这些录像对于制作你在 Play Store 中的描述视屏而言大有帮助.

[![pointer\_spot\_anchor](http://www.phonekr.com/wp-content/uploads/2013/11/pointer_spot_anchor.png)](http://www.phonekr.com/wp-content/uploads/2013/11/pointer_spot_anchor.png) [![pointer\_spot\_hover](http://www.phonekr.com/wp-content/uploads/2013/11/pointer_spot_hover.png)](http://www.phonekr.com/wp-content/uploads/2013/11/pointer_spot_hover.png)

[![slides.015-001](http://www.phonekr.com/wp-content/uploads/2013/11/slides.015-001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/11/slides.015-001.png)

最后一点就是场景切换. 在 Android 4.4 中, 系统自带的切换动画有了很大的不同. 我们将其称为布景与转场. 你可以对应用中的场景进行定义. 系统会自动在不同的场景中采用不同的转场动画. 对于开发者而言, android.transition.TransitionManager 是必须查看的部分. 对于设计师而言, 你需要告诉开发者, 在什么样的场景下, 你想要使用什么样的动画. 现在, 定义不同的动画已经比以前要容易太多了.

> 最后, 一如既往的感谢 [+Roman Nurik](https://plus.google.com/u/0/113735310430199015092), [+Nick Butcher](https://plus.google.com/u/0/118292708268361843293) 和 [+Adam Koch](https://plus.google.com/u/0/+AdamKoch) 的这一期 [Android Design in Action](http://www.youtube.com/watch?v=6QHkv-bSlds&list=WL-obuenZ2I0mzvXqf5b61lfcuA3M8LnBv "Android Design in Action: New in Android 4.4") 特别篇.
