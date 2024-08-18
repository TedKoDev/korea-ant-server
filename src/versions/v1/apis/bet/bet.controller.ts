// src/bet/bet-post.controller.ts
import { Auth } from '@/decorators';
import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  Req,
} from '@nestjs/common';
import { BetService } from './bet.service';
import { CreateBetPostDto } from './dto/create-bet-post.dto';
import { CreateStockDto } from './dto/create-stock-post.dto';
import { PaginationQueryDto } from './dto/pagination-query.dto';
import { UpdateBetPostDto } from './dto/update-bet-post.dto';
import { UpdateStockDto } from './dto/update-stock-post.dto';

@Controller({
  path: 'bets/posts',
  version: '1',
})
export class BetPostController {
  constructor(private readonly betService: BetService) {}

  // 베팅 게시글 작성

  @Auth(['ANY'])
  @Post()
  create(
    @Body() createBetPostDto: CreateBetPostDto,
    @Req() req: { user: { userId: number } },
  ) {
    const userId = req.user.userId;
    return this.betService.createBetPost(userId, createBetPostDto);
  }

  // 베팅 게시글 목록 조회 (페이지네이션 포함)
  @Auth(['ANY'])
  @Get()
  async findAll(@Query() paginationQuery: PaginationQueryDto) {
    return this.betService.getBetPosts(paginationQuery);
  }

  // 특정 베팅 게시글 조회
  @Auth(['ANY'])
  @Get(':id')
  async findOne(@Param('id') id: number) {
    return this.betService.getBetPostById(id);
  }

  // 베팅 게시글 수정
  @Auth(['ANY'])
  @Patch(':id')
  update(
    @Param('id') id: number,
    @Body() updateBetPostDto: UpdateBetPostDto,
    @Req() req: { user: { userId: number } },
  ) {
    const userId = req.user.userId;
    return this.betService.updateBetPost(id, {
      ...updateBetPostDto,
      user_id: userId,
    });
  }

  // 베팅 게시글 삭제
  @Auth(['ADMIN'])
  @Delete(':id')
  async remove(
    @Param('id') id: number,
    // @Req() req: { user: { userId: number } },
  ) {
    // const userId = req.user.userId;
    return this.betService.deleteBetPost(id);
  }

  // Stock 관련 CRUD

  // 주식/지수 등록
  @Auth(['ADMIN'])
  @Post('stocks')
  createStock(@Body() createStockDto: CreateStockDto) {
    return this.betService.createStock(createStockDto);
  }

  // 주식/지수 목록 조회
  @Auth(['ANY'])
  @Get('stocks')
  findAllStocks() {
    return this.betService.getStocks();
  }

  // 특정 주식/지수 조회
  @Auth(['ANY'])
  @Get('stocks/:id')
  findStock(@Param('id') id: number) {
    return this.betService.getStockById(id);
  }

  // 주식/지수 수정
  @Auth(['ADMIN'])
  @Patch('stocks/:id')
  updateStock(@Param('id') id: number, @Body() updateStockDto: UpdateStockDto) {
    return this.betService.updateStock(id, updateStockDto);
  }

  // 주식/지수 삭제
  @Auth(['ADMIN'])
  @Delete('stocks/:id')
  removeStock(@Param('id') id: number) {
    return this.betService.deleteStock(id);
  }
}
