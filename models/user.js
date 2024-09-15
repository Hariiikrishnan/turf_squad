import mongoose from "mongoose";
import session from "express-session";
import passport from "passport";
import passportlocalmongoose from "passport-local-mongoose";
import express from "express";
import dotenv from "dotenv";

const app = express();
dotenv.config()

const userSchema = new mongoose.Schema({
    u_id:String,
    onesignal_id:String,
    avatarId:String,
    username:String,
    email:String,
    teams:Array,
    amountSpent:Number,
    timeSpent:Number,
  });
  userSchema.plugin(passportlocalmongoose);

const User = new mongoose.model("User", userSchema);

passport.use(User.createStrategy());

passport.serializeUser(function (user, done) {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    return done(null, await User.findById(id));
  } catch(error) {
    return done(error);
  }
});

app.use(
  session({
    secret: process.env.SECRETKEY,
    resave: false,
    saveUninitialized: false,
  })
);
app.use(passport.session());

export default User;
