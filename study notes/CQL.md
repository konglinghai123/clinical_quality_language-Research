# HL7 Domain Analysis Model: Health Quality Improvement, Release 1 September 2014 US Realm Informative Specification文档        9/16/14

##  Introduction简介
目前在美国，电子化的医疗质量测度eCQM和临床决策支持CDS是采用不同的数据模型来表达的。eCQM用的是QDM(Quality Data Model质量数据模型)，CDS是使用vMR(Virtual Medical Record虚拟病历)。而二者之间又存在紧密的关联，eCQM度量医疗服务的质量，CDS为改进以来质量通过干预措施，二者存在共通的需求，即如何标识某种eCQM或CDS知识/规则所应用的患者。
举例说明，在CDS中常常会用到怀孕的概念，我们可以将其映射到eCQM目前所使用的vMR模型中，在vMR中 如果Problem中给类的problemCode使用了特殊的字典(2.16.840.1.113883.3.600.1622 怀孕)，我们就认为这个Pbolem类它表示的是怀孕的概念。如下所示：
```
<def name="Pregnancy">
    <expression xsi:type="ClinicalRequest" cardinality="Multiple"
        dataType="vmr:Problem" codeProperty="problemCode"   
       dateProperty="problemEffectiveTime.low"
         useValueSets="true" subjectProperty="evaluatedPersonId">
        <codes xsi:type="ValueSet" id="2.16.840.1.113883.3.600.1622"
            authority="Quality Insights of Pennsylvania" 
                version="20130614" />
    </expression>
</def>
```
反过来 我们也可以用QDM(eCQM)模型来表达vMR(CDS)中的概念，比如eCQM中使用“Diagnosis, Active: Pregnancy” 的术语来表示怀孕，对于CDS而言，我们可以用字典为(2.16.840.1.113883.3.600.1622 怀孕)的Diagnosis类同样来表示怀孕。
![](qdm2vmr.jpg)

##  目标
这份文档也就是QIDAM(Health Quality Improvement Domain Analysis Model 医疗质量改进领域分析模型)是一个概念层面数据模型(其实应该是概念模型就对了)，可以作为这个域的任何一种逻辑数据模型的基础。
这个模型分析了逻辑数据模型的需求，也就是说应该包含哪些元素。这个逻辑数据模型是用来表达医疗质量改进领域知识中的逻辑条件、总体条件、公式和其他表达的临床数据模型。这样子就确保了CDS和eCQM知识之间的一致性。

## 受众
包括医疗知识质量的测度、管理和上报的工作人员，知识的编辑和使用人员，标准分析和开发人员，工具开发人员以及系统集成商。
最好熟悉OO的设计原则和UML知识。
## 大背景介绍
MU第二阶段中要求通过认证的EHR系统实现CDS来支撑eCQM的改进。eCQM和CDS知识采用了不同的数据模型则1)阻碍了二者之间患者数据需求的共享;2)要求软件供应商在不同的格式间进行映射3)阻碍了二者之间共享模块开发
vMR是HL7的一种逻辑模型，2014年发布了第二版。使用UML来定义，其中的概念沿用了HL7 CLinical Statement 模型中的概念，使用了简化版的HL7 V3数据类型第二版。该模型的核心类是ClinicalStatement，该类可以具体化成ProcedureEvent，其中也包含了proposals的类，用以表示医嘱套餐中的一项或者一些规则中的建议。
QDM模型是基于components的，规定了如何将这些components组合成一种数据映射的表达方式。其中包括了：
*  Category (e.g., Procedure, Medication, Communication)
*  State (e.g., Active, Administered)
*   Attribute (e.g., Dosage, Frequency, Admission Date Time)
*  Timing Operators (e.g., Starts Before or During)
QIDAM对两种模型进行了整合

## 方法学
QIDAM旨在确定医疗质量改进的应用程序的数据需求，它整合了vMR和QDM的功能点。除此之外，还考虑了Quality Reporting Document Architecture (QRDA) Category 1 Templates 、vMR Templates 、Consolidated Clinical Document Architecture (CCDA) Templates 中的模板来分析QIDAM中要对哪些概念建模，概念的结构。另外还尽可能的复用了HL7 Fast Healthcare Interoperability Resources (FHIR) Specification 和Federal Health Information Model (FHIM) Specification 的元素。
附件中的QDM-vMR-cross-map.xlsx中提供了QIDAM、QDM、VMR之间的映射关系。
由于QIDAM是概念模型，使用VMR和QDM表达的数据完全没必要转换成QIDAM。你可以通过将自己的数据模型与QIDAM映射的方式来分析数据模型是否有能力提供实现医疗质量改进目标所需的数据。

## 范围      
仅适用于US的eCQM和CDS制品中所需的临床数据元的表达。目前涵盖的概念包括：
*   Communication
*   Care goals
*   Diet and nutrition
*   Participation in care plans and protocols
*   Use of devices
*   Encounters
*   Immunization
*   Medication treatments
*   Procedures
*   Allergies, intolerances, and adverse reactions
*   Conditions including findings, diagnoses, symptoms
*   Contraindications
*   Care experience 
*   Family history
*   Observation results 
*   Predictions such as risks and prognoses


## 场景分析
能够使用到  QIDAM的场景有三：
* artifacts的开发
    *  描述：eCQM和CDS artifacts的作者创建数据标准或动作/行为标准
    * 标识符：M1
    *  角色：eCQM author or CDS artifact author
    *  前置条件：数据标准以描述性的形式(指南中或指标中的文字)已经有了；对于CDS而言，建议或其他动作的标准以描述性的形式存在(临床指南中的文本 检查或处方)
    * 动作：作者确定了选取哪个QIDAM概念来表示数据标准或动作/行为标准;作者确定了数据标准或动作/行为标准的语境，使用语境来选择QIDAM中的概念类;作者确定具体的属性，使用QIDAM属性来完成数据或行为标准
    * 后置条件：通过QIDAM就可以实现完整准确的数据标准或动作/行为标准的定义，标准中会包含一些诸如剂量、时间，字典中的属性来表达数据元(如诊断、用药、手术)
    * 备注：如果QIDAM用到了一些属性，它们的值来自其他受控术语中编码值，QIDAM中并未对编码进行限制
* artifacts的实现
    * 描述：eCQM和CDS artifact实现人员将采用QIDAM定义的数据标准和动作/行为标准对应到自己系统中
    * 标识：M2
    *  角色：eCQM implementer or CDS artifact implementer
    * 前置条件：eCQM  or CDS artifact 中已经定义好了数据标准，数据标准中将artifact中的用到的标记或名称映射到QIDAM中的定义 比如Last LDL result到an observation result with the specified LOINC codes and date selection criteria;
     CDS artifact 包含了行为/动作标准(prescription of statins)
    * 动作：实施人员确定与用QIDAM定义的数据标准或动作标准中等同的目标系统中的元素 一张表或一个类;实施人员使用这个定义在目标环境下来构建数据或动作的定义;如果QIDAM的元素属性存在不明确的地方，实施人员对模型标准文档进行咨询; 重复此任务    
    * 后置条件：实施人员成功的将eCQM和CDS制品中的数据标准、动作行为标准全部映射到自己的系统当中。
    *  备注：如果数据标准、动作行为标准中的一些项在目标系统中找不到对应的元素，根据实际情况可以不处理
* artifacts的评估
    *  描述：指标评估系统或者CDS系统来评估eCQM或者是CDS。用QIDAM来表示数据标准、动作/行为标准
    *  标识符：M3
    * 角色：A measure calculation system or a CDS system 
    *  前置条件：eCQM CDS制品中存在数据标准，数据标准将制品中的符合映射到QIDAM的定义中;
    CDS制品包含了行为动作标准；
    制品中的所有标准都已经映射到自己系统的数据模型中或者是系统可以执行的动作
    * 动作：系统评估CDS制品和eCQM;当系统遇到数据标准，能够将其无歧义的转换成一个检索/查询数据的请求;CDS系统可以决定应用某个行为标准是由于评估逻辑，系统将标准转换成可执行的动作;动作分两种，一种是展现给用户的proposal，一种是系统自动执行的;
    *  后置条件：eCQM评估的结果是可计算机化的质量指标的效果，CDS制品评估的结果是从动作集合中选一个或者执行一些动作
    * 备注

artifacts在HL7中用的很多，比如像每个域对应的类图、excel、xsd等等，这里我们就理解成CDS的知识/规则。
这里我们描述时是将QIDAM作为数据模型来使用的，实际应用中，我们只需要用我们自己的数据模型将其替换即可。

## 模型概述
### 设计
#### 方法学
在QIDAM中，表达患者数据的核心概念是ClinicalStatement类。这个类又将ClinicalStatement分成三大类：
*  StatementOfOccurrence:表示一个事件的发生(肺炎)或者与患者健康相关的动作(用药)
*  StatementOfNonOccurrence：表示某个类型的事件或动作并没有发生
*  StatementOfUnknownOccurrence：表示不知道某个类型的事件或动作有没有发生
每种类型的statements都包含元数据，主题和模式 如下图，主题 topic指的是该statement的主题如症状、检验结果、手术或免疫接种;模式指的是主题发生、存在或进行的方式，如观察、医嘱、治疗计划;患者诊断可以用StatementOfOccurrence(topic是condition，modality是observation)，手术史可以用StatementOfOccurrence(topic是procedure，modality是performance) 主题和模式都是类，可以通过用属性来进一步描述。
![](statementStructure.jpg)
目前主题有两类：见![](topic.jpg)   
* Act：用以评估或改变患者健康的已经发生的事-比如药物治疗，血压测量，胸部X射线检查
* Observable:构成患者健康状态的元素-通常是检查、检验的结果，既往病情、现病情，检验结果，生命体征，过敏，预后
模式也包含两大类：
* Action:临床声明中的act存在的模式，可以有子类型，包括医嘱、order 和执行performance。如果StatementOfOccurrence(topic是procedure，modality是order )指的是手术医嘱。如果StatementOfOccurrence(topic是procedure，modality是peformance )指的是已执行或即将执行的手术
* Observation：临床声明中的observable存在的模式。不存在子类型

topic和modality要匹配，如果topic是observable，modality必须是observation 如下图所示：
![](observation.jpg)     
如果topic是Act，modality必须是Performance,Proposal,proposalAgainst,Order,Plan

1.有关act的临床声明
2.有关observation的临床声明
3.设计原理

#### 数据类型、实体和扩展数据类型
#### 基数和可选性
#### 质量改进的逻辑模型

