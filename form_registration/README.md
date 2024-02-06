
After successful build, your application structure should look like this:

```
.
├── android                        
├── assets                        
├── ios                             
├── lib                             
    ├── main.dart                   - Начальная точка приложения.
    ├── selector_loading.dart       - Выбор варианта загрузки, в зависимости авторизованы или нет.
    ├── firebase_options.dart       - Сгенерированный файл - привязка приложения к проэкту в Firebase.
    ├── core
    │   ├── app_export.dart         - Часто используемые импорты файлов.
    │   ├── constants               - Содержит constant файлы.
    │   └── utils                   - Содержит общие файлы и утилиты приложения.
    ├── data                        - Содержит классы данных.
    ├── presentation                - Содержит виджеты экранов
    ├── routes                      - Содержит все маршруты приложения.
    ├── servises                    - Содержит сервисы работы с Firebase.
    └── theme                       - Содержит темы приложений и классы оформления.
    └── widgets                     - содержит пользовательские классы виджетов.
```
