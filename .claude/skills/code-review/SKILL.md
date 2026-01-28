# Code Review Skill

Review code for quality, maintainability, and best practices.

## Trigger

Activate when user says: "code review", "review this", "review PR", "review changes"

## Checklist

### Correctness
- [ ] Logic is correct and handles edge cases
- [ ] Error handling is appropriate
- [ ] No obvious bugs or typos
- [ ] Meets the requirements/ticket

### Readability
- [ ] Code is self-documenting (clear names)
- [ ] Complex logic has comments explaining "why"
- [ ] Consistent formatting/style
- [ ] No dead code or commented-out code

### Maintainability
- [ ] Functions/methods do one thing
- [ ] No excessive nesting (max 3 levels)
- [ ] DRY - no copy-pasted code blocks
- [ ] Reasonable file/function length

### Performance
- [ ] No N+1 queries
- [ ] No unnecessary loops or computations
- [ ] Appropriate data structures used
- [ ] No memory leaks (event listeners, subscriptions)

### Testing
- [ ] New code has tests
- [ ] Tests cover happy path and edge cases
- [ ] Tests are readable and maintainable
- [ ] No flaky tests introduced

### Security
- [ ] No hardcoded secrets
- [ ] User input validated/sanitized
- [ ] No SQL injection or XSS vulnerabilities
- [ ] Proper authorization checks

### API Design (if applicable)
- [ ] RESTful conventions followed
- [ ] Consistent naming
- [ ] Proper HTTP methods and status codes
- [ ] Input validation with clear errors

## Feedback Format

For each issue found:

```
**[Severity]** File:Line - Brief description

Suggestion: How to fix it

Example (optional):
[code snippet]
```

Severity levels:
- **Blocker**: Must fix before merge
- **Major**: Should fix, significant issue
- **Minor**: Nice to fix, small improvement
- **Nitpick**: Style/preference, optional

## Process

1. Understand the context (PR description, ticket)
2. Review files changed
3. Go through checklist
4. Provide actionable feedback
5. Highlight what's done well (not just problems)
6. Summarize: Approve / Request Changes / Comment
