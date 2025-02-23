import express from "express";
import authRouter from "./routes/auth";
import "dotenv/config";
import taskRouter from "./routes/task";

const app = express();
const port = process.env.PORT || 8000;

// Middleware to parse JSON bodies
app.use(express.json());

// Routes
app.use("/auth", authRouter);
app.use("/tasks", taskRouter);
app.get("/", (req, res) => {
  res.send("Hello World");
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
