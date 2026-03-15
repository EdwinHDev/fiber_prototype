# Documento Fundacional y Arquitectura: Fiber Prototype
**Proyecto:** Fiber Prototype (Cix Telecom)
**Rol:** Sistema de Relevamiento de Infraestructura de Fibra Óptica (Híbrido / Offline-First)
**Tecnología Base:** Flutter, `maplibre_gl`, Riverpod, Drift (SQLite)

## 1. Arquitectura del Sistema (Clean Architecture)

El proyecto se estructura bajo **Clean Architecture** orientada a funcionalidades (Feature-First), garantizando escalabilidad y cumplimiento estricto de los principios SOLID.

- **Capa de Dominio (Domain):** Entidades puras y contratos (Interfaces). Aislada de frameworks externos.
- **Capa de Datos (Data):** Implementaciones de repositorios (Drift, MapLibre). Expuestas globalmente mediante Providers.
- **Capa de Presentación (Presentation):** Widgets reactivos y "tontos" que escuchan los Providers.
- **Gestión de Estado (Riverpod):** Uso estricto de generación de código (`@riverpod`). Todo el estado se maneja exclusivamente con `Notifier` y `AsyncNotifier`. Prohibido el uso de sintaxis legacy (como `StateNotifier`).

## 2. Motor Cartográfico y Estrategia Visual

Se utiliza `maplibre_gl` para el renderizado de mapas vectoriales (Vector Tiles).

### 2.1. Visibilidad Extrema (Modo Luz Solar)
Está prohibido el uso de "Dark Mode" en el mapa. Para combatir el deslumbramiento solar en campo:
- **Fondo:** Blanco o gris cálido muy claro (`#F4F4F4` o `#FFFFFF`).
- **Vías:** Negro puro (`#000000`) con un grosor (`line-width`) superior al estándar.
- **Data Operativa (Postes, Fibra):** Uso de colores institucionales o saturados (ej. cian, magenta) que resalten agresivamente sobre el mapa monocromático.

### 2.2. Optimización de Datos (Stripped Schema)
Los Vector Tiles a descargar eliminarán la "basura" visual. Solo se conservarán las capas de vías (`roads`), cuerpos de agua (`water`) y edificios (`buildings`). Se omiten POIs, árboles y polígonos de uso de suelo para reducir el peso del tile en un ~80%.

## 3. Estrategia de Mapas Offline (Multi-Capa e Inteligente)

El sistema funciona de manera Híbrida (Online/Caché con fallback a Offline nativo). La descarga de mapas no es masiva para evitar colapsar el almacenamiento del dispositivo, sino que sigue una arquitectura de dos capas:

### 3.1. Capa Base Nacional (Toda Venezuela)
- **Ejecución:** Descarga mandatoria en el primer inicio de la app. Bloquea la UI principal hasta completarse.
- **Límites:** Bounding Box de Venezuela.
- **Zoom:** Nivel 5 al 12.
- **Propósito:** Navegación interurbana y contexto global con peso mínimo.

### 3.2. Capa Operativa Dinámica (Smart Viewport)
- **Ejecución:** Bajo demanda. Descarga las zonas operativas específicas (ej. Upata, Maturín) a las que el técnico hará relevamiento.
- **Límites:** Se calcula usando el `CameraBounds` actual (la pantalla visible) + un **Buffer Matemático del 20%** hacia los bordes para cubrir zonas rurales/periféricas.
- **Zoom:** Nivel 13 al 19.

### 3.3. Administrador de Regiones
- **Deduplicación:** MapLibre gestiona tiles XYZ; regiones superpuestas no duplican datos.
- **Nomenclatura:** Auto-generada vía Reverse Geocoding del centro del Viewport, con opción de sobreescritura manual por el usuario.
- **Auditoría Visual:** Pantalla dedicada que inyecta un `GeoJSONSource` en el mapa. Dibuja polígonos translúcidos (`FillLayer` al 40% de opacidad) de colores aleatorios sobre las áreas descargadas usando sus `LatLngBounds`. Muestra peso (MB) y fecha.

## 4. Lógicas Inteligentes y UI Global (Drawer)

Las configuraciones se persisten localmente y se gestionan desde un Drawer lateral:

### 4.1. Indicador de Zoom y UI del Mapa
- Widget flotante que lee el stream de la cámara.
- Si Zoom <= 12: Muestra el nivel y el mensaje "(Acércate al nivel 13 para detalle)".

### 4.2. Ubicación Inteligente (Smart Location Point)
- Control en el Drawer: Switch de "Mostrar Ubicación" (Por defecto: apagado).
- **Validación Espacial:** Al intentar encenderlo, se obtiene el GPS en segundo plano y se cruza con las regiones offline en Drift.
  - Si hay cobertura: Se activa el punto y la cámara vuela a la posición con zoom 16~17.
  - Si NO hay cobertura: El switch rechaza la activación y lanza un diálogo exigiendo descargar la región (Viewport + 20% buffer) para poder habilitar el GPS.

### 4.3. Motor de Sugerencias (Smart Idle Prompt)
- Actúa cuando el mapa se detiene (`onCameraIdle`) y el Zoom >= 13.
- Verifica si el Viewport actual ya está descargado. Si no lo está, lanza un diálogo/banner sugiriendo la descarga.
- **Anti-Spam:** El Drawer incluye un ajuste del "Temporizador Anti-Spam" (ej. 30 min) para no acosar al técnico preguntándole por la misma zona si ya la ignoró.

## 5. Contrato de Datos Universal (GeoJSON)

El formato **GeoJSON (RFC 7946)** es el estándar estricto de comunicación entre el motor de MapLibre, la Base de Datos Local y el futuro Backend. 
- Los datos no se guardan como strings GeoJSON en la base de datos (por eficiencia), sino que la Capa de Datos implementa **Mappers** (`toGeoJsonFeature()`, `fromGeoJsonFeature()`) para traducir en tiempo real entre SQLite y GeoJSON.

## 6. Modelo de Datos y Persistencia Relacional (Drift)

Toda la infraestructura de Cix Telecom se gestiona en **Drift (SQLite)**, usando relaciones robustas y metadatos flexibles para soportar futuros cambios.

### 6.1. Entidades Principales
1. **Points:**
   - **Rol Cartográfico:** `GeoJSON: Point`.
   - **Atributos Fijos:** `id` (UUID), `name`, `type`, `description`, `latitude`, `longitude`.
   - **Metadatos (JSON Column):** Propiedades variables como `material_type`, `height`, `diameter`.

2. **Lines:**
   - **Rol Cartográfico:** `GeoJSON: LineString`. Geometría inferida estrictamente de los puntos que conecta. No tiene posición propia.
   - **Regla de Negocio:** Requiere mínimo 2 puntos (Padres).
   - **Atributos Fijos:** `id` (UUID), `name`, `type`, `description`, `color_hex`.
   - **Metadatos (JSON Column):** Propiedades variables como `fiber_count` (12 pelos, 48 pelos), `capacity_gbps`.

3. **Complements:**
   - **Rol:** Elementos modulares adjuntos a los puntos (Cajas NAT, Anclas).
   - **Atributos:** `id`, `name`.

### 6.2. Esquema Relacional Estricto (N:M)
La Capa de Datos modelará la topología con las siguientes Tablas:
- Tabla `points`.
- Tabla `lines`.
- Tabla `complements`.
- Tabla Intermedia `point_complements` (`point_id`, `complement_id`).
- Tabla de Ruteo `line_routes`: Vital para trazar el LineString. Une `line_id` con `point_id` y exige una columna `order` (Entero: 1, 2, 3...) que dicta la secuencia de dibujo de la fibra óptica de inicio a fin.