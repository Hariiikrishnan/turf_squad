import mongoose from 'mongoose';

const teamSchema = new mongoose.Schema({
    team_id:String,
    short_id:Number,
    players:{
        type:[{
            id:String,
            name:String,
            onesignal_id:String,
        }],
        // unique: true,
        // cxcxrtfc c c x
        // validate: [(val) => val.length < 5, 'Must have minimum two options']
        // validate: {
        //     validator: function(v,x,z) {
        //         return !(this.players.length > 5);  
        //     }, 
        //     message: props => `${props.value} exceeds maximum array size (10)!`
        //   },
    },
    name:String,
  });



  const Team = new mongoose.model("Team",teamSchema);

 

  export default Team;