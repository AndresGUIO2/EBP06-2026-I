import { render, screen, waitFor } from '@testing-library/react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import App from './App'

const fetchMock = vi.fn()

describe('App', () => {
  beforeEach(() => {
    fetchMock.mockReset()
    vi.stubGlobal('fetch', fetchMock)
  })

  afterEach(() => {
    vi.unstubAllGlobals()
  })

  it('renders backend health data when request succeeds', async () => {
    fetchMock.mockResolvedValue({
      ok: true,
      status: 200,
      json: async () => ({
        status: 'ok',
        service: 'backend',
        timestamp: '2026-03-30T10:00:00.000Z',
      }),
    } as Response)

    render(<App />)

    expect(screen.getByText('Conectando al API...')).toBeInTheDocument()

    await waitFor(() => {
      expect(screen.getByText('ok')).toBeInTheDocument()
    })

    expect(fetchMock).toHaveBeenCalledWith('http://localhost:8080/api/health')
    expect(screen.getByText('backend')).toBeInTheDocument()
  })

  it('shows a connection error when request fails', async () => {
    fetchMock.mockRejectedValue(new Error('network down'))

    render(<App />)

    await waitFor(() => {
      expect(screen.getByText('Error de conexión:')).toBeInTheDocument()
    })

    expect(screen.getByText('network down')).toBeInTheDocument()
  })
})
