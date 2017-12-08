# jatin
留学生作业。
###客户需求
要求服务器使用PHP，客户端使用swift，最迟2月前完成，期望尽快完成。
用户密码必须加密，连接学校提供的数据库，部署到学校提供的服务器。
注：需要校园内网才能连接数据库，可先建立测试数据库进行开发。
### 邮箱注册

    GET /users/reg?email=&username=&pwd=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| email | string | Y | 注册邮箱，不可重复|
| username | string | Y | 用户名，不可重复 |
| pwd | string | Y | 用户密码，要求数据库存加密后的密码 |

##### 返回值说明

``` json
{ 
	"code": 1 //1-成功,0=失败
	"data":{
	        "mid": 123, 
    	        "email": "foo@bar.com",
    	        "username": "八宝山趐臀颜王",
    	        "token": "xxx00yyyzzz",//访问其他信息时使用此token请求
	}
        "errMsg":"邮箱已被使用！"
}
```
### 用户登录

    GET /users/login?user=&pwd=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| user | string | Y | 注册邮箱或者用户名|
| pwd | string | Y | 用户密码，明文密码 |

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //0=失败，1=登录成功,2=登录成功且需要更改密码
	"data":{
	        "mid": 123, 
                "email": "foo@bar.com",
    	        "username": "八宝山趐臀颜王",
    	        "token": "xxx00yyyzzz",//访问其他信息时使用此token请求
	}
        "errMsg":"用户不存在！"
}
</pre>
```
### 找回密码

    GET /users/forget?username=&email=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| email | string | Y | 注册时的邮箱|
| username | string | Y | 用户名，必须和邮箱一直，发送临时密码的邮件到这个邮箱 |

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
        "errMsg":"用户不存在！"
}
</pre>
```
### 更改密码

    GET /users/changepwd?username=&email=&newpwd=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| email | string | Y | 注册时的邮箱|
| username | string | Y | 用户名 |
| newpwd | string | Y |  新的密码，明文密码，服务器加密存到数据库|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
        "errMsg":"用户不存在！"
}
</pre>
```
### 编辑资料

    GET /users/editprofile?username=&email=&phone=&pwd=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| email | string | Y | 注册时的邮箱|
| username | string | Y | 用户名 |
| phone | string | Y | 手机号 |
| pwd | string | Y |  明文密码|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
        "errMsg":"邮箱已存在！"
}
</pre>
```
### 注销账户

    GET /users/delete?pwd=&email=&reason=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| email | string | Y | 注册时的邮箱|
| pwd | string | Y | 用户密码，明文密码 |
| reason | string | Y | 注销账号的原因|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
        "errMsg":"用户不存在！"
}
</pre>
```
### 获取用户积分

    GET /shop/account?token=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| token | string | Y | 用户凭证|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
	"count": 100
        "errMsg":"foo bar"
}
</pre>
```
### 获取用户积分消费明细

    GET /shop/accountdetail?token=&start=&limit=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| token | string | Y | 用户凭证|
| start | int | Y | 上一次获得的交易记录列表最后一条的id，第一次请求为0|
| limit | int | Y | 请求数据的条数|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //0=失败，1=成功
	"data":{
              "count":100
	       "list": [
                            {
                                "aid": 123, 
                                "location": "北京市",
    	                        "date": "2017-12-30",
    	                          "price": 12
                          },
                            {
                                "aid": 344, 
                                  "location": "天津市",
    	                        "date": "2017-11-30",
    	                          "price": 22
                          },
                         .......
                       ]
	}
        "errMsg":"foo"
}
</pre>
```
### 获取商品列表

    GET /shop/goods?token=&start=&limit=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| token | string | Y | 用户凭证|
| start | int | Y | 上一次获得的交易记录列表最后一条的id，第一次请求为0|
| limit | int | Y | 请求数据的条数|
##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //0=失败，1=成功
	"data": [
                            {
                                "gid": 123, 
                                "title": "手机壳",
    	                        "picurlstr": "http://baidu.com/hotdog.jpg",
    	                        "description": "十块钱你卖不了吃亏卖不了上当",
    	                         "price": 12,//价格
                          },
                            {
                                "gid": 44, 
                                "title": "避孕套",
    	                        "picurlstr": "http://baidu.com/hotdog.jpg",
    	                        "description": "十块钱你卖不了吃亏卖不了上当",
    	                         "price": 22,//价格
                          },
                         .......
                   ]
        "errMsg":"foo"
}
</pre>
```
### 兑换商品

    GET /shop/pay?token=&goodsid=

##### 请求参数说明

| NAME | TYPE | REQUIRED | MEMO |
| ----- | ----- | ----- | ----- |
| token | string | Y | 用户凭证|
| goodsid | string | Y | 商品的id|

##### 返回值说明

``` json
<pre>
{ 
	"code": 1 //1-成功,0=失败
        "errMsg":"foo bar"
}
</pre>
```
