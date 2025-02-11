<!DOCTYPE html>
<html lang="en">

 <head>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            padding: 20px;
            max-width: 800px;
            background-color:rgb(20, 20, 20);
        }
        h1, h2 {
            color: #fff;
        }
        code {
            background: #ddd;
            padding: 2px 5px;
            border-radius: 3px;
        }
        pre {
            background: #222;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>

</head>
<body>
    <h1>Task App - Teaching at central Campus</h1>
    <p>A real-time task management application with Firebase Authentication (Email only).</p>
    
<h2>Repository</h2>
<p>GitHub: <a href="https://github.com/sanam-tamang/firebase_flutter_task_app_central_campus_teaching" target="_blank">firebase_flutter_task_app_central_campus_teaching</a></p>
    
<h2>Features</h2>
    <ul>
        <li>User authentication using Firebase Email & Password.</li>
        <li>Create tasks with a title and description.</li>
        <li>Read tasks in real-time.</li>
        <li>Update task details in real-time.</li>
        <li>Delete tasks instantly.</li>
    </ul>
    
<h2>Tech Stack</h2>
    <ul>
        <li>Flutter</li>
        <li>Firebase Authentication (Email & Password)</li>
        <li>Cloud Firestore (for real-time database operations)</li>
    </ul>
    
<h2>Installation</h2>
    <pre><code>git clone https://github.com/sanam-tamang/firebase_flutter_task_app_central_campus_teaching.git
cd firebase_flutter_task_app_central_campus_teaching
flutter pub get</code></pre>
    
<h2>Firebase Setup</h2>
    <p>Follow these steps to set up Firebase:</p>
    <ol>
        <li>Create a Firebase project at <a href="https://console.firebase.google.com/">Firebase Console</a>.</li>
        
</ol>
    
<h2>Usage</h2>
    <p>Run the Flutter app with:</p>
    <pre><code>flutter run</code></pre>
    
<h2>Firestore Data Structure</h2>
    <pre><code>{
"tasks": {
    "taskId1": {
        "id" : "taskId1",
      "title": "Task 1",
      "description": "This is task 1",
    }
  }
}</code></pre>
    
<h2>Authentication</h2>
    <p>Users must sign in with an email and password before performing any task operations.</p>
    
<h2>Screenshots</h2>
   
    
<p> UI:</p>
    <img src="screenshot/image.png" alt="App UI">
    
<h2>Contributing</h2>
    <p>Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to change.</p>
  
</body>
</html>
