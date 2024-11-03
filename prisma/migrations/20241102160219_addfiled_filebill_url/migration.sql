/*
  Warnings:

  - You are about to drop the column `filebillUrl` on the `BillSaleDetail` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "BillSale" ADD COLUMN     "filebillUrl" TEXT;

-- AlterTable
ALTER TABLE "BillSaleDetail" DROP COLUMN "filebillUrl";
