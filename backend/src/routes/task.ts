import { Router } from "express";
import { auth, AuthRequest } from "../middleware/auth";
import { error } from "console";
import { db } from "../db";
import { tasks, NewTask } from "../db/schema";
import { eq } from "drizzle-orm";

const taskRouter = Router();

taskRouter.post("/", auth, async (req: AuthRequest, res) => {
  try {
    req.body = { ...req.body, uid: req.user };
    const newTask: NewTask = req.body;
    const [task] = await db.insert(tasks).values(newTask).returning();
    res.status(201).json(task);
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

taskRouter.get("/", auth, async (req: AuthRequest, res) => {
  try {
    const allTasks = await db
      .select()
      .from(tasks)
      .where(eq(tasks.uid, req.user!));
    res.status(200).json(allTasks);
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

taskRouter.delete("/:id", auth, async (req: AuthRequest, res) => {
  try {
    const { taskId }: { taskId: string } = req.body;
    await db.delete(tasks).where(eq(tasks.id, taskId));
    res.status(204).send();
  } catch (e) {
    res.status(500).json({ error: e });
  }
});

export default taskRouter;
