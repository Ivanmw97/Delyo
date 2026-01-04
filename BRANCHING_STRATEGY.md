# PadelTracker - Branching Strategy & CI/CD

## 🌳 Branching Strategy

### Branch Structure
```
main (production-ready)
├── develop (integration)
    ├── feature/add-statistics-page
    ├── feature/match-export
    ├── fix/samsung-button-visibility
    └── release/v1.1.0 (when needed)
```

### Branch Purposes

**`main`**
- Production-ready code only
- Protected branch with required PR reviews
- Tagged releases (v1.0.0, v1.1.0, etc.)
- Deployable to app stores
- **Merge from:** `develop` or `release/*` branches only

**`develop`**
- Integration branch for ongoing development
- All features merge here first
- Continuous testing and validation
- Source for release branches
- **Merge from:** `feature/*`, `fix/*`, `chore/*` branches

**Feature Branches**
- `feature/feature-name` - New functionality
- `fix/bug-description` - Bug fixes  
- `chore/task-description` - Maintenance tasks
- **Branch from:** `develop`
- **Merge to:** `develop`

**Release Branches (Optional)**
- `release/v1.1.0` - Prepare releases
- Use when you need release-specific fixes
- **Branch from:** `develop`
- **Merge to:** `main` and `develop`

### Naming Conventions

```bash
# Features
feature/add-match-statistics
feature/export-match-data
feature/user-authentication

# Bug fixes
fix/performance-rating-localization
fix/samsung-navigation-bar
fix/date-picker-validation

# Maintenance
chore/update-dependencies
chore/refactor-providers
chore/improve-test-coverage

# Releases (when needed)
release/v1.1.0
release/v2.0.0
```

### Workflow Rules

1. **Never commit directly to `main`**
2. **All changes go through Pull Requests**
3. **Feature branches must be up-to-date with `develop`**
4. **Delete feature branches after merge**
5. **Use squash merge for feature branches**
6. **Use merge commit for `develop` → `main`**

## 🔄 CI/CD Workflows

### Current Workflows

1. **`ci-develop.yml`** - Runs on PRs and pushes to `develop`
2. **`ci-main.yml`** - Runs on PRs and pushes to `main`
3. **`pr-checks.yml`** - Quality gate for all PRs
4. **`dependency-check.yml`** - Weekly dependency audit

### What Each Workflow Does

**Develop Branch CI:**
- ✅ Code formatting check
- ✅ Static analysis (`flutter analyze`)
- ✅ Run all tests with coverage
- ✅ Build debug APK
- ⚠️ Upload artifacts (7-day retention)

**Main Branch CI:**
- ✅ All develop checks +
- ✅ Build release APK and AAB
- ✅ Build iOS (macOS runner)
- ⚠️ Upload artifacts (30-day retention)

**PR Quality Checks:**
- ✅ Formatting validation
- ✅ Static analysis
- ✅ Test coverage reporting
- ✅ Dependency validation
- ⚠️ TODO/FIXME detection

## 📋 Current Enforcement vs Future

### ✅ Enforce Now
- Code formatting (`dart format`)
- Static analysis (`flutter analyze --fatal-infos`)
- All tests must pass
- PR reviews required
- Branch protection on `main`

### ⏳ Add Later (Pre-Release)
- Minimum test coverage threshold (80%+)
- Code signing for iOS builds
- Automated versioning
- Release notes generation
- Store deployment workflows

### 🚀 Add for Production
- Semantic versioning automation
- Crash reporting integration
- Performance monitoring
- Store upload automation
- Rollback procedures

## 🛡️ Branch Protection Rules

### For `main` branch:
```
✅ Require pull request reviews before merging
✅ Require status checks to pass before merging
   - CI - Main Branch / test
   - CI - Main Branch / build
✅ Require branches to be up to date before merging
✅ Restrict pushes that create files larger than 100MB
✅ Do not allow bypassing the above settings
```

### For `develop` branch:
```
✅ Require status checks to pass before merging
   - CI - Develop Branch / test
   - PR Quality Checks / quality-gate
✅ Require branches to be up to date before merging
✅ Restrict pushes that create files larger than 100MB
```

## 🎯 Quick Commands

```bash
# Start new feature
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name

# Finish feature
git checkout develop
git pull origin develop
git checkout feature/your-feature-name
git rebase develop
git push origin feature/your-feature-name
# Create PR to develop

# Prepare release (when needed)
git checkout develop
git pull origin develop
git checkout -b release/v1.1.0
# Update version numbers, changelog
git push origin release/v1.1.0
# Create PR to main
```

## 📊 Monitoring

- **GitHub Actions** - CI/CD status
- **Codecov** - Test coverage trends
- **Dependabot** - Dependency updates
- **GitHub Insights** - Development metrics
