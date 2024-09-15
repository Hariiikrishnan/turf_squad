import mongoose from 'mongoose';

// const subSchema = new mongoose.Schema({
//   name:String,
//   lat:String,
//   lng:String,
// });
// const timeSchema = new mongoose.Schema({
//   from:String,
//   to:String,
// });

const turfSchema = new mongoose.Schema({
    t_id:String,
    name:String,
    length:Number,
    breadth:Number,
    games_allowed:Array,
    max_slot:Number,
    starting_time:String,
  }); 



  const Turf = new mongoose.model("Turf",turfSchema);

  export default Turf;