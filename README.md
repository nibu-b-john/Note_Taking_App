
# Note Taking Machine 
Your personalised Note taking mobile app.


## Features

- Communicating with server and database
- Auto Date and Time saving system
- Adding Notes and lists
- Swipe To Detele functionality
- Good User Interface


## Run Locally

Clone the project
```bash
  git clone https://github.com/nibu-b-john/Note_Taking_App.git
```

Connect to your `mySql database` using `sequelize`

- Download mySql workbench to work with database.
- Right click under Schema section and select create schema.
- To Connect to your server `cd service`.
- Create a .env file in service folder and fill out the following.

 ```bash
  - TABLE_NAME={YOUR_SCHEMA}
  - TABLE_OWNER={USERNAME}
  - TABLE_PASSWORD={PASSWORD}
 ```
- Create a .env file in your root folder and fill out the following.

 ```bash
  - YOUR_ENDPOINT_URL={YOUR_ENDPOINT}:3000
 ```



### Server side
```bash
  cd service
  npm install
  node server.js 
```
### Client side


```bash
  flutter pub get

```






## Tech Stack

**Client:** flutter, dart, 

**Server:** Node, Express, mySql, Sequelize, Rest API



