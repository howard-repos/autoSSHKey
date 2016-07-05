# autoSSHKey
自动创建无密钥登录

利用了expect命令来实现的自动建立ssh无密钥登录

特性:

 * 如果没有密钥文件则自动创建
 * 可以重复多次运行,不会在authorized_keys中添加多余的条目
 
用法:

 * 需要expect和ssh-copy-id命令
 * 修改conf.sh中的WORKERS_HOSTNAME,添加需要建立无密钥访问的hostname
 * 修改tools/ssh-expect.sh中的command,用来在远程服务器上执行以便检查是否已经建立了无密钥登录机制
