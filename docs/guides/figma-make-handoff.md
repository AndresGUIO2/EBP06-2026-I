# Figma Make Handoff (Nivel Inicial)

## Objetivo
Pasar de diseno a codigo sin enredos, con pasos simples para equipos que estan empezando.

## Pasos
1. Diseno comparte el link de Figma/Figma Make.
2. Dev define que pantalla va a implementar primero.
3. Dev implementa una version funcional en React.
4. PR incluye link y una captura comparativa.

## Minimos antes de codificar
- Tener claro 1 pantalla objetivo.
- Cubrir 3 estados: loading, success y error.
- Ver version desktop y mobile en el diseno.

## Minimos para cerrar PR
- Link del diseno usado.
- 1 captura desktop y 1 mobile de la implementacion.
- Nota corta si hubo diferencias respecto al diseno.

## Ejemplo rapido
- Pantalla: tarjeta "Estado del Servidor".
- Estados:
  - loading: "Conectando al API..."
  - success: muestra `status` y `service`
  - error: muestra mensaje de falla

## Regla de oro
Figma Make marca la idea visual.
El codigo final debe seguir los patrones del repo y ser entendible para el equipo.
