# Binding: AirAccount Service Contract

## 背景

Binding是我们AirAccount增加的一个账户的生命周期。逻辑是

1. 开放
    1. 无论已有的EOA还是AA，还是你没有加密账户，想通过手机号或者Email获取其他web2账户新建，都可以binding
2. 增值
    1. 绑定后，就可以享受AirAccount和AAStar提供的各种增值服务
    2. 例如Money Notify、DMFA、D2FA，Public Guardian，Will Excutor，Comet ENS，Alert（security），或者更多
    3. 更新中的roadmap
        1. 
        
        ![Untitled](Binding%20AirAccount%20Service%20Contract%20c7679b47fde647c69e71fb24dce8fb0f/Untitled.png)
        

## 结构

Binding的核心动作，是

1. 在中心化relay做一个关联记录，例如购买了NFT，经过验证交易有效性，则会把余额、 NFT和用户地址关联，存储到中心化relay（未来可能会改进为去中心化合约或者IPFS等）
2. 在Service Contract做签名记录和必要授权，不同业务可能有不同条件，未来尝试合并：
    1. 比如日限额业务，需要签名一个额度，和地址关联，和一些参数关联，每个交易都是被链上验证一次
        1. 验证方式可以是链上hash重新生成的验证（消耗gas多？）
        2. 也可以是类似verkle tree的zk，向量验证方式，链下按相同规则计算，提交proof，链上验证proof？（消耗gas少？）
    2. 其他业务规则也类似，需要有一个通用的验证规则，链下计算，提交proof上链，链上验证proof？
    

## Flow

![Untitled](Binding%20AirAccount%20Service%20Contract%20c7679b47fde647c69e71fb24dce8fb0f/Untitled%201.png)

![Untitled](Binding%20AirAccount%20Service%20Contract%20c7679b47fde647c69e71fb24dce8fb0f/Untitled%202.png)

![Untitled](Binding%20AirAccount%20Service%20Contract%20c7679b47fde647c69e71fb24dce8fb0f/Untitled%203.png)