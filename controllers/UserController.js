const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const { status } = require("express/lib/response");
dotenv.config();

module.exports = {
    signIn: async (req, res) => {
        try {
            const u = req.body.username;
            const p = req.body.password;
            const user = await prisma.user.findFirst({
                select: {
                    id: true,
                    name: true,
                    username: true,
                    level: true,
                    status: true,
                },
                where: {
                    username: u,
                    password: p,
                    status: "use",
                },
            });
            if (user != null) {
                const key = process.env.SECRET_KEY;
                const token = jwt.sign({ user }, key, {
                    expiresIn: "1D",
                });
                res.json({
                    token: token,
                    level: user.level,
                    name: user.name,
                    id: user.id,
                    username: user.username,
                    status: user.status,
                });
            } else {
                res.json({
                    token: undefined,
                    level: undefined,
                    name: undefined,
                    id: undefined,
                    username: undefined,
                    status: undefined,
                });
            }
        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: error.message });
        }
    },
    create: async (req, res) => {
        try {
            await prisma.user.create({
                data: {
                    name: req.body.name,
                    username: req.body.username,
                    password: req.body.password,
                    level: req.body.level
                }
            });

            return res.send({ message: 'success' });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    list: async (req, res) => {
        try {
            const users = await prisma.user.findMany({
                select: {
                    id: true,
                    name: true,
                    username: true,
                    level: true
                },
                where: {
                    status: 'use'
                },
                orderBy: {
                    id: 'asc'
                }
            });

            return res.send({ results: users });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    update: async (req, res) => {
        try {
            await prisma.user.update({
                where: {
                    id: req.body.id
                },
                data: {
                    name: req.body.name,
                    username: req.body.username,
                    level: req.body.level
                }
            });

            return res.send({ message: 'success' });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    remove: async (req, res) => {
        try {
            await prisma.user.update({
                where: {
                    id: parseInt(req.params.id)
                },
                data: {
                    status: 'delete'
                }
            });

            return res.send({ message: 'success' });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    getLevelByToken: async (req, res) => {
        try {
            const token = req.headers.authorization.split(' ')[1];
            const user = jwt.verify(token, process.env.SECRET_KEY);

            return res.send({ level: user.user.level });

        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
};
