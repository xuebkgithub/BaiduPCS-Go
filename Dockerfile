#本镜像基于最新版alpine+glibc+BaiduPCSweb
FROM alpine:edge

LABEL MAINTAINER="Xuebk <mail@xuebk.cn>"

# 百度云盘Docker版，适用系统：CentOS 7、Unbutu、Debian、Fedora、Raspberry Pi等linux系统，
# 也适用于windos、mac等系统
ENV GLIBC_VERSION="2.30-r0"
# 这里是 版本号
ENV baidupcs_web_tag=3.6.8
# 这里是 系统架构
ENV baidupcs_web_architecture=linux-amd64
ENV baidupcs_web_name=BaiduPCS-Go-${baidupcs_web_tag}-${baidupcs_web_architecture}
ENV baidupcs_web_URL=https://github.com/liuzhuoling2011/baidupcs-web/releases/download/${baidupcs_web_tag}/${baidupcs_web_name}.zip

# 基础依赖
RUN apk update \
    && apk --no-cache add ca-certificates wget libstdc++ tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >  /etc/timezone \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && apk --no-cache add glibc-${GLIBC_VERSION}.apk

# 项目安装
RUN mkdir -p /BaiduPCS \
    && wget -q ${baidupcs_web_URL} \
    && unzip ${baidupcs_web_name}.zip && mv /${baidupcs_web_name}/BaiduPCS-Go /BaiduPCS \
    && rm -rf ${baidupcs_web_name}.zip ${baidupcs_web_name} \
    && chmod a+x /BaiduPCS/BaiduPCS-Go

# 删除 无用内容
RUN apk del wget tzdata \
    && rm -rf /glibc-${GLIBC_VERSION}.apk

WORKDIR /root/Downloads
VOLUME ["/root/Downloads"]
EXPOSE 5299

CMD ["sh", "-c", "/BaiduPCS/BaiduPCS-Go"]