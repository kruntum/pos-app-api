/*
  Warnings:

  - You are about to drop the column `saleTemptID` on the `SaleTempDetail` table. All the data in the column will be lost.
  - Added the required column `saleTempId` to the `SaleTempDetail` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "SaleTempDetail" DROP CONSTRAINT "SaleTempDetail_saleTemptID_fkey";

-- DropIndex
DROP INDEX "User_username_key";

-- AlterTable
ALTER TABLE "FoodType" ALTER COLUMN "remark" DROP NOT NULL;

-- AlterTable
ALTER TABLE "SaleTempDetail" DROP COLUMN "saleTemptID",
ADD COLUMN     "saleTempId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_saleTempId_fkey" FOREIGN KEY ("saleTempId") REFERENCES "SaleTemp"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
