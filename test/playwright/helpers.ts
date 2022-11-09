import {glob} from 'glob'

// Previews we're ignoring because they're not ready to be tested yet
const ignoredPreviews = ['primer/forms/forms']

interface ComponentPreview {
  componentName: string
  previewURL: string
}

export function componentPreviews(): ComponentPreview[] {
  const previews = glob.sync('previews/**/*_preview.rb')
  const result: ComponentPreview[] = []
  for (const preview of previews) {
    const previewURL = preview.replace('previews/', '').replace('_preview.rb', '').replace('_component', '')
    if (ignoredPreviews.includes(previewURL)) {
      continue
    }
    const componentName = previewURL
      .split('/')
      .map(module => {
        return module
          .split('_')
          .map(word => {
            return word[0].toUpperCase() + word.substring(1)
          })
          .join('')
      })
      .join('::')

    result.push({
      componentName,
      previewURL
    })
  }
  return result
}
