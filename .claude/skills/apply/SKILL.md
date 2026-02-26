# Job Application Generator Skill

Generate a tailored, merged cover letter + resume (DOCX only) for a job posting.

## Trigger

Activate when user pastes a job posting and wants to apply, or says: "apply", "generate application", "cover letter and resume"

## Process

1. **Read master profile**: `.local/master-profile.md` — this is the source of truth for all experience, skills, and personal info.
2. **Assess fit**: Briefly tell the user how their profile aligns with the job (strengths and gaps). Be honest.
3. **Generate merged DOCX**: One document with cover letter (page 1) and resume (pages 2-3).
4. **No PDF** — only generate DOCX.

## Output Format

- **Page 1**: Cover letter — personalized, addressing the specific company and role. Mention referrals if the user provides one.
- **Page 2-3**: Resume — tailored to the job. Reframe job titles, reorder experience, cherry-pick bullets, and adjust the summary/skills to match what the employer is looking for.

## Tailoring Rules

- **Reframe job titles** to match the target role language (e.g., "WordPress Developer" becomes "E-Commerce Developer" for an e-commerce role, or stays "WordPress Developer" for a WordPress role)
- **Reorder experience** to put the most relevant role first, even if it's not the most recent
- **Cherry-pick bullets** from master profile that are relevant to the job posting — don't include everything
- **Adjust the summary** to position Jayr for the specific role, using keywords from the job posting
- **Adjust skills section** to lead with what the job asks for
- **Strip irrelevant details** — if applying for an admin role, don't include PHP/React/Node.js details
- **Use the job posting's language** — mirror their terminology in the resume and cover letter
- **Quantify achievements** wherever possible (e.g., "200+ units", "50+ stores", "20%+ conversion rates")

## Cover Letter Guidelines

- Keep to 1 page (5 paragraphs max)
- Opening: state the role, mention referral if any, lead with most relevant experience
- Body: map your experience directly to their requirements
- Don't be generic — reference specific things from the job posting
- Close with location/availability and thank them

## File Structure

Shared dependencies live at `.local/applications/` root:
- `package.json` — shared `docx` dependency (one `node_modules` for all apps)
- `lib/docx-helpers.mjs` — all reusable DOCX helpers

Applications are organized by category:
- `.local/applications/web/{company-slug}/` — web dev, WordPress, e-commerce roles
- `.local/applications/admin/{company-slug}/` — office admin, bookkeeping, non-dev roles

Files created per application:
- `generate-docx.mjs` — the generator script (imports from `../../lib/docx-helpers.mjs`)
- `Jayr_Sullano_{Company_Name}.docx` — the output

**No per-folder `package.json` or `node_modules`.** Everything resolves to the shared root.

## Shared Library: `lib/docx-helpers.mjs`

Import everything you need from the shared lib:
```js
import {
  COLORS, coverLetterHeader, coverLetterClosing, resumeHeader, summaryBlock,
  sectionHeading, jobHeader, jobSubheader, bullet, bulletBold, skillRow, certRow,
  spacer, clParagraph, buildDocument, generateDocx
} from '../../lib/docx-helpers.mjs';
```

Key functions:
- `coverLetterHeader({ date, company, address, links })` — full CL header block (returns array)
- `coverLetterClosing()` — "Sincerely, Jayr Sullano" block (returns array)
- `resumeHeader({ links })` — name + contact + links (returns array)
- `summaryBlock(text)` — blue-bordered summary paragraph
- `buildDocument(coverLetterChildren, resumeChildren)` — creates the 2-section Document
- `generateDocx(doc, outputPath)` — writes to disk
- `sectionHeading(text)` — blue uppercase heading with bottom border
- `jobHeader(title, date)` — title left, date right
- `jobSubheader(text)` — gray company line
- `bullet(text)` — bulleted list item
- `bulletBold(label, value)` — bold prefix bullet (for portfolio items)
- `skillRow(label, value)` — bold label + value
- `certRow(name, issuer, date)` — certification line
- `clParagraph(text)` — justified cover letter paragraph
- `spacer()` — spacing between job entries

## Generator Pattern

Each `generate-docx.mjs` follows this pattern:
```js
// 1. Define links (LinkedIn only for admin roles, + portfolio/GitHub for technical)
const LINKS = [{ label: '...', url: '...' }];

// 2. Build cover letter children array
const coverLetterChildren = [
  ...coverLetterHeader({ date, company, address, links }),
  clParagraph('...'),
  ...coverLetterClosing(),
];

// 3. Build resume children array
const resumeChildren = [
  ...resumeHeader({ links }),
  summaryBlock('...'),
  sectionHeading('EXPERIENCE'),
  // ... jobs, skills, education, certs
];

// 4. Build and generate
const doc = buildDocument(coverLetterChildren, resumeChildren);
await generateDocx(doc, path.resolve(__dirname, 'Jayr_Sullano_Company.docx'));
```

Run from project root: `node .local/applications/{category}/{slug}/generate-docx.mjs`

## Important Notes

- Always read `.local/master-profile.md` first to get the latest profile data
- Date on cover letter should be today's date
- Jayr's location: Waterloo, ON
- Always install npm deps and run the generator to produce the DOCX
- If the user mentions a referral, include it in the cover letter opening paragraph
- Cover letter contact info: LinkedIn only (no GitHub/portfolio unless the role is technical)
- Resume contact info: LinkedIn + portfolio for technical roles, LinkedIn only for admin roles
