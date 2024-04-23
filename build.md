
crontab -e:

*/1 * * * *  /home/faith/overleaf-toolkit/export.sh &&cd '/home/faith/overleaf-toolkit/overleaf/MUST Ph.D. Thesis-MOD' && git add . && git commit -m "Build overleaf-date" && git push -u origin "master"


您的问题是如何生成TLS私钥和证书，这些文件可以用于配置nginx服务器，以支持HTTPS协议。TLS是一种安全协议，可以在网络通信中提供身份验证和加密功能。

要生成TLS私钥和证书，您需要使用openssl工具，它是一个开源的加密库，可以在多种平台上运行。您可以按照以下步骤操作：

1. 在终端中，进入您想要存放证书的目录，例如config/nginx/certs。
2. 生成一个私钥文件，命名为overleaf_key.pem，使用rsa算法，长度为2048位。您可以使用以下命令：

```bash
openssl genrsa -out overleaf_key.pem 2048
```

3. 生成一个证书签名请求（CSR）文件，命名为overleaf_csr.pem，它包含了您的公钥和一些身份信息，例如域名、组织、邮箱等。您可以使用以下命令，根据提示输入相应的信息：

```bash
openssl req -new -key overleaf_key.pem -out overleaf_csr.pem
```

4. 生成一个自签名的证书文件，命名为overleaf_certificate.pem，它由您的私钥对您的CSR进行签名，有效期为365天。您可以使用以下命令：

```bash
openssl x509 -req -days 365 -in overleaf_csr.pem -signkey overleaf_key.pem -out overleaf_certificate.pem
```

5. 检查您的证书文件是否有效，您可以使用以下命令查看证书的详细信息：

```bash
openssl x509 -in overleaf_certificate.pem -noout -text
```

这样，您就成功生成了TLS私钥和证书，您可以在nginx的配置文件中指定它们的路径，例如：

```nginx
server {
    listen 443 ssl;
    server_name overleaf.com;
    ssl_certificate config/nginx/certs/overleaf_certificate.pem;
    ssl_certificate_key config/nginx/certs/overleaf_key.pem;
    # 其他配置...
}
```


Source: Conversation with Bing, 2/24/2024
(1) 如何生成TLS(SSL)证书 - 知乎 - 知乎专栏. https://zhuanlan.zhihu.com/p/423506052.
(2) 如何创建和签名SSL/TLS证书？ - 俗 - 博客园. https://www.cnblogs.com/shisuizhe/p/13712591.html.