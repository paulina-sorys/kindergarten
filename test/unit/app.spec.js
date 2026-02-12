import { mount } from '@vue/test-utils'
import App from '@/app.vue'

describe('App.vue', () => {
  it('renders hello vue message', () => {
    const wrapper = mount(App)
    expect(wrapper.text()).toContain('Hello Vue!')
  })

  it('data message is reactive', () => {
    const wrapper = mount(App)
    expect(wrapper.vm.message).toBe('Hello Vue!')
  })
})
