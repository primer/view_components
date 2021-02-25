import {
  BorderBox,
  Box,
  Details,
  Flex,
  Grid,
  Heading,
  Position,
  StyledOcticon,
  Text,
} from '@primer/components'
import {ChevronDownIcon, ChevronUpIcon} from '@primer/octicons-react'
import React from 'react'
import {
  Head,
  Header,
  Sidebar,
  SourceLink,
  StatusLabel,
} from '@primer/gatsby-theme-doctocat'
import {HEADER_HEIGHT} from '@primer/gatsby-theme-doctocat/src/components/header'
import PageFooter from '@primer/gatsby-theme-doctocat/src/components/page-footer'
import TableOfContents from '@primer/gatsby-theme-doctocat/src/components//table-of-contents'
import StorybookLink from './storybook-link'

function Layout({children, pageContext}) {
  let {
    title,
    description,
    status,
    source,
    additionalContributors,
    storybook,
  } = pageContext.frontmatter

  if (!additionalContributors) {
    additionalContributors = []
  }

  return (
    <Flex flexDirection="column" minHeight="100vh">
      <Head title={title} description={description} />
      <Header />
      <Flex flex="1 1 auto" flexDirection="row" css={{zIndex: 0}}>
        <Box display={['none', null, null, 'block']}>
          <Sidebar />
        </Box>
        <Grid
          id="skip-nav"
          maxWidth="100%"
          gridTemplateColumns={['100%', null, 'minmax(0, 960px) 220px']}
          gridTemplateAreas={[
            '"heading" "content"',
            null,
            '"heading table-of-contents" "content table-of-contents"',
          ]}
          gridColumnGap={[null, null, 6, 7]}
          gridRowGap={3}
          mx="auto"
          p={[4, 5, 6, 7]}
          css={{alignItems: 'start', alignSelf: 'start'}}
        >
          <BorderBox
            css={{gridArea: 'heading'}}
            borderWidth={0}
            borderBottomWidth={1}
            borderRadius={0}
            pb={2}
          >
            <Heading as="h1">{title}</Heading>
          </BorderBox>
          {pageContext.tableOfContents.items ? (
            <Position
              display={['none', null, 'block']}
              css={{gridArea: 'table-of-contents', overflow: 'auto'}}
              position="sticky"
              top={HEADER_HEIGHT + 24}
              maxHeight={`calc(100vh - ${HEADER_HEIGHT}px - 24px)`}
            >
              <Text display="inline-block" fontWeight="bold" mb={1}>
                Table of contents
              </Text>
              <TableOfContents items={pageContext.tableOfContents.items} />
            </Position>
          ) : null}
          <Box css={{gridArea: 'content'}}>
            {status || source || storybook ? (
              <Flex mb={3} alignItems="center">
                {status ? <StatusLabel status={status} /> : null}
                <Box mx="auto" />
                <Flex flexDirection="column">
                  {source ? <SourceLink href={source} /> : null}
                  {storybook ? <StorybookLink href={storybook} mt={source ? 2 : 0}/> : null}
                </Flex>
              </Flex>
            ) : null}
            {pageContext.tableOfContents.items ? (
              <BorderBox display={['block', null, 'none']} mb={3} bg="gray.1">
                <Details>
                  {({open}) => (
                    <>
                      <Box as="summary" p={3} sx={{cursor: 'pointer'}}>
                        <Flex
                          flexDirection="row"
                          justifyContent="space-between"
                          alignItems="center"
                        >
                          <Text fontWeight="bold">Table of contents</Text>
                          {open ? (
                            <StyledOcticon
                              icon={ChevronUpIcon}
                              mr={2}
                              color="gray.6"
                            />
                          ) : (
                            <StyledOcticon
                              icon={ChevronDownIcon}
                              mr={2}
                              color="gray.6"
                            />
                          )}
                        </Flex>
                      </Box>
                      <Box
                        p={3}
                        sx={{
                          borderTop: '1px solid',
                          borderColor: 'border.gray',
                        }}
                      >
                        <TableOfContents
                          items={pageContext.tableOfContents.items}
                        />
                      </Box>
                    </>
                  )}
                </Details>
              </BorderBox>
            ) : null}
            {children}
            <PageFooter
              editUrl={pageContext.editUrl}
              contributors={pageContext.contributors.concat(
                additionalContributors.map((login) => ({login})),
              )}
            />
          </Box>
        </Grid>
      </Flex>
    </Flex>
  )
}

export default Layout
