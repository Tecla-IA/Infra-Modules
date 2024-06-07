const express = require("express");
const app = express();

// Set the view engine to EJS
app.set("view engine", "ejs");

// Define a route to render the current time
app.get("/", (req, res) => {
  const currentTime = new Date();
  res.render("index", { time: currentTime });
});

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
