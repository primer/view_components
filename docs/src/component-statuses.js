import { Link, Text, Label } from '@primer/react'
import StatusLabel from '@primer/gatsby-theme-doctocat/src/components/status-label'
import Table from '@primer/gatsby-theme-doctocat/src/components/table'
import { graphql, Link as GatsbyLink, useStaticQuery } from 'gatsby'
import React from 'react'

export function ComponentStatuses() {
  const data = useStaticQuery(graphql`
    query ComponentStatuses {
      allMdx(
        filter: {frontmatter: {status: {ne: null}}}
        sort: {fields: frontmatter___title}
      ) {
        nodes {
          slug
          excerpt(pruneLength: 300)
          frontmatter {
            status
            title
            a11yReviewed
          }
        }
      }
    }
  `)

  const components = data.allMdx.nodes.map(node => {
    // get first sentence of the excerpt
    // search for a period space and capital letter to avoid splitting at e.g.
    const excerptMatch = node.excerpt
      .replace(/\n/g, ' ')
      .match(/(^.+?\.)(\s+[A-Z])/, '.')

    return {
      slug: node.slug,
      description: excerptMatch ? excerptMatch[1] : node.excerpt,
      title: node.frontmatter.title,
      status: node.frontmatter.status,
      a11yReviewed: node.frontmatter.a11yReviewed,
    }
  })

  return (
    <Table>
      <thead>
        <tr>
          <th align="left">Component</th>
          <th align="center">Status</th>
          <th align="center">Accessibility</th>
          <th align="left">Description</th>
        </tr>
      </thead>
      <tbody>
        {components.map(({ slug, description, title, status, a11yReviewed }) => (
          <tr key={slug}>
            <td valign="top">
              <Link as={GatsbyLink} to={`/${slug}`}>
                {title}
              </Link>
            </td>
            <td align="center" valign="top">
              <StatusLabel status={status} />
            </td>
            <td align="center" valign="top" style={{ whiteSpace: 'nowrap' }}>
              {a11yReviewed ? (
                <Label variant="primary">Reviewed</Label>
              ) : (
                <Text sx={{ color: 'fg.subtle' }}>Pending review</Text>
              )}
            </td>
            <td valign="top">{description}</td>
          </tr>
        ))}
      </tbody>
    </Table>
  )
}
