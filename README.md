# ESM_Project
NO2 Analysis Project for course ESM

_processMultipleCSVFiles.m_ 可以允许用户依次选择5个不同选择站的原始文件，格式为.csv，示例文件储存在NO2Database文件夹里。    

**按窗口左上角提示选择对应站点的文件！**      

该函数将5个站点的数据整合并暂存为一个新的表格，为下一步的可视化分析做准备。     


_visualizeNO2Data.m_ 把读取后的NO2数据先转换为ppb单位，再放在一张plot里进行对比。     

