# Getting and Cleaning Data 项目说明

## 项目描述
本课程的目的是证明您收集、运用以及整理数据集的能力。目标是准备可以用于后续分析的整洁数据。

以下是项目的数据：
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

您需要提交：

1.  整洁的数据集；
2.  带有您执行分析脚本的Github知识库链接；
3.  说明变量、数据的编码本和您为清理名为CodeBook.md的数据所执行的所有转换或工作。还应包含一个README.md，解释所有脚本的工作方式以及连接方式。   


您应该创建一个名为run_analysis.R的R编程语言脚本，完成以下操作。

1.  整合培训和测试集，创建一个数据集。
2.  仅提取测量的平均值以及每次测量的标准差。
3.  使用描述性活动名称命名数据集中的活动
4.  使用描述性变量名称恰当标记数据集。
5.  从第4步的数据集中，针对每个活动和每个主题使用每个表里的平均值建立第2个独立的整洁数据集。

## 项目内容
* README.md: 项目内容和使用方法介绍
* CodeBook.md: 变量和编码的说明，以及数据转换工作说明
* run_analysis.R: 数据处理脚本

## 使用方法
1. 下载项目原始数据，并解压缩到UCI HAR Dataset目录下
2. 打开R Studio，并使用setwd()设置工作目录为UCI HAR Dataset的上级目录
3. 运行source run_analisys.R (需要dplyr和tidyr包支持)



