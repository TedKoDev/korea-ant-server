// src/bet/bet.module.ts
import { Module } from '@nestjs/common';

import { PrismaService } from '@/prisma';
import { BetPostController } from './bet.controller';
import { BetService } from './bet.service';

@Module({
  controllers: [BetPostController],
  providers: [BetService, PrismaService],
})
export class BetModule {}
