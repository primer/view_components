import {AnalyticsClient, getOptionsFromMeta} from '@github/hydro-analytics-client'

const client = new AnalyticsClient(getOptionsFromMeta())

client.sendPageView()

window.addEventListener('navigation:complete', () => {
  client.sendPageView()
})
