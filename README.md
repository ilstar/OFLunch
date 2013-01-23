# Welcome to OFLunch

OFLunch是我们进行内部Scrum培训时的一个产物，当时大家为了中午叫外卖要收集各种订单信息和各种找零钱，所以在这个产物诞生后我们就直接部署在了公司的内部机器上投入使用，没想到实际运行效果良好，所以使用至今。OFers秉着贡献人类的精神，决定把这份代码开源，虽然写的比较一般，但的确对有需求的人有帮助。  
OF是OpenFeint的简写，所以这个订午餐的系统就取名为OFLunch :)

Demo看[这里](http://oflunch.herokuapp.com/) Username/password: openfeint@example.com/openfeint

# 功能列表

###管理员的功能

* 商家、菜单管理
* 用户充值
* 选择当日可以订餐的商家

### 普通用户的功能

* 用户订餐
* 用户查看自己的流水账目
* 当日订餐列表

暂时就想到这么多，还是看[demo](http://oflunch.herokuapp.com/)比较实在 O(∩_∩)O哈哈~

# 使用流程

管理员创建菜单 -> 管理员为当日选择可以订餐的商家 -> 用户订餐 -> 管理员锁定，订餐 -> 收到实物后结账！

# 安装

### Requirements to install

* Ruby 1.9.2
* MySQL 5.0 or above.

### Installation for deployment

    git clone git@github.com:ilstar/OFLunch.git && cd OFLunch
    bundle install
    cp config/database.yml.example config/database.yml

edit `config/database.yml` according to your envinorment

    rake db:create
    rake db:schema:load
    rake db:seed
    rails s

# 问题反馈

如果有任何问题可以发信息给我，欢迎提问。