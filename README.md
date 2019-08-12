# About Daily Dive

Daily Dive is a simple project I created as a way to showcase my ability as a programmer. The idea for the app is simple, a Q&A style journal that you can walk through daily to identify strengths and weaknesses in your current routine and obstacles you

You can check it out at [https://dailydive.jhadik307.com](https://dailydive.jhadik307.com)

Once you sign up or log in, you can easily walk through and answer your daily questions just by pressing the 'start' button. You can also adjust the questions you will be asked by pressing the 'Questions' button, or you can view and edit your previously filled out journals by pressing the 'History' button.

# About the Code

Behind the scenes, Daily Dive uses an architecture that deviates from the standard Rails convention. The reason for this is simple, Daily Dive is not a typical resource-driven app, it's a scene-driven app.

Traditional Rails apps use a separate page for each action of each resource: index, show, edit, and new. This app does away with this convention and instead allows multiple actions for multiple different resources on a single screen, known as a "scene", to optimize the user experience (no more navigating through 7 pages to update one property.)

To allow for this kind of hybrid activity on each page, Daily Dive takes advantage of a gem I created known as [https://github.com/JoshHadik/dynamic_text](dynamic_text) that allows developers to create multi-functional text elements in their HTML that act as both the display text for a specific attribute of a resource, as well as the edit box for that attribute when clicked on.

Additionally, this app utilizes a unique controller structure consisting of two main subfolders: 'resources' and 'scenes.' The resource controllers act like traditional Rails controllers, and specify certain controller actions available for specific resources such as 'update' and 'destroy.' The scene controllers are a bit more interesting, they define a series of all actions that can be performed on a specific screen of the application.

The View folder contains subfolders that relate to each scene, and each of those subfolders may contain three unique elements. The 'scene.html.erb' file within each scene view folder contains all the initial HTML needed to display the scene. The 'props' folder contain a series of partials that may be utilized by a specific scene, this allows for better separation of concerns within the HTML logic. Finally, the 'updates' folders contain a series of js.erb files that can be rendered from a scenes controller to handle specific actions, like displaying warning text when login or sign up was failed on the authentication screen. 
