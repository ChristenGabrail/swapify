const express = require('express');
const dotenv = require('dotenv'); // for config file and environment variables
const morgan = require('morgan'); // for middleware to log requests
const http = require('http');
const cors = require('cors');
const socketIo = require('socket.io');

// Load environment variables from config file
dotenv.config({ path: 'config.env' });

// Initialize Express app
const app = express();

// Serve static files
app.use("/Uploads", express.static('Uploads'));
app.use("/uploadsCategories", express.static('uploadsCategories'));
app.use("/uploadsUsers", express.static('uploadsUsers'));

// Create HTTP server
const server = http.createServer(app);

// Set up Socket.io with CORS configuration
const io = socketIo(server, {
  cors: {
    origin: "*"
  }
});

// Import database connection and routes
const dbConnection = require('./config/database');
const categoryRoute = require('./Routes/categoreyRouts');
const itemRoute = require('./Routes/itemRoute');
const UserRoute = require('./Routes/userRouts');
const ChatsRoute = require('./Routes/chatRoute');
const AdminRoute = require('./Routes/AdminRoute');
const statisticsRoute = require('./Routes/statisticsRoute');
const RequestsRoute = require('./Routes/RequestsRoute');

// Import models
const Cart = require('./modules/CartModel');
const User = require('./modules/UserModel');
const Favorite = require('./modules/FavouritesModel');
const Payment = require('./modules/PaymentModel');
const Transaction = require('./modules/TransactionModel');

// Connect to the database
dbConnection();

// Middleware
app.use(express.json()); // Parse JSON bodies
app.use(cors()); // Enable CORS

// Handle socket connections
io.on('connection', (socket) => {
  console.log('A user connected');

  // Handle chat messages
  socket.on('chat message', (msg) => {
    console.log('message: ' + msg);

    // Broadcast the message to all connected clients
    io.emit('chat message', msg);
  });

  // Handle disconnections
  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

// Use morgan middleware for logging in development mode
if (process.env.Node_ENV === 'development') {
  app.use(morgan('dev'));
  console.log(`mode: ${process.env.Node_ENV}`);
}

// Define routes
app.use('/categories', categoryRoute);
app.use('/item', itemRoute);
app.use('/User', UserRoute);
app.use('/Request', RequestsRoute);
app.use('/chat', ChatsRoute);
app.use('/Admin', AdminRoute);
app.use('/Stat', statisticsRoute);

// Start the server
const PORT = process.env.PORT || 8000;
server.listen(PORT, () => {
  console.log(`Server is running on ${PORT}`);
});
// Export io for use in other modules
module.exports = { io };