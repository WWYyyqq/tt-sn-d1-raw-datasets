# TT、SN、D1 原始数据集

本仓库存放三个数据集的原始本地副本，快照日期为 2026-09-20。数据文件以无损压缩包保存在 [GitHub Release](https://github.com/WWYyyqq/tt-sn-d1-raw-datasets/releases/tag/raw-v1)，仓库本身保存说明和校验清单。

| 数据集 | 原始目录名 / 解压后的目录名 | 文件数 | 原始字节数 |
| --- | --- | ---: | ---: |
| TT（TrainTicket） | `TT Dataset` | 336 | 807,137,799 |
| SN（SocialNetwork） | `SN Dataset` | 107 | 1,452,286,108 |
| D1（AIOps-Dataset） | `Aiops-Dataset` | 1,225 | 30,252,477,472 |
| 合计 | | 1,668 | 32,511,901,379 |

这些是最原始的数据目录，包含 TT/SN 的 `data/`、`no fault/` 和目录中已有的原始压缩文件，以及 D1 的 `data/`、`groundtruth/`。完整保留源目录，包括已有的隐藏文件。没有重新归一化、生成样本或修改标签，不包含 REACR-RCA 的 `D1_weighted` 或其他实验处理版。

## 下载、校验与还原

数据在 Release 附件中；GitHub 的 “Source code” 下载和 `git clone` 本身只包含说明与清单。

安装 GitHub CLI 并登录有仓库访问权限的账号，然后运行：

```bash
git clone https://github.com/WWYyyqq/tt-sn-d1-raw-datasets.git
cd tt-sn-d1-raw-datasets
mkdir -p downloads data
gh release download raw-v1 --repo WWYyyqq/tt-sn-d1-raw-datasets --dir downloads
(cd downloads && sha256sum -c ../SHA256SUMS)
bash restore.sh
(cd data && sha256sum -c ../FILES.sha256)
```

`restore.sh` 会按分卷编号顺序合并并流式解压至 `data/`；不会产生一个额外的合并压缩包。请预留足够空间存放下载附件及约 32.51 GB 的解压数据。脚本遇到已存在的目标数据集目录会停止，避免覆盖。

也可以在 Release 页面下载所有数据附件，将其放入 `downloads/`，然后执行校验和还原命令。Windows 用户可在 WSL 或 Git Bash 中运行。

## 校验与来源

- `manifest.json`：每个源文件及 Release 附件的路径、大小和 SHA-256。
- `SHA256SUMS`：全部数据压缩包或分卷的校验清单。
- `FILES.sha256`：解压后的全部 1,668 个文件的校验清单。

源目录均位于 `D:\Users\wyq\shiyan\Eadro\chunks\`：

```text
TT Dataset/
SN Dataset/
Aiops-Dataset/
```

对应 WSL 路径为 `/mnt/d/Users/wyq/shiyan/Eadro/chunks/`。此快照只声明与本机原始目录逐文件一致，不声称已核对上游最新发布版本。

原数据的权利归属和许可条款保持不变，本仓库不另行授予数据再分发许可。
