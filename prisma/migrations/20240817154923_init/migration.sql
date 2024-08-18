/*
  Warnings:

  - The `status` column on the `comment` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `post` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `report` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `AdBanner` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `adminAction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `adminBlock` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `authCode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `commentLike` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `postTag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `postView` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `socialLogin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userBlock` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `media_type` on the `media` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `type` on the `post` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `target_type` on the `report` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "ad_banner_status" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "report_target_type" AS ENUM ('POST', 'COMMENT', 'USER');

-- CreateEnum
CREATE TYPE "report_status" AS ENUM ('PENDING', 'RESOLVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "post_type" AS ENUM ('GENERAL', 'COLUMN', 'QUESTION');

-- CreateEnum
CREATE TYPE "sort_type" AS ENUM ('LATEST', 'POPULAR');

-- CreateEnum
CREATE TYPE "post_status" AS ENUM ('PUBLIC', 'DRAFT', 'DELETED');

-- CreateEnum
CREATE TYPE "media_type" AS ENUM ('IMAGE', 'VIDEO');

-- CreateEnum
CREATE TYPE "comment_status" AS ENUM ('PUBLIC', 'DELETED');

-- CreateEnum
CREATE TYPE "target_type" AS ENUM ('POST', 'COMMENT');

-- CreateEnum
CREATE TYPE "action_type" AS ENUM ('DELETE');

-- CreateEnum
CREATE TYPE "bet_direction" AS ENUM ('UP', 'DOWN');

-- CreateEnum
CREATE TYPE "bet_status" AS ENUM ('OPEN', 'WON', 'LOST', 'CANCELLED');

-- DropForeignKey
ALTER TABLE "adminAction" DROP CONSTRAINT "adminAction_admin_user_id_fkey";

-- DropForeignKey
ALTER TABLE "adminBlock" DROP CONSTRAINT "adminBlock_admin_id_fkey";

-- DropForeignKey
ALTER TABLE "adminBlock" DROP CONSTRAINT "adminBlock_blocked_user_id_fkey";

-- DropForeignKey
ALTER TABLE "authCode" DROP CONSTRAINT "authCode_user_id_fkey";

-- DropForeignKey
ALTER TABLE "commentLike" DROP CONSTRAINT "commentLike_comment_id_fkey";

-- DropForeignKey
ALTER TABLE "commentLike" DROP CONSTRAINT "commentLike_user_id_fkey";

-- DropForeignKey
ALTER TABLE "postTag" DROP CONSTRAINT "postTag_post_id_fkey";

-- DropForeignKey
ALTER TABLE "postTag" DROP CONSTRAINT "postTag_tag_id_fkey";

-- DropForeignKey
ALTER TABLE "postView" DROP CONSTRAINT "postView_post_id_fkey";

-- DropForeignKey
ALTER TABLE "socialLogin" DROP CONSTRAINT "socialLogin_user_id_fkey";

-- DropForeignKey
ALTER TABLE "userBlock" DROP CONSTRAINT "userBlock_blocked_id_fkey";

-- DropForeignKey
ALTER TABLE "userBlock" DROP CONSTRAINT "userBlock_blocker_id_fkey";

-- AlterTable
ALTER TABLE "comment" DROP COLUMN "status",
ADD COLUMN     "status" "comment_status" NOT NULL DEFAULT 'PUBLIC';

-- AlterTable
ALTER TABLE "media" DROP COLUMN "media_type",
ADD COLUMN     "media_type" "media_type" NOT NULL;

-- AlterTable
ALTER TABLE "point" ADD COLUMN     "is_bet" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "related_bet_id" INTEGER;

-- AlterTable
ALTER TABLE "post" DROP COLUMN "type",
ADD COLUMN     "type" "post_type" NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" "post_status" NOT NULL DEFAULT 'PUBLIC';

-- AlterTable
ALTER TABLE "report" DROP COLUMN "status",
ADD COLUMN     "status" "report_status" NOT NULL DEFAULT 'PENDING',
DROP COLUMN "target_type",
ADD COLUMN     "target_type" "report_target_type" NOT NULL;

-- DropTable
DROP TABLE "AdBanner";

-- DropTable
DROP TABLE "adminAction";

-- DropTable
DROP TABLE "adminBlock";

-- DropTable
DROP TABLE "authCode";

-- DropTable
DROP TABLE "commentLike";

-- DropTable
DROP TABLE "postTag";

-- DropTable
DROP TABLE "postView";

-- DropTable
DROP TABLE "socialLogin";

-- DropTable
DROP TABLE "userBlock";

-- DropEnum
DROP TYPE "AdBannerStatus";

-- DropEnum
DROP TYPE "actionType";

-- DropEnum
DROP TYPE "commentStatus";

-- DropEnum
DROP TYPE "mediaType";

-- DropEnum
DROP TYPE "postStatus";

-- DropEnum
DROP TYPE "postType";

-- DropEnum
DROP TYPE "reportStatus";

-- DropEnum
DROP TYPE "reportTargetType";

-- DropEnum
DROP TYPE "sortType";

-- DropEnum
DROP TYPE "targetType";

-- CreateTable
CREATE TABLE "ad_banner" (
    "id" SERIAL NOT NULL,
    "position" TEXT NOT NULL,
    "company_name" TEXT NOT NULL,
    "contract_period" INTEGER NOT NULL,
    "contract_date" TIMESTAMP(3) NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "image_url" TEXT NOT NULL,
    "status" "ad_banner_status" NOT NULL DEFAULT 'INACTIVE',
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "ad_banner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_login" (
    "social_login_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "provider" "provider" NOT NULL,
    "provider_user_id" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "social_login_pkey" PRIMARY KEY ("social_login_id")
);

-- CreateTable
CREATE TABLE "auth_code" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "code" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "koreaant_code" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "expired_at" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "auth_code_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comment_like" (
    "comment_like_id" SERIAL NOT NULL,
    "comment_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "liked_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "comment_like_pkey" PRIMARY KEY ("comment_like_id")
);

-- CreateTable
CREATE TABLE "post_tag" (
    "post_tag_id" SERIAL NOT NULL,
    "post_id" INTEGER NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "post_tag_pkey" PRIMARY KEY ("post_tag_id")
);

-- CreateTable
CREATE TABLE "post_view" (
    "post_view_id" SERIAL NOT NULL,
    "post_id" INTEGER NOT NULL,
    "ip_address" VARCHAR(45) NOT NULL,
    "viewed_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "post_view_pkey" PRIMARY KEY ("post_view_id")
);

-- CreateTable
CREATE TABLE "admin_action" (
    "action_id" SERIAL NOT NULL,
    "admin_user_id" INTEGER NOT NULL,
    "target_type" "target_type" NOT NULL,
    "target_id" INTEGER NOT NULL,
    "action_type" "action_type" NOT NULL,
    "reason" TEXT,
    "action_timestamp" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "admin_action_pkey" PRIMARY KEY ("action_id")
);

-- CreateTable
CREATE TABLE "user_block" (
    "block_id" SERIAL NOT NULL,
    "blocker_id" INTEGER NOT NULL,
    "blocked_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "user_block_pkey" PRIMARY KEY ("block_id")
);

-- CreateTable
CREATE TABLE "admin_block" (
    "admin_block_id" SERIAL NOT NULL,
    "admin_id" INTEGER NOT NULL,
    "blocked_user_id" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "unblocked_at" TIMESTAMP(3),
    "block_count" INTEGER NOT NULL DEFAULT 1,
    "updated_at" TIMESTAMP NOT NULL,

    CONSTRAINT "admin_block_pkey" PRIMARY KEY ("admin_block_id")
);

-- CreateTable
CREATE TABLE "stock" (
    "stock_id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "symbol" VARCHAR(10) NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "stock_pkey" PRIMARY KEY ("stock_id")
);

-- CreateTable
CREATE TABLE "bet_post" (
    "bet_post_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "bet_post_pkey" PRIMARY KEY ("bet_post_id")
);

-- CreateTable
CREATE TABLE "bet" (
    "bet_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "stock_id" INTEGER NOT NULL,
    "bet_post_id" INTEGER NOT NULL,
    "bet_amount" INTEGER NOT NULL,
    "direction" "bet_direction" NOT NULL,
    "fixed_odds" DOUBLE PRECISION NOT NULL,
    "status" "bet_status" NOT NULL DEFAULT 'OPEN',
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "resolved_at" TIMESTAMP,

    CONSTRAINT "bet_pkey" PRIMARY KEY ("bet_id")
);

-- CreateTable
CREATE TABLE "bet_comment" (
    "bet_comment_id" SERIAL NOT NULL,
    "bet_post_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "bet_comment_pkey" PRIMARY KEY ("bet_comment_id")
);

-- CreateTable
CREATE TABLE "bet_like" (
    "bet_like_id" SERIAL NOT NULL,
    "bet_post_id" INTEGER,
    "bet_comment_id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP,
    "deleted_at" TIMESTAMP,

    CONSTRAINT "bet_like_pkey" PRIMARY KEY ("bet_like_id")
);

-- CreateTable
CREATE TABLE "market_event" (
    "event_id" SERIAL NOT NULL,
    "stock_id" INTEGER NOT NULL,
    "closing_price" DOUBLE PRECISION NOT NULL,
    "event_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolved_at" TIMESTAMP,

    CONSTRAINT "market_event_pkey" PRIMARY KEY ("event_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "auth_code_user_id_key" ON "auth_code"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_code_code_key" ON "auth_code"("code");

-- CreateIndex
CREATE UNIQUE INDEX "auth_code_koreaant_code_key" ON "auth_code"("koreaant_code");

-- CreateIndex
CREATE UNIQUE INDEX "stock_symbol_key" ON "stock"("symbol");

-- AddForeignKey
ALTER TABLE "social_login" ADD CONSTRAINT "social_login_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auth_code" ADD CONSTRAINT "auth_code_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comment_like" ADD CONSTRAINT "comment_like_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "comment"("comment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comment_like" ADD CONSTRAINT "comment_like_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_tag" ADD CONSTRAINT "post_tag_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("post_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_tag" ADD CONSTRAINT "post_tag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("tag_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_view" ADD CONSTRAINT "post_view_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("post_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin_action" ADD CONSTRAINT "admin_action_admin_user_id_fkey" FOREIGN KEY ("admin_user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_block" ADD CONSTRAINT "user_block_blocker_id_fkey" FOREIGN KEY ("blocker_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_block" ADD CONSTRAINT "user_block_blocked_id_fkey" FOREIGN KEY ("blocked_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin_block" ADD CONSTRAINT "admin_block_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin_block" ADD CONSTRAINT "admin_block_blocked_user_id_fkey" FOREIGN KEY ("blocked_user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_post" ADD CONSTRAINT "bet_post_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet" ADD CONSTRAINT "bet_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet" ADD CONSTRAINT "bet_stock_id_fkey" FOREIGN KEY ("stock_id") REFERENCES "stock"("stock_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet" ADD CONSTRAINT "bet_bet_post_id_fkey" FOREIGN KEY ("bet_post_id") REFERENCES "bet_post"("bet_post_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_comment" ADD CONSTRAINT "bet_comment_bet_post_id_fkey" FOREIGN KEY ("bet_post_id") REFERENCES "bet_post"("bet_post_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_comment" ADD CONSTRAINT "bet_comment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_like" ADD CONSTRAINT "bet_like_bet_post_id_fkey" FOREIGN KEY ("bet_post_id") REFERENCES "bet_post"("bet_post_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_like" ADD CONSTRAINT "bet_like_bet_comment_id_fkey" FOREIGN KEY ("bet_comment_id") REFERENCES "bet_comment"("bet_comment_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_like" ADD CONSTRAINT "bet_like_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "market_event" ADD CONSTRAINT "market_event_stock_id_fkey" FOREIGN KEY ("stock_id") REFERENCES "stock"("stock_id") ON DELETE RESTRICT ON UPDATE CASCADE;
