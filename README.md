# BaiduPCS-Go
百度云盘Docker版
本版基于 BaiduPCS-Go linux-amd64 3.6.8

适用范围：基于百度云盘linux版开发，支持centos、debian、ubuntu、树莓派，也支持Windows、mac等系统

特点：
非会员用户也可以获得不错的下载速度
镜像轻量，安装迅速
可迁移至任意Docker环境下的机器，比如linux服务器或本地电脑等
运行：

```bash
docker run -itd -p 5299:5299 \
--name baidu \
-v /opt/BDdownload:/root/Downloads \
baoku/baidupcsweb
```
说明：

若要改端口号，比如要改成2020，可修改5299:5299为2020:5299
宿主机挂载目录为/opt/BDdownload
运行日志查看命令：docker logs baidu
删除容器：docker rm -f baidu