# 📚 API Documentation - Quick Start Guide

## 🚀 Tạo Documentation tự động cho API

Hệ thống này tự động generate API documentation từ Swagger/OpenAPI specs và format theo chuẩn Obsidian.

### Setup một lần

1. **Đảm bảo có biến môi trường trong `.env`:**
   ```env
   SWAGGER_ACCOUNT_NAME=admin
   SWAGGER_ACCOUNT_PASS=admin
   PORT=4000
   ```

2. **Cài đặt dependencies (nếu chưa):**
   ```bash
   npm install
   ```

### Sử dụng

#### Option 1: Sử dụng PowerShell Scripts (Khuyến nghị cho Windows)

```powershell
# Xem tất cả commands
.\make.ps1 help

# Generate docs một lần
.\make.ps1 docs

# Auto-generate docs mỗi 30 giây
.\make.ps1 docs-watch

# Mở thư mục docs
.\make.ps1 docs-open

# Start docs server
.\make.ps1 docs-server
```

#### Option 2: Sử dụng Batch file (Windows Command Prompt)

```cmd
make.bat docs
make.bat docs-watch
make.bat docs-open
```

#### Option 3: Sử dụng npm scripts

```bash
# Generate docs
npm run docs:generate

# Auto-generate khi có thay đổi
npm run docs:watch

# Mở docs folder
npm run docs:open

# Start docs server
npm run docs:server
```

#### Option 4: Sử dụng Makefile (Linux/Mac hoặc Windows với GNU Make)

```bash
make docs
make docs-watch
make docs-open
```

### 🔄 Workflow phát triển

#### Setup cơ bản:

```powershell
# Terminal 1: Start dev server
npm run start:dev

# Terminal 2: Generate docs (sau khi server đã chạy)
.\make.ps1 docs
```

#### Setup auto-regenerate (Optional):

```powershell
# Terminal 1: Dev server
npm run start:dev

# Terminal 2: Auto-generate docs mỗi 30s
.\make.ps1 docs-watch
```

### 📖 Xem Documentation

#### Trong Obsidian (Khuyến nghị):

1. Tải [Obsidian](https://obsidian.md/)
2. Open folder as vault → Chọn folder `docs/`
3. Mở file `API-Index.md`
4. Navigate qua các links

**Ưu điểm:**
- Navigation nhanh giữa endpoints
- Graph view để visualize API structure
- Search mạnh mẽ
- Có thể thêm personal notes

#### Trong VS Code:

1. Cài extension "Markdown Preview Enhanced"
2. Mở `docs/API-Index.md`
3. Click links để navigate

#### Trong Browser:

```bash
npm run docs:server
# Hoặc
.\make.ps1 docs-server
```

Mở: http://localhost:8080

### 📝 Viết API với Documentation

Thêm Swagger decorators vào code:

```typescript
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('users')  // Gom nhóm endpoints
@Controller('users')
export class UsersController {
  
  @ApiOperation({ summary: 'Get user by ID' })  // Mô tả ngắn
  @ApiResponse({ status: 200, description: 'User found' })
  @ApiResponse({ status: 404, description: 'User not found' })
  @ApiBearerAuth()  // Require authentication
  @Get(':id')
  getUser(@Param('id') id: string) {
    // Implementation
  }
  
  @ApiOperation({ summary: 'Create new user' })
  @ApiResponse({ status: 201, description: 'User created' })
  @ApiBody({ type: CreateUserDto })
  @Post()
  createUser(@Body() dto: CreateUserDto) {
    // Implementation
  }
}
```

### 🎯 Best Practices

1. **Thêm decorators đầy đủ:**
   - `@ApiTags()` - Group endpoints
   - `@ApiOperation()` - Mô tả
   - `@ApiResponse()` - Document responses
   - `@ApiBody()` - Document request body
   - `@ApiBearerAuth()` - Authentication

2. **Generate docs thường xuyên:**
   - Sau khi thêm endpoint mới
   - Sau khi update API
   - Trước khi commit

3. **Review trong Obsidian/Browser**

### 📁 Cấu trúc Docs

```
docs/
├── API-Index.md           # Entry point
├── {Tag}-APIs.md          # Grouped by tags
├── endpoints/             # Chi tiết từng endpoint
│   ├── GET-users.md
│   ├── POST-auth-login.md
│   └── ...
└── swagger.json           # Raw spec
```

### 🔗 Links

- **Swagger UI**: http://localhost:4000/api-docs
- **Swagger JSON**: http://localhost:4000/api-docs-json
- **Docs Folder**: `./docs/`
- **Full Guide**: `./docs/README.md`

### ⚠️ Troubleshooting

**Problem: Cannot fetch Swagger spec**
```
✅ Solution: Đảm bảo server đang chạy
npm run start:dev
```

**Problem: Authentication failed**
```
✅ Solution: Check .env file
SWAGGER_ACCOUNT_NAME=admin
SWAGGER_ACCOUNT_PASS=admin
```

**Problem: Empty docs**
```
✅ Solution: Thêm Swagger decorators vào controllers
```

### 🛠️ Customization

Script location: `scripts/generate-api-docs.js`

Có thể customize:
- Output format
- Template structure
- Grouping logic
- Additional sections

---

**Happy Documenting! 📚✨**
