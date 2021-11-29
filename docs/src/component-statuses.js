import {Link} from '@primer/components'
import StatusLabel from '@primer/gatsby-theme-doctocat/src/components/status-label'
import Table from '@primer/gatsby-theme-doctocat/src/components/table'
import {graphql, Link as GatsbyLink, useStaticQuery} from 'gatsby'
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
          }
        }
      }
    }
  `)

  const components = data.allMdx.nodes.map((node) => {
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
    }
  })

  return (
    <Table>
      <thead>
        <tr>
          <th align="left">Component</th>
          <th align="left">Status</th>
          <th align="left">Description</th>
        </tr>
      </thead>
      <tbody>
        {components.map(({slug, description, title, status}) => (
          <tr key={slug}>
            <td valign="top">
              <Link as={GatsbyLink} to={`/${slug}`}>
                {title}
              </Link>
            </td>
            <td valign="top">
              <StatusLabel status={status} />
            </td>
            <td valign="top">{description}</td>
          </tr>
        ))}
      </tbody>
    </Table>
  )
}
