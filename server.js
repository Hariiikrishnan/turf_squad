import express, { response } from "express";
import bodyParser from "body-parser";
import { v4 as uuidv4 } from "uuid";
import dotenv from "dotenv";

import connectDB from './config/db.js'

import Turf from "./models/turf.js";
import Booking from "./models/booking.js";
import User from "./models/user.js";
import Team from "./models/team.js";


import passport from "passport";
import session from "express-session";
import jwt from "jsonwebtoken";
import https from "https";

const app = express();

dotenv.config();
connectDB();
app.use(express.static("public"));
app.set("view engine","ejs");
app.use(bodyParser.urlencoded({extended:true}));



app.use(express.json());

app.use(passport.initialize());
app.use(session({
    secret:process.env.SECRETKEY ,
    resave:false,
    saveUninitialized:false
  }));
app.use(passport.session());

app.get("/",(req,res)=>{
    res.send("Hello");
})


app.get("/turfs",(req,res)=>{
    Turf.find({}).then((turfs)=>{
        res.json({data:turfs});
    })
});
app.get("/turfsByGame/:u_id/:game_name",(req,res)=>{
    Turf.find({games_allowed:req.params.game_name}).then((turfs)=>{
        res.json({msg:"Success",data:turfs});
    }).catch((error)=>{
        console.log(error);
    })
});


app.get("/addTurf",(req,res)=>{
    const turf = new Turf({
        t_id:uuidv4(),
        name:"Turf 360",
        length:270,
        breadth:150,
        games_allowed:["Football","Cricket"],
        max_slot:14,
        starting_time:"8 AM"
    });

    console.log(turf);

    turf.save().then((booked)=>{
        res.json({msg:"Success",turf:booked});
    }).catch((err)=>{
        console.log(err);
    })
});


app.post("/booking/:turf_name/:u_id",(req,res)=>{
    const turf_name = req.params.turf_name;
    const u_id = req.params.u_id;

    var time = new Date().toLocaleString();
    const { timeSlot , paid , payment_id , slot_no , date , playersCount } = req.body ;

    console.log(time);

    const booking = new Booking({
        b_id:uuidv4(),
        turf_name:turf_name,
        u_id:u_id,
        date:date,
        slotNo:slot_no,
        timeSlot : timeSlot,
        bookedTime:time,
        playersCount:playersCount,
        paid : paid,
        payment_id : payment_id,
    });

    console.log(booking);
    console.log(req.body.players);
    

    // req.body.players.forEach((player)=>{
    //     player_one_ids.push(player.onesignal_id);
    // })

    booking.save().then((booked)=>{

        sendNotificationToDevice(req.body.players);

        res.json({msg:"Success",data:booked});
    }).catch((err)=>{
        console.log(err);
    })

    // res.json({time});
})

app.get("/getBooked/:t_id/:date",(req,res)=>{
    console.log(req.params.t_id);
    Booking.find({t_id:req.params.t_id,date:req.params.date}).then((booked)=>{
        console.log(booked);
        if(booked!=null && booked !=undefined && booked.length != 0 ){
            res.json({msg:"Success",data:booked})
        }else{
            res.json({msg:"Data Not Found"})
        }
   }).catch((err)=>{
    console.log(er);
   });
});

app.get("/getByGame/:game_name",(req,res)=>{
    Turf.find({games_allowed:req.params.game_name}).then((turfs)=>{
        console.log(turfs);
        if(turfs!=null && turfs !=undefined && turfs.length != 0 ){
            res.json({msg:"Success",data:turfs})
        }else{
            res.json({msg:"Data Not Found"})
        }
   }).catch((err)=>{
    console.log(err);
   });
});


app.get("/punchOut/:u_id",(req,res)=>{
    User.findOneAndUpdate(
        {u_id:req.params.u_id}, 
        {$inc:{timeSpent:1}},
        { new: true, useFindAndModify: false }).then((savedUser)=>{
            console.log(savedUser);
            res.json({msg:"Success",user:savedUser})
        }).catch((err)=>{
            console.log(err);
        })
});



app.post("/login",(req,res)=>{
    

    const username = req.body.username;
    const password = req.body.password;
    const user = new User({
        username: username,
        password: password,
    });
    
    req.login(user, async function (err) {
        if (err) {
            console.log(err);
            res.sendStatus(500);
            return;
        } else {
            await passport.authenticate("local")(req, res,function () {
                var accessToken = jwt.sign({ user }, process.env.SECRETKEY,{expiresIn:"365d"});
                //   var refreshToken = jwt.sign({ user }, process.env.REFRESH_TOKEN_SECRETKEY, {expiresIn:"10d"});
                User.findOne({username:username}).then((userCreds)=>{
                    
                    // console.log("Enna da aachu");
                    console.log(userCreds);
                    res.json({ token: accessToken, user: userCreds });
                }).catch((error)=>{
                    console.log(error);
                });
                
            });
      }
    });
});


app.post("/register",(req,res)=>{
    console.log(req.body);
    // var avatarId ="avatar"+ Math.round(Math.random() * 5 );
    User.register(
        { u_id: uuidv4(), 
            username:req.body.username,
        email:req.body.email,
        amountSpent:0,
        timeSpent:0,
        onesignal_id:req.body.onesignal_id,
        teams:[],
    },
        req.body.password,
        function (err, user) {
          if (err) {
            console.log(err);
            res.sendStatus(500);
            return;
          } else {
            passport.authenticate("local")(req, res, function () {
              jwt.sign({ user }, process.env.SECRETKEY, (err, token) => {
                res.json({ token: token, user: user });
              });
            });
          }
        }
      );
})

app.get("/teams/:u_id",(req,res)=>{
    User.find({u_id:req.params.u_id}).then((user)=>{

    // print(user);
    console.log(user[0].teams);
    Team.find({team_id:user[0].teams}).then((teams)=>{
        console.log(teams);
        if(teams!=null && teams !=undefined && teams.length != 0 ){
            res.json({msg:"Success",data:teams})
        }else{
            res.json({msg:"Data Not Found"})
        }
   }).catch((err)=>{
    console.log(err);
   });
}).catch((error)=>{
console.log(error);
});
});


app.post("/addTeam/:u_id",(req,res)=>{
    const team = new Team({
        team_id:uuidv4(),
        name:req.body.team_name,
        players:[
            {
                id:req.params.u_id,
            }
        ]  
    });

    User.findOneAndUpdate({u_id:req.params.u_id},  
        { $push:{ teams: team.team_id, } },
        { new: true, useFindAndModify: false },).then((savedUser2)=>{
            // console.log(savedUser2);
            team.players[0]['name'] = savedUser2.username;
            team.short_id = parseInt(team.team_id, 16);
            team.players[0]['onesignal_id'] = savedUser2.onesignal_id,
            
            console.log(team);
    team.save().then((teamAdded)=>{

    
            
            res.json({msg:"Success",team:teamAdded})
      

        // res.json({msg:"Success",team:teamAdded});
    }).catch((err)=>{
        console.log(err);
    })
}).catch((error)=>{
    console.log(error);
});

});

app.post("/addPlayer/:short_id/:u_id", (req,res)=>{
    var teamPlayers;
    // console.log(req.params.team_id);

    // Team.findOne({
    //     team_id:req.params.team_id,
    //     // players:req.params.u_id,
    // }).then((team)=>{
    //     console.log(team);
    //     if(team!=null){
    //         res.json({msg:"Success",team:team});
    //     }else{
    //         res.json({msg:"Sorry",team:team});
    //     }
    // }).catch((err)=>{
    //     console.log(err);
    // })

     Team.findOne({short_id:req.params.short_id}).then((team)=>{
        // console.log(team);
        teamPlayers = team.players;
   console.log(team);
   if(team.players.length < 5){
       
       console.log(team.players);
        console.log(team.players.includes(req.params.u_id));
        if(team.players.includes(req.params.u_id)){
            res.json({msg:"Failed",desc:"You're Already in the Squad"});
        }else{
            console.log(team.team_id);
            User.findOneAndUpdate({u_id:req.params.u_id},  
                { $push:{ teams: team.team_id } },
            { new: true, useFindAndModify: false },).then((savedUser2)=>{
                console.log(savedUser2);


            Team.findOneAndUpdate({short_id:req.params.short_id},  
                { $push:{ players: {id:req.params.u_id,name:savedUser2.username,onesignal_id:savedUser2.onesignal_id} } },
            { new: true, useFindAndModify: false },).then((savedTeam)=>{
                console.log(savedTeam);

                res.json({msg:"Success",team:savedTeam})
            }).catch((err)=>{
                console.log(err);
            });
        }).catch((error)=>{
            console.log(error);
        });
        }

    }
    else{
        res.json({msg:"Failed",desc:"Squad is Already filled!"});
          
    }
}).catch((err2)=>{
    console.log(err2);
})
});


    
   

// app.get("/byTeams/:u_id",(req,res)=>{

//     Team.find({players})
// });

app.get("/teamPlayers/:team_id/:u_id",(req,res)=>{

    var playerIds = [] ;
    Team.findOne({team_id:req.params.team_id}).then((team)=>{
        console.log(team);
        // console.log(team.players);
        team.players.forEach((player)=>{
            playerIds.push(player.id);
        })
    
        console.log(playerIds);
    User.find({u_id:playerIds}).then((players)=>{
        console.log(players);
        if(players.length!=0){
            res.json({msg:"Success",data:players});
        }else{
            res.json({msg:"Data Not Found!"});
        }
    }).catch((err)=>{
        console.log(err);
    })
}).catch((err)=>{
    console.log(err);
});
});


app.post("/allTeamPlayers/:u_id",(req,res)=>{
    var allPlayeIds = [] ;
    var playerIds = [] ;
    var playersAndteams = [];


    





    Team.find({team_id:req.body.teams}).then((teams)=>{
        console.log(teams);
        // teams.forEach((eachTeam,index)=>{
        //     var obj = {};
        //      obj['team_name'] = eachTeam.name;
        //      obj['players'] = eachTeam
        //     playersAndteams.push(obj);
        // });
         res.json({msg:"Success",data:teams});
        // console.log(playersAndteams);
    }).catch((err)=>{
        console.log(err);
    })
    // res.json({msg:"Success",data:players});
});


app.get("/sendNotification",(req,response)=>{
    // function sendNotification(){

        var headers = {
            "Content-Type" : "application/json; charset=utf-8",
            // "Content-Type": "application/json",
        "Authorization":"Basic " + process.env.ONE_API_KEY
    };
    var options = {
        host:"onesignal.com",
        port:443,
        path:"/api/v1/notifications",
        method:"POST",
        headers:headers,
    };
    
    var message = {
        app_id:process.env.APP_ID,
        contents:{
            en:"Test Notifications",
            
        },
        included_segments:["All"],
        content_available:true,
        small_icon:"ic_notification_icon",
        data:{
            pushTitle:"CUSTOM_NOTIFICATION",
        },
        
    };
    
    
    var req = https.request(
        options,
        function(res){
            res.on("data",function(data){
                console.log(JSON.parse(data));
                
                // response.json({msg:"Success",data:JSON.parse(data)});
                return callback(null,JSON.parse(data));
            })
        }
    );
    req.on("error",(function(err){
        console.log(err);
    }))
    
    req.write(JSON.stringify(message));
    
    req.end();
    
    function callback(error,results){
        if(error){
            console.log(error);
        }
        else{
            response.status(200).send({
                msg:"Success",
                data:results,
            });
        }
    }
    })
// }


// app.get("/sendNotificationToDevice/:u_id",(req,response)=>{

    function sendNotificationToDevice(players){

   
    var headers = {
        "Content-Type" : "application/json; charset=utf-8",
        // "Content-Type": "application/json",
        "Authorization":"Basic " + process.env.ONE_API_KEY
    };
    var options = {
        host:"onesignal.com",
        port:443,
        path:"/api/v1/notifications",
        method:"POST",
        headers:headers,
    };

    var message = {
        app_id:process.env.APP_ID,
        contents:{
            en:"Test Notifications for Specific user",

        },
        included_segments:["include_player_ids"],
        include_player_ids:players,
        content_available:true,
        small_icon:"ic_notification_icon",
        data:{
            pushTitle:"CUSTOM_NOTIFICATION",
        },

    };


    var req = https.request(
        options,
        function(res){
            res.on("data",function(data){
                console.log(JSON.parse(data));

                // response.json({msg:"Success",data:JSON.parse(data)});
                return callback(null,JSON.parse(data));
                        })
        }
    );
    req.on("error",(function(err){
        console.log(err);
    }))
    
    req.write(JSON.stringify(message));

    req.end();

    function callback(error,results){
        if(error){
            console.log(error);
        }
        else{
           console.log("Notification Sent Succesfully");
        }
    }
// })
}


app.listen(3000,()=>{
    
    console.log("Server started at 3000");
})