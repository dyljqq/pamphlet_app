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

##### 规划

作为flutter的练手项目，以及后续会通过这个项目在手机上查看一些GitHub相关的信息。

