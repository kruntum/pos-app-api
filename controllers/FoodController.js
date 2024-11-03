const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

module.exports = {
    upload: async (req, res) => {
        try {
            if (req.files != undefined) {
                const myFile = req.files.myFile;
                if (myFile != undefined) {
                    const fileName = myFile.name;

                    const fileExtension = fileName.split(".").pop();
                    const newFileName = new Date().getTime() + "." + fileExtension;
                    const path = "uploads/" + newFileName;
                    myFile.mv(path, async (err) => {
                        if (err) {
                            return res.status(500).send({ error: e.messge });
                        }
                        return res.send({ message: "success", fileName: newFileName });
                    });
                } else {
                    return res.status(500).send({ error: "No file uploaded" });
                }
            }
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    create: async (req, res) => {
        try {
            await prisma.food.create({
                data: {
                    foodTypeId: req.body.foodTypeId,
                    name: req.body.name,
                    remark: req.body.remark,
                    image: req.body.image,
                    price: req.body.price,
                    img: req.body.img,
                },
            });
            return res.send({ message: "success" });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },

    list: async (req, res) => {
        try {
            const rows = await prisma.food.findMany({
                include: {
                    FoodType: true,
                },
                where: {
                    status: "use",
                },
                orderBy: {
                    id: "desc",
                },
            });
            return res.send({ results: rows });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    /**
     * Get the first food with the given id.
     * @param {Request} req - The request object.
     * @param {Response} res - The response object.
     * @returns {Promise<void>}
     */
    first: async (req, res) => {
        try {
            const results = await prisma.food.findFirst({
                where: {
                    status: "use",
                    id: parseInt(req.params.id),
                },
                select: {
                    id: true,
                    img: true,
                    name: true,
                },
            });
            return res.send({ results: results });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    update: async (req, res) => {
        try {
            // remove old file in food
            const oldFood = await prisma.food.findUnique({
                where: {
                    id: req.body.id,
                },
            });
            if (oldFood.img != "") {
                if (req.body.img != "") {
                    const fs = require("fs");
                    fs.unlinkSync("uploads/" + oldFood.img);
                }
            }

            await prisma.food.update({
                data: {
                    foodTypeId: req.body.foodTypeId,
                    name: req.body.name,
                    remark: req.body.remark,
                    image: req.body.image,
                    price: req.body.price,
                    img: req.body.img,
                    foodType: req.body.foodType,
                },
                where: {
                    id: parseInt(req.body.id),
                },
            });
            return res.send({ message: "success" });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    remove: async (req, res) => {
        try {
            await prisma.food.update({
                data: {
                    status: "delete",
                },
                where: {
                    id: parseInt(req.params.id),
                },
            });
            return res.send({ message: "success" });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    filter: async (req, res) => {

        try {
            let conditon = {
                status: 'use',
            };
            if (req.params.foodType != 'all') {
                conditon.foodType = req.params.foodType;
            }
            const foods = await prisma.food.findMany({
                where: conditon,
                orderBy: {
                    id: "asc",
                },
            });
            return res.send({ results: foods });
        } catch (e) {
            return res.status(500).send({ error: e.message });
        }
    },
    paginate: async (req, res) => {
        try {
            const page = req.body.page;
            const itemsPerPage = req.body.itemsPerPage;
            const foods = await prisma.food.findMany({
                skip: (page - 1) * itemsPerPage,
                take: itemsPerPage,
                orderBy: {
                    id: 'desc'
                },
                where: {
                    status: 'use'
                }
            })
            const totalItems = await prisma.food.count({
                where: {
                    status: 'use'
                }
            })
            const totalPage = Math.ceil(totalItems / itemsPerPage);

            return res.send({ results: foods, totalItems: totalItems, totalPage: totalPage })
        } catch (e) {
            return res.status(500).send({ error: e.message })
        }
    }
};
