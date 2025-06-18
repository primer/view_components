import {controller} from '@github/catalyst'
import {IncludeFragmentElement} from '@github/include-fragment-element'

@controller
export class TreeViewIncludeFragmentElement extends IncludeFragmentElement {
  request(): Request {
    const originalRequest = super.request()
    const url = new URL(originalRequest.url)
    url.searchParams.set('path', this.getAttribute('data-path') || '')

    return new Request(url, {
      method: originalRequest.method,
      headers: originalRequest.headers,
      credentials: originalRequest.credentials,
    })
  }
}

if (!window.customElements.get('tree-view-include-fragment')) {
  window.TreeViewIncludeFragmentElement = TreeViewIncludeFragmentElement
  // eslint-disable-next-line custom-elements/extends-correct-class
  window.customElements.define('tree-view-include-fragment', TreeViewIncludeFragmentElement)
}

declare global {
  interface Window {
    TreeViewIncludeFragmentElement: typeof TreeViewIncludeFragmentElement
  }
}
