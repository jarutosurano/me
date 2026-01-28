# Security Review Skill

Comprehensive security review based on OWASP Top 10 with practical tooling.

## Trigger

Activate when user says: "security review", "security audit", "check security", "vulnerability check"

## Severity Levels

| Level | Description | Action |
|-------|-------------|--------|
| 🔴 Critical | Actively exploitable | Block deployment |
| 🟠 High | Exploitable with effort | Fix within 7 days |
| 🟡 Medium | Requires conditions | Fix within 30 days |
| 🟢 Low | Minimal impact | Fix when convenient |

## Dependency Audit Commands

Run these first to check known vulnerabilities:

```bash
# Node.js
npm audit
yarn audit
pnpm audit

# Python
pip-audit
safety check

# Go
govulncheck ./...

# Rust
cargo audit
```

## OWASP Top 10 Checklist

### 1. Injection (A01)
- [ ] SQL queries use parameterized statements
- [ ] No string concatenation in queries
- [ ] User input sanitized before shell commands
- [ ] No eval() or similar with user input

### 2. Broken Authentication (A02)
- [ ] Passwords hashed with bcrypt/argon2 (not MD5/SHA1)
- [ ] Session tokens are cryptographically random
- [ ] Sessions expire appropriately
- [ ] Rate limiting on auth endpoints
- [ ] Account lockout after failed attempts
- [ ] CSRF protection exists

### 3. Sensitive Data Exposure (A03)
- [ ] Secrets in environment variables, not code
- [ ] `.env` files in `.gitignore`
- [ ] No secrets in git history
- [ ] HTTPS enforced with HSTS
- [ ] Sensitive data encrypted at rest
- [ ] No sensitive data in URLs or logs
- [ ] Secure cookie flags (`Secure`, `HttpOnly`, `SameSite`)

### 4. XML External Entities (A04)
- [ ] XML parsing disables external entities
- [ ] DTD processing disabled

### 5. Broken Access Control (A05)
- [ ] Authorization checks on all endpoints
- [ ] No direct object references without auth
- [ ] CORS properly configured (restrictive)
- [ ] Directory listing disabled

### 6. Security Misconfiguration (A06)
- [ ] Debug mode disabled in production
- [ ] Default credentials changed
- [ ] Error messages don't leak stack traces
- [ ] Generic error messages to users
- [ ] Security headers present (CSP, X-Frame-Options)
- [ ] TLS 1.2+ required

### 7. Cross-Site Scripting (A07)
- [ ] Output encoding/escaping
- [ ] Content-Security-Policy header
- [ ] No innerHTML with user data
- [ ] Template auto-escaping enabled

### 8. Insecure Deserialization (A08)
- [ ] No deserializing untrusted data
- [ ] Input validation before deserialization

### 9. Known Vulnerabilities (A09)
- [ ] Dependencies up to date
- [ ] No critical CVEs in dependencies
- [ ] No high-severity issues over 30 days old
- [ ] Lock files committed

### 10. Insufficient Logging (A10)
- [ ] Auth events logged
- [ ] Access control failures logged
- [ ] No sensitive data in logs
- [ ] Logs protected from tampering

## File Upload Security (if applicable)
- [ ] File types validated server-side
- [ ] File size limited
- [ ] Files stored outside webroot
- [ ] Uploaded files renamed

## Output Format

```markdown
# Security Review: [Project Name]
Date: [Date]

## Summary
| Severity | Count |
|----------|-------|
| 🔴 Critical | X |
| 🟠 High | X |
| 🟡 Medium | X |
| 🟢 Low | X |

## Findings

### [Severity] Finding Title
**Location:** file:line
**Risk:** Description of the vulnerability
**Remediation:** Steps to fix

## Recommendations
1. [Priority action items]
```

## Process

1. Run dependency audit commands
2. Search for hardcoded secrets (patterns: API_KEY, password, secret)
3. Review code against OWASP checklist
4. Report findings with severity
5. Provide remediation steps for each issue
6. Summarize with actionable recommendations
