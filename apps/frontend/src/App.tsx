import { useEffect, useState } from 'react'

type HealthPayload = {
  status: string
  service: string
  timestamp: string
}

function App() {
  const [health, setHealth] = useState<HealthPayload | null>(null)
  const [error, setError] = useState<string | null>(null)

  const apiBaseUrl = (
    import.meta.env.VITE_API_URL ??
    import.meta.env.VITE_API_BASE_URL ??
    'http://localhost:8080'
  ).replace(/\/$/, '')

  useEffect(() => {
    const checkHealth = async () => {
      try {
        const response = await fetch(`${apiBaseUrl}/api/health`)
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}`)
        }
        const payload = (await response.json()) as HealthPayload
        setHealth(payload)
      } catch (fetchError) {
        setError(
          fetchError instanceof Error
            ? fetchError.message
            : 'Unable to connect to backend',
        )
      }
    }

    void checkHealth()
  }, [apiBaseUrl])

  return (
    <main className="min-h-screen bg-background flex flex-col items-center justify-center p-6">
      <header className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-bold text-primary mb-4">
          Fábrica Escuela
        </h1>
        <p className="text-lg text-text-muted max-w-2xl leading-relaxed">
          Plataforma educativa en desarrollo. Vite + React frontend conectado
          al backend de Spring Boot.
        </p>
      </header>

      <section className="bg-surface shadow-lg rounded-xl p-8 w-full max-w-md border-t-4 border-secondary">
        <h2 className="text-2xl font-semibold text-text mb-4">
          Estado del Servidor
        </h2>
        <p className="text-sm text-text-muted mb-6">
          API base URL: <strong className="text-primary-light">{apiBaseUrl}</strong>
        </p>

        {health && (
          <div className="bg-slate-50 rounded-lg p-5 border border-slate-100">
            <ul className="space-y-3">
              <li className="flex justify-between border-b border-slate-200 pb-2">
                <span className="text-text-muted">Estado:</span>
                <span className="font-medium text-emerald-600">{health.status}</span>
              </li>
              <li className="flex justify-between border-b border-slate-200 pb-2">
                <span className="text-text-muted">Servicio:</span>
                <span className="font-medium text-text">{health.service}</span>
              </li>
              <li className="flex justify-between pt-1">
                <span className="text-text-muted">Hora:</span>
                <span className="font-medium text-text text-sm">{new Date(health.timestamp).toLocaleTimeString()}</span>
              </li>
            </ul>
          </div>
        )}

        {!health && !error && (
          <div className="flex items-center justify-center space-x-2 text-primary-light mt-4">
            <div className="w-4 h-4 border-2 border-primary-light border-t-transparent rounded-full animate-spin"></div>
            <p>Conectando al API...</p>
          </div>
        )}
        
        {error && (
          <div className="bg-red-50 text-red-600 p-4 rounded-lg mt-4 border border-red-100">
            <p className="font-semibold mb-1">Error de conexión:</p>
            <p className="text-sm">{error}</p>
          </div>
        )}
      </section>
    </main>
  )
}

export default App
