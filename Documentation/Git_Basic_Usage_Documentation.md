# Git 基本使用文档

Git 是一个分布式版本控制系统，用于跟踪代码的更改、管理代码版本，并促进多人协作开发。本文档将介绍 Git 的一些基本操作，包括安装、初始化仓库、常用命令、分支管理等。

## 安装 Git

### Windows

* 下载 Git 安装程序：访问 Git 官网，下载并安装适用于 Windows 的版本。
* 安装过程中，选择默认选项即可。

### macOS

在终端运行以下命令来安装 Git：

```bash
brew install git
```

如果没有安装 Homebrew，可以参考 Homebrew 官网安装 Homebrew。

### Linux

在终端运行以下命令：

```bash
sudo apt-get update
sudo apt-get install git
```

对于其他 Linux 发行版，可以使用相应的软件包管理器安装 Git。

## 配置 Git

安装完成后，使用以下命令设置 Git 的全局配置：

### 设置用户名和邮箱

Git 需要使用用户名和邮箱来标识每次提交的作者。可以通过以下命令进行设置：

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

### 验证配置

通过以下命令可以验证是否设置成功：

```bash
git config --list
```

## 创建 Git 仓库

### 初始化一个新的 Git 仓库

在一个空目录中初始化一个新的 Git 仓库：

```bash
git init
```

### 克隆远程仓库

从远程仓库克隆一个已有的仓库：

```bash
git clone https://github.com/username/repository.git
```

## 基本操作

### 查看文件状态

查看文件当前的状态，例如哪些文件被修改、哪些文件未跟踪等：

```bash
git status
```

### 添加文件到暂存区

将文件添加到 Git 的暂存区，以准备提交：

```bash
git add <file>
```

添加所有文件：

```bash
git add .
```

### 提交更改

将暂存区的更改提交到本地仓库：

```bash
git commit -m "commit message"
```

### 查看提交历史

查看提交记录：

```bash
git log
```

## 远程仓库操作

### 查看远程仓库

查看当前仓库关联的远程仓库地址：

```bash
git remote -v
```

### 添加远程仓库

将本地仓库关联到远程仓库：

```bash
git remote add origin https://github.com/username/repository.git
```

### 拉取远程仓库的更新

从远程仓库获取最新的更改并合并到本地：

```bash
git pull origin main
```

### 推送更改到远程仓库

将本地的提交推送到远程仓库：

```bash
git push origin main
```

## 分支管理

### 查看当前分支

查看当前所在的分支：

```bash
git branch
```

### 创建新分支

创建一个新的分支：

```bash
git branch <branch-name>
```

### 切换分支

切换到另一个分支：

```bash
git checkout <branch-name>
```

### 创建并切换分支

创建新分支并切换到该分支：

```bash
git checkout -b <branch-name>
```

### 合并分支

将指定的分支合并到当前分支：

```bash
git merge <branch-name>
```

### 删除分支

删除本地分支：

```bash
git branch -d <branch-name>
```

删除远程分支：

```bash
git push origin --delete <branch-name>
```

## 解决冲突

在合并分支时，可能会出现冲突，Git 会提示冲突文件，并要求你手动解决冲突。

* 打开冲突文件，修改文件内容，保留你想要的更改。
* 完成修改后，标记文件为已解决并提交：

```bash
git add <conflicted-file>
git commit -m "Resolved merge conflict"
```

## 查看差异

### 查看文件差异

查看工作区和暂存区的差异：

```bash
git diff
```

### 查看提交间的差异

查看两个提交之间的差异：

```bash
git diff <commit1> <commit2>
```

## 回滚与撤销

### 撤销未暂存的修改

撤销工作区的更改，恢复到上一次提交时的状态：

```bash
git checkout -- <file>
```

### 撤销已暂存的修改

撤销已暂存但未提交的更改：

```bash
git reset <file>
```

### 回退到之前的提交

回退到指定的历史提交：

```bash
git reset --hard <commit-id>
```

### 删除本地提交（保留更改）

如果你想删除本地的提交，但保留工作目录中的更改，可以使用：

```bash
git reset --soft HEAD~1
```

## 标签管理

### 创建标签

在某个提交上创建标签：

```bash
git tag <tag-name>
```

### 删除标签

删除本地标签：

```bash
git tag -d <tag-name>
```

删除远程标签：

```bash
git push origin --delete tag <tag-name>
```

## Git 配置文件

Git 使用三个主要配置文件来保存配置信息：

* 系统级配置文件：适用于所有用户的配置，存储在 Git 安装目录。
* 用户级配置文件：适用于当前用户，通常存储在 `~/.gitconfig` 文件中。
* 仓库级配置文件：每个 Git 仓库都有自己的配置，存储在 `.git/config` 文件中。

## 总结

Git 是一个强大的版本控制工具，掌握基本的 Git 命令对于开发者来说至关重要。通过 Git，你可以轻松地管理代码版本、协作开发、解决冲突和追踪历史记录。希望这份文档能帮助你快速上手 Git，并有效地进行版本控制。