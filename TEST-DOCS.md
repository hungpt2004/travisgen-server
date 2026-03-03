# Example: Verify Documentation System

## Quick Test

1. Start server:
```bash
npm run start:dev
```

2. Wait for server to start (~10 seconds)

3. Generate docs:
```bash
.\make.ps1 docs
# Or
npm run docs:generate
```

4. Check output:
```bash
ls docs/
```

Expected output:
- API-Index.md
- *-APIs.md (various tags)
- swagger.json
- endpoints/ folder with markdown files

5. Open in Obsidian or browser

## Test Checklist

- [ ] Server starts successfully
- [ ] Can access http://localhost:4000/api-docs
- [ ] Can access http://localhost:4000/api-docs-json
- [ ] Generate script runs without errors
- [ ] docs/ folder created
- [ ] API-Index.md exists and has content
- [ ] Endpoint files created in endpoints/
- [ ] Can open docs in Obsidian
- [ ] Internal links work

## Test Commands

```powershell
# Test 1: Show help
.\make.ps1 help

# Test 2: Test curl to swagger endpoint
curl -u admin:admin http://localhost:4000/api-docs-json

# Test 3: Generate docs
.\make.ps1 docs

# Test 4: Open docs
.\make.ps1 docs-open

# Test 5: Verify file structure
Get-ChildItem -Recurse docs/
```

## Expected Behavior

### After running `.\make.ps1 docs`:

```
🚀 Starting API documentation generation...

✅ Swagger specification fetched successfully

📝 Found X endpoints

📄 Generating endpoint documentation...
  ✅ GET-users.md
  ✅ POST-auth-login.md
  ...

📚 Generating tag indexes...
  ✅ auth-APIs.md
  ✅ users-APIs.md
  ...

📖 Generating main index...
  ✅ API-Index.md

💾 Saving raw Swagger specification...
  ✅ swagger.json

✨ Documentation generation completed successfully!
📁 Documentation location: D:\WorkSpace\TRAVISGEN\server\travisgen-server\docs
💡 Open this folder in Obsidian to view the documentation
```

## Common Issues

### Issue 1: "Cannot fetch Swagger spec"
**Cause**: Server not running
**Fix**: `npm run start:dev`

### Issue 2: "Authentication failed"
**Cause**: Wrong credentials in .env
**Fix**: Check SWAGGER_ACCOUNT_NAME and SWAGGER_ACCOUNT_PASS

### Issue 3: "No endpoints found"
**Cause**: No Swagger decorators in controllers
**Fix**: Add @ApiTags(), @ApiOperation() to controllers

### Issue 4: "Permission denied"
**Cause**: PowerShell execution policy
**Fix**: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`
