# UIDesignAssistant

**This UIDesignAssistant** is a simple and directed UI-design helper.It can enhance your efficience on UI-design as you don't need to push manay ViewControllers to your aimed ViewController any more. You can use It to check your new ViewController while you are desining it anytime and anywhere. It is a convenient Tool for the begining of your new project.

这个UIDesignAssisstant是一个简单直接的UI设计帮手。它能帮你提高你的工作效率，你不再需要push很多层Controller才能到你的目的Controller。在你设计新控制器时，你可以用它检验你新建的Controlller。在开发初期它是一个比较方便的工具。
## Effect
![image](https://github.com/WuChuming/UIDesignAssistant/blob/master/github.gif)   

## Install steps
**1.** Drop files in a floder called CM_UIDesignAssistant into your project。

**2.** In Appdelegate，#import "BYDUIDesignAssistant.h" and wtrite a commend “[[BYDUIDesignAssistant shareInstance] setAssistant]” into the method named “didFinishLaunchingWithOptions”。

**3.** Enjoy it！！！！！！

**PS：** It automatically load your classes‘ files。You can set the classes’ fliter in a class called “UIViewController+runtime”。By the way，It is the core。