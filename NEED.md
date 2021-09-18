# 记账工具需求分析
- [UI链接](https://www.figma.com/file/EsMyL1C8CuoSGLpa7pmvS5/%E6%97%BA%E8%B4%A2%E8%AE%B0%E8%B4%A6%EF%BC%88%E7%BD%91%E7%BB%9C%E7%89%88%EF%BC%89?node-id=0%3A1)


### 用户 (邮箱登录) user
1. 登录
2. 注册
3. 请求充值 ==> 用户输入邮箱发链接
4. 重置密码 ==> 用户点击重置
5. 退出登录


### 用户记录 record
1. 新增记录
2. 修改记录
3. 删除记录
4. 查找记录

### 行为标签 tag
- 增删改查

### 标记


# 表设计
1. 上面的需求分析我们应该有哪些表
   - users/records/tags
   - taggings 表, 表示records 和tags 的关联
   - password_reset_request记录所有的重置请求


### users 表
**从需求出发**
- 注册: 邮箱, 密码, 确认密码 ==> 邮箱需要存, 密码不存, 存密文
- 数据库不需要确认密码
- 数据是不需要存密码, 只存密文
- 如何加密 ==> 使用 rails 最佳实践 has_secure_password
- 密文最佳实践 password_digest
- 注册之后使用 mailer 发欢迎邮件

**结论**
- users 表含有 email 和 password_digest

### 创建 users 表
```bash
# 1
# 创建 User 模型表
bin/rails generate model User
# 也可以添加参数
bin/rails g model User email:string password_digest:string

# 2
# 数据迁移
bin/rails db:migrate 
```
