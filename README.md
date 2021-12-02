# pamphlet_app

一个查看Github内容的小册子。

### 已完成的功能

1. 一些基础模块的搭建
2. github的repo页面的展示
3. 完成repo list



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

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/repos.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/repo.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/developers.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/developer.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/pamphlet.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/issues.png)

![](https://github.com/dyljqq/pamphlet_app/tree/main/pamphlet_screenshot/issue.png)

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

