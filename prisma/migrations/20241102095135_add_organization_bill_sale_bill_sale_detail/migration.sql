-- CreateTable
CREATE TABLE "Organization" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "website" TEXT NOT NULL,
    "promptpay" TEXT NOT NULL,
    "logo" TEXT NOT NULL,
    "taxCode" TEXT NOT NULL,

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BillSale" (
    "id" SERIAL NOT NULL,
    "createdDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "amount" INTEGER NOT NULL,
    "payType" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "inputMoney" INTEGER NOT NULL,
    "returnMoney" INTEGER NOT NULL,
    "tableNo" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',

    CONSTRAINT "BillSale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BillSaleDetail" (
    "id" SERIAL NOT NULL,
    "billSaleId" INTEGER NOT NULL,
    "foodId" INTEGER NOT NULL,
    "tasteId" INTEGER,
    "foodSizeId" INTEGER,
    "moneyAdded" INTEGER,
    "price" INTEGER,

    CONSTRAINT "BillSaleDetail_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "BillSale" ADD CONSTRAINT "BillSale_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_billSaleId_fkey" FOREIGN KEY ("billSaleId") REFERENCES "BillSale"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_foodSizeId_fkey" FOREIGN KEY ("foodSizeId") REFERENCES "FoodSize"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_tasteId_fkey" FOREIGN KEY ("tasteId") REFERENCES "Taste"("id") ON DELETE SET NULL ON UPDATE CASCADE;
