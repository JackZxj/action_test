# Github Actions自动推送镜像到dockerhub

Github 自从被微软收购了就越来越财大气粗了，Actions 这么好用的 CI/CD 工具都免费供应，简直良心。。

## 注册并配置 dockerhub

* 注册完毕后，在这个页面创建一个repo: `https://hub.docker.com/repository/create` (每个用户有一个免费私人仓库，可以开来测试)
* 在这个页面创建一个私钥用于 Actions 的虚机登录 docker ，推送镜像: `https://hub.docker.com/settings/security`

## 创建 Github 仓库并配置自动化流水线

从 `https://github.com/new` 创建一个新的仓库用于测试，私有或者公开仓库都行。

### 在本地创建一个 Dockerfile

``` dockerfile
FROM nginx:alpine
RUN echo "hello from init version!" > /usr/share/nginx/html/index.html
```

### 创建 Github Actions

``` BASH
mkdir -p .github/workflows
vi .github/workflows/publish-my-image.yml
```

关于自动化推送镜像的更多操作可以参考 https://github.com/docker/build-push-action

### 配置 Secrets

在 `https://github.com/YOUR_GITHUB_NAME/YOUR_REPO/settings/secrets/actions` 里可以配置 repo 的 Secrets，当然也可以不配置，使用团队的公用 Secrets，参考 https://docs.github.com/cn/free-pro-team@latest/actions/reference/encrypted-secrets

创建两个值：

* Key: `DOCKERHUB_USERNAME` Value: `dockerhub 用户名`
* Key: `DOCKERHUB_TOKEN` Value: `前面第二部分创建的 dockerhub token`

(key 取决于 publish-my-image.yml 配置的名字)

## 触发

触发 Actions 取决于 publish-my-image.yml 配置的方式。本例的触发方式为 `发布release` ，即当在仓库中创建release时，就会触发流水线，自动构建多版本镜像发布到 dockerhub。

其他触发方式参考 https://docs.github.com/cn/free-pro-team@latest/actions/reference/events-that-trigger-workflows
