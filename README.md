# The JDMs

Aplicación móvil desarrollada en Flutter que combina autenticación de usuarios, un panel interactivo de rotación de un logotipo, un catálogo de autos JDM consumido desde una API pública, un historial de actividad persistido en archivo local y notificaciones reales del sistema operativo.

## Tabla de contenidos

1. [Información general del proyecto](#1-información-general-del-proyecto)
2. [Tecnologías, herramientas y recursos utilizados](#2-tecnologías-herramientas-y-recursos-utilizados)
3. [Requisitos previos](#3-requisitos-previos)
4. [Instalación y ejecución del proyecto](#4-instalación-y-ejecución-del-proyecto)
5. [Plataformas probadas](#5-plataformas-probadas)
6. [Características del proyecto](#6-características-del-proyecto)
7. [Estructura del proyecto](#7-estructura-del-proyecto)
8. [Diagramas del sistema](#8-diagramas-del-sistema)
9. [Arquitectura y funcionamiento](#9-arquitectura-y-funcionamiento)
10. [Capturas del proyecto](#10-capturas-del-proyecto)
11. [Conclusión](#11-conclusión)
12. [Créditos](#12-créditos)

---

## 1. Información general del proyecto

| Campo | Detalle |
|---|---|
| Nombre del proyecto | The JDMs |
| Nombre técnico del paquete | `flutter_application_1` |
| Autor | Erick Ivan Ponce Hernandez |
| Materia | Programación Móvil |
| Grupo | ITI-23 |

### Introducción

The JDMs es una aplicación móvil construida sobre Flutter que integra, en un solo proyecto, los pilares fundamentales del desarrollo de aplicaciones móviles modernas: persistencia local mediante bases de datos SQLite, consumo de servicios web externos, manejo de archivos del sistema, procesamiento asíncrono y notificaciones nativas del sistema operativo. La aplicación fue diseñada bajo un enfoque visual inspirado en el sistema de diseño de iOS (Cupertino), con un tema oscuro consistente en todas sus pantallas.

### Propósito y objetivo

El proyecto busca demostrar, de manera práctica y funcional, la implementación de un ciclo completo de autenticación de usuarios, gestión de datos remotos y locales, y comunicación con el usuario a través de notificaciones reales, dentro de una única aplicación cohesiva. Su objetivo principal es servir como evidencia de dominio técnico sobre:

- Autenticación y persistencia de usuarios mediante una base de datos SQLite embebida.
- Consumo de una API pública externa y su combinación con una capa de persistencia local para simular un ciclo CRUD completo.
- Lectura y escritura de archivos de texto en el sistema de archivos del dispositivo.
- Manejo correcto de operaciones asíncronas, incluyendo tareas en segundo plano (isolates) y tareas programadas (temporizadores).
- Envío de notificaciones reales del sistema operativo como resultado de acciones concretas del usuario.

### Problema que resuelve

Reúne, en un caso de uso realista (una cuenta de usuario que administra un catálogo de autos JDM), las prácticas necesarias para construir aplicaciones Flutter que no dependen únicamente de la interfaz visual, sino que también gestionan datos persistentes, se comunican con servicios externos y notifican al usuario de manera nativa.

---

## 2. Tecnologías, herramientas y recursos utilizados

### Lenguaje y Framework

- **Flutter** — SDK principal utilizado para la construcción de la interfaz y la lógica de la aplicación (versión de desarrollo: 3.41.9, canal stable).
- **Dart** — Lenguaje de programación en el que está escrita toda la lógica de la aplicación (versión 3.11.5).

### Entorno de desarrollo

El proyecto es compatible con cualquier entorno que soporte el SDK de Flutter y no depende de un editor específico. Durante el desarrollo se utilizaron entornos como:

- Android Studio, con el complemento de Flutter y Dart instalado.
- Visual Studio Code, con las extensiones oficiales de Flutter y Dart.
- Terminal / línea de comandos (Flutter CLI), utilizada de forma directa para compilar, analizar y ejecutar la aplicación.

El proyecto puede abrirse y ejecutarse desde cualquiera de estos entornos indistintamente, siempre que el SDK de Flutter esté correctamente configurado en el sistema.

### Herramientas de desarrollo

- **Flutter CLI** — compilación, análisis estático (`flutter analyze`) y ejecución del proyecto.
- **Android SDK Command-line Tools** (`sdkmanager`, `avdmanager`) — instalación de plataformas, herramientas de compilación y creación de dispositivos virtuales Android.
- **Android Debug Bridge (ADB)** — instalación de la aplicación y depuración sobre dispositivos y emuladores Android.
- **Android Emulator (AVD)** — ejecución y prueba de la aplicación en un dispositivo Android virtual.
- **Gradle** (a través del Android Gradle Plugin) — construcción del proyecto para la plataforma Android.
- **Git** — control de versiones del código fuente.

### Herramientas de diseño

La interfaz de la aplicación se diseñó directamente en código, utilizando el sistema de diseño Cupertino que provee Flutter (`CupertinoApp`, `CupertinoPageScaffold`, `CupertinoNavigationBar`, entre otros), junto con una paleta de colores y tema propios definidos en el proyecto. No se utilizaron herramientas externas de prototipado gráfico; el diseño visual y sus iteraciones se realizaron de forma iterativa sobre la propia aplicación en ejecución.

### Herramientas de investigación

- [Documentación oficial de Flutter](https://docs.flutter.dev/) — referencia principal para widgets, ciclo de vida y buenas prácticas.
- [pub.dev](https://pub.dev/) — repositorio oficial de paquetes Dart/Flutter, utilizado para consultar documentación y versiones de las dependencias del proyecto.
- [API pública NHTSA vPIC](https://vpic.nhtsa.dot.gov/api/) — fuente de datos utilizada para el catálogo de autos JDM.
- Documentación oficial del paquete `flutter_local_notifications` — referencia para la configuración de notificaciones locales en Android.

### Inteligencia Artificial

- **Claude** (Anthropic) — utilizada como asistente de desarrollo durante distintas etapas del proyecto.

---

## 3. Requisitos previos

### Sistema operativo recomendado

El desarrollo y las pruebas de este proyecto se realizaron sobre **Windows**. Flutter también es compatible con macOS y Linux como sistemas operativos de desarrollo; el proyecto puede compilarse desde cualquiera de ellos siempre que se cuente con las herramientas correspondientes a la plataforma de destino.

### Instalación de Flutter

Para compilar y ejecutar este proyecto en Windows es necesario tener instalado Flutter SDK.

Guía oficial de instalación para Windows:
https://docs.flutter.dev/get-started/install/windows

### Instalación del SDK necesario

Para ejecutar la aplicación en un dispositivo o emulador Android es necesario contar con:

- **Android SDK** (Platform Tools, Build Tools y al menos una plataforma Android instalada; el proyecto fue probado sobre Android SDK 35/36).
- **Android SDK Command-line Tools** o **Android Studio** (que los incluye), para gestionar el SDK y los dispositivos virtuales.
- Un **emulador Android (AVD)** configurado, o bien un dispositivo Android físico con la depuración USB habilitada.

### Configuración del ambiente

1. Instalar Flutter SDK siguiendo la guía oficial enlazada anteriormente.
2. Agregar la carpeta `flutter/bin` a la variable de entorno `PATH` del sistema.
3. Instalar el Android SDK (mediante Android Studio o las Command-line Tools) y aceptar las licencias correspondientes con:
   ```
   flutter doctor --android-licenses
   ```
4. Verificar que el entorno esté correctamente configurado ejecutando:
   ```
   flutter doctor
   ```
   Este comando debe reportar en verde, como mínimo, el SDK de Flutter y el toolchain de Android.

### Dependencias necesarias

El proyecto declara las siguientes dependencias en `pubspec.yaml`:

| Paquete | Versión | Uso en el proyecto |
|---|---|---|
| `cupertino_icons` | ^1.0.8 | Iconografía del sistema de diseño Cupertino |
| `crypto` | ^3.0.7 | Generación de hash seguro (SHA-256) para contraseñas |
| `sqflite` | ^2.4.2+1 | Base de datos SQLite embebida |
| `path` | ^1.9.1 | Construcción de rutas de archivos multiplataforma |
| `sqflite_common_ffi` | ^2.4.0+3 | Soporte de SQLite en plataformas de escritorio |
| `path_provider` | ^2.1.6 | Ubicación del directorio de documentos de la aplicación |
| `http` | ^1.6.0 | Consumo de la API pública de autos JDM |
| `flutter_local_notifications` | 18.0.1 | Notificaciones reales del sistema operativo |

Estas dependencias se descargan automáticamente al ejecutar `flutter pub get`, tal como se describe en la siguiente sección.

---

## 4. Instalación y ejecución del proyecto

1. **Clonar el repositorio**

   ```
   git clone <URL-del-repositorio>
   ```

   Descarga una copia local del código fuente del proyecto.

2. **Entrar a la carpeta del proyecto**

   ```
   cd flutter_application_1
   ```

   Ubica la terminal dentro del directorio raíz del proyecto, donde se encuentra el archivo `pubspec.yaml`.

3. **Descargar dependencias**

   ```
   flutter pub get
   ```

   Descarga e instala todos los paquetes declarados en `pubspec.yaml` necesarios para compilar el proyecto.

4. **Ejecutar el proyecto**

   ```
   flutter run
   ```

   Compila la aplicación y la instala en el dispositivo o emulador conectado. Si existe más de un dispositivo disponible, Flutter solicitará elegir uno; también puede indicarse explícitamente con `flutter run -d <id-del-dispositivo>`.

---

## 5. Plataformas probadas

| Plataforma | Estado |
|---|---|
| Android (emulador y/o dispositivo físico) | Probado |
| Windows (aplicación de escritorio nativa) | Agregar plataforma probada |
| Web (navegador) | No compatible: la aplicación utiliza SQLite, archivos locales (`dart:io`) y notificaciones del sistema, funcionalidades no soportadas en tiempo de ejecución por Flutter Web |
| iOS | Agregar plataforma probada |
| macOS | Agregar plataforma probada |
| Linux | Agregar plataforma probada |

---

## 6. Características del proyecto

- **Autenticación de usuarios con SQLite**: registro e inicio de sesión respaldados por una base de datos SQLite local, con contraseñas protegidas mediante hash SHA-256 y una sal (salt) aleatoria generada por usuario.
- **Registro de cuenta con validación de campos**: nombre, correo electrónico (validado mediante expresión regular), contraseña con longitud mínima y confirmación de contraseña.
- **Aceptación de Términos y Condiciones**: pantalla dedicada, con validación obligatoria antes de iniciar sesión.
- **Panel de rotación interactivo**: pantalla principal que permite rotar un logotipo mediante un control deslizante (slider) y una serie de valores de grados predefinidos, con animación suave.
- **Menú de navegación**: acceso centralizado, mediante una hoja de acciones (action sheet), a las distintas secciones de la aplicación y al cierre de sesión.
- **Catálogo de autos JDM consumido desde una API pública**: listado de vehículos obtenido en tiempo real desde la API pública NHTSA vPIC, filtrado a marcas japonesas (JDM).
- **Ciclo CRUD combinando API y base de datos local**: la lectura (Read) proviene de la API pública; la creación, edición y eliminación de autos se gestionan localmente mediante SQLite, permitiendo tanto agregar vehículos propios como sobrescribir o eliminar (de forma local) los obtenidos de la API.
- **Actualización automática periódica**: el catálogo de autos se refresca automáticamente cada 30 segundos mediante un temporizador, además de contar con actualización manual (deslizar para refrescar).
- **Procesamiento en segundo plano**: el análisis (parseo) de la respuesta JSON de la API se realiza en un isolate independiente, evitando bloquear la interfaz de usuario.
- **Historial de actividad persistido en archivo**: cada inicio de sesión, registro de cuenta y operación sobre el catálogo de autos queda registrado con fecha y hora en un archivo de texto plano (`historial.txt`) almacenado en el dispositivo.
- **Notificaciones reales del sistema operativo**: se disparan notificaciones nativas ante acciones concretas del usuario (registro exitoso, inicio de sesión, alta, edición y eliminación de un auto).
- **Interfaz con tema oscuro consistente**: paleta de colores y tipografía unificadas en todas las pantallas mediante un tema Cupertino centralizado.

---

## 7. Estructura del proyecto

```
lib/
├── main.dart                     Punto de entrada, tema global y pantalla de inicio de sesión
├── registro.dart                 Pantalla de creación de cuenta
├── terminos.dart                 Pantalla de Términos y Condiciones
├── inicio.dart                   Pantalla principal (rotación del logotipo y menú)
├── autos.dart                    Pantalla del catálogo de autos JDM
├── historial.dart                Pantalla del historial de actividad
├── theme.dart                    Definición del tema y paleta de colores de la aplicación
│
├── data/
│   ├── database_helper.dart      Configuración y esquema de la base de datos SQLite
│   ├── auth_database.dart        Lógica de registro y autenticación de usuarios
│   └── historial_service.dart    Lectura y escritura del archivo de historial (.txt)
│
├── models/
│   └── auto.dart                 Modelo de datos de un auto del catálogo
│
├── services/
│   ├── api_service.dart          Consumo de la API pública de autos JDM
│   └── notification_service.dart Configuración y disparo de notificaciones locales
│
├── repositories/
│   └── auto_repository.dart      Combinación de datos de la API y overrides locales (CRUD)
│
├── widgets/
│   ├── campo_texto.dart          Campo de texto reutilizable con estilo propio
│   ├── auto_card.dart            Tarjeta de presentación de un auto en la lista
│   └── auto_form_dialog.dart     Formulario emergente para crear/editar un auto
│
└── utils/
    ├── dialogs.dart               Diálogo de aviso reutilizable
    └── validadores.dart           Validaciones compartidas (por ejemplo, formato de correo)
```

---



## 8. Arquitectura y funcionamiento

### Flujo de navegación

La aplicación sigue un flujo de navegación lineal basado en `Navigator` y `CupertinoPageRoute`:

```
Pantalla (login)
   ├── RegistroPage (crear cuenta)
   ├── TerminosPage (términos y condiciones)
   └── InicioPage (tras iniciar sesión)
          ├── AutosPage (catálogo JDM, vía menú)
          └── HistorialPage (historial de actividad, vía menú)
```

El acceso a `AutosPage` y `HistorialPage` se realiza a través del menú (`CupertinoActionSheet`) disponible en `InicioPage`, el cual también permite cerrar sesión y regresar a la pantalla de login.

### Manejo de datos

El proyecto combina tres fuentes de datos distintas, cada una con una responsabilidad clara:

- **Base de datos SQLite** (`database_helper.dart`): contiene las tablas `usuarios` (id, nombre, correo, hash de contraseña, sal y fecha de registro) y `autos` (registros locales y overrides de elementos provenientes de la API).
- **API pública remota** (`api_service.dart`): fuente de lectura (Read) del catálogo de autos JDM, consumida mediante peticiones HTTP.
- **Archivo de texto local** (`historial_service.dart`): bitácora de eventos de la aplicación, escrita y leída directamente del sistema de archivos del dispositivo mediante `dart:io`.

### Componentes principales

- **Capa de pantallas** (`main.dart`, `registro.dart`, `terminos.dart`, `inicio.dart`, `autos.dart`, `historial.dart`): responsables de la interfaz y la interacción con el usuario.
- **Capa de servicios** (`services/`): encapsulan el acceso a la API externa y a las notificaciones del sistema.
- **Capa de repositorio** (`repositories/auto_repository.dart`): combina los datos obtenidos de la API con los cambios locales almacenados en SQLite, exponiendo una única fuente de verdad a la interfaz.
- **Capa de datos** (`data/`): encapsula el acceso directo a la base de datos y al archivo de historial.
- **Widgets reutilizables** (`widgets/`): componentes de interfaz compartidos entre distintas pantallas.

### Comunicación entre módulos

Las pantallas no acceden directamente a la base de datos, a la API ni al sistema de archivos: siempre lo hacen a través de las clases de `data/`, `services/` y `repositories/`, manteniendo la lógica de negocio separada de la interfaz. Las notificaciones del sistema (`NotificationService`) y el registro en el historial (`HistorialService`) se invocan desde las pantallas como consecuencia directa de una acción del usuario (registrarse, iniciar sesión, o crear, editar o eliminar un auto).

---


## 9. Conclusión

El desarrollo de Rust Rotator permitió aplicar, dentro de un mismo proyecto, los conceptos fundamentales de una aplicación móvil profesional construida con Flutter: persistencia de datos mediante SQLite, consumo de servicios web externos, manipulación de archivos del sistema operativo, manejo correcto de operaciones asíncronas —incluyendo aislamiento de procesos pesados mediante isolates y tareas programadas mediante temporizadores— y comunicación proactiva con el usuario a través de notificaciones nativas del sistema operativo.

Más allá de la funcionalidad individual de cada pantalla, el proyecto aporta una arquitectura organizada por responsabilidades (datos, servicios, repositorios e interfaz), lo que facilita su mantenimiento y escalabilidad futura. Su desarrollo reforzó conocimientos prácticos sobre buenas prácticas de seguridad en el manejo de contraseñas, diseño de interfaces consistentes y la integración de múltiples fuentes de datos —locales y remotas— dentro de un flujo coherente para el usuario final.

---

## 10. Créditos

**Desarrollador:**
Erick Ivan Ponce Hernandez

**Materia:**
Programación Móvil

**Grupo:**
ITI-23
