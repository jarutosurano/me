import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import 'nextra-theme-docs/style.css'

export const metadata = {
  title: 'Jayr Sullano — WordPress Developer & Project Lead',
  description: 'Portfolio of Jayr Sullano — WordPress/WooCommerce Developer, Project Manager, and AI-augmented workflow specialist.',
  robots: {
    index: false,
    follow: false,
  },
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const navbar = (
    <Navbar
      logo={<span style={{ fontWeight: 700 }}>Jayr Sullano</span>}
      projectLink="https://github.com/jarutosurano"
    />
  )
  const footer = <Footer>© {new Date().getFullYear()} Jayr Sullano. Built with Nextra & Claude Code.</Footer>

  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head />
      <body>
        <Layout
          navbar={navbar}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/jarutosurano/me"
          footer={footer}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}
