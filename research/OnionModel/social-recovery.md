# 社交恢复方案之Guardian公钥存储
我们使用ERC4337为基础的合约账户来为用户提供Semi-custody的账户全生命周期服务，包括创建、查询、交易、过滤、恢复等。
其中的社交恢复是重要的服务，基于去中心思路，提供开源代码，可以自行部署和启动恢复流程，也可以使用AirAccount提供的恢复服务。
而恢复服务中有一个重要角色：Guardian，他们要预先提供自己的公钥，从而保障当开始恢复时，可以使用公钥来验证签名，然后执行恢复。

## 公钥隐私验证：ZK承诺保障公钥私密的方案概述
首先，我们对所有Guardian公钥，都不暴露，而是使用ZK承诺来验证私钥签名，这个方案称为：公钥隐私验证。
主要目标是保护Guardian的公钥不被泄露，保护他们的隐私，例如可以根据公钥计算钱包地址从而有可能追查到具体Guardian信息等，因此此方案保护隐私的同时又能完成正常的签名验证。
验证Guardian签名从而恢复账户需要哪些参数呢？
我们假设有公钥承诺存储合约和收集签名页面，以及预设guardian恢复方案的合约账户，如果收集完成签名，则可以通过隐私验证来完成验证过程，然后执行恢复动作




## ERC4337合约账户的恢复机制介绍
根据提供的ERC-4337规范（https://github.com/ethereum/ercs/blob/master/ERCS/erc-4337.md），我将对ERC-4337合约账户的恢复机制进行介绍和概述，分析其核心动作，并提供伪代码以说明实现方式。ERC-4337（Account Abstraction via User Operation）是一种通过用户操作（UserOperation）实现账户抽象的Ethereum改进提案，旨在增强账户灵活性，包括恢复机制。以下是详细分析。
一、ERC-4337合约账户恢复机制的介绍与概述
1. 背景与目标
背景：传统Ethereum账户分为外部拥有账户（EOA，依赖私钥）和合约账户。EOA受限于单签机制，丢失私钥无法恢复；合约账户虽可实现复杂逻辑，但需与现有基础设施兼容。
目标：ERC-4337通过引入“用户操作”（UserOperation）抽象账户管理，允许合约账户实现多签、社交恢复（Social Recovery）等功能，而无需修改Ethereum核心协议。
恢复机制：恢复本质上是更新账户的控制逻辑或状态，例如替换验证器（validator）、授权新签名者或重置密钥对，适应用户需求（如私钥丢失）。
2. 核心概念
UserOperation：
一个结构体，包含交易数据（如sender、nonce、callData、signature等），由用户提交至“入口点合约”（EntryPoint）。
恢复通过UserOperation触发，执行账户合约的自定义逻辑。
EntryPoint合约：
全局入口，负责验证和执行UserOperation，包括费用支付和状态更新。
账户合约：
实现validateUserOp函数，定义签名验证和恢复逻辑。
恢复动作由callData指定，通常涉及更新账户状态。
3. 恢复机制概述
触发方式：
用户通过客户端提交UserOperation，指定恢复操作（如更换验证器或owner）。
恢复需满足账户合约的验证规则（例如多签或社交恢复签名）。
核心动作：
验证签名：通过validateUserOp检查UserOperation签名，确认发起者有权执行恢复。
更新状态：执行callData中的恢复逻辑，例如：
替换验证器地址。
重置账户的签名方案（例如从ECDSA切换至多签）。
授权新公钥或地址。
费用支付：由paymaster或用户预付gas，恢复操作完成后结算。
与传统EOA的区别：
EOA恢复依赖私钥恢复或新地址授权，ERC-4337通过合约逻辑实现动态恢复，无需链上硬分叉。
4. 适用场景
私钥丢失：通过社交恢复（多签守护者签名）重置账户。
安全升级：更换验证器，适应新签名算法（如抗量子签名）。
大额交易：触发多签验证，增强安全性。
二、核心恢复动作的详细分析
ERC-4337的恢复机制核心在于账户合约的灵活性，其动作取决于具体实现。以下是典型恢复动作：
验证签名：
validateUserOp函数检查UserOperation.signature，验证发起者身份。
支持多签、门限签名（TSS）或社交恢复签名。
执行恢复逻辑：
替换验证器：更新账户的validator地址，指向新签名方案。
授权新地址：将新公钥或EOA地址绑定至账户。
重置状态：清除旧签名数据，初始化新配置。
这些动作通过callData编码，execute函数执行。
状态更新：
账户合约的存储变量（如owner或validator）被修改。
链上事件（如RecoveryExecuted）记录恢复详情。
费用结算：
EntryPoint扣除gas费用，更新账户nonce。
关键点：
恢复不直接替换owner address（传统多签概念），而是更新账户的验证和执行逻辑。
动作由账户合约定义，开发者可定制（如结合你的守护者方案）。
三、伪代码实现
以下是ERC-4337恢复机制的伪代码，基于规范和你的多签守护者需求（类别1、2、3，权重阈值15）。
1. UserOperation 结构体
solidity
struct UserOperation {
    address sender;         // 账户合约地址
    uint256 nonce;          // 防止重放的唯一标识
    bytes callData;         // 恢复逻辑的编码数据
    bytes signature;        // 签名数据（多签聚合）
    uint256 callGasLimit;   // gas限制
    // ... 其他字段（如paymaster）
}
2. EntryPoint 合约（简化版）
solidity
contract EntryPoint {
    function handleOps(UserOperation[] calldata ops, address payable beneficiary) external {
        for (uint i = 0; i < ops.length; i++) {
            UserOperation memory op = ops[i];
            address account = op.sender;
            require(IAccount(account).validateUserOp(op) == 0, "Validation failed");
            // 执行callData
            (bool success, ) = account.call(op.callData);
            require(success, "Execution failed");
            // 结算gas费用
            // ...
        }
    }
}
3. 账户合约（Account Contract）
solidity
contract RecoveryAccount is IAccount {
    address public validator;         // 当前验证器
    mapping(bytes32 => uint256) public guardianWeights; // guardianID => weight
    uint256 public threshold = 15;    // 权重阈值
    CommitmentStorage public commitmentStorage;

    constructor(address _commitmentStorage) {
        commitmentStorage = CommitmentStorage(_commitmentStorage);
        validator = msg.sender; // 初始验证器
    }

    function validateUserOp(UserOperation calldata userOp) external override returns (uint256) {
        bytes32[] memory guardianIds = extractGuardianIds(userOp.signature);
        require(verifyZKProof(userOp.signature, guardianIds), "Invalid ZK proof");
        require(calculateTotalWeight(guardianIds) >= threshold, "Insufficient weight");
        return 0; // 验证通过
    }

    function executeRecovery(bytes calldata callData, bytes calldata signature) external {
        UserOperation memory op = UserOperation({
            sender: address(this),
            nonce: getNonce(),
            callData: callData,
            signature: signature,
            callGasLimit: 200000 // 示例gas限制
            // ... 其他字段
        });
        EntryPoint(payable(0xEntryPointAddress)).handleOps([op], payable(msg.sender));
    }

    function updateValidator(address newValidator) external {
        validator = newValidator;
        emit ValidatorUpdated(newValidator);
    }

    function verifyZKProof(bytes calldata signature, bytes32[] memory guardianIds) internal view returns (bool) {
        // 集成zk-SNARK verifier
        bytes32[] memory commitments = commitmentStorage.getCommitments(guardianIds);
        return zkVerifier.verify(signature, commitments); // 伪代码
    }

    function calculateTotalWeight(bytes32[] memory guardianIds) internal view returns (uint256) {
        uint256 totalWeight = 0;
        for (uint i = 0; i < guardianIds.length; i++) {
            totalWeight += guardianWeights[guardianIds[i]];
        }
        return totalWeight;
    }

    function extractGuardianIds(bytes calldata signature) internal pure returns (bytes32[] memory) {
        // 解码signature，提取guardianIds
        // 伪代码：假设signature包含guardianIds数组
        return abi.decode(signature, (bytes32[]));
    }

    event ValidatorUpdated(address newValidator);
}
4. CommitmentStorage 合约
solidity
contract CommitmentStorage {
    mapping(bytes32 => bytes32) public commitments; // guardianID => commitment
    mapping(bytes32 => uint256) public guardianWeights;

    function storeCommitment(bytes32 guardianId, bytes32 commitment, uint256 weight) external {
        commitments[guardianId] = commitment;
        guardianWeights[guardianId] = weight;
    }

    function getCommitments(bytes32[] memory guardianIds) external view returns (bytes32[] memory) {
        bytes32[] memory commits = new bytes32[](guardianIds.length);
        for (uint i = 0; i < guardianIds.length; i++) {
            commits[i] = commitments[guardianIds[i]];
        }
        return commits;
    }
}
5. 客户端ZK生成（伪代码）
javascript
const { generateProof } = require('snarkjs');

async function generateZKProof(signatures, guardianIds, commitments, message) {
    const circuit = new Circuit('zk-circuit.json'); // 预定义电路
    const input = {
        signatures: signatures,
        guardianIds: guardianIds,
        commitments: commitments,
        message: message
    };
    const { proof, publicSignals } = await generateProof(circuit, input);
    return { proof, publicSignals };
}
电路设计：
输入：签名、承诺、消息。
输出：证明签名由承诺对应的公钥生成。
工具：circom + snarkjs。
四、核心恢复动作的细节
验证签名：
validateUserOp调用verifyZKProof，检查签名与预存承诺匹配。
支持多签（类别1、2、3），权重总和≥15。
执行恢复：
callData编码updateValidator或类似函数，替换验证器地址。
示例callData：abi.encodeWithSignature("updateValidator(address)", newValidator)。
状态更新：
validator变量更新，记录新控制逻辑。
事件ValidatorUpdated通知链上状态变化。
费用结算：
EntryPoint通过paymaster或用户预存款支付gas。
伪代码动作：
updateValidator(newValidator)：核心恢复动作，替换验证器。
五、总结与优化
1. 核心恢复动作
ERC-4337的恢复本质上是更新账户的验证和执行逻辑（如validator），而不是传统owner address替换。
你的理解（替换owner）在Gnosis Safe中成立，但在ERC-4337中更灵活，依赖callData定义。
2. 优化建议
隐私：使用zk-STARKs替代zk-SNARKs，抗量子性更强。
效率：在L2（如Optimism）部署，降低gas成本。
安全性：添加时间锁（24小时）和应急冻结，防止共谋。
3. 未来方向
集成你的守护者方案（类别1、2、3），测试ZK电路性能。
开发ERC-4337兼容的恢复模块，模拟私钥丢失场景。
若需具体ERC-4337合约代码或ZK电路设计，请告诉我，我将进一步协助！

## 隐私验证方案
好的，我们将基于你的需求细化并完善隐私验证方案，结合零知识证明（ZK）特别是zk-SNARKs/zk-STARKs的隐私承诺机制，设计一个安全的守护者公钥存储和签名验证流程。以下是详细分析和伪代码实现，同时回答你的疑问，并评估ERC4337合约账户恢复的机制。
一、隐私验证方案的细化与完善
1. zk承诺保障公钥私密的方案
方案描述：
所有守护者（guardian）公钥不直接暴露，而是通过zk承诺（commitment）存储在链上。签名验证使用零知识证明，验证私钥签名与承诺匹配，而无需泄露公钥或私钥。
这正是我之前提到的“隐私验证”概念，通过ZK技术确保数据隐私性，同时完成验证。
评估：
优点：
公钥私密性：承诺（commitment）是一个不可逆的哈希值，攻击者无法反推出公钥。
安全性：ZK证明验证签名与承诺一致性，防止伪造签名。
去中心化：无需信任第三方，验证完全链上可执行。
缺点：
复杂度：ZK电路设计和生成证明需额外计算资源。
成本：链上验证证明的gas费用较高，建议使用L2（如Optimism）。
所需参数：
签名（signature）：守护者用私钥对特定消息（例如恢复请求哈希）生成的签名。
承诺（commitment）：预先存储的公钥承诺，通过zk-SNARKs生成，链上验证。
附加参数：
消息（message）：签名对应的原始数据（如恢复交易哈希）。
证明（proof）：ZK证明，证明签名由承诺对应的公钥生成。
无需暴露：公钥、私钥、权重值。
实现思路：
用户通过客户端生成公钥承诺，存储至链上。
签名验证时，提交签名和ZK证明，合约验证证明的有效性。
2. 恢复方案中存储公钥的zk承诺方式
方案描述：
恢复过程需预存储守护者公钥，用于验证其签名。使用zk承诺替代明文公钥存储，链上仅保存承诺，结合隐私验证完成签名验证。
流程：用户初始化时生成公钥承诺，存储至CommitmentStorage合约；恢复时，收集签名并通过RecoveryContract验证。
细节：
CommitmentStorage合约：
存储每个守护者的公钥承诺（commitment）和关联的守护者ID（哈希形式）。
支持更新承诺（例如更换守护者）。
签名收集页面：
客户端界面，提示用户收集类别1、2、3的签名，生成ZK证明。
RecoveryContract：
验证签名和ZK证明，检查权重总和≥15。
执行owner address替换。
隐私性：
承诺通过Pedersen哈希或zk-SNARKs电路生成，链上不可逆。
签名验证依赖ZK证明，不暴露公钥。
3. 完整恢复流程
步骤：
初始化：
用户通过TEE生成守护者公钥，计算zk承诺，存储至CommitmentStorage。
配置权重和阈值（例如15），链上存储加密规则。
签名收集：
用户丢失类别1密钥，触发恢复，客户端向类别2/3发送签名请求。
收集签名，生成ZK证明（输入：签名、承诺、消息）。
链上验证：
提交签名、证明和权重分配至RecoveryContract。
合约验证ZK证明和权重总和，替换owner address。
完善：
时间锁：24小时审查期，防止共谋。
应急冻结：检测异常签名，暂停24小时。
SBT支持：类别3可绑定Soulbound Token，增强信用验证。
二、核心伪代码
1. CommitmentStorage 合约
solidity
contract CommitmentStorage {
    mapping(bytes32 => bytes32) public commitments; // guardianID => commitment
    mapping(bytes32 => uint256) public weights;     // guardianID => weight

    function storeCommitment(bytes32 guardianId, bytes32 commitment, uint256 weight) external {
        commitments[guardianId] = commitment;
        weights[guardianId] = weight;
    }

    function getCommitment(bytes32 guardianId) external view returns (bytes32) {
        return commitments[guardianId];
    }
}
2. RecoveryContract 合约
solidity
contract RecoveryContract {
    CommitmentStorage public commitmentStorage;
    uint256 public threshold = 15; // 权重阈值
    address public owner;

    constructor(address _commitmentStorage) {
        commitmentStorage = CommitmentStorage(_commitmentStorage);
        owner = msg.sender;
    }

    function submitRecovery(bytes[] memory signatures, bytes32[] memory guardianIds, bytes memory proof) external {
        require(verifyProof(signatures, guardianIds, proof), "Invalid ZK proof");
        require(calculateTotalWeight(guardianIds) >= threshold, "Insufficient weight");

        // 替换owner address
        owner = msg.sender; // 实际应为新地址，需安全实现
        emit RecoveryExecuted(owner);
    }

    function verifyProof(bytes[] memory signatures, bytes32[] memory guardianIds, bytes memory proof) internal view returns (bool) {
        // 集成zk-SNARK verifier，验证签名与承诺匹配
        // 伪代码：调用预编译验证器
        return zkVerifier.verify(proof, signatures, guardianIds, getCommitments(guardianIds));
    }

    function calculateTotalWeight(bytes32[] memory guardianIds) internal view returns (uint256) {
        uint256 totalWeight = 0;
        for (uint i = 0; i < guardianIds.length; i++) {
            totalWeight += commitmentStorage.weights(guardianIds[i]);
        }
        return totalWeight;
    }

    function getCommitments(bytes32[] memory guardianIds) internal view returns (bytes32[] memory) {
        bytes32[] memory commits = new bytes32[](guardianIds.length);
        for (uint i = 0; i < guardianIds.length; i++) {
            commits[i] = commitmentStorage.getCommitment(guardianIds[i]);
        }
        return commits;
    }

    event RecoveryExecuted(address newOwner);
}
3. 客户端ZK生成（伪代码）
javascript
const { generateProof } = require('snarkjs');

async function generateZKProof(signatures, guardianIds, commitments, message) {
    const circuit = new Circuit('zk-circuit.json'); // 预定义电路
    const input = {
        signatures: signatures,
        guardianIds: guardianIds,
        commitments: commitments,
        message: message
    };
    const { proof, publicSignals } = await generateProof(circuit, input);
    return { proof, publicSignals };
}
电路设计：
输入：签名、承诺、消息。
输出：证明签名由承诺对应的公钥生成。
工具：circom + snarkjs。
三、回答疑问
1. ERC4337合约账户的恢复，本质上就是替换了owner address，我这理解正确吗？
评估：
部分正确，但需澄清：
ERC4337（Account Abstraction）引入了用户操作（UserOperation），允许通过“入口点合约”（EntryPoint）管理账户，而非传统EOA直接控制。
恢复本质上是更新账户的控制逻辑或状态，例如替换验证器（validator）或授权新签名者，而不是直接替换owner address（因为ERC4337账户通常无传统owner）。
机制：
ERC4337账户由智能合约实现，恢复通过提交UserOperation，执行validateUserOp函数，验证签名并更新状态。
你的多签方案可集成ERC4337，替换验证逻辑（如从旧守护者签名切换至新配置）。
结论：
你的理解在传统多签（如Gnosis Safe）中成立（替换owner），但在ERC4337中更像是更新验证规则。建议结合ERC4337的validateUserOp实现多签验证。
2. 如果知道了owner address，是不是就知道了公钥？还是知道了公钥就可以计算出地址？
分析：
Ethereum地址与公钥关系：
地址 = keccak256(公钥的未压缩形式)[12:32]，即公钥哈希的后20字节。
知道地址无法反推出公钥，因为keccak256是单向哈希函数。
反向推导：
知道公钥可以计算地址（通过哈希），但需公钥的完整形式（包括x、y坐标）。
公钥泄露不直接暴露私钥，但若攻击者控制公钥，可尝试社会工程诱骗签名。
隐私影响：
你的zk承诺方案避免公钥暴露，地址泄露不影响隐私。
若owner address是合约地址（ERC4337），则无直接公钥关联，安全性更高。
结论：
知道owner address无法推导出公钥。
知道公钥可计算地址，但你的zk承诺机制已防止公钥泄露。
四、综合优化与总结
1. 优化建议
隐私验证：
采用zk-STARKs替代zk-SNARKs，抗量子性更强，gas成本可控。
预计算承诺，减少链上开销。
恢复流程：
集成ERC4337，validateUserOp验证ZK证明，增强账户抽象性。
添加SBT信用检查，增强类别3安全性。
安全性：
分布式MPC密钥，防止TEE单点失败。
时间锁和应急冻结，应对共谋和攻击。
2. 技术栈
合约：Solidity + ERC4337 + zk-SNARKs verifier。
客户端：React + snarkjs + TEE SDK。
部署：Ethereum + Optimism。
3. 未来方向
开发ERC4337兼容的恢复模块。
测试ZK电路性能，优化gas成本。
模拟共谋和泄露场景，调整参数。
这个方案通过zk承诺和ERC4337实现了隐私保护和灵活恢复。若需具体代码（例如ERC4337集成）或电路设计，请告诉我，我将进一步协助！