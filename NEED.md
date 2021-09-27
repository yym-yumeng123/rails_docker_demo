# 记账工具需求分析

- [UI 链接](https://www.figma.com/file/EsMyL1C8CuoSGLpa7pmvS5/%E6%97%BA%E8%B4%A2%E8%AE%B0%E8%B4%A6%EF%BC%88%E7%BD%91%E7%BB%9C%E7%89%88%EF%BC%89?node-id=0%3A1)

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
   - taggings 表, 表示 records 和 tags 的关联
   - password_reset_request 记录所有的重置请求

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

**注册接口**
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

### 创建 users 控制器 controller

```bash
# 带 s
bin/rails g controller users
```


# Record 记录

- params: 金额
- params: 类型: 支出 or 收入
- params: 标签: 衣食住行...

```bash
# 创建model
bin/rails g model record
# 数据迁移
bin/rails db:migrate
```

# Tags 标签

**比如: 衣,食,住,行等标签**

```bash
bin/rails g model tag

bin/rails db:migrate
```

# Tagging 关联数据库
1. 关联 `record` 和 `tag`
   - 一个记录可以有多个标签
   - 一个标签可以有多个记录
   - n => n

2. 我们可以创建另外一张表
   - `例如: r1 -> t1, r1 -> t2, t1 -> r2, ...`
   - `taggings model` ==> `record_id, tag_id`


```rb
# 引用 record tag
class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :record, null: false
      t.references :tag, null: false
      t.timestamps
    end
  end
end
```

# 这三个表的从属关系
- `record has_many tagging`
- `tag has_magy tagging`
- `tagging belongs_to record`
- `tagging belongs_to tag`
- 通过上面推导 `record has_many tag` `tag has_many record`


```rb
# tagging.rb
class Tagging < ApplicationRecord
  belongs_to :record
  belongs_to :tag

  validates :record_id, presence: true
  validates :tag_id, presence: true
end

# tag.tb
class Tag < ApplicationRecord
  has_many :taggings
  has_many :records, through: :taggings

  validates :name, presence: true
end

# record.rb
class Record < ApplicationRecord
  # 我拥有很多从属, taggings
  has_many :taggings
  # 因为每一个 tagging 又属于某一个 tag, 所以 rcord 拥有很多 tags,  通过 taggings
  has_many :tags, through: :taggings

  enum category: {  outgoings: 1, income: 2 }
  
  validates :amount, presence: true
  validates :category, presence: true
end
```