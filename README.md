# Todo Test

A new Flutter project.

## Getting Started
In the project, I implemented the MVVM pattern for most features, except for pagination, where I opted for the Clean Architecture approach. Each feature is encapsulated within a Cubit, providing a clear separation of concerns and facilitating modular development.

For routing, I utilized the Go Router package, organizing route names in a separate file for better maintainability. The logic for navigating between routes is centralized in the router file, enhancing code readability and manageability.

To explore different features, simply modify the initialLocation variable, enabling easy navigation to different sections of the application.

Within the TodoCubit, I integrated functionality to check for internet connectivity. In cases where the connection is unavailable, data retrieval is seamlessly handled through local database access, ensuring robustness and uninterrupted user experience.

Moreover, I employed GetIt as a service locator, streamlining dependency injection and enhancing the flexibility and scalability of the application architecture.![Screenshot from 2024-04-12 07-48-03](https://github.com/abdallh1999/todo/assets/96979660/82134250-de09-4cfb-8dce-3a1ec19fa2a3)
![Screenshot from 2024-04-12 08-07-59](https://github.com/abdallh1999/todo/assets/96979660/bd63d2c2-f1a2-47d1-b21f-a8292a08b4a0)
![Screenshot from 2024-04-12 07-48-22](https://github.com/abdallh1999/todo/assets/96979660/adeddfc9-3a5c-4f48-945e-d3acb8fcdc7e)


