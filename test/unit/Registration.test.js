import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import Registration from '../../src/components/Registration.vue'

describe('Registration.vue', () => {
  it('renders registration form', () => {
    const wrapper = mount(Registration)

    expect(wrapper.find('input[type="email"]').exists()).toBe(true)
    expect(wrapper.find('input[type="password"]').exists()).toBe(true)
    expect(wrapper.findAll('input[type="password"]').length).toBeGreaterThanOrEqual(2) // hasło + potwierdzenie

    expect(wrapper.find('button[type="submit"]').exists()).toBe(true)
  })

  it('emits submit event with form data when submitted', async () => {
    const wrapper = mount(Registration)

    await wrapper.find('input[type="email"]').setValue('test@example.com')
    const passwordInputs = wrapper.findAll('input[type="password"]')
    await passwordInputs[0].setValue('password123')
    await passwordInputs[1].setValue('password123')

    await wrapper.find('form').trigger('submit.prevent')

    expect(wrapper.emitted('submit')).toBeTruthy()
    const submitEvent = wrapper.emitted('submit')[0][0]
    expect(submitEvent).toEqual({
      email: 'test@example.com',
      password: 'password123',
      passwordConfirmation: 'password123'
    })
  })
})
