import {expect} from 'chai'
import {componentTest} from './helpers.js'

componentTest('time_ago_component', it => {

  it('works', async page => {
    await expect(page).to.have.selector('body')
    const el = await page.$('body')
    await expect(el).to.be.visible()
  })

})
