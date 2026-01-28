import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import 'nextra-theme-docs/style.css'

export const metadata = {
  title: 'My Project',
  description: 'Nextra documentation site',
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const navbar = (
    <Navbar
      logo={<span style={{ fontWeight: 700 }}>My Project</span>}
      projectLink="https://github.com/shuding/nextra-docs-template"
    />
  )
  const footer = <Footer>MIT {new Date().getFullYear()} © Nextra Docs Template.</Footer>

  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head />
      <body>
        <Layout
          navbar={navbar}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/shuding/nextra-docs-template"
          footer={footer}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}
