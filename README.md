# Ejercicio 1: Pokédex con PokéApi (CON IA)

**Autora:** Macarena Morales Toledo  
**Proyecto:** Estudio de eficiencia de la IA  
**Tecnología:** Liferay 7.4 – MVC Portlet 

# Pokémon MVC Portlet - Liferay 
Este módulo de Liferay proporciona una interfaz para explorar Pokémons consumiendo la PokeApi. Permite visualizar un listado global y acceder a una vista detallada de
cada criatura mediante una navegación por páginación.

La aplicación permite:

- ✅ Listado paginado de Pokémon (mínimo 3 páginas)
- ✅ Vista de detalle individual
- ✅ Consumo real mediante `limit` y `offset`
- ✅ Estados controlados: loading, error, vacío
- ✅ Manejo de errores sin ruptura del portlet

## Setup & Instalación

Sigue estos pasos para desplegar el módulo en tu entorno local:

1. **Requisitos Previos**:
    - Liferay DXP / Portal 7.4
    - Java JDK 11/17/21
    - Blade CLI o Gradle instalado
      
2. **Clonar y Desplegar**:
     ```
     git clone https://github.com/MacarenaStNTTDATA/ejercicio1
     ```
     ```
     cd ejercicio1
     ```
     ```
     blade sever start
     ```
     
3. **Prueba y testeo**:
     - En la página del Home > Pokédex > Navega con libre albedrío.

## Decisiones Técnicas:
Para este desarrollo se han tomado las siguientes decisiones de diseño para garantizar escalabilidad y mantenibilidad:

### ✅ Arquitectura
- Implementación basada en **MVC Portlet**
- Uso de `MVCRenderCommand` para separar:
  - Vista principal (listado)
  - Vista de detalle

### ✅ Consumo de API
- Consumo realizado **desde backend (Java)**.
- Uso de `HttpURLConnection`.
- Parseo de respuesta con `JSONFactoryUtil`.

Motivo:  
Separación de responsabilidades y mejor control de errores frente a consumo client-side.

### ✅ Paginación
- Uso de parámetros `limit` y `offset` reales.
- Navegación mediante `renderURL`.
- Cálculo dinámico de número total de páginas.

### ✅ Manejo de estados
- Loading visual con overlay.
- Estado vacío controlado.
- Error gestionado sin caída del portlet.

## Limitaciones Documentadas:
- No se implementa cacheo de resultados.
- No se usan servicios OSGi externos (servicio simplificado).
- Loading simulado (no SPA real).
- No incluye tests automatizados.

## Video Demo
El vídeo de demostración (4 minutos) está disponible en GitHub Releases
[Descargar vídeo demostración](https://github.com/MacarenaStNTTDATA/ejercicio1/releases/tag/Video)
