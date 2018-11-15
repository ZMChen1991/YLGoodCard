/*
 轮播图
 http://ucarjava.bceapp.com/play?method=play
 返回
 {"code":"200","data":[{"createAt":"","id":1,"img":"http://image-public.gz.bcebos.com/vehicle.jpg","status":1,"updateAt":"","url":"http://www.baidu.com"},{"createAt":"","id":2,"img":"http://image-public.gz.bcebos.com/vehicle2.jpg","status":1,"updateAt":"","url":"http://www.baidu.com"},{"createAt":"","id":3,"img":"http://image-public.gz.bcebos.com/vehicle3.jpg","status":1,"updateAt":"","url":"http://www.baidu.com"},{"createAt":"","id":4,"img":"http://image-public.gz.bcebos.com/vehicle4.jpg","status":1,"updateAt":"","url":"http://www.baidu.com"}],"message":"请求成功"}
 关键字：
 http://ucarjava.bceapp.com/play?method=keyword
 返回
 {"code":"200","data":{"keyword":["冠道","麦瑞纳","北汽威旺M35","瑞风S2mini","众泰M300","荣威e550","双环SCEO","沃尔沃XC60新能源","大柴神"]},"message":"请求成功"}
 
 c成交记录
 http://ucarjava.bceapp.com/trade?method=random
 返回
 {"code":"200","data":[{"createAt":"2018-11-12 09:53:42","id":12,"list":[],"status":"1","text":"恭喜朱先生 179****3539 以6.16元成功购买 日产 轩逸 2016款 经典 1.6XE 手动舒适版一台(车商收购价5.9万,车商售价6.6万)。","updateAt":""},{"createAt":"2018-11-12 09:57:43","id":19,"list":[],"status":"1","text":"恭喜林先生 131****5342 以6.88元成功购买 丰田 威驰 2017款 1.5L CVT创行版一台(车商收购价6.5万,车商售价7.4万)。","updateAt":""},{"createAt":"2018-11-12 10:00:55","id":25,"list":[],"status":"1","text":"恭喜冯先生 143****4240 以18.25元成功购买 日产 楼兰 2015款 2.5L XE 两驱精英版一台(车商收购价17.3万,车商售价19.5万)。","updateAt":""},{"createAt":"2018-11-12 10:15:48","id":36,"list":[],"status":"1","text":"恭喜许先生 181****6088 以6.8元成功购买 本田 思域 2012款 1.8L 自动舒适版一台(车商收购价6.5万,车商售价7.3万)。","updateAt":""},{"createAt":"2018-11-12 10:21:31","id":50,"list":[],"status":"1","text":"恭喜孙先生 136****9488 以18元成功购买 宝马3系 2015款 320Li 超悦版时尚型一台(车商收购价17.1万,车商售价19.3万)。","updateAt":""}],"message":"请求成功"}
 
 推荐列表
 http://ucarjava.bceapp.com/detail?method=recommend
 返回
 {"code":"200","data":[{"id":100006,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100007,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100009,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100010,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100005,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型5","licenseTime":"2014-06","course":"4.2","price":120000,"originalPrice":"299000"},{"id":100008,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型5","licenseTime":"2014-06","course":"4.2","price":120000,"originalPrice":"299000"},{"id":100011,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君威 2013款 2.4L SIDI精英舒适型1","licenseTime":"2016-01","course":"1.2","price":130000,"originalPrice":"0"},{"id":100002,"displayImg":"http://image-public.cdn.bcebos.com/vehicle2.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型2","licenseTime":"2015-06","course":"4.1","price":115000,"originalPrice":"299000"},{"id":100004,"displayImg":"http://image-public.cdn.bcebos.com/vehicle4.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型4","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100003,"displayImg":"http://image-public.cdn.bcebos.com/vehicle3.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型3","licenseTime":"2013-11","course":"1.0","price":134400,"originalPrice":"299000"}],"message":"请求成功"}
 
 根据条件搜索;
 http://ucarjava.bceapp.com/detail?method=search
 {"code":"200","data":[{"id":100006,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100007,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100009,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100010,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"雪佛兰 赛欧 2013款 2.3L SIDI豪华舒适型6","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100005,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型5","licenseTime":"2014-06","course":"4.2","price":120000,"originalPrice":"299000"},{"id":100008,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型5","licenseTime":"2014-06","course":"4.2","price":120000,"originalPrice":"299000"},{"id":100011,"displayImg":"http://image-public.cdn.bcebos.com/vehicle.jpg","title":"别克 君威 2013款 2.4L SIDI精英舒适型1","licenseTime":"2016-01","course":"1.2","price":130000,"originalPrice":"0"},{"id":100002,"displayImg":"http://image-public.cdn.bcebos.com/vehicle2.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型2","licenseTime":"2015-06","course":"4.1","price":115000,"originalPrice":"299000"},{"id":100004,"displayImg":"http://image-public.cdn.bcebos.com/vehicle4.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型4","licenseTime":"2014-06","course":"4.2","price":134500,"originalPrice":"299000"},{"id":100003,"displayImg":"http://image-public.cdn.bcebos.com/vehicle3.jpg","title":"别克 君越 2013款 2.4L SIDI豪华舒适型3","licenseTime":"2013-11","course":"1.0","price":134400,"originalPrice":"299000"}],"message":"请求成功！"}
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

