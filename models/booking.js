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



// t_id : Turf ID 
// b_id : Booking ID
// u_id : User ID 


const bookingSchema = new mongoose.Schema({
    t_id:String,
    b_id:String,
    u_id:String,
    slotNo:Number,
    timeSlot:String,
    date:String,
    playersCount:Number,
    bookedTime:String,
    paid:Boolean,
    payment_id:String,
  });



  const Booking = new mongoose.model("Booking",bookingSchema);

  export default Booking;