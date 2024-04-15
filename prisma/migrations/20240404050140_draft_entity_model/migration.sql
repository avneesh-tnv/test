-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntity" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "entityCategory" TEXT,
    "entitySubCategory" TEXT DEFAULT '',
    "entityCountry" TEXT,
    "entityRegion" TEXT DEFAULT '',
    "entityLegalName" TEXT,
    "entityLegalNameInEn" TEXT,
    "registrationEntityId" TEXT DEFAULT '',
    "registrationAuthorityId" TEXT,
    "entityLegalFormCode" TEXT,
    "entityCreationDate" TEXT,
    "website" TEXT,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "haveDirectParent" BOOLEAN NOT NULL DEFAULT false,
    "haveUltimateParent" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "DraftEntity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntityDirectParent" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "leiNumber" TEXT,
    "accountingStandared" TEXT,
    "accountingStatus" TEXT,
    "AccountingStartDate" TEXT,
    "AccountingEndDate" TEXT,
    "percentageOwned" INTEGER,

    CONSTRAINT "DraftEntityDirectParent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftDirectRelationshipTimePeriod" (
    "id" SERIAL NOT NULL,
    "directParentId" INTEGER NOT NULL,
    "RelationshipStartDate" TEXT,
    "RelationshipEndDate" TEXT,
    "periodType" TEXT,

    CONSTRAINT "DraftDirectRelationshipTimePeriod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntityUltimateParent" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "leiNumber" TEXT,
    "accountingStatus" TEXT,
    "accountingStandared" TEXT,
    "percentageOwned" INTEGER,

    CONSTRAINT "DraftEntityUltimateParent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftUltimateRelationshipTimePeriod" (
    "id" SERIAL NOT NULL,
    "ultimateParentId" INTEGER NOT NULL,
    "startDate" TEXT,
    "endDate" TEXT,
    "periodType" TEXT,

    CONSTRAINT "DraftUltimateRelationshipTimePeriod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftOtherEntityNames" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "entityNameType" TEXT DEFAULT '',
    "entityName" TEXT DEFAULT '',

    CONSTRAINT "DraftOtherEntityNames_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntityLocalAddress" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "lane1" TEXT,
    "lane2" TEXT DEFAULT '',
    "lane3" TEXT DEFAULT '',
    "lane4" TEXT DEFAULT '',
    "city" TEXT,
    "country" TEXT,
    "region" TEXT,
    "postalCode" TEXT,

    CONSTRAINT "DraftEntityLocalAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntityHeadQuarterAddress" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "HQlane1" TEXT,
    "HQlane2" TEXT DEFAULT '',
    "HQlane3" TEXT DEFAULT '',
    "HQlane4" TEXT DEFAULT '',
    "HQcity" TEXT,
    "HQcountry" TEXT,
    "HQregion" TEXT DEFAULT '',
    "HQpostalCode" TEXT DEFAULT '',

    CONSTRAINT "DraftEntityHeadQuarterAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DraftEntityContact" (
    "id" SERIAL NOT NULL,
    "entityId" INTEGER NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "position" TEXT,
    "phone" TEXT,
    "email" TEXT,

    CONSTRAINT "DraftEntityContact_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "DraftEntity_entityId_key" ON "DraftEntity"("entityId");

-- AddForeignKey
ALTER TABLE "DraftEntityDirectParent" ADD CONSTRAINT "DraftEntityDirectParent_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftDirectRelationshipTimePeriod" ADD CONSTRAINT "DraftDirectRelationshipTimePeriod_directParentId_fkey" FOREIGN KEY ("directParentId") REFERENCES "DraftEntityDirectParent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftEntityUltimateParent" ADD CONSTRAINT "DraftEntityUltimateParent_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftUltimateRelationshipTimePeriod" ADD CONSTRAINT "DraftUltimateRelationshipTimePeriod_ultimateParentId_fkey" FOREIGN KEY ("ultimateParentId") REFERENCES "DraftEntityUltimateParent"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftOtherEntityNames" ADD CONSTRAINT "DraftOtherEntityNames_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftEntityLocalAddress" ADD CONSTRAINT "DraftEntityLocalAddress_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftEntityHeadQuarterAddress" ADD CONSTRAINT "DraftEntityHeadQuarterAddress_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftEntityContact" ADD CONSTRAINT "DraftEntityContact_entityId_fkey" FOREIGN KEY ("entityId") REFERENCES "DraftEntity"("entityId") ON DELETE RESTRICT ON UPDATE CASCADE;
