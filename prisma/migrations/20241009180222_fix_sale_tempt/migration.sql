/*
  Warnings:

  - You are about to drop the column `salTemptID` on the `SaleTempDetail` table. All the data in the column will be lost.
  - Added the required column `saleTemptID` to the `SaleTempDetail` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "SaleTempDetail" DROP CONSTRAINT "SaleTempDetail_salTemptID_fkey";

-- AlterTable
ALTER TABLE "SaleTempDetail" DROP COLUMN "salTemptID",
ADD COLUMN     "saleTemptID" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_saleTemptID_fkey" FOREIGN KEY ("saleTemptID") REFERENCES "SaleTemp"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
