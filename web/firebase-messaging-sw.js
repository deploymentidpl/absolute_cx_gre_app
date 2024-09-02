importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


  const firebaseConfig = {
    apiKey: "AIzaSyD2AmNONwTDGmBTLyx6wWa8wp1R1T5m5_A",
    authDomain: "absolutecxgre.firebaseapp.com",
    projectId: "absolutecxgre",
    storageBucket: "absolutecxgre.appspot.com",
    messagingSenderId: "268320364455",
    appId: "1:268320364455:web:4779ceaab7ce5d471d0882",
    measurementId: "G-CXDKR61EQE"
  };
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
//messaging.onBackgroundMessage((message) => {
//  console.log("onBackgroundMessage", message);
//});