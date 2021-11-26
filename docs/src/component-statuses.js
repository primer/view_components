import {Link} from '@primer/components'
import StatusLabel from '@primer/gatsby-theme-doctocat/src/components/status-label'
import Table from '@primer/gatsby-theme-doctocat/src/components/table'
import {graphql, Link as GatsbyLink, useStaticQuery} from 'gatsby'
import React from 'react'

export function ComponentStatuses() {
  const data = useStaticQuery(graphql`
    query ComponentStatuses {
      allSitePage(
        filter: {context: {frontmatter: {status: {ne: null}}}}
        sort: {fields: context___frontmatter___title}
      ) {
        nodes {
          context {
            frontmatter {
              title
              status
            }
          }
          path
        }
      }
    }
  `)

  const components = data.allSitePage.nodes.map((node) => ({
    title: node.context.frontmatter.title,
    status: node.context.frontmatter.status,
    pagePath: node.path,
  }))

  return (
    <Table>
      <thead>
        <tr>
          <th align="left">Component</th>
          <th align="left">Status</th>
        </tr>
      </thead>
      <tbody>
        {components.map(({title, status, pagePath}) => (
          <tr key={pagePath}>
            <td valign="top">
              <Link as={GatsbyLink} to={pagePath}>
                {title}
              </Link>
            </td>
            <td valign="top">
              <StatusLabel status={status} />
            </td>
          </tr>
        ))}
      </tbody>
    </Table>
  )
}
