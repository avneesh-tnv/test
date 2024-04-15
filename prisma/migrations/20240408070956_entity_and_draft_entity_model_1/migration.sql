/*
  Warnings:

  - Made the column `createdAt` on table `DraftEntity` required. This step will fail if there are existing NULL values in that column.
  - Made the column `firstName` on table `DraftEntityContact` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lastName` on table `DraftEntityContact` required. This step will fail if there are existing NULL values in that column.
  - Made the column `position` on table `DraftEntityContact` required. This step will fail if there are existing NULL values in that column.
  - Made the column `phone` on table `DraftEntityContact` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `DraftEntityContact` required. This step will fail if there are existing NULL values in that column.
  - Made the column `HQlane1` on table `DraftEntityHeadQuarterAddress` required. This step will fail if there are existing NULL values in that column.
  - Made the column `HQcity` on table `DraftEntityHeadQuarterAddress` required. This step will fail if there are existing NULL values in that column.
  - Made the column `HQcountry` on table `DraftEntityHeadQuarterAddress` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lane1` on table `DraftEntityLocalAddress` required. This step will fail if there are existing NULL values in that column.
  - Made the column `city` on table `DraftEntityLocalAddress` required. This step will fail if there are existing NULL values in that column.
  - Made the column `country` on table `DraftEntityLocalAddress` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "TokenType" AS ENUM ('ACCESS', 'REFRESH', 'RESET_PASSWORD', 'VERIFY_EMAIL');

-- AlterTable
ALTER TABLE "DraftEntity" ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "haveDirectParent" DROP NOT NULL,
ALTER COLUMN "haveUltimateParent" DROP NOT NULL;

-- AlterTable
ALTER TABLE "DraftEntityContact" ALTER COLUMN "firstName" SET NOT NULL,
ALTER COLUMN "lastName" SET NOT NULL,
ALTER COLUMN "position" SET NOT NULL,
ALTER COLUMN "phone" SET NOT NULL,
ALTER COLUMN "email" SET NOT NULL;

-- AlterTable
ALTER TABLE "DraftEntityDirectParent" ADD COLUMN     "haveLei" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "leiReason" TEXT DEFAULT '';

-- AlterTable
ALTER TABLE "DraftEntityHeadQuarterAddress" ALTER COLUMN "HQlane1" SET NOT NULL,
ALTER COLUMN "HQcity" SET NOT NULL,
ALTER COLUMN "HQcountry" SET NOT NULL;

-- AlterTable
ALTER TABLE "DraftEntityLocalAddress" ALTER COLUMN "lane1" SET NOT NULL,
ALTER COLUMN "city" SET NOT NULL,
ALTER COLUMN "country" SET NOT NULL;

-- AlterTable
ALTER TABLE "DraftEntityUltimateParent" ADD COLUMN     "haveLei" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "leiReason" TEXT DEFAULT '';

-- CreateTable
CREATE TABLE "Entity" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "entityCategory" TEXT NOT NULL,
    "entitySubCategory" TEXT NOT NULL DEFAULT '',
    "entityCountry" TEXT NOT NULL,
    "entityRegion" TEXT NOT NULL DEFAULT '',
    "entityLegalName" TEXT NOT NULL,
    "entityLegalNameInEn" TEXT NOT NULL,
    "registrationEntityId" TEXT NOT NULL DEFAULT '',
    "registrationAuthorityId" TEXT NOT NULL,
    "entityLegalFormCode" TEXT NOT NULL,
    "entityCreationDate" TEXT NOT NULL,
    "website" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "haveDirectParent" BOOLEAN NOT NULL DEFAULT false,
    "haveUltimateParent" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Entity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityDirectParent" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "leiNumber" TEXT,
    "accountingStandared" TEXT,
    "accountingStatus" TEXT,
    "AccountingStartDate" TEXT,
    "AccountingEndDate" TEXT,
    "percentageOwned" INTEGER,
    "haveLei" BOOLEAN NOT NULL DEFAULT false,
    "leiReason" TEXT DEFAULT '',

    CONSTRAINT "EntityDirectParent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DirectRelationshipTimePeriod" (
    "id" SERIAL NOT NULL,
    "directParentId" INTEGER NOT NULL,
    "RelationshipStartDate" TEXT NOT NULL,
    "RelationshipEndDate" TEXT,
    "periodType" TEXT,

    CONSTRAINT "DirectRelationshipTimePeriod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityUltimateParent" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "leiNumber" TEXT,
    "accountingStatus" TEXT,
    "accountingStandared" TEXT,
    "percentageOwned" INTEGER,
    "haveLei" BOOLEAN NOT NULL DEFAULT false,
    "leiReason" TEXT DEFAULT '',

    CONSTRAINT "EntityUltimateParent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UltimateRelationshipTimePeriod" (
    "id" SERIAL NOT NULL,
    "ultimateParentId" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL,
    "endDate" TEXT,
    "periodType" TEXT,

    CONSTRAINT "UltimateRelationshipTimePeriod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OtherEntityNames" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "entityNameType" TEXT DEFAULT '',
    "entityName" TEXT DEFAULT '',

    CONSTRAINT "OtherEntityNames_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityLocalAddress" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "lane1" TEXT NOT NULL,
    "lane2" TEXT DEFAULT '',
    "lane3" TEXT DEFAULT '',
    "lane4" TEXT DEFAULT '',
    "city" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "region" TEXT,
    "postalCode" TEXT,

    CONSTRAINT "EntityLocalAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityHeadQuarterAddress" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "HQlane1" TEXT NOT NULL,
    "HQlane2" TEXT DEFAULT '',
    "HQlane3" TEXT DEFAULT '',
    "HQlane4" TEXT DEFAULT '',
    "HQcity" TEXT NOT NULL,
    "HQcountry" TEXT NOT NULL,
    "HQregion" TEXT DEFAULT '',
    "HQpostalCode" TEXT DEFAULT '',

    CONSTRAINT "EntityHeadQuarterAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityContact" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "EntityContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegistrationAuthority" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "RegistrationAuthority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LegalForm" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "country_code" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "LegalForm_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Country" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "iso_code" TEXT NOT NULL,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "State" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iso_code" TEXT NOT NULL,

    CONSTRAINT "State_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Token" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "type" "TokenType" NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "blacklisted" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Token_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Entity_entityId_key" ON "Entity"("entityId");

-- CreateIndex
CREATE UNIQUE INDEX "RegistrationAuthority_code_key" ON "RegistrationAuthority"("code");

-- CreateIndex
CREATE UNIQUE INDEX "LegalForm_code_key" ON "LegalForm"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Country_iso_code_key" ON "Country"("iso_code");

-- CreateIndex
CREATE UNIQUE INDEX "State_value_key" ON "State"("value");

-- AddForeignKey
ALTER TABLE "EntityDirectParent" ADD CONSTRAINT "EntityDirectParent_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DirectRelationshipTimePeriod" ADD CONSTRAINT "DirectRelationshipTimePeriod_directParentId_fkey" FOREIGN KEY ("directParentId") REFERENCES "EntityDirectParent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntityUltimateParent" ADD CONSTRAINT "EntityUltimateParent_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UltimateRelationshipTimePeriod" ADD CONSTRAINT "UltimateRelationshipTimePeriod_ultimateParentId_fkey" FOREIGN KEY ("ultimateParentId") REFERENCES "EntityUltimateParent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OtherEntityNames" ADD CONSTRAINT "OtherEntityNames_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntityLocalAddress" ADD CONSTRAINT "EntityLocalAddress_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntityHeadQuarterAddress" ADD CONSTRAINT "EntityHeadQuarterAddress_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EntityContact" ADD CONSTRAINT "EntityContact_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "Entity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "State" ADD CONSTRAINT "State_iso_code_fkey" FOREIGN KEY ("iso_code") REFERENCES "Country"("iso_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Token" ADD CONSTRAINT "Token_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
