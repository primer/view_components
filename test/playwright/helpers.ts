import {glob} from 'glob'

// Previews we're ignoring because they're not ready to be tested yet
const ignoredPreviews = ['Primer::Forms::FormsPreview', 'Primer::Forms::Forms']

interface ComponentPreview {
  componentName: string
  previewURL: string
}

export function componentPreviews(): ComponentPreview[] {
  // Glob for all the preview files
  const previews = glob.sync('previews/**/*_preview.rb')
  const result: ComponentPreview[] = []

  for (const preview of previews) {
    // Remove prefixes and suffixes to get the component name and preview URL
    let previewURL = preview.replace('previews/', '').replace('_preview.rb', '')

    if (previewURL.includes('_component')) {
      previewURL = previewURL.replace('_component', '')
    } else {
      previewURL = `${previewURL}`
    }

    // Covert the preview URL to a component name ie. primer/beta/button => Primer::Beta::Button
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

    // If the preview is in the ignored list, don't add it to the result
    if (!ignoredPreviews.includes(componentName)) {
      result.push({componentName, previewURL})
    }
  }
  return result
}
