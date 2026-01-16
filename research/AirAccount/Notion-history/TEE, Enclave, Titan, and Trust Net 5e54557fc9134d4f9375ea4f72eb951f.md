# TEE, Enclave, Titan, and Trust Net

## 背景

AAStar社区节点未来的演进方向是Trust Net，具备多样性、自组织、可伸缩、去中心的可信网络，为社区成员提供服务。其中核心之一，是安全，也是构建所有上层应用的基础。

而TEE，隐私计算，ZKP以及eBPF，是构建这些可信计算环境，安全可靠的底层设施，我这里汇总零碎的研究和分析，包括相关资料，为我们规划和构建础Trust Net，以及核心安全特性例如D2FA提供基础。

安全假设：

我们信任芯片级别的TEE，不会存储和上传你的生物特征或者其他唯一性凭证。

这个是可验证的，但是面对技术资料和安全说明书，大部分人没能力验证。

我们信任TEE OS，不会泄露、存储和上传你的生物特征或者其他唯一性凭证和其他隐私数据。

这个也是可验证的，从架构和逻辑角度来讲，懂一些技术的人能够初步验证安全性保障。

我们相信，我们依赖的安全算法，公私钥，在签名后不会被强力算法例如量子计算很快破解。

目前这个风险的应对方案还在形成过程中

KMS??

## 概念解释

TEE

TEE指的是可信执行环境（Trusted Execution Environment），是一种计算机安全技术，用于保护应用程序和数据免受恶意软件和攻击的影响。TEE技术使用硬件隔离和加密技术，将应用程序和敏感数据隔离在一个安全的执行环境中，防止未经授权的访问和修改。它通常通过安全处理器或者特殊的硬件模块来实现，可以在智能手机、物联网设备、云服务器等各种计算平台上使用。TEE技术对于保护用户隐私、安全支付、数字版权保护等方面都有重要作用。

隐私计算

隐私计算是一种保护数据隐私的计算方法，旨在在不暴露原始数据的情况下对数据进行共享和分析。隐私计算的核心思想是将数据转换成加密或者匿名的形式，然后在这种形式下进行计算分析，最终得到结果而不泄露原始数据。常见的隐私计算技术包括同态加密、安全多方计算和安全数据聚合等。隐私计算可以应用在各种场景下，如医疗健康数据分析、金融风控、个性化推荐系统等，保护数据隐私的同时实现数据共享和价值提升。隐私计算有助于解决数据共享难题，促进数据驱动决策和创新发展。

ZKP

零知识证明（Zero-Knowledge Proof，ZKP）是一种密码学技术，允许一个参与者向另一个参与者证明某个断言是正确的，而不需要透露关于证明的任何其他信息。在零知识证明中，证明者可以向验证者证明某个事实的正确性，但不会透露任何关于事实背后的细节信息。这种技术可以用于验证某些个人信息，而不将详细信息公开，从而实现更高水平的隐私保护。

零知识证明在许多领域都有广泛应用，如密码学、区块链、隐私计算等。在区块链领域，零知识证明可以帮助用户证明他们具有某些特定的资产或权限，而无需透露具体的资产或权限详情。在隐私计算中，零知识证明可以帮助确保数据隐私，同时验证数据分析的准确性。零知识证明技术为提高数据隐私和安全性提供了一种重要的工具。

eBPF

eBPF（extended Berkeley Packet Filter）是一种基于内核的虚拟机技术，最初由Alexei Starovoitov在Linux内核中开发。eBPF允许用户在不需要重新编译内核并加载新模块的情况下，将自定义的代码注入到内核中进行运行。它可以用于实现网络过滤、性能监控、安全检查等功能，同时保持内核的稳定性和安全性。

eBPF的优点包括高效性、可移植性和灵活性。它可以在内核空间内运行高性能、安全的代码，同时允许用户动态地改变内核行为而无需重新编译内核。eBPF还可以与运维工具、性能分析工具等结合使用，为系统监控和调试提供更加灵活和强大的手段。

总之，eBPF是一种强大的技术，为Linux系统提供了更加灵活和高效的扩展方式，使得用户可以定制化地实现各种功能而无需修改内核源代码。

Trust Net / eBPF-S

一个设想，基于eBPF，和Smart Contract联合构建链上交互的一个安全监控的可信执行环境，EOF（EVM Object File）是EVM新特性，结合代理合约特性，可以链上接受WebAssembly代码，而代码亦可在链上，确保其被审计后的安全性。

这样任何基于该Linux+eBPF的链上合约扩展，变成了系统内核，具备了加密级别的安全性，任何运行这样系统的节点，称之为Trust Net Community Node。

基于此，可以构建无数安全特性，例如基于链上table的安全过滤，账户日限额、父子账户；相关节点的防共谋验证，类似于AOP（切片编程）模式，在系统级别，增加了可控的安全层， 包括D2FA，都会基于本环境运行，有更高的安全性。

从某个角度看，eBPF-S构建的Trust Net，是和区块链共用加密安全特征的另外一层应用构建网络，这也是我想象中的Layer3基础，而不是纯粹的区块链Scale up，Scale out思路。

关键，基于私钥存储在Trust Net + D2FA + Public Guardian，构建了普通人账户的全面安全性，对于以太坊来说，是一个很好的安全账户扩展。

## 逻辑概述

一个网络级别的可信执行环境（TEE），则它不可作恶，不会被篡改，执行你的指令并进行验证，保护你的隐私，存储在这样网络环境的数据，隐私，是可信和安全的。这样的网络，我们成为Trust Net。

## 相关分析

### TEE

系统讲解：

[可信执行环境 (TEE) 的定义及实现形态](https://www.secrss.com/articles/13922)

TEE操作系统通常由具有较高特权的内核和具有较低特权的多个应用程序（称为可信应用程序，TA，Trusted Applications）组成。各个TA之间相互隔离，与TEE内核也是分离的。这样一来，如果有应用程序被攻破，它就无法对其他应用程序或TEE内核造成威胁。简而言之，一个强大的TEE机制能够实现以下三种隔离：1、TEE与REE之间的隔离；2、TA和TEE内核之间的隔离；3、各个TA之间的隔离。为了满足这些安全需求，TEE需要硬件原语的支持，以确保强制性隔离。硬件和软件之间的协同非常重要，而且需要持续地配合。TEE只允许经过适当授权并由其他授权代码检查过的代码来执行。因此，在TEE环境下，我们需要一个安全启动功能来检查所有操作系统组件（包括启动加载程序、内核、文件系统、可信应用程序等）的完整性和真实性。这样就能够确保在设备关机时没有人篡改操作系统的代码。

### 1.  ARM TrustZone

Arm的TrustZone技术提供了一种高效的、系统范围的安全方法，它将硬件强制隔离内置于CPU中。 多区域安全是Hex-Five安全创建的第一个RISC-V可信执行环境。

在现代计算机中，CPU通过内存映射的方式为每个进程创建单独的地址空间，以隔离多个进程的代码和数据。通过不同的特权级别来区分操作系统和用户进程的代码和数据。但是由于内存中的代码和数据都是明文，容易被其他应用程序窥探，所以出现了扩展的安全模块。应用程序会将加密数据发送到安全模块进行处理，然后再将结果返回给相应的应用程序。

TrustZone是ARM针对消费电子设备设计的一种硬件架构，旨在为消费电子产品构建一个安全框架，以抵御各种潜在的攻击。

TrustZone在概念上将SoC的硬件和软件资源划分为安全世界和非安全世界两个部分。

所有需要保密的操作都在安全世界中进行（如指纹识别、密码处理、数据加密解密、安全认证等），而其他操作则在非安全世界中执行（如用户操作系统、各种应用程序等）。安全世界和非安全世界通过一个名为Monitor Mode的模式进行切换。

![Untitled](TEE,%20Enclave,%20Titan,%20and%20Trust%20Net%205e54557fc9134d4f9375ea4f72eb951f/Untitled.png)

在监视器模式下运行时，CPU是安全的，可以访问设备的所有外围设备和内存。 如果不在这种模式下运行，则CPU处于非安全状态，只能访问外设的子集和特定范围的物理内存。

在处理器架构上，TrustZone将每个物理核虚拟为两个核：一个是非安全核（NS核），运行非安全世界的代码；另一个是安全核，运行安全世界的代码。

这两个虚拟核会以基于时间片的方式运行，根据需要实时占用物理核，并通过监视器模式在安全世界和非安全世界之间进行切换。它类似于同一CPU下的多应用程序环境，不同之处在于操作系统在多应用程序环境下实现进程间切换，而TrustZone下的监视器模式实现了同一CPU上两个操作系统间的切换。

组件 要实现这样一套硬件架构，首先需要SoC中的各个硬件模块都支持TrustZone，才能构成一个完整的安全系统。

其中主要的组件包括：

必选组件

AMBA3 AXI总线，安全机制的基础设施 AMBA3 AXI（AMBA3 Advanced eXtensible Interface）系统总线作为TrustZone的基础架构设施，提供了安全世界和非安全世界的隔离机制，确保非安全核只能访问非安全世界的系统资源，而安全核可以访问所有资源。因此，安全世界的资源不会被非安全世界（或者通用世界）所访问到。

### 1.1 Intel SGX

Intel SGX（Intel Software Guard Extensions） 是Intel提供的TEE实现，由于过去十年Intel在市场上的主流位置，Intel SGX也自然而然地成为了最常用的TEE方案之一。在SGX中，用于执行代码的TEE环境被称为Enclave（飞地），在Enclave中的数据可以确保其机密性和完整性；而Intel也提供了一个用于验证某个结果是否由SGX所执行出来，以此确保恶意者伪装成SGX来窃取信息；最后SGX方案提供了更广阔的安全边界，内存数据，BIOS都无法读取。

Intel SGX 技术是一种新的基于硬件的可信计算技术。该技术通过CPU的安全扩展，对用户空间运行环境（enclave）提供机密性和完整性保护。即使是攻击者获得OS，hypervisor，BIOS 和SMM 等权限，也无法直接攻击enclave。因此，攻击者不得不通过侧信道的攻击方法来间接获取数据（比如隐私数据，加密密钥等等）。得益于enclave 的强安全假设和工作模型，攻击者有大量的侧信道攻击面可以选择，比如页表，cache，DRAM 等等。这个工作就是对侧信道攻击面进行一个全面的总结，并讨论一些可能的防御和检测方法。

### 1.2 AMD PSP/SEV

 AMD平台安全处理器（PSP）的正式名称是AMD安全技术，是一个集成在AMD微处理器中的可信执行环境子系统。 苹果使用了一种专用处理器SEP（Secure Enclave processor）来实现数据保护、触摸ID和人脸识别等功能。SEP负责处理密钥和其他信息，如生物特征识别，这些信息非常敏感，不会被应用处理器处理。 谷歌也有一个类似的解决方案称为Titan M，这是一些Android Pixel设备上可用的外部芯片，可以实现TEE和处理安全引导、锁屏保护、磁盘加密等功能。

SEV（AMD Secure Encrypted Virtualizationn），SME（AMD Secure Memory Encryption）和SEV-ES（Secure Encrypted Virtualization-Encrypted State）等技术实现虚拟机的 Guest 内存加密和安全隔离；

### 2.  iOS Secure Enclave

Secure Enclave是几乎每台Apple设备都随附的安全协处理器，可提供额外的安全保护。iPhone，iPad，Mac，Apple Watch和其他Apple设备上存储的所有数据都是使用随机私钥加密的，只能由Secure Enclave访问。这些密钥对于您的设备是唯一的，并且永远不会与iCloud同步。

Secure Enclave不仅仅加密文件，还负责存储管理敏感数据的密钥，例如密码，Apple Pay使用的信用卡，甚至是用于启用Touch ID和Face ID的生物识别信息。

尽管设备中内置了Secure Enclave芯片，但它与系统的其余部分完全分开工作。这样可以确保应用程序无法访问您的私钥，因为它们只能发送请求以解密特定数据（例如您的指纹）以通过Secure Enclave解锁应用程序。

即使您拥有可以完全访问系统内部文件的越狱设备，Secure Enclave所管理的所有内容也将受到保护。

iPhone 5S 的处理器是基于ARMv8架构的，被称为A7，而A7也可以说是为了高度安全建立的，为了成功运用这个技术，苹果需要这个处理器可以达到本地级别的加密和安全，需要处理器架构的设计支持一个专门的硬件区来隔离加密这些数据。

ARM 多年前就在关注相关问题，比如现在已知的TrustZone/SecurCore，TrustZone技术就整合进了A7，而且通过AMBA AXI总线和特别的TrustZone System IP 块扩展到整个系统。这种系统方式支持它保护内存；加密模块；保护键盘、屏幕和传感器,以确保它们能免受软件的攻击。

2012年苹果收购 AuthenTec，开始构建Enclave，**它解决了最关键的问题——如何安全存储生物数据，这些数据其实就是“证明你是你”的凭证，等于是私钥**。

苹果定制了一个高度优化的TrustZone版本，可以说A7的TrustZone安全系统是由硬件和软件分区来成就的。不管是硬件还是软件中，都 有两个区，一个是安全子系统，一个是正常的区。TrustZone AMBA3 AXI总线可确保正常区组件不访问安全区的数据。而那些敏感的数据就放在安全区，来防止许多可能的攻击。当有安全验证的需求时，Moniter模式就会自 主进行两个虚拟处理器的切换，有针对性地工作。

使用Touch ID也可以通过密码解锁，这使得它的安全性有了双重保障。所以使用Touch ID时，用户必须设定一个解锁密码作为在指纹识别器失效时的后备措施。在其它情况下，iOS也可能要求用户通过输入密码来解锁设备。

苹果其实为Touch ID的释放默默做了很多年的准备，这其中申请了许多专利、收购了一些关键技术、跟芯片商高度合作、集成TrustZone技术，都是我们能接触到Touch ID的前提

![Untitled](TEE,%20Enclave,%20Titan,%20and%20Trust%20Net%205e54557fc9134d4f9375ea4f72eb951f/Untitled%201.png)

### 2.1 Touch ID

Touch ID 传感器也就是你的 Home 键，实际上由三个主要部件组成：**激光切割的蓝宝石水晶片**、**不锈钢环**和**一枚电容传感器**。别看这些组件似乎很普通，实际上每部分都有它自己独特的功能。

而 500 ppi 的超高像素密度更能辨识出人眼根本察觉不到的丰富细节，使得仿造指纹变得极为困难。这枚先进的传感器不从你容易受损的表皮读取指纹，而是读取手指表皮下的导电层，进一步提升了识别的准确率和伪造指纹的难度。

**Secure Enclave**在收到传感器发来的指纹图像之后，便会与其中存储的指纹进行比对。如果指纹匹配，这块芯片便会用密钥来解锁你的数据，进而让你正常使用手机。

**如果你 48 小时都没有解锁过手机，或者指纹识别失败了五次以上，「Enclave」会立刻将解锁你数据的密钥抹掉并禁用 Touch ID ，只有输入锁屏密码才能解锁 iPhone** 。此外，iPhone 的重新启动和 Find My iPhone 的「丢失模式」也会促使 Touch ID 自动停用，即便有人真的做出了能骗过 Touch ID 的假指纹，iPhone 也能以此尽可能地降低个人隐私被泄露的风险。

以下是旧的技术信息，仅供参考:

常规TouchID 基于芯片硬件的安全解决方案，华为为例：指纹加密，存储，校验的程序是运行在海思芯片里物理隔离的安全OS中，安卓环境下的程序无法直接访问，即使手机被root后，这部分仍然不能被访问和篡改。

2，手机并不会保存指纹图像，只保存经过提取后的模板信息，通过指纹模板并不能还原出指纹图像。所有指纹模板信息只在手机本地用AES256算法加密，每个芯片都有独一无二的密钥，这个密钥在芯片出厂时就被一次性熔断写入，无法从外部读取和修改。指纹模板数据只能写入和删除，无法读取和修改，因此也不会上传任何服务器，也不会被任何第三方程序读取。

3，指纹安全程序对外提供经过签名的验证结果，整个过程通过RSA 2048签名保护，无法被仿冒和篡改。支付宝就是通过这个结果来判断是否要付款的。

---

根据白皮书的描述，苹果公司在A7芯片中划分了一块Secure Enclave（安全区域），用来管理、核对、和存储用户的[指纹信息](https://www.zhihu.com/search?q=%E6%8C%87%E7%BA%B9%E4%BF%A1%E6%81%AF&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A29895030%7D)。Secure Enclave是一个独立的系统，有自己的安全启动顺序和软件升级机制。用户按下Home键的时候，Touch ID会进行一次88x88像素，500 ppi的[光栅扫描](https://www.zhihu.com/search?q=%E5%85%89%E6%A0%85%E6%89%AB%E6%8F%8F&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A29895030%7D)，数据暂时存储在Secure Enclave的加密的内存里，等待[矢量化分析](https://www.zhihu.com/search?q=%E7%9F%A2%E9%87%8F%E5%8C%96%E5%88%86%E6%9E%90&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A29895030%7D)。Touch ID会从各种角度不断学习用户的指纹，在已有的[指纹图谱](https://www.zhihu.com/search?q=%E6%8C%87%E7%BA%B9%E5%9B%BE%E8%B0%B1&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A29895030%7D)上添加新的节点。陌生人如果想要用Touch ID解锁设备，大概只有五万分之一的成功几率。

设备完成指纹数据处理和分析以后，就会删除这些数据，不会发送到iCloud、iTunes或者苹果公司。就算设备内部的A7处理器也不能直接处理Touch ID数据。

由于指纹传感器和Secure Enclave内建一个共享的秘钥A，然后系统再由这个共享秘钥随机生成一个唯一的秘钥B，来加密保护Touch ID数据。如果使用中要调用指纹数据，整个过程都会有AES秘钥随机加密保护。同样也由于传感器本身与Secure Enclave共享唯一密钥A使得每一台设备上的[指纹传感器](https://www.zhihu.com/search?q=%E6%8C%87%E7%BA%B9%E4%BC%A0%E6%84%9F%E5%99%A8&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A29895030%7D)与手机主板上的A7处理器绑定！

**由此可见，Secure Enclave（安全区域）即为保障iPhone5s指纹安全核心所在！那么Secure Enclave是什么呢？苹果当年为了满足iPhone5s Touch ID 的硬件需求，选择了具有原生的安全性能并且有专门的区域供隔离和加密基于ARMv8架构的A7芯片。并以ARM TrustZone/SecurCore （信任区域/安全核心）技术为基础高度优化，做出了Secure Enclave！基于TrustZone技术的 A7 芯片精密结合并通过AMBA AXI 总线和特定的 TrustZone System IP 块贯穿系统层面。这种布局意味着保护外围设备不受软件攻击成为了可能。不过安全白皮书中未对“Secure Enclave”未做过多解释，我们无法进一步去了解。**

---

1.华为和apple都是基于ARM的trustezone技术，说白了就是TEE技术，硬件安全解决方案应该说目前最优的，如果说因为海思自己实现的和apple自己实现的有什么优劣我不敢说，这部分开起来平分秋色。

2.用了RSA算法和AES算法应该这部分目前强于apple，算领先；但是实际上RSA应该会是国家政策上的一个可能问题点，从国家安全的角度来讲一个中国制造上的国内产品不考虑国家限制是不可能的，只不过现在确实国产不成熟也没有强制要求。

---

TPM，TrustedPlatformModule，PC的安全模块，可信赖平台模块相关：

是一种专门的硬件或者说基于固件的安全解决方案，它在诞生之初就肩负着存储并保护敏感信息的任务，即使整个系统都被黑客攻破也能保护敏感信息全身而退。

有鉴于此类威胁与形容密码攻击的Coppersmith’sattack有关，使得研究人员将它称之为TheReturnofCoppersmith’sAttack（ROCA）。计算私钥需要运算资源，CRoCS估计，若要破解512位长度的RSA密钥只需花费CPU两小时，成本只要0.6美元，而破解1024位则需要97天，成本介于40到80美元之间，破解2048位的RSA密钥则需140.8年的CPU，成本最高，需要花费2万至4万美元。CRoCS以AWS执行攻击为例，显示计算出1024位RSA私钥的价格为76美元，算出2048位私钥则需4万美元

TEE（Trusted Execution Environment，可信执行环境）是一种硬件支持的安全环境，通过独立的处理器或专用的安全模块实现。TEE可以保护关键数据和应用程序免受恶意软件或攻击者的入侵，确保数据在处理和存储过程中的完整性和保密性。TEE可以在设备的操作系统之上运行，提供额外的安全层。

TPM（Trusted Platform Module，可信平台模块）是一种安全芯片，通常集成在主板或独立硬件模块中。TPM通过提供加密、认证和密钥管理等功能，可以实现硬件级别的安全保护。TPM主要用于系统启动过程中的认证和加密，以确保系统的启动过程不受篡改。

总的来说，TEE主要用于应用程序和数据的保护，而TPM主要用于系统的启动和认证，两者在功能和实现方式上有所不同。如果需要同时保护硬件和软件，可以同时使用TEE和TPM来提高整个系统的安全性。

### 3. Google(Android) Titan

曾在Pixel 2系列身上内置了名为Visual Core的独立芯片，不过最初谷歌并未激活它，用户最初只能通过开发者选项启用该芯片的功能。一代之后，该公司宣布 Pixel 3 设备将包括一个名为 Titan M 的硬件安全模块。然后，在 2021 年，谷歌紧随其后推出了 Titan M2。

Titan M2 是Pixel 6和 Pixel 7 系列智能手机中包含的专用安全芯片。谷歌内部设计了 Titan M2，因此它可以完全控制其功能集。该芯片基于 RISC-V CPU 架构，包含自己的内存、RAM 和密码加速器。
Titan M2 是谷歌多年来为提高智能手机安全性而采用的众多措施之一。谷歌花了三年时间对Titan M2进行了第三方实验室SGS Brightsight的测试。该芯片现在拥有一系列通用标准(Common Criteria)硬件安全认证，与智能卡、SIM卡和银行卡芯片的安全认证过程相同。Titan M2通过了最高级别的硬件漏洞评估，这意味着它具有很强的抵御物理攻击的能力。
以 Android 的强制性全盘加密为例。在大多数设备上，它依赖于称为可信执行环境 (TEE) 的安全功能，它本质上是处理器的安全区域。Android 设备将其加密密钥存储在这个安全区域中，而该区域又受到您的图案、PIN 或密码的保护。换句话说，TEE 隔离了加密密钥，从不向用户甚至操作系统泄露它们。

至于安全芯片究竟有什么作用，我们先从启动安卓操作系统说起。当您打开 Pixel 设备时，Titan M2 会与引导加载程序通信，以验证您运行的是最新的已知 Android 版本。此检查可确保攻击者未将您设备的操作系统回滚到可能不安全的旧版本。谷歌还表示，该芯片可以防止恶意尝试解锁引导加载程序。
启动后，手机的存储将保持加密状态且无法访问，直到您清除锁定屏幕提示。Titan M2 在这里起着关键作用，因为它存储了解密密钥。即使攻击者篡改操作系统以尝试暴力破解锁定屏幕，该芯片也会在硬件级别限制尝试次数。如果您输入正确的图案或 PIN，Titan M2 只会显示解密密钥。
但是，如果攻击者试图直接篡改 Titan M2 怎么办？谷歌也想到了这一点。没有设备的模式或 PIN，您无法更改或更新芯片的固件。该公司还表示，它强化了芯片以抵御功率分析和电压波动等侧信道攻击。
Titan M2 还支持 Android StrongBox，它是第三方应用程序使用的加密密钥的安全存储空间。例如，支付应用程序可以请求芯片为您保存的卡生成并存储私钥。并且通过Android的Protected Confirmation，该芯片还支持通用的FIDO认证标准。这意味着您可以将 Pixel 手机用作在线帐户的物理双因素身份验证密钥。
谷歌还表示，它不会记录用户浏览数据，不过该公司表示，它会记录一些匿名的汇总指标。

### 4. Virtual TEE/Enclave

AliCloud(Ant): 虚拟化Enclave,建一个可信的隔离空间，从而保护您的应用程序和数据的安全，阿里云虚拟化Enclave在ECS实例内部提供一个可信的隔离空间，将**合法软件的安全操作**封装在一个Enclave中，保障您的代码和数据的机密性与完整性，不受恶意软件的攻击。

### 5. Trust Net

类似于上面的Virtual TEE，但加持了区块链和智能合约的不可篡改代码和可信列表、用户约束行为，这些都来自于区块链，再使用eBPF来进行动态加载，保障节点所有的行为，都是来自于安全操作。

### 5.1 Occlum

蚂蚁集团开源的TEE OS，这个5-29还在提交代码，证明是很活跃的

除了提供类容器的、用户友好的接口以外，Occlum 还有三个主要特色：

- **高效多进程支持**：Occlum 实现了一种轻量级的进程，相比此前最先进的开源 TEE OS（Graphene-SGX），进程启动提速 10-1000 倍，进程间通信的吞吐量提升 3 倍（详见我们的论文，链接见文末）；
- **强大文件系统**：Occlum 支持多种文件系统，比如保护完整性的文件系统、保护机密性的文件系统、内存文件系统、主机文件系统等等，满足应用的各种文件 I/O 需求；
- **内存安全保障**：作为全球首个使用 [Rust 语言](https://link.segmentfault.com/?enc=%2Bey1eTpvefVceXQtakEItg%3D%3D.kQftOWQgtiD341EDlJ9X29%2FDpigjKw%2BrpQIih1XukMU%3D)开发的 TEE OS，Occlum 极大降低了内存安全问题的几率（据统计，Linux 有 50% 的安全漏洞都与内存安全有关），因此更值得信赖；

20年的一个快速入门视频：[https://www.bilibili.com/video/BV1S5411a7gr](https://www.bilibili.com/video/BV1S5411a7gr/?spm_id_from=333.999.0.0&vd_source=0a978d5cb963890b0cab49f66fae30af)

和清华合作的论文：[https://dl.acm.org/doi/10.1145/3373376.3378469](https://dl.acm.org/doi/10.1145/3373376.3378469)

Occlum is a *memory-safe*, *multi-process* library OS (LibOS) for [Intel SGX](https://software.intel.com/en-us/sgx). As a LibOS, it enables *legacy* applications to run on SGX with *little or even no modifications* of source code, thus protecting the confidentiality and integrity of user workloads transparently.

Occlum has the following salient features:

- **Efficient multitasking.** Occlum offers *light-weight* LibOS processes: they are light-weight in the sense that all LibOS processes share the same SGX enclave. Compared to the heavy-weight, per-enclave LibOS processes, Occlum's light-weight LibOS processes is up to *1,000X faster* on startup and *3X faster* on IPC. In addition, Occlum offers an optional [**PKU**](https://github.com/occlum/occlum/blob/master/docs/pku_manual.md) (Protection Keys for Userspace) feature to enhance fault isolation between Occlum's LibOS and userspace processes if needed.
- **Multiple file system support.** Occlum supports various types of file systems, e.g., *read-only hashed FS* (for integrity protection), *writable encrypted FS* (for confidentiality protection), *untrusted host FS* (for convenient data exchange between the LibOS and the host OS).
- **Memory safety.** Occlum is the *first* SGX LibOS written in a memory-safe programming language ([Rust](https://www.rust-lang.org/)). Thus, Occlum is much less likely to contain low-level, memory-safety bugs and is more trustworthy to host security-critical applications.
- **Ease-of-use.** Occlum provides user-friendly build and command-line tools. Running applications on Occlum inside SGX enclaves can be as simple as only typing several shell commands (see the next section).

Since version 0.30.0, Occlum has introduced EDMM as an optional feature. With EDMM, Occlum configurations become more flexible, and enclave loading time is significantly reduced. More details please refer to [edmm_config_guide](https://github.com/occlum/occlum/blob/master/docs/edmm/edmm_config_guide.md).

[https://github.com/occlum/occlum](https://github.com/occlum/occlum)

[https://space.bilibili.com/228717294/search/video?keyword=tee](https://space.bilibili.com/228717294/search/video?keyword=tee)

### 5.2 Teaclave(百度)/Mesa TEE

好像github不太活跃，待验证

### 6 一些方案和逻辑思考

机密计算（隐私计算太扎眼？改名机密计算？），本质上是中心化数据平台，迫于社会压力和政府的一些考虑，例如GDPR，个人数据保护法规等等，在技术上给出的解决方案，而无论是传统的原来计算方式，还是机密计算，都是为了从个人数据中“挖矿”，简单说，数据带来了价值，这个价值可以运用在各个层面，例如发现年轻人的关注特征、获得规律，然后构造年轻人喜欢的内容，并推送给你；发现你购物的选择倾向，不断推给你相关的item，包括Google广告、小红书推荐、TikTok的推送等等，本质是尝试了解你之后，引导你；而所有的计算目标，是让你听从你内心（哈哈，你以为的内心），引导你进入平台的逻辑流程，进而影响你的选择，例如点击、查看、再点击、购物、借贷、参与活动、积分粘性粘住你长期关注，从而提升ARPU，获得稳定的收入，这就是平台掌握数据的核心逻辑。

而这里面其实缺少或者有一个假设，我们不自知，我们不知道，以为这些机密计算是听从了我们的内心，实际不是，是心理学、社会学、交叉数据验证和商业目标的多层叠加，这种影响不一定是负面的，例如你搜了饮水机，百度广告会出现在你浏览页面的旁边，各种饮水机广告出现，过滤器，滤芯等等，更聪明的计算会猜测你的场景，出现办公室桌椅、绿植，或者家庭装修的窗帘、衣架等等，这就是计算。

而隐私，是因为迫于影响力进行的，所谓的安全，是迫于无奈。

当然，数据的中心化，是目前无法解决的问题，政府、银行或者互联网平台，都竭尽全力攫取数据，存储和计算，从而挖出商业的金子。

**有一个解决思路是无论你如何计算，我不相信你的计算结果，因为你的动机不纯，而是相信自己科学和理性的选择，当然，可以追求时尚，但不要被机密计算篡夺了你的选择权**。

TEE某种程度上解决了这些数据攫取者和垄断者之间的信任和合作的机制问题，比如两个企业都有用户隐私数据，互不信任，如何协作，拼图完整一些用户的画像和模型，从而两家互补的公司都从中受益？这就需要TEE了，**它解决了数据协作过程的信任问题**。

eBPF-S或者叫TrustNet，目标是**引入TEE到区块链**，帮助去中心化更好的保护隐私又互相协作，提升区块链账户的UX同时，不损失安全特性。

度量证明是核心，例如基于代码完整性、代码不变、可审计日志、安全原语 

## 资料

阿里云：https://help.aliyun.com/zh/ecs/user-guide/build-a-confidential-computing-environment-by-using-enclave

1. 
2. 非营利组织Global Platform开发了TEE API和框架规范，以标准化TEE并避免碎片化。
3. TEE客户端、Core等有各种可用规范，规定了受信任的应用程序和安全世界操作系统之间的交互、与另一个受信任应用程序的受信任应用软件、与受信任应用应用程序的客户端应用软件等。
4. **这使最终用户无需更改其受信任的程序即可切换安全操作系统。**
5. 在选择您的安全世界操作系统时，既有商业/专有选项，也有开源选项。
6. 操作系统的选择取决于所需的功能和所需的支持级别，**但谨慎的做法是选择符合全球平台TEE规范的操作系统。**,[https://zhuanlan.zhihu.com/p/651478843](https://zhuanlan.zhihu.com/p/651478843)

中心化钱包钱包一般供给交易所使用，将完整的私钥加密之后管理在中心化的环境中，常见的管理方式有 TEE, KMS 和 CloadHSM。

去中心化钱包私钥加密之后存储在用户设备中，一般钱包私钥丢失无法找回。社交恢复钱包分为两种，密钥分片备份和守护者恢复，密钥分片技术是将用户的私钥使用门限共享秘密算法将私钥分成 N 片加密之后分发给不同的朋友存储到设备中，一旦密钥丢失，通过社交加验证的方式从朋友哪里获取 M 个密钥分片，使用 N-M(密钥拆分成 N 分，拿大其中 M 份可以恢复出完整的密钥) 逆门限共享秘密算法恢复出完整的私钥。守护者社交恢复主要是针对 EVM 系列的社交恢复钱包，由一个合约来管理整个钱包，一旦密钥丢失，发起社交恢复，由多个守护者签名一笔交易进行钱包合约的私钥替换，完成恢复的过程。

硬件钱包主要是把私钥管理在离线的硬件设备中，在硬件设备中集成钱包签名算法。

托管钱包有两种，团队资金共管钱包，一般使用多签钱包；EVM 链比较成熟的方案是 gnosis 多签，其他链还是使用多签算法实现；企业资管一般使用 MPC 钱包，MPC 是资管解决方案里面用得最多的密码学算法，运行 N 个 MPC 节点，节点之间通过多轮交互之后生成密钥片，节点与节点之间互相不知道对方生成的密钥片是什么，当需要发交易时，只需要其中 M 个节点签名交易就有效。

wasm+ebpf: https://github.com/eunomia-bpf/wasm-bpf

阿里云的Attestation，认证的过程，可以通过它来确保运行在Enclave中的镜像、操作系统和应用程序代码没有被修改或篡改。可以在自己的Enclave应用代码内调用SDK提供的API接口生成证明材料，并将证明材料上传至远程证明服务进行验证，远程证明服务会将验证结果返回给调用者。以上可以改造为和合约交互验证。

[https://blog.csdn.net/Refrain_mh/article/details/128283967](https://blog.csdn.net/Refrain_mh/article/details/128283967)

PRD29-GENC-009492C_trustzone_security_whitepaper.pdf [https://www.jianshu.com/p/3f952f2c8bf4](https://www.jianshu.com/p/3f952f2c8bf4) [https://zhuanlan.zhihu.com/p/504531528](https://zhuanlan.zhihu.com/p/504531528) [https://zuopeng.blog.csdn.net/article/details/115608087](https://zuopeng.blog.csdn.net/article/details/115608087) [https://blog.csdn.net/Thanksgining/article/details/111248666](https://blog.csdn.net/Thanksgining/article/details/111248666)

TEE，occlum普及：[https://blog.kelu.org/tech/2022/03/20/confidential-computing.html](https://blog.kelu.org/tech/2022/03/20/confidential-computing.html)

[https://www.freebuf.com/](https://www.freebuf.com/) , [https://www.freebuf.com/news/others/864.html](https://www.freebuf.com/news/others/864.html)

[https://cse.sustech.edu.cn/faculty/~zhangfw/paper/tee-crad24.pdf](https://cse.sustech.edu.cn/faculty/~zhangfw/paper/tee-crad24.pdf)

[https://www.inforsec.org/wp/?p=2298](https://www.inforsec.org/wp/?p=2298)

[https://space.bilibili.com/228717294/search/video?keyword=tee](https://space.bilibili.com/228717294/search/video?keyword=tee)

SGX介绍：[https://link.springer.com/article/10.1007/s11704-019-9096-y](https://link.springer.com/article/10.1007/s11704-019-9096-y)

协处理器：[https://zh.wikipedia.org/wiki/安全加密協處理器](https://zh.wikipedia.org/wiki/%E5%AE%89%E5%85%A8%E5%8A%A0%E5%AF%86%E5%8D%94%E8%99%95%E7%90%86%E5%99%A8)

下面的传送门提供了更多资料：

- Occlum 官方网站：[https://occlum.io](https://link.segmentfault.com/?enc=PlBRiWhHW1oQZi2TMGgjFg%3D%3D.rYlDJg1AXtOakGwFM1XQrN%2BLDSIAOK9Mvx4spJ8XPfs%3D)
- Occlum 项目地址：[https://github.com/occlum/occlum](https://link.segmentfault.com/?enc=Lnnx3TPMtcMn%2Bl1GMvFFLQ%3D%3D.vH4WjK2rfFg%2B6%2BXw%2BBCALffHFelVn91Bt708R2swyG7JqALdOk%2BbwIFU7o1UgqRU)
- Occlum 学术论文：[https://arxiv.org/abs/2001.07450](https://link.segmentfault.com/?enc=kk%2FQqFqRN0J8iaRs972tVw%3D%3D.wg1D7yOmJTJYWaRriop8w6Zs8T%2BuSDPl7FrZuD9czbW%2FzTzzHcgeE9xId%2FQQuakh)
- SOFAChannel 直播回顾视频：https://www.bilibili.com/video/BV1S5411a7gr

> 以下原文：当 Kubernetes 遇到机密计算，阿里巴巴如何保护容器内数据的安全？
> 

8 月 26 日，我们发起了第 6 期 SIG Cloud-Provider-Alibaba 网研会直播。本次直播主要介绍了机密计算的概况， InclavareContainers 开源项目架构、已支持的功能和迭代计划，以及阿里云 ACK-TEE 的发展现状和规划。

本文汇集了此次直播完整视频回顾及资料下载，并整理了直播过程中收集的问题和解答，希望能够对大家有所帮助~阿里巴巴云原生公众号后台回复“826”即可下载相关 PPT。

直播视频回顾链接：https://v.qq.com/x/page/z3143a6agsg.html

Keychain的工作原理  [https://www.bytezonex.com/archives/eFfINM7F.html](https://www.bytezonex.com/archives/eFfINM7F.html)

Keychain是一个安全存储数据库，它使用加密技术对存储的敏感信息进行保护。在iOS系统中，Keychain由Secure Enclave芯片管理，这是一种专为安全存储数据而设计的硬件模块。Secure Enclave芯片与iOS系统隔离，因此即使iOS系统被攻击，Secure Enclave芯片中的数据也不会受到影响。

Keychain中存储的信息包括：

- 网络密码：用户访问服务器或网站时使用的密码。
- 通用密码：用于保存应用程序或数据库密码。
- 认证证书：用于认证的证书，例如SSL证书。
- 密钥：用于加密或解密数据的密钥。
- 身份信息：用于标识用户身份的信息，例如Touch ID或Face ID数据。

## **如何使用Keychain**

在iOS应用程序中使用Keychain，需要导入Security框架。然后，可以使用以下步骤将数据存储到Keychain中：

1. 创建一个Keychain查询对象（SecItemRequest）。
2. 设置查询对象的属性，包括要存储的数据类型、要存储的数据以及要存储数据的Keychain。
3. 将查询对象添加到Keychain中。

当需要从Keychain中检索数据时，可以使用以下步骤：

1. 创建一个Keychain查询对象（SecItemRequest）。
2. 设置查询对象的属性，包括要检索的数据类型、要检索的数据以及要检索数据的Keychain。
3. 从Keychain中检索数据。

## **Keychain的安全性**

Keychain是一个非常安全的存储工具。它使用加密技术对存储的敏感信息进行保护，并且由Secure Enclave芯片管理。因此，即使iOS系统被攻击，Secure Enclave芯片中的数据也不会受到影响。

## **Keychain的优点**

- 安全：Keychain使用加密技术对存储的敏感信息进行保护，安全性很高。
- 方便：Keychain可以自动存储和检索数据，非常方便。
- 兼容性好：Keychain可以在iOS和macOS系统上使用，兼容性很好。

## **Keychain的缺点**

- 复杂性：Keychain的使用相对比较复杂，需要开发者具备一定的开发经验。
- 性能开销：Keychain的使用会带来一定的性能开销，因此不适合存储大量的数据。

## **总结**

Keychain是一个非常安全的存储工具，可以用来存储敏感信息，例如网络密码、通用密码、认证证书、密钥和身份信息等。Keychain的使用相对比较复杂，需要开发者具备一定的开发经验。但是，Keychain的安全性很高，非常适合存储敏感信息。

---

隐私计算和机密计算（Confidential Computing）都是数据安全领域的重要概念，它们之间有密切的关系，但又有一定的区别。

隐私计算是一种技术和方法，旨在保护数据在处理过程中的隐私和保密性。它通过在不暴露原始数据的情况下允许对数据进行计算和分析，从而保护个人或企业的隐私。隐私计算的目的是确保数据在使用过程中不会被泄露，同时允许对数据进行有效的利用。

机密计算则更加侧重于保护数据在计算过程中的机密性和保密性。它通过使用加密技术和安全计算协议，使计算过程中的数据对参与计算的各方都是不可见的，从而保护数据的隐私和安全性。机密计算的目的是确保数据在计算过程中不被泄露或篡改。

因此，隐私计算和机密计算都是为了保护数据的安全性和隐私性，在实际应用中也常常结合使用，以确保数据在处理和计算过程中的全面安全保护。

---

椭圆曲线密码学，什么？安全？

Secp256k1: Y **2 = X ***3 + 7

EIP7212: Secp256r1 

有限域：

a+b=c，封闭性

a+b=b+a

a+b+c=a+(b+c)

a+i=-a

椭圆曲线

A+B=C

群

点和椭圆曲线

Y**2=X***3+ax+b

a=0

b=7

P=2 ^256 -??

G(x,y) x很大，y很大

宇宙中的所有原子数量之和（小一些）10

seed 随机数

抗量子

TEE，Occlum（OpenTEE），