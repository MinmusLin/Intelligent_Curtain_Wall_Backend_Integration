# OSS 控制器 API 文档

OSS 控制器 API 提供文件的上传与下载功能，通过 HTTP 请求与服务端交互。所有接口均以 `/oss` 为基础路径。

## 下载文件

### 接口描述

通过提供文件的路径，从 OSS 存储中下载指定文件。

### URL

`GET /oss/download/{文件路径}`

### 请求参数

无直接请求参数。

**注意**：

文件的最终存储路径（包括文件名）需要在上传请求的 URL 中明确指定。举例来说，如果您上传的原始文件名是 `upload.txt`，并在请求URL中指定存储路径为 `/oss/upload/user/documents/file.txt`，那么该文件会以指定的文件名 `file.txt` 存储于 `user/documents/` 目录下，即最终存储路径为 `user/documents/file.txt`。请注意，这里的 `file.txt` 是需要由您在上传请求中明确指定的新文件名（可以与原文件名重合）。

### 响应

* **成功**：返回文件的二进制数据，同时响应头包含文件下载的必要信息。
  * **HTTP 状态码**：`200 OK`
  * **响应头**：
    * `Content-Disposition: attachment; filename=<文件名>`
  * **响应体**：文件的二进制内容
* **失败**：返回 HTTP 错误状态码。
  * **`404 Not Found`**: 文件不存在。

## 上传文件

### 接口描述

通过提供文件及相关用户信息，将文件上传至OSS存储。

### URL

`POST /oss/upload/{文件路径}`

### 请求参数

| 参数名 | 类型 | 必填 | 描述 |
| :--- | :--- | :--- | :--- |
| `file` | MultipartFile | 是 | 要上传的文件 |
| `userName` | String | 是 | 账号（用于身份验证） |
| `password` | String | 是 | 密码（用于身份验证） |

**注意**：

文件路径通过 URL 动态指定。例如，上传的文件为 `upload.txt`，上传路径为 `/oss/upload/user/documents/file.txt`，则 `upload.txt` 会存储为 `user/documents/file.txt`。

### 响应

* **成功**：返回文件的下载链接。
  * **HTTP 状态码**：200 OK
  * **响应体**：

    ```json
    {
        "downloadUrl": "http://<服务域名>/oss/download/<文件路径>"
    }
    ```

* **失败**：返回 HTTP 错误状态码及错误信息。
  * **`401 Unauthorized`**: 身份验证失败。
  * **`400 Bad Request`**: 对象键格式无效（如路径或文件名非法）。
  * **`500 Internal Server Error`**: 文件上传失败。

### 验证规则

* 目录部分（路径中的每一层目录）只能包含字母、数字和 `-`。
* 文件名部分只能包含字母、数字、`.` 和 `-`。
* 不允许使用连续的斜杠（ `//` ）。
