# pamphlet_app

一个查看Github内容的小册子。

### 已完成的功能

1. 一些基础模块的搭建
2. github的repo页面的展示
3. 完成repo list
4. 完成github用户模块
5.  repo的issue展示

### TODO List

- [ ] 完善github客户端的体验
- [ ] 一些特殊部分的高亮显示，以及markdown文本的解析工作（主要原因是，在用第三方库，碰到一个列表中，每个cell中都有markdown的文本的话，会导致一些问题）
-  [ ] 添加搜索等服务
-  [ ] 增加登录模块，然后展示个人github的一些内容。目前的展示内容多为公共的。后续为了更方便的使用的话，这一块是一定要完善的。

做这个app的初衷其实是，看到戴老师的小册子后，因为上下班通勤会有很多的通勤时间，因此可能可以利用这些碎片的时间，去看一些东西。（卷起来！）然后因为想接触一下flutter的知识吧，刚好也能做一个实践吧。

### Run Project

add a json file named auth_token.json to /assets/data directory;

I will get github token in this way:

```dart
static Future<String> githubAuthToken() async {
  var r = await FileManager.loadDataFromFile('assets/data/auth_token.json');
  return r['authToken'];
}
```
So make sure you have done this!!!!

### App展示



| <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/repos.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/repo.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/developers.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/developer.png" width="190" height="335"/> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/pamphlet.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/issues.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/issue.png" width="190" height="335"/> | <img src="https://github.com/dyljqq/pamphlet_app/raw/main/pamphlet_screenshot/issueComment.png" width="190" height="335"/>                                                            |



##### 规划

作为flutter的练手项目，以及后续会通过这个项目在手机上查看一些GitHub相关的信息。



### 接口简介

* 获取用户的contribution

  

  - url:

    https://api.github.com/graphql

  - method

    Post

  - 参数

  ```dart
  "query": '''query {
        user(login: "$name") {
          name
          contributionsCollection {
            contributionCalendar {
              colors
              totalContributions
              weeks {
                contributionDays {
                  color
                  contributionCount
                  date
                  weekday
                }
                firstDay
              }
            }
          }
        }
      }'''
    
    name: 表示用户的名字，比如dyljqq.

具体可以参考这个链接: [UserContribution Api](https://docs.github.com/en/graphql/reference/objects#contributionscollection)



##### ps 鸣谢

[GitHub - ming1016/SwiftPamphletApp: 戴铭的 Swift 小册子，一本活的 Swift 手册](https://github.com/ming1016/SwiftPamphletApp) 

