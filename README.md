# UMA Cavalry

《Crusader Kings III》马娘与马娘骑兵机制 MOD。

## 仓库结构

- `mod/UMA/`：游戏实际加载、Steam Workshop 实际上传的 MOD 本体。
- `docs/`：构想、设计、研究、实现说明和路线图，不随 MOD 本体上传。
- `launcher/`：本地启动器描述文件模板。
- `tools/`：新设备部署和项目维护脚本。

整个目录由同一个 Git 仓库管理，但 CK3 只通过目录联接读取 `mod/UMA/`。

