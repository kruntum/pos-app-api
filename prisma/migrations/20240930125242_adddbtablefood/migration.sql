-- CreateTable
CREATE TABLE "FoodType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "remark" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',

    CONSTRAINT "FoodType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FoodSize" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "remark" TEXT NOT NULL,
    "foodTypeId" INTEGER NOT NULL,
    "moneyAdded" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',

    CONSTRAINT "FoodSize_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Taste" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "remark" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',
    "foodTypeId" INTEGER NOT NULL,

    CONSTRAINT "Taste_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Food" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "remark" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',
    "price" INTEGER NOT NULL,
    "foodType" TEXT NOT NULL DEFAULT 'food',
    "foodTypeId" INTEGER NOT NULL,

    CONSTRAINT "Food_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "FoodSize" ADD CONSTRAINT "FoodSize_foodTypeId_fkey" FOREIGN KEY ("foodTypeId") REFERENCES "FoodType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Taste" ADD CONSTRAINT "Taste_foodTypeId_fkey" FOREIGN KEY ("foodTypeId") REFERENCES "FoodType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Food" ADD CONSTRAINT "Food_foodTypeId_fkey" FOREIGN KEY ("foodTypeId") REFERENCES "FoodType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
