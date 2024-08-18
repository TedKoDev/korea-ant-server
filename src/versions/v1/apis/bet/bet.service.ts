// src/bet/bet.service.ts
import { PrismaService } from '@/prisma';
import { Injectable } from '@nestjs/common';
import { bet, bet_comment, bet_like, bet_post, stock } from '@prisma/client';
import { CreateBetPostDto } from './dto';
import { CreateStockDto } from './dto/create-stock-post.dto';
import { PaginationQueryDto } from './dto/pagination-query.dto';
import { UpdateStockDto } from './dto/update-stock-post.dto';

@Injectable()
export class BetService {
  constructor(private prisma: PrismaService) {}

  // Stock CRUD
  async createStock(data: CreateStockDto): Promise<stock> {
    return this.prisma.stock.create({
      data,
    });
  }

  async getStocks(): Promise<stock[]> {
    return this.prisma.stock.findMany();
  }

  async getStockById(id: number): Promise<stock> {
    return this.prisma.stock.findUnique({
      where: { stock_id: id },
    });
  }

  async updateStock(id: number, data: UpdateStockDto): Promise<stock> {
    return this.prisma.stock.update({
      where: { stock_id: id },
      data,
    });
  }

  async deleteStock(id: number): Promise<stock> {
    return this.prisma.stock.delete({
      where: { stock_id: id },
    });
  }

  // BetPost CRUD

  async createBetPost(
    userId: number,
    data: CreateBetPostDto,
  ): Promise<bet_post> {
    return this.prisma.bet_post.create({
      data: {
        ...data,
        user: {
          connect: { user_id: userId },
        },
      },
    });
  }

  async getBetPosts(paginationQuery: PaginationQueryDto): Promise<bet_post[]> {
    const { limit, offset } = paginationQuery;
    return this.prisma.bet_post.findMany({
      take: limit,
      skip: offset,
    });
  }

  async getBetPostById(id: number): Promise<bet_post> {
    return this.prisma.bet_post.findUnique({
      where: { bet_post_id: id },
    });
  }

  async updateBetPost(id: number, data: Partial<bet_post>): Promise<bet_post> {
    return this.prisma.bet_post.update({
      where: { bet_post_id: id },
      data,
    });
  }

  async deleteBetPost(id: number): Promise<bet_post> {
    return this.prisma.bet_post.delete({
      where: { bet_post_id: id },
    });
  }

  // Bet CRUD
  async createBet(data: bet): Promise<bet> {
    return this.prisma.bet.create({
      data,
    });
  }

  async getBets(): Promise<bet[]> {
    return this.prisma.bet.findMany();
  }

  async getBetById(id: number): Promise<bet> {
    return this.prisma.bet.findUnique({
      where: { bet_id: id },
    });
  }

  async updateBet(id: number, data: Partial<bet>): Promise<bet> {
    return this.prisma.bet.update({
      where: { bet_id: id },
      data,
    });
  }

  async deleteBet(id: number): Promise<bet> {
    return this.prisma.bet.delete({
      where: { bet_id: id },
    });
  }

  // BetComment CRUD
  async createBetComment(data: bet_comment): Promise<bet_comment> {
    return this.prisma.bet_comment.create({
      data,
    });
  }

  async getBetComments(betPostId: number): Promise<bet_comment[]> {
    return this.prisma.bet_comment.findMany({
      where: { bet_post_id: betPostId },
    });
  }

  async deleteBetComment(id: number): Promise<bet_comment> {
    return this.prisma.bet_comment.delete({
      where: { bet_comment_id: id },
    });
  }

  // BetLike CRUD
  async likeBetPost(betPostId: number, userId: number): Promise<bet_like> {
    return this.prisma.bet_like.create({
      data: { bet_post_id: betPostId, user_id: userId },
    });
  }

  async likeBetComment(
    betCommentId: number,
    userId: number,
  ): Promise<bet_like> {
    return this.prisma.bet_like.create({
      data: { bet_comment_id: betCommentId, user_id: userId },
    });
  }

  async getBetLikesForPost(betPostId: number): Promise<number> {
    return this.prisma.bet_like.count({
      where: { bet_post_id: betPostId },
    });
  }

  async getBetLikesForComment(betCommentId: number): Promise<number> {
    return this.prisma.bet_like.count({
      where: { bet_comment_id: betCommentId },
    });
  }
}
