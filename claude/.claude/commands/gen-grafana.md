---
description: 生成 grafana query code
---

基于本项目里的代码，基于我给你的 prometheus metric 生成直接可以在 Grafana 里使用的 query code

如果是 histogram，我希望得到以下几类折线图：

1. 总的数据
2. 按照各个label 区分的数据
3. 按照各个label 区分的数据且带上各自的占比（总的是100%）

如果是 counter，我希望得到以下几个图：

1. 折线图：看每5min的增减情况
2. 饼图：看过去3小时（以我的选择的时间段为准）不同label 的占比（需要能看到各自占比的具体数字）

我希望生成的code要能直接添加到 Grafana 里查询得到结果，如果需要除了选择对应图表类型以外的其他配置才能得到合适的图，也麻烦告诉我详细的配置方法
